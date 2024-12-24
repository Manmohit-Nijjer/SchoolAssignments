# Code done for my Mobile Web Class where we took the APPL.csv file within the repository and added was able to add the data into tables in postgres. 

import psycopg2
import csv

def upload_csv_to_db(csv_file, conn):
    with conn.cursor() as cur:
        with open(csv_file, 'r') as file:
            reader = csv.DictReader(file)
            for row in reader:
                date = row['Date']
                high = row['High']
                low = row['Low']
                open_price = row['Open']
                close = row['Close']
                adj_close = row['Adj Close']
                volume = int(float(row['Volume']))
                
                cur.execute("""
                    INSERT INTO "lab 3".high_low (stock_Id, Date, High, Low) VALUES (2, %s, %s, %s)
                """, (date, high, low))
                
                cur.execute("""
                    INSERT INTO "lab 3".open_close (stock_Id, Date, Open, Close, AdjClose) VALUES (2, %s, %s, %s, %s)
                """, (date, open_price, close, adj_close))
                
                cur.execute("""
                    INSERT INTO "lab 3".volume (stock_Id, Date, Volume) VALUES (2, %s, %s)
                """, (date, volume))
        
        conn.commit()

def main():
    conn = psycopg2.connect("dbname= user= password=")
    
    # Upload CSV data to the database
    upload_csv_to_db('APPL.csv', conn)
    
    conn.close()

if __name__ == "__main__":
    main()
