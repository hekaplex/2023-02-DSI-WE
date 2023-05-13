--PIVOT
-- Pivot table with one row and five columns  
USE AdventureWorks2019 ;  
GO  
SELECT DaysToManufacture, AVG(StandardCost) AS AverageCost   
FROM Production.Product  
GROUP BY DaysToManufacture;  
/*
DaysToManufacture	AverageCost
0	5.0885
1	223.88
2	359.1082
4	949.4105
*/
GO
--PIVOT Sample
SELECT 'AverageCost' AS Cost_Sorted_By_Production_Days,   
  [0], [1], [2], [3], [4]  
FROM  
(
  SELECT DaysToManufacture, StandardCost   
  FROM Production.Product
) AS SourceTable  
PIVOT  
(  
  AVG(StandardCost)  
  FOR DaysToManufacture IN ([0], [1], [2], [3], [4])  
) AS PivotTable;

UNPIVOT

DROP TABLE pvt 
CREATE TABLE pvt (VendorID INT, Emp1 INT, Emp2 INT,  
    Emp3 INT, Emp4 INT, Emp5 INT);  
GO  
INSERT INTO pvt VALUES (1,4,3,5,4,4);  
INSERT INTO pvt VALUES (2,4,1,5,5,5);  
INSERT INTO pvt VALUES (3,4,3,5,4,4);  
INSERT INTO pvt VALUES (4,4,2,5,5,4);  
INSERT INTO pvt VALUES (5,5,1,5,5,5);  
GO  
/*
VendorID	Emp1	Emp2	Emp3	Emp5	Emp4
1	4	3	5	4	4
2	4	1	5	5	5
3	4	3	5	4	4
4	4	2	5	4	5
5	5	1	5	5	5
*/
-- Unpivot the table.  
SELECT VendorID, Employee, Orders  
FROM   
   (SELECT VendorID, Emp1, Emp2, Emp3, Emp4, Emp5  
   FROM pvt) p  
UNPIVOT  
   (Orders FOR Employee IN   
      (Emp1, Emp2, Emp3, Emp4, Emp5)  
)AS unpvt;  
GO  