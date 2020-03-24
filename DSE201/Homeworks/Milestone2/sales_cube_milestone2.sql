-- Create tables for sales cube
CREATE TABLE states (
    state_id        SERIAL PRIMARY KEY NOT NULL,
    name            character varying(50) NOT NULL
);
CREATE TABLE customers (
    customer_id     SERIAL PRIMARY KEY NOT NULL,
    first_name      character varying(50) NOT NULL,
    last_name       character varying(50) NOT NULL,
    state_id        INTEGER REFERENCES states (state_id) NOT NULL
);
CREATE TABLE categories (
    category_id     SERIAL PRIMARY KEY NOT NULL,
    name            character varying(50) NOT NULL,
    description     TEXT
);
CREATE TABLE products (
    product_id      SERIAL PRIMARY KEY NOT NULL,
    name            character varying(50) NOT NULL,
    list_price      DECIMAL(15,2),
    category_id     INTEGER REFERENCES categories (category_id) NOT NULL
);
CREATE TABLE sales (
    sale_id         SERIAL PRIMARY KEY NOT NULL,
    quantity        INTEGER  NOT NULL,
    price_paid      DECIMAL(15,2)  NOT NULL,
    discount        DECIMAL(15,2) NOT NULL,
    customer_id     INTEGER REFERENCES customers (customer_id) NOT NULL,
    product_id      INTEGER REFERENCES products (product_id) NOT NULL
);


-- Add data

-- states
INSERT INTO states (state_id, name) VALUES (1, 'Arizona');
INSERT INTO states (state_id, name) VALUES (2, 'California');
INSERT INTO states (state_id, name) VALUES (3, 'Florida');
INSERT INTO states (state_id, name) VALUES (4, 'Texas');
INSERT INTO states (state_id, name) VALUES (5, 'Hawaii');
INSERT INTO states (state_id, name) VALUES (6, 'New Jersey');
INSERT INTO states (state_id, name) VALUES (7, 'Virginia');
INSERT INTO states (state_id, name) VALUES (8, 'Colorado');
INSERT INTO states (state_id, name) VALUES (9, 'Michigan');
INSERT INTO states (state_id, name) VALUES (10, 'Ohio');
INSERT INTO states (state_id, name) VALUES (11, 'Washington');
INSERT INTO states (state_id, name) VALUES (12, 'Paraguay');
INSERT INTO states (state_id, name) VALUES (13, 'Mexico');


-- customers
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (1, 'Phil', 'Canette', 2);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (2, 'Lauren', 'Sitts', 2);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (3, 'Ivan', 'Ulloa', 1);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (4, 'Ivan', 'Federico', 6);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (5, 'Ramon', 'Martinez', 9);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (6, 'Raul', 'Martinez', 7);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (7, 'Phil', 'Perez', 6);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (8, 'Alberto', 'Cedeno', 10);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (9, 'Fernando', 'Tatis', 10);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (10, 'Manny', 'Machado', 2);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (11, 'Francisco', 'Juarez', 1);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (12, 'Ricardo', 'Ulloa', 2);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (13, 'Alfonso', 'Cardenaz', 3);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (14, 'Yu', 'Pol', 7);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (15, 'Jo', 'Lu', 8);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (16, 'Jean', 'Reza', 4);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (17, 'Michael', 'Castaneda', 5);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (18, 'El', 'Mijito', 6);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (19, 'Javier', 'Lareq', 7);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (20, 'Laura', 'Penelope', 10);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (21, 'Ana', 'Lanzar', 2);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (22, 'Sandra', 'Massiel', 1);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (23, 'Hector', 'Jaramillo', 1);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (24, 'Lorena', 'Jaramillo', 7);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (25, 'Jocelyn', 'Zamora', 8);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (26, 'Jocelyna', 'Zarara', 8);
INSERT INTO customers (customer_id, first_name, last_name, state_id) VALUES (27, 'Pepito', 'Zarsamora', 8);


-- categories
INSERT INTO categories (category_id, name, description) VALUES (1, 'Baby Products', NULL);
INSERT INTO categories (category_id, name, description) VALUES (2, 'Automotive', 'Products similar to Autozone and OReillys');
INSERT INTO categories (category_id, name, description) VALUES (3, 'Beauty', 'Only for women');
INSERT INTO categories (category_id, name, description) VALUES (4, 'Camera & Photo', 'For professional photography');
INSERT INTO categories (category_id, name, description) VALUES (5, 'Cell Phone & Accessories', 'Only for Android');
INSERT INTO categories (category_id, name, description) VALUES (6, 'Collectible Coins', 'In the USA Only');
INSERT INTO categories (category_id, name, description) VALUES (7, 'Consumer Electronics', 'None of them are waterproof');
INSERT INTO categories (category_id, name, description) VALUES (8, 'Entertainment', 'For people under 21');
INSERT INTO categories (category_id, name, description) VALUES (9, 'Fine Art', 'Europe style art');
INSERT INTO categories (category_id, name, description) VALUES (10, 'Grocery & Food', NULL);
INSERT INTO categories (category_id, name, description) VALUES (11, 'Health & Personal Care', 'Only for men');
INSERT INTO categories (category_id, name, description) VALUES (12, 'Home & Garden', 'Similar to Home Depot');
INSERT INTO categories (category_id, name, description) VALUES (13, 'Independent Design', 'Local people from Guatemala');
INSERT INTO categories (category_id, name, description) VALUES (14, 'Industrial & Scientific', NULL);
INSERT INTO categories (category_id, name, description) VALUES (15, 'Music', '80s music');
INSERT INTO categories (category_id, name, description) VALUES (16, 'Musical Instruments', 'These are very expensive');
INSERT INTO categories (category_id, name, description) VALUES (17, 'Office Products', 'Michael Scott paper company');
INSERT INTO categories (category_id, name, description) VALUES (18, 'Outdoors', 'Opt outside');
INSERT INTO categories (category_id, name, description) VALUES (19, 'Personal Computers', 'Apple products');
INSERT INTO categories (category_id, name, description) VALUES (20, 'Pet Supplies', NULL);
INSERT INTO categories (category_id, name, description) VALUES (21, 'Software', 'But not firmware or hardware');
INSERT INTO categories (category_id, name, description) VALUES (22, 'Sports', 'ping pong is not a sport');
INSERT INTO categories (category_id, name, description) VALUES (23, 'Toys & Games', 'For girls');
INSERT INTO categories (category_id, name, description) VALUES (24, 'Video Games', 'Shooting games only');
INSERT INTO categories (category_id, name, description) VALUES (25, 'Watches', NULL);


-- products
INSERT INTO products (product_id, name, list_price, category_id) VALUES (1, 'Baby Hat', 4.99, 1);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (2, 'Toy Car', 26.05, 1);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (3, 'Diapers', 18.19, 1);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (4, 'Baby Shampoo', 6.33, 1);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (5, 'Pijama', 23.99, 1);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (6, 'Make-up', 105.99, 3);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (7, '20x Zoom Lens', 234.99, 4);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (8, 'Camera Case', 24.99, 4);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (9, 'Galaxy S9 Case', 6.00, 5);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (10, 'Gorilla Glass', 16.40, 5);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (11, 'Oldest Penny', 1110.60, 6);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (12, '60 inch flat screen', 2300.00, 7);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (13, 'Bose Sound System', 560.49, 7);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (14, 'Parasite movie Blueray', 29.99, 8);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (15, 'Barbie movie', 5.00, 8);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (16, 'Picasso painting', 1345600.99, 9);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (17, 'Daly painting', 2221399.00, 9);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (18, 'Granola Cereal', 4.99, 10);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (19, 'Shrimp', 50.01, 10);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (20, 'Eggs 12 count', 2.99, 10);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (21, 'Deodorant', 6.00, 11);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (22, 'Skin care cream', 5.00, 11);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (23, 'P90x', 21.03, 11);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (24, 'coin bag', 9.99, 13);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (25, 'Nuclear Calculator', 234.90, 14);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (26, 'Drug #8', 70000.00, 14);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (27, 'Guitar Fender', 233.00, 16);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (28, 'Paper White', 0.99, 17);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (29, 'Cheese balls', 0.35, 17);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (30, 'Crampons', 93.00, 18);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (31, 'Hiking Shoes', 270.00, 18);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (32, 'water filter', 24.00, 18);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (33, 'Hoddie', 56.90, 18);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (34, 'Macbook', 2443.00, 19);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (35, 'Jumbo', 23.00, 20);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (36, 'Snacks for doggie', 45.00, 20);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (37, 'Excel', 234.00, 21);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (38, 'Tableau', 45678.00, 21);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (39, 'baseball bat', 243.00, 22);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (40, '12 inch glove nike', 345.00, 22);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (41, 'Running shoes', 30.00, 22);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (42, 'catan', 50.00, 23);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (43, 'codenames', 26.00, 23);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (44, 'ball', 5.00, 23);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (45, 'call of duty', 99.90, 24);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (46, 'mortal kombat', 9.99, 24);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (47, 'simpsons', 23.00, 24);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (48, 'hannah montana', 51.00, 24);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (49, 'the most expensive watch', 359.99, 25);
INSERT INTO products (product_id, name, list_price, category_id) VALUES (50, 'the second most expensive watch', 350.00, 25);

-- sales
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (1, 2, 9.98, 0.00, 1, 1);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (2, 20, 521.00, 0.00, 1, 2);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (3, 3, 54.57, 0.00, 2, 3);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (4, 50, 316.50, 0.00, 3, 4);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (5, 3, 71.97, 0.00, 4, 5);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (6, 14, 1483.86, 0.00, 4, 6);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (7, 18, 4229.82, 0.00, 4, 7);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (8, 19, 474.81, 0.00, 4, 8);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (9, 18, 108.00, 0.00, 5, 9);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (10, 11, 180.40, 0.00, 6, 10);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (11, 200, 22120.00, 0.00, 7, 11);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (12, 900, 2070000.00, 0.00, 7, 12);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (13, 123, 68940.27, 0.00, 7, 13);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (14, 1, 29.99, 0.00, 8, 14);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (15, 5, 25.00, 0.00, 9, 15);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (16, 7, 9419206.93, 0.00, 10, 16);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (17, 8, 17771192.00, 0.00, 11, 17);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (18, 9, 44.91, 0.00, 12, 18);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (19, 65, 3250.65, 0.00, 13, 19);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (20, 43, 128.57, 0.00, 14, 20);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (21, 3, 18.00, 0.00, 15, 21);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (22, 2, 10.00, 0.00, 16, 22);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (23, 1, 21.03, 0.00, 16, 23);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (24, 110, 2313.30, 0.00, 16, 23);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (25, 10, 210.30, 0.00, 16, 23);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (26, 11, 109.89, 0.00, 16, 24);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (27, 21, 2583.90, 0.00, 16, 25);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (28, 45, 3150000, 0.00, 16, 26);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (29, 32, 11.20, 0.00, 16, 29);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (30, 76, 7068.00, 0.00, 16, 30);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (31, 89, 217427.00, 0.00, 17, 34);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (32, 76, 185668.00, 0.00, 17, 34);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (33, 54, 131922.00, 0.00, 18, 34);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (34, 56, 136808.00, 0.00, 19, 34);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (35, 76, 1748.00, 0.00, 19, 35);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (36, 30, 1350.00, 0.00, 20, 36);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (37, 2, 468.00, 0.00, 21, 37);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (38, 43, 1964154.00, 0.00, 21, 38);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (39, 45, 10935.00, 0.00, 21, 39);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (40, 1, 345.00, 0.00, 22, 40);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (41, 2, 60.00, 0.00, 23, 41);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (42, 5, 250.00, 0.00, 24, 42);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (43, 6, 156.00, 0.00, 25, 43);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (44, 7, 35.00, 0.00, 25, 44);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (45, 9, 207.00, 0.00, 25, 47);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (46, 10, 230.00, 0.00, 25, 47);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (47, 22, 7919.78, 0.00, 25, 49);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (48, 23, 8279.77, 0.00, 25, 49);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (49, 24, 8639.76, 0.00, 25, 49);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (50, 20, 7000.00, 0.00, 25, 50);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (51, 0, 7000.00, 0.00, 25, 50);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (52, 100, 0, 0.00, 25, 50);
INSERT INTO sales (sale_id, quantity, price_paid, discount, customer_id, product_id) VALUES (53, 45, 310000, 0.00, 16, 27);


-- old Queries 
-- select c.customer_id, sum(s.quantity) as "quantity sold", sum(s.price_paid) as "dollar value"
-- from sales s
-- join customers c
-- on s.customer_id = c.customer_id
-- group by c.customer_id
-- ;


-- select st.name as "state", sum(s.quantity) as "quantity sold", sum(s.price_paid) as "dollar value"
-- from sales s
-- join customers c
-- on s.customer_id = c.customer_id
-- join states st
-- on c.state_id = st.state_id
-- group by st.name
-- ;


-- select c.customer_id, p.name as "product name", sum(s.quantity) as "quantity sold", sum(s.price_paid) as "dollar value"
-- from sales s
-- join customers c
-- on s.customer_id = c.customer_id
-- join products p
-- on s.product_id = p.product_id 
-- where (c.customer_id = 25) and (s.quantity != 0) and (s.price_paid != 0)
-- group by p.name, c.customer_id
-- order by "dollar value" desc
-- ;


-- select c.customer_id, p.product_id, sum(s.quantity) as "quantity sold", sum(s.price_paid) as "dollar value"
-- from sales s
-- join customers c
-- on s.customer_id = c.customer_id
-- join products p
-- on s.product_id = p.product_id 
-- group by p.product_id, c.customer_id
-- order by "dollar value" desc
-- ;


-- select cat.name as "product category", st.name as "state", sum(s.quantity) as "quantity sold", sum(s.price_paid) as "dollar value"
-- from sales s
-- join customers c
-- on s.customer_id = c.customer_id
-- join products p
-- on s.product_id = p.product_id 
-- join states st
-- on c.state_id = st.state_id
-- join categories cat
-- on cat.category_id = p.category_id
-- group by cat.name, st.name
-- ;


-- select s.product_id as "top product", s.customer_id as "top customer", sum(s.quantity) as "quantity sold", sum(s.price_paid) as "dollar value"
-- from sales s
-- join customers c
-- on s.customer_id = c.customer_id
-- join products p
-- on s.product_id = p.product_id 
-- join categories cat
-- on cat.category_id = p.category_id
-- where 
--     (cat.category_id in (
--     select cat.category_id
--     from sales s
--     join products p
--     on s.product_id = p.product_id 
--     join categories cat
--     on cat.category_id = p.category_id
--     group by cat.category_id
--     order by sum(s.price_paid) desc
--     limit 20 )
--     ) 
--     and 
--     (c.customer_id in (
--     select c.customer_id
--     from sales s
--     join customers c
--     on s.customer_id = c.customer_id
--     group by c.customer_id
--     order by sum(s.price_paid) desc
--     limit 20 )
--     ) 
-- group by s.product_id, s.customer_id
-- ;



-- new Queries 

-- 1. Total sales for each customer
select c.customer_id, c.first_name, c.last_name, coalesce(sum(s.quantity),0) 
    as "quantity sold", coalesce(sum(s.price_paid), cast(0 as decimal(36,2))) as "dollar value"
from customers c
left join sales s
on s.customer_id = c.customer_id
group by c.customer_id
order by "dollar value" desc
;

-- 2. Total sales for each state
select st.state_id, st.name as "state name", coalesce(sum(s.quantity), 0) 
    as "quantity sold", coalesce(sum(s.price_paid), cast(0 as decimal(36,2))) as "dollar value"
from sales s
join customers c
on s.customer_id = c.customer_id
right join states st
on c.state_id = st.state_id
group by st.name, st.state_id
order by "dollar value" desc
;

-- 3. Total sales for each product for a given customer
select c.customer_id, c.first_name, c.last_name, p.name as "product name", 
    sum(s.quantity) as "quantity sold", sum(s.price_paid) as "dollar value"
from sales s
join customers c
on s.customer_id = c.customer_id
join products p
on s.product_id = p.product_id 
-- Define customer and exclude zero entries for qty and price 
where (c.customer_id = 25) and (s.quantity != 0) and (s.price_paid != 0) 
group by p.name, c.customer_id
order by "dollar value" desc
;

-- 4. Total sales for each product and customer
select c.customer_id, c.first_name, c.last_name, p.product_id, p.name 
    as "product name", coalesce(sum(s.quantity),0) as "quantity sold", 
    coalesce(sum(s.price_paid), cast(0 as decimal(36,2))) as "dollar value"
from products p
cross join customers c
left join sales s
on (s.product_id = p.product_id) and (c.customer_id = s.customer_id)
group by p.product_id, c.customer_id
order by "dollar value" desc
;

-- 5. Total sales for each product category and state
select cat.category_id, cat.name as "category name", st.state_id, st.name 
    as "state name", coalesce(sum(s.quantity),0) as "quantity sold", 
    coalesce(sum(s.price_paid), cast(0 as decimal(36,2))) as "dollar value"
from categories cat
cross join states st
left join products p
on p.category_id = cat.category_id
left join customers c
on st.state_id = c.state_id
left join sales s
on (s.product_id = p.product_id) and (c.customer_id = s.customer_id)
group by cat.category_id, st.state_id
order by "dollar value" desc
;

-- top 20 queries
-- select category,sales
-- from (
--  select cat.category_id as category, sum(s.price_paid) as sales, dense_rank() over(order by sum(s.price_paid) desc) as rn
--  from sales s
--  join products p
--  on s.product_id = p.product_id 
--  join categories cat
--  on cat.category_id = p.category_id
--  group by cat.category_id
-- ) as t
-- where rn <= 20
-- ;

-- select customer, sales
-- from (
--  select customer_id as customer, sum(s.price_paid) as sales, dense_rank() over(order by sum(s.price_paid) desc) as rn
--  from sales s    
--  group by customer_id
--  order by sales desc
-- ) as t
-- where rn <= 20
-- ;


-- 6. Top 20 product categories and top 20 customers
-- select cat.category_id, cat.name as "top category", p.product_id, p.name as "top product", c.customer_id, c.first_name as "top customer first_name", c.last_name as "top customer last_name", coalesce(sum(s.quantity),0) as "quantity sold", coalesce(sum(s.price_paid),0) as "dollar value"
-- from products p
-- cross join customers c
-- left join categories cat
-- on cat.category_id = p.category_id
-- left join sales s
-- on (s.product_id = p.product_id) and (c.customer_id = s.customer_id)
-- where cat.category_id in -- keep categories from top 20 categories
--     (
--     -- select top 20 for categories
--     select category
--     from (
--         select cat.category_id as category, dense_rank() over(order by sum(s.price_paid) desc) as rn
--         from sales s
--         join products p
--         on s.product_id = p.product_id 
--         join categories cat
--         on cat.category_id = p.category_id
--         group by cat.category_id
--     ) as t1
--     where rn <= 20
--     ) 
--     and c.customer_id in -- keep customers from top 20 customers
--     (
--     -- select top 20 for customers
--     select customer
--     from (
--         select customer_id as customer, dense_rank() over(order by sum(s.price_paid) desc) as rn
--         from sales s    
--         group by customer_id
--     ) as t2
--     where rn <= 20
--     )
-- group by p.product_id, c.customer_id, cat.category_id
-- order by "dollar value" desc
-- ;

-- 6. Tuples for each of the top 20 product categories and top 20 customers
select t5.category_id, t5.name as "top category", t5.customer_id, t5.first_name 
    as "top customer first name", t5.last_name as "top customer last name", 
    coalesce(sum(s.quantity),0) as "quantity sold", coalesce(sum(s.price_paid),0) as "dollar value"
from sales s
join products p
on s.product_id = p.product_id
join categories cat
on cat.category_id = p.category_id
right join (
    select * from (
        -- select top 20 for categories
        select *
        from (
            select cat.category_id, cat.name, dense_rank() over(order by sum(s.price_paid) desc) as rn
            from sales s
            join products p
            on s.product_id = p.product_id
            join categories cat
            on cat.category_id = p.category_id
            group by cat.category_id, cat.name
            ) as t1
            where rn <= 20
            ) as t2
            cross join ( -- find all possible combinations ~400 with cross join
            -- select top 20 for customers
            select *
            from (
            select c.customer_id, c.first_name, c.last_name, dense_rank() over(order by sum(s.price_paid) desc) as rn
            from sales s    
            join customers c
            on s.customer_id = c.customer_id
            group by c.customer_id
            ) as t3
            where rn <= 20
            ) as t4
        ) as t5
-- join on categories and customers only
on cat.category_id = t5.category_id and s.customer_id = t5.customer_id
group by t5.category_id, t5.name, t5.customer_id, t5.first_name, t5.last_name
order by "dollar value" desc
;




















