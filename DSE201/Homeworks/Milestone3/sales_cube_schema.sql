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


