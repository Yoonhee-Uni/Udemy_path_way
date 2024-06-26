USE AdventureWorks2019;

-- SELECT * FROM Person.EmailAddress;

-- SUM all the sales YTD
SELECT BusinessEntityID, TerritoryID, SalesQuota, Bonus, CommissionPCT, SalesYTD, TotalYTDSales = SUM(SalesYTD) OVER(),
MaxYTDSales = MAX(SalesYTD) OVER(),
[% of Best performer] = SalesYTD/ MAX(SalesYTD) OVER()

FROM Sales.SalesPerson

SELECT MAX(SalesYTD)
FROM Sales.SalesPerson; 


-- Exercise 1
SELECT AverageRate = AVG(Rate)
FROM HumanResources.EmployeePayHistory;
SELECT 
P.FirstName, P.LastName, H.JobTitle, E.Rate, 
AverageRate = AVG(E.Rate) OVER()
FROM Person.Person P
JOIN HumanResources.Employee H
ON P.BusinessEntityID =  H.BusinessEntityID
JOIN HumanResources.EmployeePayHistory E
ON H.BusinessEntityID = E.BusinessEntityID;

-- Exercise 2
SELECT 
P.FirstName, P.LastName, H.JobTitle, E.Rate, 
AverageRate = AVG(E.Rate) OVER(),
MaximumRate = MAX(E.Rate) OVER()
FROM Person.Person P
JOIN HumanResources.Employee H
ON P.BusinessEntityID =  H.BusinessEntityID
JOIN HumanResources.EmployeePayHistory E
ON H.BusinessEntityID = E.BusinessEntityID;


-- Exercise 3
SELECT 
P.FirstName, P.LastName, H.JobTitle, E.Rate, 
AverageRate = AVG(E.Rate) OVER(),
MaximumRate = MAX(E.Rate) OVER(),
DiffFromAvgRate = E.Rate - AVG(E.Rate) OVER()

FROM Person.Person P
JOIN HumanResources.Employee H
ON P.BusinessEntityID =  H.BusinessEntityID
JOIN HumanResources.EmployeePayHistory E
ON H.BusinessEntityID = E.BusinessEntityID;

-- Exercise 4
SELECT 
P.FirstName, P.LastName, H.JobTitle, E.Rate, 
AverageRate = AVG(E.Rate) OVER(),
MaximumRate = MAX(E.Rate) OVER(),
DiffFromAvgRate = E.Rate - AVG(E.Rate) OVER(),
PercentofMaxRate = (E.Rate / MAX(E.Rate)OVER() )*100

FROM Person.Person P
JOIN HumanResources.Employee H
ON P.BusinessEntityID =  H.BusinessEntityID
JOIN HumanResources.EmployeePayHistory E
ON H.BusinessEntityID = E.BusinessEntityID;


--PARTITION BY
--Exercise 1

SELECT 
P.Name AS ProductName , 
P.ListPrice, 
PP.Name AS ProductSubcategory,
PPC.Name AS ProductCategory

FROM Production.Product P
JOIN Production.ProductSubcategory PP
ON P.ProductSubcategoryID = PP.ProductSubcategoryID
JOIN Production.ProductCategory PPC
ON PP.ProductCategoryID = PPC.ProductCategoryID;

--Exercise 2
SELECT 
P.Name AS ProductName , 
P.ListPrice, 
PP.Name AS ProductSubcategory,
PPC.Name AS ProductCategory,
AvgPriceByCategory = AVG(P.ListPrice) OVER(PARTITION BY PPC.Name)

FROM Production.Product P
JOIN Production.ProductSubcategory PP
ON P.ProductSubcategoryID = PP.ProductSubcategoryID
JOIN Production.ProductCategory PPC
ON PP.ProductCategoryID = PPC.ProductCategoryID;


--Exercise 3
SELECT 
P.Name AS ProductName , 
P.ListPrice, 
PP.Name AS ProductSubcategory,
PPC.Name AS ProductCategory,
AvgPriceByCategory = AVG(P.ListPrice) OVER(PARTITION BY PPC.Name),
AvgPriceByCategoryAndSubcategory =  AVG(P.ListPrice) OVER(PARTITION BY PP.Name, PPC.Name)

FROM Production.Product P
JOIN Production.ProductSubcategory PP
ON P.ProductSubcategoryID = PP.ProductSubcategoryID
JOIN Production.ProductCategory PPC
ON PP.ProductCategoryID = PPC.ProductCategoryID;

--Exercise 4
SELECT 
P.Name AS ProductName , 
P.ListPrice, 
PP.Name AS ProductSubcategory,
PPC.Name AS ProductCategory,
AvgPriceByCategory = AVG(P.ListPrice) OVER(PARTITION BY PPC.Name),
AvgPriceByCategoryAndSubcategory =  AVG(P.ListPrice) OVER(PARTITION BY PP.Name, PPC.Name),
ProductVsCategoryDelta = (P.ListPrice - AVG(P.ListPrice) OVER(PARTITION BY PPC.Name))

FROM Production.Product P
JOIN Production.ProductSubcategory PP
ON P.ProductSubcategoryID = PP.ProductSubcategoryID
JOIN Production.ProductCategory PPC
ON PP.ProductCategoryID = PPC.ProductCategoryID;




