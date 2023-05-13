CREATE FUNCTION Largest_Order()
RETURNS TABLE AS 
RETURN
	(SELECT TOP 1 ORDERID, 
	SUM(QUANTITY) 
	AS ORDERTOTAL
	FROM [dbo].[OrderDetails]
	GROUP BY ORDERID
	ORDER BY ORDERTOTAL DESC)
;
GO
SELECT *
FROM [dbo].[Largest_Order]()

SELECT 
GO;


CREATE PROCEDURE 
[DBO].[CUSTOMERPERSTATE] 

AS 
DECLARE
		@[CustState] NVARCHAR(20)
SET 
	@CUSTSTATE =
	(
	SELECT [CustState]
	FROM[dbo].[Customers]
	WHERE  [CustState] = STATE
	)
GO;

EXEC CUSTOMERPERSTATE @STATE = 'CA'

;
select [dbo].[OrderDetails].[Quantity],[dbo].[Items].[Artist],[dbo].[Items].[UnitPrice]
FROM [dbo].[Items]
join [dbo].[OrderDetails] on [dbo].[Items].[ItemID]=[dbo].[OrderDetails].[ItemID]
order by [dbo].[Items].[Artist],
	Where Artist = '%burt%'
	sum(Quantity*UnitPrice)
	
	
	;





select  [ItemID],[Quantity]
FROM [dbo].[OrderDetails]
order by[ItemID],
	(
	select sum([Quantity])
	from [dbo].[OrderDetails]
	where [ItemID] = 1
	)
	



