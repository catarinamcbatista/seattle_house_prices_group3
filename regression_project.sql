# SQL questions - regression

create schema `house_price_regression`;

# Create a database called house_price_regression.

use house_price_regression;

# Select all the data from table house_price_data to check if the data was imported correctly

select*from house_price_data;

# Use sql query to find how many rows of data you have.

select COUNT(*) 
from house_price_data;

# Now we will try to find the unique values in some of the categorical columns:
# What are the unique values in the column bedrooms?

select distinct bedrooms, count(bedrooms) 
as total_bedrooms 
from house_price_data 
group by bedrooms;

# What are the unique values in the column bathrooms?

select distinct bathrooms, count(bathrooms) 
as total_bathrooms 
from house_price_data 
group by bathrooms;

# What are the unique values in the column floors?

select distinct floors, count(floors) 
as total_floors 
from house_price_data 
group by floors;

# What are the unique values in the column condition?

select distinct `condition`, count(`condition`) 
as total_condtion 
from house_price_data 
group by `condition`;

# What are the unique values in the column grade?

select distinct grade, count(grade) 
as total_grade 
from house_price_data 
group by grade;

# Arrange the data in a decreasing order by the price of the house. 
# Return only the IDs of the top 10 most expensive houses in your data.

select  price, ID 
from house_price_data 
order by price desc limit 10;

# What is the average price of all the properties in your data?

select round(avg(price),2)
as AVG_PRICE
from house_price_data;

# In this exercise we will use simple group by to check the properties of some of the categorical variables in our data

# What is the average price of the houses grouped by bedrooms? 
# The returned result should have only two columns, bedrooms and Average of the prices. 
# Use an alias to change the name of the second column.

select bedrooms, round(avg(price),2)
as AVG_PRICE
from house_price_data 
group by bedrooms;

# What is the average sqft_living of the houses grouped by bedrooms? 
# The returned result should have only two columns, bedrooms and Average of the sqft_living. 
# Use an alias to change the name of the second column.

select sqft_living, round(avg(price),2)
as AVG_PRICE
from house_price_data 
group by sqft_living;

# What is the average price of the houses with a waterfront and without a waterfront? 
# The returned result should have only two columns, waterfront and Average of the prices. 
# Use an alias to change the name of the second column.

select waterfront, round(avg(price),2)
as AVG_PRICE
from house_price_data 
group by waterfront;

# Is there any correlation between the columns condition and grade? 
# You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. 
# Visually check if there is a positive correlation or negative correlation or no correlation between the variables.

select 
round((Avg(`condition`* grade) - (Avg(`condition`) * Avg(grade))) / (std(`condition`) * std(grade)),6) as correlation
from house_price_data;

# One of the customers is only interested in the following houses:

# Number of bedrooms either 3 or 4

select id, price, bedrooms
from house_price_data where bedrooms>2 and bedrooms<5;

# Bathrooms more than 3

select id, price, bathrooms
from house_price_data where bathrooms>3;

# One Floor

select id, price, floors
from house_price_data where floors=1;

# No waterfront

select id, price, waterfront
from house_price_data where waterfront=0;

# Condition should be 3 at least

select id, price, `condition`
from house_price_data where `condition`>=3;

# Grade should be 5 at least

select id, price, grade
from house_price_data where grade>=5;

# Price less than 300000

select id, price
from house_price_data where grade<300000;

# Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. 
# Write a query to show them the list of such properties. 
# You might need to use a sub query for this problem.

select id, price 
from house_price_data 
where price > (select 2*avg(price) as double_avg_price from house_price_data) order by price;

# Since this is something that the senior management is regularly interested in, create a view of the same query.

create view double_avg as 
select id, price 
from house_price_data 
where price > (select 2*avg(price) as double_avg_price from house_price_data) 
order by price;

# Most customers are interested in properties with three or four bedrooms. 
# What is the difference in average prices of the properties with three and four bedrooms?

select ((select avg(price) from house_price_data where bedrooms=4)-
(select avg(price) from house_price_data where bedrooms=3)) 
as difference_avg_price from house_price_data;

# What are the different locations where properties are available in your database? 
# (distinct zip codes)

select distinct zipcodes, count(zipcodes) 
as total_zipcodes 
from house_price_data 
group by zipcodes;

# Show the list of all the properties that were renovated.

select id, yr_renovated
from house_price_data where yr_renovated>0;

# Provide the details of the property that is the 11th most expensive property in your database.

select*from house_price_data order by price desc, id asc limit 1 offset 10;