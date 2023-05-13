/*
CREATE TABLE [Table1]
(
KeyCol int,
TblName char(20),
ColValue int
)
truncate table Table1
truncate table Table2
GO
CREATE TABLE [Table2]
(
KeyCol int,
TblName char(20),
ColValue int
)
GO
INSERT INTO 
	[Table2] 
	(KeyCol,TblName,ColValue) 
	VALUES
		 (1,'Table2',2) 
		,(3,'Table2',2) 
		,(4,'Table2',2) 
GO
INSERT INTO 
	[Table1] 
	(KeyCol,TblName,ColValue) 
	VALUES
		 (1,'Table1',1) 
		,(2,'Table1',1) 
GO
*/
SELECT 
	 a.*
FROM Table1 a
GO
SELECT 
	b.*
FROM
	Table2 b
GO
SELECT 
	 a.*
	,b.*,'Full Outer Join' as ShapeType
FROM Table1 a
FULL OUTER
JOIN
	Table2 b
ON
	a.KeyCol = b.KeyCol
GO
SELECT 
	 a.*
	,b.*,'Left Join' as ShapeType
FROM Table1 a
LEFT
JOIN
	Table2 b
ON
	a.KeyCol = b.KeyCol
GO
SELECT 
	 a.*
	,b.*,'Right Join' as ShapeType
FROM Table1 a
RIGHT
JOIN
	Table2 b
ON
	a.KeyCol = b.KeyCol

GO
SELECT 
	 a.*
	,b.*,'Inner Join' as ShapeType
FROM Table1 a
JOIN
	Table2 b
ON
	a.KeyCol = b.KeyCol
GO
SELECT 
	 a.*
	,b.*,'Cross Join' as ShapeType
FROM Table1 a
CROSS JOIN
	Table2 b
GO
SELECT 
	 a.*,'Union' as ShapeType
FROM Table1 a
UNION --remove duplicates
--UNION ALL --will not remove duplicates
SELECT 
	b.*,'Union' as ShapeType
FROM
	Table2 b
GO

CREATE FUNCTION apply_tbl(@Keycol int)
RETURNS TABLE
RETURN
	SELECT * from Table1 where ColValue = @Keycol 
GO
select 'sample use of TVF' as Example,* from apply_tbl(1)
GO
--CROSS APPLY
SELECT 
	* 
, 'Cross Apply' as Shape
from Table2 
CROSS APPLY  apply_tbl(KeyCol)
GO
--CROSS APPLY
SELECT 
	* 
, 'Outer Apply' as Shape
from Table2 
Outer APPLY  apply_tbl(KeyCol)


SELECT 'Sum_ColVal' AS Pivot_Example,   
  [1], [3], [4]  
FROM  
(
  SELECT KeyCol,ColValue
  FROM Table2
) AS SourceTable  
PIVOT  
(  
  SUM(ColValue)
  FOR KeyCol IN ( [1], [3], [4])  
) AS PivotTable;
GO


SELECT TblName, UnpivotColName, UnpivotColVal
FROM   
   (SELECT KeyCol, TblName, ColValue
   FROM Table2
   UNION
   SELECT KeyCol, TblName, ColValue
   FROM Table1
   ) p  
UNPIVOT  
   (UnpivotColVal FOR UnpivotColName IN   
      (KeyCol)  
)AS unpvt; 