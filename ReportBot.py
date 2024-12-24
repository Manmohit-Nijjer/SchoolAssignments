# This like the other report bot is a continuation of Assignment 4 with the unique additon of a report bot that prints out the total sales and items of a product. 
# It has little notes throughout to understand each use case of the commands, but in summary this uses same prinicple as Assignment 4 with the additon of a time and threading variable to simulate the every second output desired. 

import psycopg2
from faker import Faker
import random
import time
import threading

not_real = Faker()

# Database connection
def get_db_connection():
    conn = psycopg2.connect(
        dbname='',
        user='',
        password='',
        host='localhost',
        port='5432'
    )
    return conn

# Function to create random customer
def create_random_customer(cursor):
    name = not_real.name()
    email = not_real.email()
    address = not_real.address()
    cursor.execute("""INSERT INTO "assignment 3".customers (name, email, address) VALUES (%s, %s, %s) RETURNING customerid""", (name, email, address))
    customer_id = cursor.fetchone()[0]
    return customer_id

# Function to create random order
def create_random_order(cursor):
    customer_id = create_random_customer(cursor)
    cursor.execute("""INSERT INTO "assignment 3".orders (customerid) VALUES (%s) RETURNING orderid""", (customer_id,))
    order_id = cursor.fetchone()[0]

    num_products = random.randint(1, 3)
    for _ in range(num_products):
        product_id = random.randint(1, 10)
        quantity = random.randint(1, 1000)
        cursor.execute("""SELECT price FROM "assignment 3".products WHERE productid = %s""", (product_id,))
        price = cursor.fetchone()[0]
        cursor.execute("""INSERT INTO "assignment 3".orderitems (orderid, productid, quantity, price) VALUES (%s, %s, %s, %s)""", (order_id, product_id, quantity, price))

def fetch_sales_data():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('''
        SELECT "assignment 3".products.name, SUM("assignment 3".orderitems.quantity) AS total_quantity, SUM("assignment 3".orderitems.quantity * "assignment 3".orderitems.price) AS total_revenue
        FROM "assignment 3".orderitems
        JOIN "assignment 3".products ON "assignment 3".orderitems.productid = "assignment 3".products.productid
        GROUP BY "assignment 3".products.name
        ORDER BY total_revenue DESC, total_quantity DESC, "assignment 3".products.name DESC
    ''')
    sales_data = cursor.fetchall()
    cursor.close()
    conn.close()
    return sales_data

# Function to print sales report
def print_sales_report():
    while True:
        sales_data = fetch_sales_data()
        print("\nSales Report:")
        for product in sales_data:
            print(f"{product[0]} sold {product[1]} total revenue ${product[2]:.2f}")
        time.sleep(1)

if __name__ == '__main__':
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Start generating random orders
        def generate_orders():
            while True:
                create_random_order(cursor)
                conn.commit()
                time.sleep(10)

        threading.Thread(target=generate_orders, daemon=True).start()
        print_sales_report()
    except KeyboardInterrupt:
        print("Process interrupted by user.")
    finally:
        cursor.close()
        conn.close()
