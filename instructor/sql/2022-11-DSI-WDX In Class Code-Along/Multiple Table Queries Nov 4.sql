USE [AP]
GO
/*
How many states have each of our vendor's terms
(show due days)
*/

-- Terms<->Vendors
--group by terms
--distinct count
SELECT
	TermsDueDays
	,COUNT(
		DISTINCT VendorState
		)  AS DistinctStates
FROM 
--Cartesian Join or CROSS JOIN
Vendors,
Terms
GROUP BY TermsDueDays

SELECT
TermsDueDays
,VendorState
FROM 
--Cartesian Join or CROSS JOIN
Vendors,
Terms

SELECT
	t.TermsDueDays
	,COUNT(
		DISTINCT v.VendorState
		)  
		AS DistinctStates
FROM 
--left hand side of join
--table alias
	Vendors AS v
--implicit INNER
JOIN
--right hand side of join
	Terms AS t
	ON
		--SARG or seasrch argument True/False
		v.DefaultTermsID = t.TermsID

GROUP BY TermsDueDays

/*
Vendor Activity based on InvoiceTotals

*/

SELECT
	v.VendorName
	--return 0 if null
	,ISNULL(
		SUM(
			i.InvoiceTotal
		) 
	,0) 
		AS InvoiceTotals
FROM 
--left hand side of join
--table alias
	Vendors AS v
--implicit INNER
LEFT JOIN
--right hand side of join
	Invoices AS i
	ON
		--SARG or search argument True/False
		v.VendorID = i.VendorID

GROUP BY v.VendorName
ORDER BY 2 DESC

/*
Do we have any orphaned invoices
invoiceid with no vendor row based on vendorid
*/
SELECT
	i.VendorID
	--return 0 if null
,		COUNT(
			*
		) 
		AS InvoiceTotals
FROM 
--left hand side of join
--table alias
	Vendors AS v
--implicit INNER
RIGHT JOIN
--right hand side of join
	Invoices AS i
	ON
		--SARG or search argument True/False
		v.VendorID = i.VendorID
WHERE
	v.VendorID IS NULL
GROUP BY 	i.VendorID