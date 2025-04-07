/*
UNIQUE Constraint
Create a table named product with the following columns:
product_id (integer, should be unique)
product_name (string, no constraint)
price (decimal, no constraint)
First, define product_id as UNIQUE inside the CREATE TABLE statement.
Then, drop the unique constraint and add it again using ALTER TABLE.
Extend the constraint so that the combination of product_id and product_name must be unique. */

create table product (
	product_id int unique,
	product_name varchar(255),
	price decimal(10,2)
);

-- droppping the unique constraint
ALTER TABLE product DROP CONSTRAINT [UQ__product__47027DF4474F0D28];

-- adding the unique constraint
ALTER TABLE product ADD CONSTRAINT UNIQUE_ID UNIQUE(product_id);

-- Extend the constraint
ALTER TABLE product ADD CONSTRAINT UNIQUE_NAME_ID UNIQUE(product_id, product_name);

