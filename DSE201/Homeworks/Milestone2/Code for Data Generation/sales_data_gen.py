import random
import string

numStates = 50
numCategories = 100
numProducts = 1000
numCustomers = 1000
numSales = 10000

def randomString(stringLength = 5):
    letters = string.ascii_letters
    return ''.join(random.choice(letters) for i in range(stringLength)).lower().capitalize()

f = open("/Users/gio/Documents/DSE/2019-rgm001/DSE201/Homeworks/Milestone2/Data_Generated/sales_script.txt","w")

f.write('\n\n')

states = dict()
while len(states) != numStates:
    states[len(states)] = randomString()    

for idx, state in enumerate(states.keys()):
    f.write('INSERT INTO states (state_id, name) VALUES(' + str(idx+1) + ', \'' + states[state] + '\'' + ');\n')
    
f.write('\n\n')

categories = dict()
while len(categories) != numCategories:
    categories[len(categories)] = (randomString(),randomString(50))

for idx, category in enumerate(categories.keys()):
    f.write('INSERT INTO categories (category_id, name, description) VALUES (' + str(idx+1) + ', \'' + categories[category][0] + '\'' + ', \'' + categories[category][1] + '\''+ ');\n')

f.write('\n\n')

products = dict()

while len(products) != numProducts:
    products[len(products)] = (randomString(),random.choice(list(categories))+1,random.randint(100,1000))
    

for idx, product in enumerate(products.keys()):
    f.write('INSERT INTO products (product_id, name, list_price, category_id) VALUES (' + str(idx+1) + ', \'' + products[product][0] + '\'' + ',' + str(products[product][2]) + ',' + str(products[product][1]) + ');\n')


f.write('\n\n')

customers = dict()

while len(customers) != numCustomers:
    customers[len(customers)] = (randomString(random.randint(5,10)), random.choice(list(states))+1)
    
for idx, customer in enumerate(customers):
    f.write('INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (' + str(idx+1) + ', \'' + customers[customer][0] + '\'' + ', \''+ customers[customer][0] + '\',' + str(customers[customer][1]) + ');\n')


f.write('\n\n')

for idx, i in enumerate(range(numSales)):
    pid = random.choice(list(products))
    price = products[pid][2]
    f.write('INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (' + str(idx+1)  + ','+str(random.randint(1,10))  + ','+ str(random.randint(int(price/2),price)) + ',0,' + str(random.choice(list(customers))+1) + ',' + str(pid+1) + ');\n')


f.close()
















