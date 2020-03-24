import random
import string
import psycopg2


# Test values took 30 seconds
# numStates = 50
# numCategories = 20000
# numProducts = 30000
# numCustomers = 40000
# numSales = 10000

numStates = 150
numCategories = 60000
numProducts = 90000
numCustomers = 120000
numSales = 30000

# define Postgress options'

# connect to the db
con = psycopg2.connect("host = localhost dbname=Sales_Milestone3 user=postgres password = bitch")

# Cursor
cur =  con.cursor()

def randomString(stringLength = 5):
    letters = string.ascii_letters
    return ''.join(random.choice(letters) for i in range(stringLength)).lower().capitalize()

# f = open("/Users/gio/Documents/DSE/2019-rgm001/DSE201/Homeworks/Milestone3/sales_cube_data.sql","w")

# f.write('\n\n')

print('Generating States')
states = dict()
while len(states) != numStates:
    states[len(states)] = randomString()    

for idx, state in enumerate(states.keys()):
    cur.execute('INSERT INTO states (state_id, name) VALUES(' + str(idx+1) + ', \'' + states[state] + '\'' + ');\n')
    
# f.write('\n\n')

print('Generating Categories')


categories = dict()
while len(categories) != numCategories:
    categories[len(categories)] = (randomString(),randomString(50))

for idx, category in enumerate(categories.keys()):
    cur.execute('INSERT INTO categories (category_id, name, description) VALUES (' + str(idx+1) + ', \'' + categories[category][0] + '\'' + ', \'' + categories[category][1] + '\''+ ');\n')

# f.write('\n\n')

products = dict()

print('Generating Products')


while len(products) != numProducts:
    products[len(products)] = (randomString(),random.choice(list(categories))+1,random.randint(100,1000))
    

for idx, product in enumerate(products.keys()):
    cur.execute('INSERT INTO products (product_id, name, list_price, category_id) VALUES (' + str(idx+1) + ', \'' + products[product][0] + '\'' + ',' + str(products[product][2]) + ',' + str(products[product][1]) + ');\n')


# f.write('\n\n')

customers = dict()

print('Generating Customers')


while len(customers) != numCustomers:
    customers[len(customers)] = (randomString(random.randint(5,10)), random.choice(list(states))+1)
    
for idx, customer in enumerate(customers):
    cur.execute('INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (' + str(idx+1) + ', \'' + customers[customer][0] + '\'' + ', \''+ customers[customer][0] + '\',' + str(customers[customer][1]) + ');\n')


# f.write('\n\n')

print('Generating Sales')


for idx, i in enumerate(range(numSales)):
    pid = random.choice(list(products))
    price = products[pid][2]
    cur.execute('INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (' + str(idx+1)  + ','+str(random.randint(1,10))  + ','+ str(random.randint(int(price/2),price)) + ',0,' + str(random.choice(list(customers))+1) + ',' + str(pid+1) + ');\n')


# f.close()

con.commit()

# Close the connection
con.close()














