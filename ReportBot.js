import OrientDB from "orientjs";
import { faker } from "@faker-js/faker";
import random from "random";

async function connectToServer() {
    try {
        const server = await OrientDB.OrientDBClient.connect({
            host: 'localhost',
            port: 2424,
        });
        console.log('Connected to OrientDB server');
        return server;
    } catch (error) {
        console.error('Failed to connect to server:', error);
        throw error;
    }
}

async function createSession(server) {
    try {
        const session = await server.session({
            name: "store",
            username: "root",
            password: "2004"
        });
        console.log('Session created');
        return session;
    } catch (error) {
        console.error('Failed to create session:', error);
        throw error;
    }
}

function formatDateForOrientDB(date) {
    const pad = (num) => num.toString().padStart(2, '0');
    return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())} ${
        pad(date.getHours())}:${pad(date.getMinutes())}:${pad(date.getSeconds())}`;
}

async function createRandomCustomer(db) {
    try {
        const name = faker.person.fullName();
        const email = faker.internet.email();
        const address = faker.location.streetAddress();
        
        const result = await db.insert().into('Customer').set({ 
            name, 
            email, 
            address 
        }).one();
        
        console.log('Customer created:', result);
        return result['@rid'];
    } catch (error) {
        console.error('Failed to create customer:', error);
        throw error;
    }
}

async function createRandomOrder(db) {
    try {
        const customer_rid = await createRandomCustomer(db);
        const order = await db.insert().into('Order').set({ 
            customer_id: customer_rid, 
            order_date: formatDateForOrientDB(new Date())
        }).one();
        
        console.log('Order created:', order);

        const numProducts = random.int(1, 3);
        for (let i = 0; i < numProducts; i++) {
            const product_id = random.int(58, 67); // Changed to use a more flexible range
            const quantity = random.int(1, 1000);
            const price = random.float(1, 100).toFixed(2);

            try {
                const edgeResult = await db.create('EDGE', 'OrderItem')
                    .from(order['@rid'])
                    .to(`#${product_id}:0`)
                    .set({ quantity, price })
                    .one();

                console.log('OrderItem edge created:', edgeResult);
            } catch (edgeError) {
                console.error('Failed to create OrderItem edge:', edgeError);
                console.error('Full edge error details:', JSON.stringify(edgeError, null, 2));
            }
        }
    } catch (error) {
        console.error('Failed to create order:', error);
        console.error('Full error details:', JSON.stringify(error, null, 2));
        throw error;
    }
}

async function fetchSalesDataByProductId(db) {
    try {
        const result = await db.query(`
            SELECT 
                in.name AS product_name, 
                SUM(quantity) AS total_quantity, 
                SUM(quantity * price) AS total_revenue
            FROM OrderItem
            GROUP BY in.name
            ORDER BY total_revenue DESC, total_quantity DESC, in.name ASC
        `).all();

        return result;
    } catch (error) {
        // Log detailed error information
        console.error('Failed to fetch sales data by product ID:', JSON.stringify(error, Object.getOwnPropertyNames(error), 2));
        throw error;
    }
}


async function printSalesReport(db) {
    try {
        const salesData = await fetchSalesDataByProductId(db);
        console.log("\nSales Report:");
        salesData.forEach(product => {
            console.log(
                `${product.product_name} sold ${product.total_quantity} units, total revenue $${parseFloat(product.total_revenue).toFixed(2)}`
            );
        });
    } catch (error) {
        console.error('Failed to print sales report:', JSON.stringify(error, Object.getOwnPropertyNames(error), 2));
    }
}

async function main() {
    let server, session;
    try {
        server = await connectToServer();
        session = await createSession(server);
        const db = session;

        // Generate orders periodically
        const generateOrders = async () => {
            while (true) {
                await createRandomOrder(db);
                await new Promise(resolve => setTimeout(resolve, 10000)); // 10 seconds between orders
            }
        };

        // Print sales report every second
        const reportGenerator = async () => {
            while (true) {
                await printSalesReport(db);
                await new Promise(resolve => setTimeout(resolve, 1000)); // 1 second delay
            }
        };

        // Run both functions concurrently
        await Promise.all([
            generateOrders(),
            reportGenerator()
        ]);

    } catch (error) {
        console.error('Error in main process:', error);
    } finally {
        if (session) await session.close();
        if (server) await server.close();
    }
}

main().catch(error => {
    console.error('Failed to execute main process:', error);
});