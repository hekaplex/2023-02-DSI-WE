
--UNION
SELECT
--requires: same num cols, same data types
--static column'
	--'Invoices' as Source_tbl,
	[InvoiceID], [VendorID], [InvoiceNumber]
	--, [InvoiceDate] , [InvoiceTotal]
	--, [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]
FROM 
	[dbo].[Invoices]
--UNION removes duplicates, UNION ALL does not
UNION -- ALL
SELECT
--static column'
	--'InvoiceArchive' as Source_tbl,
	[InvoiceID], [VendorID], [InvoiceNumber]
	--, [InvoiceDate], [InvoiceTotal]
	--, [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]
FROM 
	[dbo].[InvoiceArchive]

/*
What states are in our invoice sample?
*/

--correlated subquery with a table alias
--"old school" subquery
select
v.VendorState
,inv.*
from
	--using an alias to abstract a query
	(SELECT
		[InvoiceID], [VendorID],
		--column alias
		[InvoiceNumber] As invno
	FROM 
		[dbo].[InvoiceArchive]
	WHERE
		InvoiceID BETWEEN 3 AND 8 --includes boundaries
		--InvoiceID >= 3 AND InvoiceID <= 8 --includes boundaries
		-- InvoiceID > 3 AND InvoiceID < 8 does not include boundaries
		) 
		--table alias or inline 
			as inv
RIGHT JOIN
	Vendors AS v
	on 
		inv.VendorID
		= v.VendorID

--new school
--Common Table Expression (CTE)
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
FROM
	base
GROUP BY 
		base.VendorState

--subquery as filter

SELECT
	*
FROM
	Invoices	
WHERE
	InvoiceTotal
	>
	(
		SELECT
			AVG(InvoiceTotal)
		FROM
			Invoices	
	)
