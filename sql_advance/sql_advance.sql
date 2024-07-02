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

--ROW_NUMBER()
SELECT
SalesOrderID,
SalesOrderDetailID,
LineTotal,
ProductIDLineTotal = SUM(LineTotal) OVER (PARTITION BY SalesOrderID),
Ranking = ROW_NUMBER() OVER (PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM Sales.SalesOrderDetail 
ORDER BY SalesOrderID;

SELECT
SalesOrderID,
SalesOrderDetailID,
LineTotal,
ProductIDLineTotal = SUM(LineTotal) OVER (PARTITION BY SalesOrderID),
Ranking = ROW_NUMBER() OVER (ORDER BY LineTotal DESC)
FROM Sales.SalesOrderDetail 
ORDER BY 5;


-- Exercise 2
SELECT 
P.Name AS ProductName , 
P.ListPrice, 
PP.Name AS ProductSubcategory,
PPC.Name AS ProductCategory,
ROW_NUMBER() OVER(ORDER BY P.ListPrice DESC) AS PriceRank

FROM Production.Product P
JOIN Production.ProductSubcategory PP
ON P.ProductSubcategoryID = PP.ProductSubcategoryID
JOIN Production.ProductCategory PPC
ON PP.ProductCategoryID = PPC.ProductCategoryID
ORDER BY 5;

-- Exercise 3
SELECT 
P.Name AS ProductName , 
P.ListPrice, 
PP.Name AS ProductSubcategory,
PPC.Name AS ProductCategory,
ROW_NUMBER() OVER(ORDER BY P.ListPrice DESC) AS PriceRank,
ROW_NUMBER() OVER (PARTITION BY PPC.Name ORDER BY P.ListPrice DESC) AS Category_Price_Rank

FROM Production.Product P
JOIN Production.ProductSubcategory PP
ON P.ProductSubcategoryID = PP.ProductSubcategoryID
JOIN Production.ProductCategory PPC
ON PP.ProductCategoryID = PPC.ProductCategoryID
ORDER BY 5;

-- Exercise 4
SELECT 
P.Name AS ProductName , 
P.ListPrice, 
PP.Name AS ProductSubcategory,
PPC.Name AS ProductCategory,
ROW_NUMBER() OVER(ORDER BY P.ListPrice DESC) AS PriceRank,
ROW_NUMBER() OVER (PARTITION BY PPC.Name ORDER BY P.ListPrice DESC) AS Category_Price_Rank,

CASE
    WHEN ROW_NUMBER() OVER (PARTITION BY PPC.Name ORDER BY P.ListPrice DESC) <= 5 THEN 'Yes'
    ELSE 'No'
END AS Top_5_Price_In_Category

FROM Production.Product P
JOIN Production.ProductSubcategory PP
ON P.ProductSubcategoryID = PP.ProductSubcategoryID
JOIN Production.ProductCategory PPC
ON PP.ProductCategoryID = PPC.ProductCategoryID
ORDER BY 5;


--Rank()
SELECT
SalesOrderID,
SalesOrderDetailID,
LineTotal,
Ranking = ROW_NUMBER() OVER (PARTITION BY SalesOrderID ORDER BY LineTotal DESC),
RankingWithRank = RANK() OVER (PARTITION BY SalesOrderID ORDER BY LineTotal DESC),
RankingWithDense_Rank = DENSE_RANK() OVER (PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM Sales.SalesOrderDetail 
;

-- RANK and DENSE_RANK - Exercises
-- Exercise 1
SELECT 
P.Name AS ProductName , 
P.ListPrice, 
PP.Name AS ProductSubcategory,
PPC.Name AS ProductCategory,
ROW_NUMBER() OVER(ORDER BY P.ListPrice DESC) AS PriceRank,
ROW_NUMBER() OVER (PARTITION BY PPC.Name ORDER BY P.ListPrice DESC) AS Category_Price_Rank,
CASE
    WHEN ROW_NUMBER() OVER (PARTITION BY PPC.Name ORDER BY P.ListPrice DESC) <= 5 THEN 'Yes'
    ELSE 'No'
END AS Top_5_Price_In_Category,

RANK() OVER(PARTITION BY PPC.Name ORDER BY P.ListPrice DESC) AS Category_Price_Rank_With_Rank

FROM Production.Product P
JOIN Production.ProductSubcategory PP
ON P.ProductSubcategoryID = PP.ProductSubcategoryID
JOIN Production.ProductCategory PPC
ON PP.ProductCategoryID = PPC.ProductCategoryID
;

-- Exercise 2
SELECT 
P.Name AS ProductName , 
P.ListPrice, 
PP.Name AS ProductSubcategory,
PPC.Name AS ProductCategory,
ROW_NUMBER() OVER(ORDER BY P.ListPrice DESC) AS PriceRank,
ROW_NUMBER() OVER (PARTITION BY PPC.Name ORDER BY P.ListPrice DESC) AS Category_Price_Rank,
CASE
    WHEN ROW_NUMBER() OVER (PARTITION BY PPC.Name ORDER BY P.ListPrice DESC) <= 5 THEN 'Yes'
    ELSE 'No'
END AS Top_5_Price_In_Category,

RANK() OVER(PARTITION BY PPC.Name ORDER BY P.ListPrice DESC) AS Category_Price_Rank_With_Rank,
DENSE_RANK() OVER(PARTITION BY PPC.Name ORDER BY P.ListPrice DESC) AS Category_Price_Rank_With_Dense_Rank

FROM Production.Product P
JOIN Production.ProductSubcategory PP
ON P.ProductSubcategoryID = PP.ProductSubcategoryID
JOIN Production.ProductCategory PPC
ON PP.ProductCategoryID = PPC.ProductCategoryID
;



--LEAD() AND LAG()
SELECT
SalesOrderID,
OrderDate,
CustomerID,
TotalDue,
NextTotalDue = LEAD(TotalDue,1) OVER(ORDER BY SalesOrderID),
PrevTotalDue = LAG(TotalDue,1) OVER(ORDER BY SalesOrderID)

FROM Sales.SalesOrderHeader
ORDER BY SalesOrderID;

--LEAD() AND LAG() and PARTITION BY
SELECT
SalesOrderID,
OrderDate,
CustomerID,
TotalDue,
NextTotalDue = LEAD(TotalDue,1) OVER(PARTITION BY CustomerID ORDER BY SalesOrderID),
PrevTotalDue = LAG(TotalDue,1) OVER(PARTITION BY CustomerID ORDER BY SalesOrderID)

FROM Sales.SalesOrderHeader
ORDER BY CustomerID, SalesOrderID ;

-- Exercise 1
SELECT 
PP.PurchaseOrderID,
PP.OrderDate,
PP.TotalDue,
VendorName = PV.Name

FROM Purchasing.PurchaseOrderHeader PP
JOIN Purchasing.Vendor PV
ON PV.BusinessEntityID = PP.VendorID
WHERE PP.TotalDue > 500 AND YEAR(PP.OrderDate) > 2013
ORDER BY PP.OrderDate
;

-- Exercise 2
SELECT 
PP.PurchaseOrderID,
PP.OrderDate,
PP.TotalDue,
VendorName = PV.Name,
PrevOrderFromVendorAmt = LAG(PP.TotalDue,1) OVER (PARTITION BY PP.VendorID ORDER BY PP.OrderDate)

FROM Purchasing.PurchaseOrderHeader PP
JOIN Purchasing.Vendor PV
ON PV.BusinessEntityID = PP.VendorID
WHERE PP.TotalDue > 500 AND YEAR(PP.OrderDate) > 2013

ORDER BY 
PP.VendorID,
PP.OrderDate
;

--Exercise 3
SELECT 
PP.PurchaseOrderID,
PP.OrderDate,
PP.TotalDue,
VendorName = PV.Name,
PrevOrderFromVendorAmt = LAG(PP.TotalDue,1) OVER (PARTITION BY PP.VendorID ORDER BY PP.OrderDate),
NextOrderByEmployeeVendor = LEAD(PV.Name,1) OVER (PARTITION BY PP.EmployeeID ORDER BY PP.OrderDate)

FROM Purchasing.PurchaseOrderHeader PP
JOIN Purchasing.Vendor PV
ON PV.BusinessEntityID = PP.VendorID
WHERE PP.TotalDue > 500 AND YEAR(PP.OrderDate) >= 2013

ORDER BY 
PP.EmployeeID,
PP.OrderDate
;

--Exercise 4
SELECT 
PP.PurchaseOrderID,
PP.OrderDate,
PP.TotalDue,
VendorName = PV.Name,
PrevOrderFromVendorAmt = LAG(PP.TotalDue,1) OVER (PARTITION BY PP.VendorID ORDER BY PP.OrderDate),
NextOrderByEmployeeVendor = LEAD(PV.Name,1) OVER (PARTITION BY PP.EmployeeID ORDER BY PP.OrderDate),
Next2OrderByEmployeeVendor = LEAD(PV.Name,2) OVER (PARTITION BY PP.EmployeeID ORDER BY PP.OrderDate)

FROM Purchasing.PurchaseOrderHeader PP
JOIN Purchasing.Vendor PV
ON PV.BusinessEntityID = PP.VendorID
WHERE PP.TotalDue > 500 AND YEAR(PP.OrderDate) >= 2013

ORDER BY 
PP.EmployeeID,
PP.OrderDate
;

--FIRST_VALUE()
SELECT
SalesOrderID,
SalesOrderDetailID,
LineTotal,
Ranking = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC),
HighestTotal = FIRST_VALUE(LineTotal) OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC),
LowestTotal = FIRST_VALUE(LineTotal) OVER(PARTITION BY SalesOrderID ORDER BY LineTotal)

FROM Sales.SalesOrderDetail
ORDER BY SalesOrderID, LineTotal DESC

--Custoemr orders by date
SELECT 
CustomerID,
OrderDate,
TotalDue,
FirstOrderAmt = FIRST_VALUE(TotalDue) OVER(PARTITION BY CustomerID ORDER BY OrderDate),
LastOrderAmt = FIRST_VALUE(TotalDue) OVER(PARTITION BY CustomerID ORDER BY OrderDate DESC)

FROM Sales.SalesOrderHeader
ORDER BY  CustomerID, OrderDate;

-- Exercise 1
SELECT
    EmployeeID = BusinessEntityID,
    JobTitle,
    HireDate,
    VacationHours,
    FirstHireVacationHours = FIRST_VALUE(VacationHours) OVER(PARTITION BY JobTitle ORDER BY HireDate)
FROM HumanResources.Employee 
ORDER BY JobTitle ASC, HireDate ASC;

-- Exercise 2
SELECT 
PP.ProductID,
ProductName = PP.Name,
PPLH.ListPrice,
PPLH.ModifiedDate,
HighestPrice = FIRST_VALUE(PPLH.ListPrice) OVER(PARTITION BY PP.ProductID ORDER BY PPLH.ListPrice DESC),
LowestPrice = FIRST_VALUE(PPLH.ListPrice) OVER(PARTITION BY PP.ProductID ORDER BY PPLH.ListPrice),
PriceRange = FIRST_VALUE(PPLH.ListPrice) OVER(PARTITION BY PP.ProductID ORDER BY PPLH.ListPrice DESC) - FIRST_VALUE(PPLH.ListPrice) OVER(PARTITION BY PP.ProductID ORDER BY PPLH.ListPrice)

FROM 
Production.Product PP
JOIN Production.ProductListPriceHistory PPLH
ON PP.ProductID = PPLH.ProductID
ORDER BY
PP.ProductID,
PPLH.ModifiedDate;

SELECT
	A.ProductID,
	ProductName = A.[Name],
	B.ListPrice,
    B.ModifiedDate,
	HighestPrice = FIRST_VALUE(B.ListPrice) OVER(PARTITION BY B.ProductID ORDER BY B.ListPrice DESC),
	LowestPrice = FIRST_VALUE(B.ListPrice) OVER(PARTITION BY B.ProductID ORDER BY B.ListPrice),
	PriceRange = FIRST_VALUE(B.ListPrice) OVER(PARTITION BY B.ProductID ORDER BY B.ListPrice DESC)-
		FIRST_VALUE(B.ListPrice) OVER(PARTITION BY B.ProductID ORDER BY B.ListPrice)

FROM AdventureWorks2019.Production.Product A
	JOIN AdventureWorks2019.Production.ProductListPriceHistory B
  ON A.ProductID = B.ProductID

ORDER BY A.ProductID, B.ModifiedDate

--Subqueries
SELECT *

FROM
(SELECT
SalesOrderID,
SalesOrderDetailID,
LineTotal,
LineTotalRanking = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM Sales.SalesOrderDetail
) A

WHERE LineTotalRanking =1;

-- Exercise 1
SELECT 
PurchaseOrderID,
VendorID,
OrderDate,
TaxAmt,
Freight,
TotalDue

FROM
(SELECT
PurchaseOrderID,
VendorID,
OrderDate,
TaxAmt,
Freight,
TotalDue,
Most_expensive = ROW_NUMBER() OVER(PARTITION BY VendorID ORDER BY TotalDue DESC)

FROM Purchasing.PurchaseOrderHeader
) A
WHERE Most_expensive BETWEEN 1 AND 3;

--Exercise 2
SELECT 
PurchaseOrderID,
VendorID,
OrderDate,
TaxAmt,
Freight,
TotalDue

FROM
(SELECT
PurchaseOrderID,
VendorID,
OrderDate,
TaxAmt,
Freight,
TotalDue,
Most_expensive = DENSE_RANK() OVER(PARTITION BY VendorID ORDER BY TotalDue DESC)

FROM Purchasing.PurchaseOrderHeader
) A
WHERE Most_expensive BETWEEN 1 AND 3;

--ROWS BETWEEN

-- Early 3days of sum INCLUDING CURRENT ROW
SELECT
OrderDate,
TotalDue,
SalesLast3Days = SUM(TotalDue) OVER(ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)

FROM(
SELECT
OrderDate,
TotalDue = SUM(TotalDue)
FROM
Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2014
GROUP BY OrderDate
) X

-- Early 3days of sum EXCLUDING CURRENT ROW
SELECT
OrderDate,
TotalDue,
SalesLast3Days = SUM(TotalDue) OVER(ORDER BY OrderDate ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING)

FROM(
SELECT
OrderDate,
TotalDue = SUM(TotalDue)
FROM
Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2014
GROUP BY OrderDate
) X;

--Span the current row and include the row prior and the row after.
-- Rolling 3day total, spanning previous and following row.
SELECT
OrderDate,
TotalDue,
SalesLast3Days = SUM(TotalDue) OVER(ORDER BY OrderDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) 

FROM(
SELECT
OrderDate,
TotalDue = SUM(TotalDue)
FROM
Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2014
GROUP BY OrderDate
) X;


-- Rolling 3 day average -aka, a "moving" average
SELECT
OrderDate,
TotalDue,
SalesLast3Days = AVG(TotalDue) OVER(ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 

FROM(
SELECT
OrderDate,
TotalDue = SUM(TotalDue)
FROM
Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2014
GROUP BY OrderDate
) X;


-- ROWS BETWEEN - Exercises
-- Exercise 1

SELECT 
OrderMonth = MONTH(OrderDate),
OrderYear = YEAR(OrderDate),
SubTotal = SUM(TotalDue)

FROM
Sales.SalesOrderHeader
GROUP BY OrderDate;

-- Exercise 2

SELECT
OrderMonth,
OrderYear,
SubTotal,
Rolling3MonthTotal = SUM(SubTotal) OVER(ORDER BY OrderMonth, OrderYear ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)

FROM
(SELECT 
OrderMonth = MONTH(OrderDate),
OrderYear = YEAR(OrderDate),
SubTotal = SUM(SubTotal)

FROM
Sales.SalesOrderHeader
GROUP BY OrderDate
) x;

-- Exercise 3

SELECT
OrderMonth,
OrderYear,
SubTotal,
Rolling3MonthTotal = SUM(SubTotal) OVER(ORDER BY OrderMonth, OrderYear ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
MovingAvg6Month = AVG(SubTotal) OVER(ORDER BY OrderMonth, OrderYear ROWS BETWEEN 6 PRECEDING AND 1 PRECEDING)

FROM
(SELECT 
OrderMonth = MONTH(OrderDate),
OrderYear = YEAR(OrderDate),
SubTotal = SUM(SubTotal)

FROM
Sales.SalesOrderHeader
GROUP BY OrderDate
) x;

-- Exercise 4
SELECT
OrderMonth,
OrderYear,
SubTotal,
Rolling3MonthTotal = SUM(SubTotal) OVER(ORDER BY OrderMonth, OrderYear ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
MovingAvg6Month = AVG(SubTotal) OVER(ORDER BY OrderMonth, OrderYear ROWS BETWEEN 6 PRECEDING AND 1 PRECEDING),
MovingAvgNext2Months = AVG(SubTotal) OVER(ORDER BY OrderMonth, OrderYear ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)

FROM
(SELECT 
OrderMonth = MONTH(OrderDate),
OrderYear = YEAR(OrderDate),
SubTotal = SUM(SubTotal)

FROM
Sales.SalesOrderHeader
GROUP BY OrderDate
) x;

-- Subqueries
SELECT
MAX(ListPrice)
FROM Production.Product;

SELECT 
AVG(ListPrice)
FROM Production.Product;

SELECT
ProductID,
Name,
StandardCost,
ListPrice,
AvgListPrice = (SELECT AVG(ListPrice) FROM Production.Product),
AvgListPriceDiff = ListPrice - (SELECT AVG(ListPrice) FROM Production.Product)
FROM Production.Product

WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product)
ORDER BY ListPrice;

-- Scalar Subqueries - Exercises
-- Exercise 1
SELECT 
BusinessEntityID,
JobTitle,
VacationHours,
MaxVacationHours = (SELECT MAX(VacationHours) FROM HumanResources.Employee)


FROM
HumanResources.Employee;

-- Exercise 2
SELECT 
BusinessEntityID,
JobTitle,
VacationHours,
MaxVacationHours = (SELECT MAX(VacationHours) FROM HumanResources.Employee),
PercentageOfVacationHours = (( VacationHours * 1.0 ) / (SELECT MAX(VacationHours) FROM HumanResources.Employee)*100)
FROM
HumanResources.Employee;

-- Exercise 3
SELECT 
BusinessEntityID,
JobTitle,
VacationHours,
MaxVacationHours = (SELECT MAX(VacationHours) FROM HumanResources.Employee),
PercentageOfVacationHours = (( VacationHours * 1.0 ) / (SELECT MAX(VacationHours) FROM HumanResources.Employee)*100)
FROM
HumanResources.Employee

WHERE (( VacationHours * 1.0 ) / (SELECT MAX(VacationHours) FROM HumanResources.Employee)*100)>  80;

-- Correlated Subqueries - Exercises
SELECT
SalesOrderID,
OrderDate,
SubTotal,
TaxAmt,
Freight,
TotalDue,
MultiOrderCount = 
    (
    SELECT COUNT(*)
    FROM Sales.SalesOrderDetail B
    WHERE B.SalesOrderID = A.SalesOrderID
    AND B.OrderQty > 1
    )
FROM Sales.SalesOrderHeader A;

SELECT SalesOrderID,
OrderQty
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43660;

-- Exercise 1
SELECT
PurchaseOrderID,
VendorID,
OrderDate,
TotalDue,

NonRejectedItems = 
    (
        SELECT COUNT(*)
        FROM Purchasing.PurchaseOrderDetail PPD
        WHERE PPD.PurchaseOrderID = PPO.PurchaseOrderID
        AND
        RejectedQty = 0
    )
FROM
Purchasing.PurchaseOrderHeader PPO;

-- SELECT PurchaseOrderID, RejectedQty
-- FROM Purchasing.PurchaseOrderDetail PPD
-- WHERE  RejectedQty > 0
-- ORDER BY PurchaseOrderDetailID

-- Exercise 2
SELECT
PurchaseOrderID,
VendorID,
OrderDate,
TotalDue,

NonRejectedItems = 
    (
        SELECT COUNT(*)
        FROM Purchasing.PurchaseOrderDetail PPD
        WHERE PPD.PurchaseOrderID = PPO.PurchaseOrderID
        AND
        RejectedQty = 0
    ),

MostExpensiveItem = 
    (
        SELECT MAX(UnitPrice)
        FROM Purchasing.PurchaseOrderDetail PPD
        WHERE PPD.PurchaseOrderID = PPO.PurchaseOrderID
    )


FROM
Purchasing.PurchaseOrderHeader PPO;

--EXISTS and NOT EXISTS
--Using exists to pick only the records we need
SELECT 
A.SalesOrderID,
A.OrderDate,
A.TotalDue
FROM Sales.SalesOrderHeader A
WHERE EXISTS(
    SELECT 
    1
    FROM Sales.SalesOrderDetail B
    WHERE B.LineTotal > 10000
    AND A.SalesOrderID = B.SalesOrderID
    
)

ORDER BY 1

-- Exclusionary one to many Join
SELECT
A.SalesOrderID,
A.OrderDate,
A.TotalDue,
B.SalesOrderDetailID,
B.LineTotal
FROM Sales.SalesOrderHeader A
INNER JOIN Sales.SalesOrderDetail B
ON A.SalesOrderID = B.SalesOrderID
WHERE B.LineTotal < 10000
AND A.SalesOrderID = 43683
ORDER BY 1;


--Using exists to pick only the records we need
SELECT 
A.SalesOrderID,
A.OrderDate,
A.TotalDue
FROM Sales.SalesOrderHeader A
WHERE NOT EXISTS(
    SELECT 
    1
    FROM Sales.SalesOrderDetail B
    WHERE B.LineTotal > 10000
    AND A.SalesOrderID = B.SalesOrderID
    
)

-- EXISTS - Exercises
-- Exercise 1
SELECT
    A.PurchaseOrderID,
    A.OrderDate,
    A.SubTotal,
    A.TaxAmt
FROM Purchasing.PurchaseOrderHeader A
WHERE EXISTS (
    SELECT 1
    FROM Purchasing.PurchaseOrderDetail B
    WHERE B.PurchaseOrderID = A.PurchaseOrderID
    AND B.OrderQty  > 500
)
ORDER BY 1;

-- Exercise 2
SELECT
    A.*
FROM Purchasing.PurchaseOrderHeader A
WHERE EXISTS (
    SELECT 1
    FROM Purchasing.PurchaseOrderDetail B
    WHERE B.PurchaseOrderID = A.PurchaseOrderID
    AND B.OrderQty  > 500
    AND B.UnitPrice > 50
)
ORDER BY 1;

-- Exercise 3
SELECT
    A.*
FROM Purchasing.PurchaseOrderHeader A
WHERE NOT EXISTS (
    SELECT 1
    FROM Purchasing.PurchaseOrderDetail B
    WHERE B.PurchaseOrderID = A.PurchaseOrderID
    AND B.RejectedQty > 0

)
ORDER BY 1;

SELECT * FROM Purchasing.PurchaseOrderDetail
WHERE RejectedQty = 0

--Flattning
SELECT
STUFF(
    (
    SELECT
    ',' + CAST(CAST(LineTotal AS MONEY) AS VARCHAR)
    FROM Sales.SalesOrderDetail A
    WHERE A.SalesOrderID = 43659
    FOR XML PATH('')
    ),
    1,1,'')

SELECT
SalesOrderID,
OrderDate,
SubTotal,
TaxAmt,
Freight,
TotalDue,
LineTotals = 
STUFF(
    (
    SELECT
    ',' + CAST(CAST(LineTotal AS MONEY) AS VARCHAR)
    FROM Sales.SalesOrderDetail B
    WHERE A.SalesOrderID = B.SalesOrderID
    FOR XML PATH('')
    ),
    1,1,'')
FROM Sales.SalesOrderHeader A

-- Exercise 1
SELECT
SubcategoryName = 
STUFF(
    (
    SELECT 
    ';' + B.Name
    FROM Production.Product B
    WHERE A.ProductSubcategoryID = B.ProductSubcategoryID
    FOR XML PATH('')
    ),
    1,1,''
)
FROM Production.ProductSubcategory A 

-- Exercise 2
SELECT
SubcategoryName = 
STUFF(
    (
    SELECT 
    ';' + B.Name
    FROM Production.Product B
    WHERE A.ProductSubcategoryID = B.ProductSubcategoryID
    AND  B.ListPrice > 50
    FOR XML PATH('')
    ),
    1,1,''
)
FROM Production.ProductSubcategory A;

--PIVOT
SELECT
[Bikes], [clothing], [Accessories], [Components]
FROM

(SELECT
ProductCategoryName = D.NAME, 
A.LineTotal

FROM Sales.SalesOrderDetail A
JOIN Production.Product B 
ON A.ProductID =B.ProductID
JOIN Production.ProductSubcategory C
ON B.ProductSubcategoryID = C.ProductSubcategoryID
JOIN Production.ProductCategory D
ON C.ProductCategoryID = D.ProductCategoryID
)A 

PIVOT(
    SUM(LineTotal)
    FOR ProductCategoryName IN ([Bikes], [clothing], [Accessories], [Components])
) B;

-- Another way of pivot
SELECT
[Order Quantity]= OrderQty,
[Bikes],
[clothing]
FROM

(SELECT
ProductCategoryName = D.NAME, 
A.LineTotal,
A.OrderQty

FROM Sales.SalesOrderDetail A
JOIN Production.Product B 
ON A.ProductID =B.ProductID
JOIN Production.ProductSubcategory C
ON B.ProductSubcategoryID = C.ProductSubcategoryID
JOIN Production.ProductCategory D
ON C.ProductCategoryID = D.ProductCategoryID
)A 

PIVOT(
    SUM(LineTotal)
    FOR ProductCategoryName IN ([Bikes], [clothing], [Accessories], [Components])
) B

ORDER BY 1;

-- FOR XML PATH With STUFF - Exercises
-- Exercise 1
SELECT 
[Sales Representative], [Buyer], [Janitor]
FROM HumanResources.Employee

PIVOT(
    AVG(VacationHours)
    FOR JobTitle IN ([Sales Representatives], [Buyers], [Janitors])
)
ORDER BY 1;