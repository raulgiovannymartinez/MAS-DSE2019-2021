#!/usr/bin/env python
#
# Documentation referenced:
# - https://docs.sqlalchemy.org/en/13/core/engines.html
#
import sys
import sqlalchemy
from sqlalchemy import Numeric, Text, Integer, Column, create_engine, ForeignKey
from sqlalchemy.ext.declarative import declarative_base

from random import seed, getrandbits, random, randint, triangular
from pprint import pprint

seed(22)

Base = declarative_base()

# Set these variables
user = 'james'
pw = 'asdf'
db = 'james'

host = 'localhost'
port = 5432

#
# Define tables
#

class State(Base):
    __tablename__ = 'states'
    id = Column(Integer, primary_key=True)
    name = Column(Text)

class Category(Base):
    __tablename__ = 'categories'
    id = Column(Integer, primary_key=True)
    name = Column(Text)
    desc = Column(Text)

class Customer(Base):
    __tablename__ = 'customers'
    id = Column(Integer, primary_key=True)
    name = Column(Text)
    state = Column(Integer, ForeignKey('states.id'))

class Product(Base):
    __tablename__ = 'products'
    id = Column(Integer, primary_key=True)
    name = Column(Text)
    price = Column(Numeric)
    category = Column(Integer, ForeignKey('categories.id'))

class Sale(Base):
    __tablename__ = 'sales'
    id = Column(Integer, primary_key=True)
    quantity = Column(Integer)
    price = Column(Numeric)
    customer = Column(Integer, ForeignKey('customers.id'))
    product = Column(Integer, ForeignKey('products.id'))

#
# Establish the connection
#
url = 'postgresql://{}:{}@{}:{}/{}'
url = url.format(user, pw, host, port, db)

con = create_engine(url, client_encoding='utf8')

Session = sqlalchemy.orm.sessionmaker(bind=con)
session = Session()

meta = sqlalchemy.MetaData(bind=con)
meta.reflect()

# Misc
numLetters = 26
uppercase = [chr(i) for i in range(65, 65+numLetters)]
lowercase = [chr(i) for i in range(97, 97+numLetters)]

numBits = 16

#
# Returns list of state codes ex: ['XA', 'CO', 'FF', ...]
#
def genStates(num):
    ret = []
    for i in range(num):
        bits = getrandbits(numBits)
        left  = (bits & 0xff00) >> 8
        right = bits  & 0x00ff

        ret.append(uppercase[left % numLetters] + uppercase[right % numLetters])
    return ret

#
# Returns list of strings conforming to the optional parameters.
# @length: returned strings will be exactly this length
# @minLen: returned strings will be at least this length
# @maxLen: returned strings will be at most this length
#
# If @length is specified, @maxLen and @minLen are ignored.
#
# Does not guarantee that the returned string lengths will follow any standard
# distribution.
#
def genText(num, length=0, maxLen=20, minLen=10):
    ret = []

    # Find out how many random bits we need per string. We need to generate
    # at least 26 options per character.
    bitsPerCharacter = 5 # 2^5 = 32 > 26
    baseMask = 0b11111 # used later
    if length:
        numChars = length
    else:
        numChars = maxLen
        numChars += 1

    numBits = numChars * bitsPerCharacter

    for _ in range(num):
        bits = getrandbits(numBits)
        mask = baseMask
        curr = ['' for _ in range(numChars)]

        if length:
            strLen = length
        else:
            strLen = (bits & mask) % (numChars-1) # subtract 1 since we added 1 earlier
            if strLen < minLen:
                strLen = minLen # this obviously messes with the distribution
            mask <<= 1

        for i in range(strLen):
            # Select the random value
            val = bits & mask
            val >>= i

            # Save random selection
            curr[i] = lowercase[val % numLetters]

            # Increment bit mask
            mask <<= 1

        ret.append(''.join(curr))

    return ret

# Returns list of ints between 1 and 10
def genInt(num, minRet=1, maxRet=10):
    if maxRet - minRet > 8:
        mid = (maxRet - minRet)/2
        return [round(triangular(minRet, maxRet, mid)) for _ in range(num)]
    else:
        raise ValueError('whoops')
        return [randint(minRet, maxRet) for _ in range(num)]

# Returns list of floats between 0 and 10
def genPrice(num, maxRet=10):
    return [round(random()*maxRet, 2) for _ in range(num)]


def genStateRows(num):
    states = genStates(num)
    session.bulk_insert_mappings(State,
        [{'name': states[i]} for i in range(num)]
    )

def genCategoryRows(num):
    names = genText(num, length=3)
    descs = genText(num, length=10)

    session.bulk_insert_mappings(Category,
        [{'name': names[i],
          'description': descs[i]}
          for i in range(num)]
    )

def genCustomerRows(num, numStates):
    names = genText(num, minLen=5, maxLen=10)
    states = genInt(num, maxRet=numStates)

    session.bulk_insert_mappings(Customer,
        [{'name': names[i],
          'state': states[i]}
          for i in range(num)]
    )

def genProductRows(num, numCategories):
    names = genText(num, length=8)
    prices = genPrice(num)
    categs = genInt(num, maxRet=numCategories)

    session.bulk_insert_mappings(Product,
        [{'name': names[i],
          'price': prices[i],
          'category': categs[i]}
          for i in range(num)]
    )
        
def genSalesRows(num, numCustomers, numProducts):
    prices = genPrice(num)
    quantities = genInt(num)
    customers = genInt(num, maxRet=numCustomers)
    products = genInt(num, maxRet=numProducts)

    session.bulk_insert_mappings(Sale,
        [{'price': prices[i],
          'quantity': quantities[i],
          'customer': customers[i],
          'product': products[i]}
          for i in range(num)]
    )

numStates = 5000
numCategories = 5000
numCustomers = 50000
numProducts = 50000
numSales = 500000

genStateRows(numStates)
genCategoryRows(numCategories)
genCustomerRows(numCustomers, numStates)
genProductRows(numProducts, numCategories)
genSalesRows(numSales, numCustomers, numProducts)

session.commit()
