/*
DEFAULT Constraint
Create a table named customer with:
customer_id (integer, primary key)
name (string, no constraint)
city (string, should have a default value of 'Unknown')
First, define the default value inside CREATE TABLE.
Then, drop and re-add the default constraint using ALTER TABLE.
 */

create table customer (
	customer_id int primary key,
	name varchar(255),
	city varchar(50) default 'Unknown'
);

-- droppping
ALTER TABLE customer DROP CONSTRAINT [PK__customer__CD65CB8562F919DF];



-- adding
ALTER TABLE customer ADD PRIMARY KEY(customer_id);


