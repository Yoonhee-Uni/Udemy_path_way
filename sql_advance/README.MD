# SQL advanced exercise
## Used  VScode, MS SQL , dataset of AdeventureWorks2019

#### Exercise 1
    Create a query with the following columns:
    1. FirstName and LastName, from the Person.Person table**
    2. JobTitle, from the HumanResources.Employee table**
    3. Rate, from the HumanResources.EmployeePayHistory table**
    4. A derived column called "AverageRate" that returns the average of all values in the "Rate" column, in each row

    **All the above tables can be joined on BusinessEntityID
    - All the tables can be inner joined, and you do not need to apply any criteria.


#### Exercise 2
    Enhance your query from Exercise 1 by adding a derived column called
    "MaximumRate" that returns the largest of all values in the "Rate" column, in each row.

#### Exercise 3
    Enhance your query from Exercise 2 by adding a derived column called
    "DiffFromAvgRate" that returns the result of the following calculation:
    An employees's pay rate, MINUS the average of all values in the "Rate" column.


#### Exercise 4
    Enhance your query from Exercise 3 by adding a derived column called
    "PercentofMaxRate" that returns the result of the following calculation:
    An employees's pay rate, DIVIDED BY the maximum of all values in the "Rate" column, times 100.


## PARTITION BY

#### Exercise 1
    Create a query with the following columns:
    1. “Name” from the Production.Product table, which can be alised as “ProductName”
        “ListPrice” from the Production.Product table
        “Name” from the Production. ProductSubcategory table, which can be alised as “ProductSubcategory”*
        “Name” from the Production.ProductCategory table, which can be alised as “ProductCategory”**

*Join Production.ProductSubcategory to Production.Product on “ProductSubcategoryID”
**Join Production.ProductCategory to ProductSubcategory on “ProductCategoryID”

All the tables can be inner joined, and you do not need to apply any criteria.

#### Exercise 2
    Enhance your query from Exercise 1 by adding a derived column called
    "AvgPriceByCategory " that returns the average ListPrice for the product category in each given row.

#### Exercise 3
    Enhance your query from Exercise 2 by adding a derived column called
    "AvgPriceByCategoryAndSubcategory" that returns the average ListPrice for the product category AND subcategory in each given row.

#### Exercise 4
    Enhance your query from Exercise 3 by adding a derived column called
    "ProductVsCategoryDelta" that returns the result of the following calculation:
    A product's list price, MINUS the average ListPrice for that product’s category.

## ROW_NUMBER()
#### Exercise 1
    Create a query with the following columns (feel free to borrow your code from Exercise 1 of the PARTITION BY exercises):

    “Name” from the Production.Product table, which can be alised as “ProductName”
    “ListPrice” from the Production.Product table
    “Name” from the Production. ProductSubcategory table, which can be alised as “ProductSubcategory”*
    “Name” from the Production.ProductCategory table, which can be alised as “ProductCategory”**
    *Join Production.ProductSubcategory to Production.Product on “ProductSubcategoryID”
    **Join Production.ProductCategory to ProductSubcategory on “ProductCategoryID”

    All the tables can be inner joined, and you do not need to apply any criteria.

#### Exercise 2
    Enhance your query from Exercise 1 by adding a derived column called

    "Price Rank " that ranks all records in the dataset by ListPrice, in descending order. That is to say, the product with the most expensive price should have a rank of 1, and the product with the least expensive price should have a rank equal to the number of records in the dataset.
#### Exercise 3
    Enhance your query from Exercise 2 by adding a derived column called

    "Category Price Rank" that ranks all products by ListPrice – within each category - in descending order. In other words, every product within a given category should be ranked relative to other products in the same category.

#### Exercise 4
    Enhance your query from Exercise 3 by adding a derived column called

    "Top 5 Price In Category" that returns the string “Yes” if a product has one of the top 5 list prices in its product category, and “No” if it does not. You can try incorporating your logic from Exercise 3 into a CASE statement to make this work.

    Resources for this lecture

# RANK and DENSE_RANK - Exercises
#### Exercise 1
    Using your solution query to Exercise 4 from the ROW_NUMBER exercises as a staring point, add a derived column called “Category Price Rank With Rank” that uses the RANK function to rank all products by ListPrice – within each category - in descending order. Observe the differences between the “Category Price Rank” and “Category Price Rank With Rank” fields.

#### Exercise 2
    Modify your query from Exercise 2 by adding a derived column called "Category Price Rank With Dense Rank" that that uses the DENSE_RANK function to rank all products by ListPrice – within each category - in descending order. Observe the differences among the “Category Price Rank”, “Category Price Rank With Rank”, and “Category Price Rank With Dense Rank” fields.

#### Exercise 3
    Examine the code you wrote to define the “Top 5 Price In Category” field back in the ROW_NUMBER exercises. Now that you understand the differences among ROW_NUMBER, RANK, and DENSE_RANK, consider which of these functions would be most appropriate to return a true top 5 products by price, assuming we want to see the top 5 distinct prices AND we want “ties” (by price) to all share the same rank.