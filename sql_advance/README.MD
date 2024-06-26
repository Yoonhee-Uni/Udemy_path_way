# SQL advanced exercise

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