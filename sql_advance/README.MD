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


# LEAD and LAG - Exercises
#### Exercise 1
    Create a query with the following columns:
    “PurchaseOrderID” from the Purchasing.PurchaseOrderHeader table
    “OrderDate” from the Purchasing.PurchaseOrderHeader table
    “TotalDue” from the Purchasing.PurchaseOrderHeader table
    “Name” from the Purchasing.Vendor table, which can be aliased as “VendorName”*
    *Join Purchasing.Vendor to Purchasing.PurchaseOrderHeader on BusinessEntityID = VendorID


    Apply the following criteria to the query:
    Order must have taken place on or after 2013
    TotalDue must be greater than $500

#### Exercise 2
    Modify your query from Exercise 1 by adding a derived column called
    "PrevOrderFromVendorAmt", that returns the “previous” TotalDue value (relative to the current row) within the group of all orders with the same vendor ID. We are defining “previous” based on order date.

#### Exercise 3
    Modify your query from Exercise 2 by adding a derived column called
    "NextOrderByEmployeeVendor", that returns the “next” vendor name (the “name” field from Purchasing.Vendor) within the group of all orders that have the same EmployeeID value in Purchasing.PurchaseOrderHeader. Similar to the last exercise, we are defining “next” based on order date.

#### Exercise 4
    Modify your query from Exercise 3 by adding a derived column called "Next2OrderByEmployeeVendor" that returns, within the group of all orders that have the same EmployeeID, the vendor name offset TWO orders into the “future” relative to the order in the current row. The code should be very similar to Exercise 3, but with an extra argument passed to the Window Function used.

# FIRST_VALUE - Exercises
#### Exercise 1
    Create a query that returns all records - and the following columns - from the HumanResources.Employee table:

    a. BusinessEntityID (alias this as “EmployeeID”)
    b. JobTitle
    c. HireDate
    d. VacationHours

    To make the effect of subsequent steps clearer, also sort the query output by "JobTitle" and HireDate, both in ascending order.

    Now add a derived column called “FirstHireVacationHours” that displays – for a given job title – the amount of vacation hours possessed by the first employee hired who has that same job title. For example, if 5 employees have the title “Data Guru”, and the one of those 5 with the oldest hire date has 99 vacation hours, “FirstHireVacationHours” should display “99” for all 5 of those employees’ corresponding records in the query.

Exercise 2
    Create a query with the following columns:

    a. “ProductID” from the Production.Product table
    b. “Name” from the Production.Product table (alias this as “ProductName”)
    c. “ListPrice” from the Production.ProductListPriceHistory table
    d. “ModifiedDate” from the Production.ProductListPriceHistory

    You can join the Production.Product and Production.ProductListPriceHistory tables on "ProductID".

    Note that the Production.ProductListPriceHistory table contains a distinct record for every different price a product has been listed at. This means that a single product ID may have several records in this table – one for every list price it has had.

    Also note that the “ModifiedDate” field in this table displays the effective date of each of these prices. So if there are 3 rows in the table for product ID 12345, the row with the oldest modified date also contains the first price in the associated product’s history. Conversely, the row with the most recent modified date also contains the current price of the product.

    To make the effect of subsequent steps clearer, also sort the query output by ProductID and ModifiedDate, both in ascending order.

    Now add a derived column called “HighestPrice” that displays – for a given product – the highest price that product has been listed at. So even if there are 4 records for a given product, this column should only display the all-time highest list price for that product in each of those 4 rows.

    Similarly, create another derived column called “LowestCost” that displays the all-time lowest price for a given product.

    Finally, create a third derived column called “PriceRange” that reflects, for a given product, the difference between its highest and lowest ever list prices.

# Introducing Subqueries - Exercises
#### Exercise 1

    Write a query that displays the three most expensive orders, per vendor ID, from the Purchasing.PurchaseOrderHeader table. There should ONLY be three records per Vendor ID, even if some of the total amounts due are identical. "Most expensive" is defined by the amount in the "TotalDue" field.

    Include the following fields in your output:
    PurchaseOrderID
    VendorID
    OrderDate
    TaxAmt
    Freight
    TotalDue

    Hints:
    You will first need to define a field that assigns a unique rank to every purchase order, within each group of like vendor IDs.
    You'll probably want to use a Window Function with PARTITION BY and ORDER BY to do this.
    The last step will be to apply the appropriate criteria to the field you created with your Window Function.

#### Exercise 2

    Modify your query from the first problem, such that the top three purchase order amounts are returned, regardless of how many records are returned per Vendor Id.

    In other words, if there are multiple orders with the same total due amount, all should be returned as long as the total due amount for these orders is one of the top three.

    Ultimately, you should see three distinct total due amounts (i.e., the top three) for each group of like Vendor Ids. However, there could be multiple records for each of these amounts.

    Hint: Think carefully about how the different ranking functions (ROW_NUMBER, RANK, and DENSE_RANK) work, and which one might be best suited to help you here.

    Resources for this lecture

