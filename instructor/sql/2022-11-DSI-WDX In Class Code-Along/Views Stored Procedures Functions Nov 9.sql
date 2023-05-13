USE [AP]
GO

/****** Object:  View [dbo].[TopVendors]    Script Date: 11/9/2022 9:19:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- int foo = 7
--Mandatory to create view you need CREATE VIEW
CREATE VIEW [dbo].[TopVendors_DM]
AS -- equivalent to '='
	SELECT 
		TOP 5 percent
		VendorID
		,InvoiceTotal
		,InvoiceDueDate
	FROM
		Invoices
	ORDER BY InvoiceTotal DESC
--two batch delimiter in Transact-SQL
-- semicolon ; 
-- GO
GO

--SELECT  123/20.0

select [TopVendors_DM].*
FROM
(SELECT 
		TOP 5 percent
		VendorID
		,InvoiceTotal
		,InvoiceDueDate
	FROM
		Invoices
	ORDER BY InvoiceTotal DESC
) AS [TopVendors_DM]

SELECT MAX(InvoiceTotal) FROM [TopVendors_DM]

USE [AP]
GO

/****** Object:  StoredProcedure [dbo].[VendorDetails]    Script Date: 11/9/2022 9:40:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--interface/prototype "contract" -  DML+ DQL + messages
ALTER PROCEDURE 
[dbo].[VendorDetails] 
--one @Vendor parameter of type int with a default of 95
@Vendor int = 95, @output OUTPUT
AS
--sandbox for variables we'll use in our logic
BEGIN
DECLARE
	@MaxInvoice money
	,@MinInvoice money
	,@PctDiff decimal(8,2)
	,@InvoiceQty int
	,@VendorIDVar int
--bring in parameter int our logic
SET
	@VendorIDVar = @Vendor
SET
	@MaxInvoice =
		(SELECT	MAX(InvoiceTotal)
			FROM Invoices
				WHERE VendorID = @VendorIDVar)
--Populating data from two variables in one select
-- implies one row or error will occur
SELECT
--@MaxInvoice =
--		MAX(InvoiceTotal),
	@MinInvoice =
			MIN(InvoiceTotal),
	@InvoiceQty =
		 COUNT(*)
			FROM Invoices
				WHERE VendorID = @VendorIDVar
SET @PctDiff =
--operator precedence
	((@MaxInvoice - @MinInvoice)/@MinInvoice) * 100
PRINT 'Vendor ID: '+ CONVERT(varchar,@Vendor)
PRINT 'Max Invoice is $'+CONVERT(varchar,@MaxInvoice ,1)+'.';
PRINT 'Min Invoice is $'+CONVERT(varchar,@MinInvoice ,1)+'.';
PRINT 'Maximum is '+CONVERT(varchar,@PctDiff)+'% more than minimum.';
PRINT 'Number of Invoices: '+CONVERT(varchar,@InvoiceQty)+'.';
--ading a table to be returned
SELECT
	@PctDiff AS [pctdiff]
RETURN @PctDiff  
END
GO

[dbo].[VendorDetails] 95

USE [AP]
GO

/****** Object:  UserDefinedFunction [dbo].[fnBalanceDue]    Script Date: 11/9/2022 10:08:59 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--scalar function - no parameter
CREATE FUNCTION [dbo].[fnBalanceDue]()
RETURNS money
BEGIN
RETURN (SELECT SUM(InvoiceTotal - PaymentTotal -
CreditTotal)
FROM Invoices
WHERE InvoiceTotal - PaymentTotal -
CreditTotal > 0);
END;
GO

DECLARE @moneyvar money 
EXEC @moneyvar = [dbo].[fnBalanceDue]
PRINT @moneyvar 


USE [AP]
GO

/****** Object:  UserDefinedFunction [dbo].[fnVendorID]    Script Date: 11/9/2022 10:13:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--scalar function with parameter
CREATE FUNCTION [dbo].[fnVendorID]
    (@VendorName varchar(50))
    RETURNS int
BEGIN
--USE A declare FOR LOCAL VARIABLE
    RETURN (SELECT VendorID FROM Vendors WHERE VendorName = @VendorName);
END;
GO
DECLARE @vendid int
EXEC @vendid  = [dbo].[fnVendorID] 'Jobtrak'
PRINT @vendid 

SELECT 
VendorName
,[dbo].[fnVendorID] (VendorName) as VendorID
from
Vendors


USE [AP]
GO

/****** Object:  UserDefinedFunction [dbo].[fnTopVendorsDue]    Script Date: 11/9/2022 10:18:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--TVF Table Valued Function with parameter
--sp_depends [fnTopVendorsDue] shows dependency
ALTER FUNCTION [dbo].[fnTopVendorsDue]
    (@CutOff money = 0)
    RETURNS TABLE
--insert complex logic
RETURN
	(SELECT 
	TOP 100 percent 
	VendorName, SUM(InvoiceTotal) AS TotalDue
	FROM Vendors JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
	WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0
	GROUP BY VendorName
	HAVING SUM(InvoiceTotal) >= @CutOff
	ORDER BY SUM(InvoiceTotal) DESC
	)
GO

SELECT * FROM [fnTopVendorsDue](7000)


CREATE FUNCTION [dbo].[fnPctDiff]
    (@Min money, @Max money)
    RETURNS float
BEGIN
DECLARE
	@MaxInvoice money
	,@MinInvoice money
	,@PctDiff decimal(8,2)
	,@InvoiceQty int
	,@VendorIDVar int
--bring in parameter int our logic
SET
	@VendorIDVar = @Vendor
SET
	@MaxInvoice =
		(SELECT	MAX(InvoiceTotal)
			FROM Invoices
				WHERE VendorID = @VendorIDVar)
--Populating data from two variables in one select
-- implies one row or error will occur
SELECT
--@MaxInvoice =
--		MAX(InvoiceTotal),
	@MinInvoice =
			MIN(InvoiceTotal),
	@InvoiceQty =
		 COUNT(*)
			FROM Invoices
				WHERE VendorID = @VendorIDVar

--USE A declare FOR LOCAL VARIABLE
    RETURN ROUND(((@Max- @Min)/@Min) * 100,2);
END;
GO


with agg as
(SELECT
	VendorID
	,MIN(InvoiceTotal) mintotal
	,MAX(InvoiceTotal) maxtotal
	into agg
	from invoices
GROUP BY 
		VendorID
)
SELECT
*
,[fnPctDiff](@Min = mintotal, @Max = maxtotal)
from agg
*/