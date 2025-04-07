/*
FOREIGN KEY Constraint
Create two tables:
category:
category_id (integer, primary key)
category_name (string)
item:
item_id (integer, primary key)
item_name (string)
category_id (integer, should be a foreign key referencing category_id in category table)
First, define the foreign key inside CREATE TABLE.
Then, drop and add the foreign key using ALTER TABLE. */

create table category (
	category_id int primary key,
	category_name varchar(255)
);

create table item (
	item_id int primary key,
	item_name varchar(255),
	category_id int foreign key references category(category_id)
);

-- droppping the foreign key
ALTER TABLE item DROP CONSTRAINT [FK__item__category_i__4E88ABD4];

-- adding the foreign key
ALTER TABLE item ADD CONSTRAINT FK_ITEM_CATEGORY FOREIGN KEY(category_id) REFERENCES category(category_id);


