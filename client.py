import mysql.connector as connector


# Function to connect to MySQL database and execute query
def execute_query(query):
    # Use "with" statement for automatic connection closing
    with connector.connect(user="root", password="rootuser", db="LittleLemonDB") as connection:
        cursor = connection.cursor()
        cursor.execute(query)

        # Check if it's a "SHOW tables" command
        if query.strip().lower().startswith('show tables'):
            # If it's SHOW tables, just print the table names
            for table in cursor:
                print(table)
        else:
            # For other queries, print column names and rows
            print(cursor.column_names)
            for row in cursor:
                print(row)


# Connect to MySQL database and show tables
show_tables = "SHOW tables"
execute_query(show_tables)

# Query to select orders with TotalCost > 60
orders_query = """
SELECT * FROM customerdetails AS c 
LEFT JOIN orders AS o 
ON c.CustomerID = o.CustomerID 
WHERE o.TotalCost > 60
ORDER BY c.CustomerID
"""

execute_query(orders_query)
