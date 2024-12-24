import OrientDB from "orientjs";
import { faker } from "@faker-js/faker";
import random from "random";

async function connectToServer() {
    try {
        return await OrientDB.OrientDBClient.connect({
            host: 'localhost',
            port: 2424,
        });
    } catch (error) {
        console.error('Failed to connect to server:', error);
        throw error;
    }
}

//using the server i can access the session 
async function createSession(server) {
    try {
        return await server.session({
            name: "store",
            username: "root",
            password: "2004"
        });
    } catch (error) {
        console.error('Failed to create session:', error);
        throw error;
    }
}

// found out the hard way that my date was incorrect format so it just did not like to work, so i searched up how to convert 
function formatDateForOrientDB(date) {
    const pad = (num) => num.toString().padStart(2, '0');
    
    return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())} ${
        pad(date.getHours())}:${pad(date.getMinutes())}:${pad(date.getSeconds())}`;
}


// Actively works, and generates random info for the three as well as generates a new name for every order created 
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
        // Create a new customer for each order
        const customer_rid = await createRandomCustomer(db);
        
        // Create the order with properly formatted date
        const order = await db.insert().into('Order').set({ 
            customer_id: customer_rid, 
            order_date: formatDateForOrientDB(new Date())
        }).one();
        
        console.log('Order created:', order);

        // Generate 1-3 random products for the order
        const numProducts = random.int(1, 3);
        for (let i = 0; i < numProducts; i++) {
            // Ensure product ID is from rid 58-67
            const product_id = random.int(58, 67);
            const quantity = random.int(1, 1000);
            const price = random.float(1, 100).toFixed(2);

            try {
                // Corrected edge creation using db.create
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

async function main() {
    let server, session;
    try {
        server = await connectToServer();
        session = await createSession(server);
        const db = session;

        const MAX_ITERATIONS = 10; // I did this to make 10 orders trigger so you can see new customer made each time and assigned to the new order
        let iterationCount = 0;

        const interval = 10000; // 10 seconds between orders
        while (iterationCount < MAX_ITERATIONS) {
            await createRandomOrder(db);
            console.log(`Order ${iterationCount + 1} created`);
            
            iterationCount++;
            
            // Only wait if not on the last iteration
            if (iterationCount < MAX_ITERATIONS) {
                await new Promise(resolve => setTimeout(resolve, interval));
            }
        }
        console.log(`Completed ${MAX_ITERATIONS} order generations`);
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