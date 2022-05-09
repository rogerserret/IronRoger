# SQL analysis

# Create the data base
CREATE DATABASE credit_card_classification;

# Create a table and check that everything worked well
# I used Table Data Import Wizard to create the table and import data
# I first needed to clean the column names in Python because SQL was not working well with blank spaces when using alter commands on the next steps
SELECT *
FROM credit_card_data;

# Drop column 'Q4 Balance'
ALTER TABLE credit_card_data
DROP COLUMN q4_balance; 

SELECT *
FROM credit_card_data
LIMIT 10;

# Total amount of rows
SELECT COUNT(*)
FROM credit_card_data;

# Select unique values for:

#offer_accepted:
SELECT DISTINCT offer_accepted
FROM credit_card_data;

#reward:
SELECT DISTINCT reward
FROM credit_card_data;

#mailer_type:
SELECT DISTINCT mailer_type
FROM credit_card_data;

#credit_cards_held:
SELECT DISTINCT credit_cards_held
FROM credit_card_data;

#household_size:
SELECT DISTINCT household_size
FROM credit_card_data;

# customer_number of the top 10 customers with the highest average_balances: 
SELECT customer_number, ROUND(average_balance,1)
FROM credit_card_data
ORDER BY average_balance DESC
LIMIT 10;

# average balance of all customers:
SELECT ROUND(AVG(average_balance),1)
FROM credit_card_data;

# average balance of the customers grouped by Income Level:
SELECT income_level as 'Income level', ROUND(AVG(average_balance),1) as 'Average balance'
FROM credit_card_data
GROUP BY income_level;

# average balance of the customers grouped by number_of_bank_accounts_open:
SELECT bank_accounts_open as 'Number of bank accounts open', ROUND(AVG(average_balance),1) as 'Average balance'
FROM credit_card_data
GROUP BY bank_accounts_open;

# average number of credit cards held by customers for each of the credit card ratings:
SELECT credit_rating as 'Credit card rating', ROUND(AVG(credit_cards_held),3) as 'Number of credit cards held'
FROM credit_card_data
GROUP BY credit_rating;

# correlation between the columns credit_cards_held and number_of_bank_accounts_open
SELECT bank_accounts_open as 'Number of bank accounts open', ROUND(AVG(credit_cards_held),3) as 'Number of credit cards held'
FROM credit_card_data
GROUP BY bank_accounts_open;
# there is no correlation between the two variables

# focus on customers with the following properties:
	# Credit rating medium or high
	# Credit cards held 2 or less
	# Owns their own home
	# Household size 3 or more
SELECT *
FROM credit_card_data
WHERE credit_rating IN ('medium','high') 
AND credit_cards_held <= 2 
AND own_your_home = 'Yes' 
AND household_size >= 3;
# if we filter out the customers that already accepted the offer:
SELECT *
FROM credit_card_data
WHERE credit_rating IN ('medium','high') 
AND credit_cards_held <= 2 
AND own_your_home = 'Yes' 
AND household_size >= 3
AND offer_accepted = 'No';

# list of customers whose average balance is less than the average balance of all the customers in the database:
SELECT customer_number, average_balance
FROM credit_card_data
WHERE average_balance < (
SELECT ROUND(AVG(average_balance),1)
FROM credit_card_data);

# create a view of the last query:
CREATE VIEW customers_low_avg_balance AS
SELECT customer_number, average_balance
FROM credit_card_data
WHERE average_balance < (
SELECT ROUND(AVG(average_balance),1)
FROM credit_card_data);

# number of people who accepted the offer vs number of people who did not:
SELECT count(*) as Not_accepted, (SELECT count(*)
FROM credit_card_data
WHERE offer_accepted = 'Yes') as Accepted
FROM credit_card_data
WHERE offer_accepted = 'No';

# average balances of the customers with high credit card rating and low credit card rating
SELECT credit_rating, ROUND(AVG(average_balance),1)
FROM credit_card_data
GROUP BY credit_rating
HAVING credit_rating IN ('high','low');

# types of communication (mailer_type) and with how many customers were used:
SELECT mailer_type, COUNT(*)
FROM credit_card_data
GROUP BY mailer_type;
# both types of communication were used

# details of the customer that is the 11th least Q1_balance:
SELECT * 
FROM (SELECT *, DENSE_RANK() OVER (
        ORDER BY q1_balance
    ) my_rank
FROM credit_card_data) t1
WHERE t1.my_rank = 11;
#if we use Dense rank we find out that there are 3 customers with the 11th least Q1 balance but I find it more meaningful than randomly picking the 11th with row_number()





