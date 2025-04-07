/*
PRIMARY KEY Constraint
Create a table named orders with:
order_id (integer, should be the primary key)
customer_name (string, no constraint)
order_date (date, no constraint)
First, define the primary key inside the CREATE TABLE statement.
Then, drop the primary key and add it again using ALTER TABLE. */

create table orders (
	order_id int primary key,
	customer_name varchar(255),
	order_date date
);

-- droppping the primary key
ALTER TABLE orders DROP CONSTRAINT [PK__orders__4659622965212116];

-- adding the primary key
ALTER TABLE orders ADD PRIMARY KEY(order_id);


