// This Assignment's purpose was to allow us to insert data into tables in orient with it properly working. 

const OrientDBClient = require('orientjs').OrientDBClient;

async function connect() {
  const client = await OrientDBClient.connect({
    host: 'localhost',
    port: 2424
  });

  const session = await client.session({
    name: '',
    username: '',
    password: ''
  });

  return session;
}


async function insertData(session) {
    // Insert customers
    const customers = [
      { name: 'John Doe', email: 'john.doe@example.com', address: '123 Elm Street, Springfield, IL' },
      { name: 'Jane Smith', email: 'jane.smith@example.com', address: '456 Oak Avenue, Springfield, IL' },
      { name: 'Alice Johnson', email: 'alice.johnson@example.com', address: '789 Pine Road, Springfield, IL' },
      { name: 'Bob Brown', email: 'bob.brown@example.com', address: '101 Maple Lane, Springfield, IL' },
      { name: 'Charlie Davis', email: 'charlie.davis@example.com', address: '202 Birch Boulevard, Springfield, IL' },
      { name: 'Diana Evans', email: 'diana.evans@example.com', address: '303 Cedar Circle, Springfield, IL' },
      { name: 'Ethan Foster', email: 'ethan.foster@example.com', address: '404 Walnut Way, Springfield, IL' },
      { name: 'Fiona Green', email: 'fiona.green@example.com', address: '505 Chestnut Drive, Springfield, IL' },
      { name: 'George Harris', email: 'george.harris@example.com', address: '606 Redwood Street, Springfield, IL' },
      { name: 'Hannah Lee', email: 'hannah.lee@example.com', address: '707 Cypress Court, Springfield, IL' }
    ];
  ``
    const customerRIDs =[];
    for (const customer of customers) {
      await session.command(`INSERT INTO Customer SET name = '${customer.name}', email = '${customer.email}', address = '${customer.address}'`).one();
      customerRIDs.push(result['@rid']);
    }
  
    // Insert products
    const products = [
      { name: 'Laptop', description: 'High-performance laptop', price: 999.99 },
      { name: 'Smartphone', description: 'Latest model smartphone', price: 799.99 },
      { name: 'Headphones', description: 'Noise-cancelling headphones', price: 199.99 },
      { name: 'Smartwatch', description: 'Feature-rich smartwatch', price: 299.99 },
      { name: 'Tablet', description: '10-inch tablet', price: 399.99 },
      { name: 'Camera', description: 'Digital SLR camera', price: 499.99 },
      { name: 'Printer', description: 'Wireless printer', price: 149.99 },
      { name: 'Monitor', description: '27-inch monitor', price: 249.99 },
      { name: 'Keyboard', description: 'Mechanical keyboard', price: 99.99 },
      { name: 'Mouse', description: 'Wireless mouse', price: 49.99 }
    ];
    
    const ProductRIDs =[];
    for (const product of products) {
      await session.command(`INSERT INTO Product SET name = '${product.name}', description = '${product.description}', price = ${product.price}`).one();
      ProductRIDs.push(result['@rid']);
    }

  
    // Insert orders and order items
    const orders = [
      { customerIndex: 0, orderdate: '2024-11-01 10:00:00' },
      { customerIndex: 1, orderdate: '2024-11-02 11:00:00' },
      { customerIndex: 2, orderdate: '2024-11-03 12:00:00' },
      { customerIndex: 3, orderdate: '2024-11-04 13:00:00' },
      { customerIndex: 4, orderdate: '2024-11-05 14:00:00' },
      { customerIndex: 5, orderdate: '2024-11-06 15:00:00' },
      { customerIndex: 6, orderdate: '2024-11-07 16:00:00' },
      { customerIndex: 7, orderdate: '2024-11-08 17:00:00' },
      { customerIndex: 8, orderdate: '2024-11-09 18:00:00' },
      { customerIndex: 9, orderdate: '2024-11-10 19:00:00' }
    ];
  
}
