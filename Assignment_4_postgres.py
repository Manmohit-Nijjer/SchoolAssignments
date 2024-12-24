import psycopg2
from faker import Faker # <- searched up "ways to create a bot, and faker library poped up" my knowledge on this is that it generates fake data allowing to test in real life examples for the testing enviorment
import random # <- need it for random int generation for the randomness of the bots 
import time # <- need import to either put the process to sleep or to make it run after every 10 seconds

not_real = Faker()

def create_random_customer(cursor):
    name = not_real.name() # <- using the faker to generate random fake input for name, email and address 
    email = not_real.email()
    address = not_real.address()
    cursor.execute("""INSERT INTO "assignment 3".customers (name, email, address) VALUES (%s, %s, %s) RETURNING customerid""", (name, email, address))
    customer_id = cursor.fetchone()[0] #<- fetches information from the first row hence fetch(one), this will then check to see whats the customerid of the table since i created the customer id to be a serial hence it increases for each input

    return customer_id

def create_random_order(cursor):
    customer_id = create_random_customer(cursor)
    cursor.execute("""INSERT INTO "assignment 3".orders (customerid) VALUES (%s) RETURNING orderid""", (customer_id,))
    order_id = cursor.fetchone()[0] #<- same idea as customer_id, but returns the order_id that is also a cerial and be used for the nect part of the process

    num_products = random.randint(1,3)
    for _ in range(num_products): #<- for any in range of one through three which will then be used to represent the three random products added to the orderlist.
        product_id = random.randint(1, 10)  #<- random product that since i only have 10 it will generate a random int from that range
        quantity = random.randint(1, 1000)
        price = random.uniform(1, 100)  #<- random pricing that will be used within orderitems price for adjusting balues
        cursor.execute("""INSERT INTO "assignment 3".orderitems (orderid, productid, quantity, price) VALUES (%s, %s, %s, %s)""", (order_id, product_id, quantity, price))

def main():
    conn = psycopg2.connect(dbname="postgres", user="postgres", password="2004", host="localhost", port="5432") # <- connection to the server / used the previous assignment for this code

    cursor = conn.cursor()

    try:
        while True:
            create_random_order(cursor)
            conn.commit()
            time.sleep(10)  # <- did the first example given using sleep though if it causes an issues I may set it to only run after 10 seconds have passed instead causing it do nothing for 10 seconds

    except KeyboardInterrupt:
        print("Process interrupt by user. ")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    main()
