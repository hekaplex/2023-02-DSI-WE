--JOIN based query
SELECT
	i.VendorID
,		COUNT(
			*
		) 
		AS InvoiceTotals
FROM 
	Vendors AS v
JOIN
	Invoices AS i
	ON
		v.VendorID = i.VendorID
GROUP BY 	i.VendorID

--subquery based  query
SELECT
	v.VendorID
	,COUNT(*) 
	--column alias
		AS InvoiceTotals
FROM 
	--table alias
	Vendors AS v
where 
	v.VendorID = 
		(
			SELECT 
				i.VendorID 
			from 
				Invoices 
					AS i
			WHERE 
				VendorState = 'CA'
		)
GROUP BY 
	v.VendorID

SELECT
	i.VendorID
,		COUNT(
			*
		) 
		AS InvoiceTotals
FROM 
	Invoices AS i
where 

	i.VendorID in
	--correlated subquery
(
	SELECT 
		DISTINCT v.VendorID 
	from 
		Vendors AS v
	WHERE VendorState = 'CA')
GROUP BY 	i.VendorID
order by i.vendorid ASC

SELECT * from Vendors where VendorState in ('CA','TN')

--correlated subquery in JOIN
SELECT
	i.VendorID
,		COUNT(
			*
		) 
		AS InvoiceTotals
FROM 
	Invoices AS i
JOIN
(
	SELECT 
		VendorID 
	from 
		Vendors
	WHERE VendorState = 'CA') v
ON
	v.VendorID = i.VendorID
GROUP BY 	i.VendorID