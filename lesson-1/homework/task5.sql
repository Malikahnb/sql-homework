/*
CHECK Constraint
Create a table named account with:
account_id (integer, primary key)
balance (decimal, should always be greater than or equal to 0)
account_type (string, should only accept values 'Saving' or 'Checking')
Use CHECK constraints to enforce these rules.
First, define the constraints inside CREATE TABLE.
Then, drop and re-add the CHECK constraints using ALTER TABLE.
 */

create table account (
	account_id int primary key,
	balance decimal(10,2) check (balance >= 0),
	account_type varchar(50) check (account_type IN ('Saving', 'Checking'))
);

-- droppping
ALTER TABLE account DROP CONSTRAINT [CK__account__balance__534D60F1];
ALTER TABLE account DROP CONSTRAINT [CK__account__account__5441852A];



-- adding
ALTER TABLE account ADD CONSTRAINT chk_balance CHECK (balance >= 0);
ALTER TABLE account ADD CONSTRAINT chk_account_type CHECK (account_type IN ('Saving', 'Checking'));


