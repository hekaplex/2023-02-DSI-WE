/*
SQL Language Construct
	DDL - Data Definition		- CREATE, DROP, ALTER
	DQL - Data Query Language	- SELECT, EXEC
	DML - Data Manipulation		- (SELECT...INTO), INSERT, UPDATE, DELETE, MERGE
*/

--SELECT...INTO - INSERT + CREATE TABLE
--nonlogged oepration vs. logged operation
WITH
	inv
		as 
	--CTE
			(
				SELECT
					 [InvoiceID]
					,[VendorID]
					,[InvoiceNumber] As invno
				FROM 
					[dbo].[InvoiceArchive]
				WHERE
					InvoiceID BETWEEN 3 AND 8 
			) 
, base
	AS
	--CTE

		(
			select
				   v.VendorState
				,inv.*
			from
				inv
			JOIN
				Vendors AS v
				on 
					inv.VendorID
					= v.VendorID
		)
select
	base.VendorState
	, COUNT(*) qty
INTO
	magnum_opus
FROM
	base
GROUP BY 
		base.VendorState
--@@ROWCOUNT returned
--(2 rows affected)

SELECT * FROM magnum_opus

--INSERT, UPDATE, DELETE, MERGE
--explicit schema
INSERT INTO magnum_opus (VendorState,qty) VALUES ('OR',47)

SELECT * FROM magnum_opus
--implicit schema
INSERT INTO magnum_opus VALUES ('TX',2)
--MULTIPLE ROWS
INSERT INTO magnum_opus 
VALUES 
	('NY',3),
	('IL',5),
	('FL',4)
--insert..select

INSERT INTO magnum_opus 
SELECT * FROM magnum_opus

-- fancy insert...select
WITH
	inv
		as 
	--CTE
			(
				SELECT
					 [InvoiceID]
					,[VendorID]
					,[InvoiceNumber] As invno
				FROM 
					[dbo].[InvoiceArchive]
				WHERE
					InvoiceID BETWEEN 3 AND 8 
			) 
, base
	AS
	--CTE

		(
			select
				   v.VendorState
				,inv.*
			from
				inv
			JOIN
				Vendors AS v
				on 
					inv.VendorID
					= v.VendorID
		)
,
	agg
		as
		(
			select
				base.VendorState
				, COUNT(*) qty
			FROM
				base
			GROUP BY 
					base.VendorState
		)
INSERT INTO magnum_opus SELECT * FROM AGG

--DELETE vs DROP
DELETE
--always do a SELECT before a DELETE or UPDATE
--SELECT * FROM
 magnum_opus
 WHERE VendorState = 'TN'


--delete any rows thatcame from source
WITH
	inv
		as 
	--CTE
			(
				SELECT
					 [InvoiceID]
					,[VendorID]
					,[InvoiceNumber] As invno
				FROM 
					[dbo].[InvoiceArchive]
				WHERE
					InvoiceID BETWEEN 3 AND 8 
			) 
, base
	AS
	--CTE

		(
			select
				   v.VendorState
				,inv.*
			from
				inv
			JOIN
				Vendors AS v
				on 
					inv.VendorID
					= v.VendorID
		)
,
	agg
		as
		(
			select
				base.VendorState
				, COUNT(*) qty
			FROM
				base
			GROUP BY 
					base.VendorState
		)
DELETE
	m
--SELECT *
from 
 magnum_opus m
 join 
 agg a
 on 
	 a.VendorState
	 = m.VendorState
and
	 a.qty
	 = m.qty
	 ;
--UPDATE = INSERT + DELETE with access to inserted & deleted table in triggers
UPDATE
--pre-flight check
--SELECT *,qty - 6 as newqty from
magnum_opus
SET qty = qty - 6 
WHERE VendorState = 'OR'
;

SELECT *
from 
 magnum_opus 
;

--Transactions - BE SURE TO COMMIT OR ROLL BACK!!!

BEGIN TRANSACTION

DELETE  FROM magnum_opus WHERE VendorState like '%L%'

--ROLLBACK = undo
ROLLBACK TRANSACTION
--COMMIT = make permanent
COMMIT TRANSACTION

WITH
	inv
		as 
	--CTE
			(
				SELECT
					 [InvoiceID]
					,[VendorID]
					,[InvoiceNumber] As invno
				FROM 
					[dbo].[InvoiceArchive]
				WHERE
					InvoiceID BETWEEN 3 AND 8 
			) 
, base
	AS
	--CTE

		(
			select
				   v.VendorState
				,inv.*
			from
				inv
			JOIN
				Vendors AS v
				on 
					inv.VendorID
					= v.VendorID
		)
,
	agg
		as
		(
			select
				base.VendorState
				, COUNT(*) qty
			FROM
				base
			GROUP BY 
					base.VendorState
		)
UPDATE
--pre-flight check
--SELECT *,m.qty * 6 as newqty 
m
SET qty = m.qty * 6
FROM
	magnum_opus m
join 
 agg a
 on 
	 a.VendorState
	 = m.VendorState
and
	 a.qty
	 = m.qty

SELECT 
	*
FROM
	magnum_opus 

--Datawarehouse scenario: Dimension Management or INSERT or UPDATE in one query
MERGE 
INTO 
--a lot like ...FROM   InvoiceCopy LEFT OUTER JOIN InvoiceArchive
--Master Copy for Analysis
InvoiceArchive ia
--Latest version from Production/Staging
USING InvoiceCopy ic
--exactly like ...FROM InvoiceCopy LEFT OUTER JOIN InvoiceArchive
ON ia.InvoiceNumber = ic.InvoiceNumber
--INNER JOIN = UPDATE
WHEN MATCHED 
--WHERE ON ia.InvoiceID IS NOT NULL AND  ic.InvoiceID IS NOT NULL 
	AND ic.PaymentDate IS NOT NULL
	AND ic.PaymentTotal > ia.PaymentTotal
	THEN 
		UPDATE SET
		ia.PaymentTotal = ic.PaymentTotal
		,ia.PaymentDate = GETDATE()
		,ia.CreditTotal = ic.CreditTotal
--LEFT OUTER JOIN WITH NULL FROM SOURCE = INSERT
WHEN NOT MATCHED 
--WHERE ON ia.InvoiceID IS NULL AND  ic.InvoiceID IS NOT NULL 
	THEN
		INSERT ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate])
		VALUES(ic.[InvoiceID], ic.[VendorID], ic.[InvoiceNumber], '7-22-22', ic.[InvoiceTotal], ic.[PaymentTotal], ic.[CreditTotal], ic.[TermsID], ic.[InvoiceDueDate])
--RIGHT OUTER JOIN = DELETE
;
SELECT [InvoiceDate], COUNT(*)
FROM InvoiceArchive
GROUP BY [InvoiceDate]

