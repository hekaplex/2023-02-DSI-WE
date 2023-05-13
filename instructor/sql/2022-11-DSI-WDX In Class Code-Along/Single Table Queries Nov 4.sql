USE [AP]
GO
--remove duplicates, no aggregate
SELECT
DISTINCT VendorState
FROM Vendors

/*
How many vendors do we have per state?
*/

--remove duplicates with aggregate
SELECT
--grouping set or tuple
VendorState
--aggregate claculation and a column alias
, COUNT(*) AS VendorQty
FROM Vendors
--column in GROUP BY must be in SELECT
--and only aggregates as the rest of columns
GROUP BY VendorState

/*
How many vendors do we have per Term?
*/

--remove duplicates with aggregate
SELECT
--grouping set or tuple
DefaultTermsID
--aggregate claculation and a column alias
, COUNT(*) AS VendorQty
FROM Vendors
--column in GROUP BY must be in SELECT
--and only aggregates as the rest of columns
GROUP BY DefaultTermsID


/*
How many vendors in what states 
have Net 30 day terms?
*/

SELECT
--grouping set or tuple
VendorState
--aggregate claculation and a column alias
, COUNT(*) AS VendorQty
FROM Vendors
--column in GROUP BY must be in SELECT
--and only aggregates as the rest of columns
--Filter TermsId =3 0 is 30 Days
WHERE
--SARG or search argument/filter on row
	[DefaultTermsID] = 3
GROUP BY VendorState

/*
What is the distribution of vendors
by terms and states?
*/
SELECT
--grouping set or tuple
	VendorState
,	[DefaultTermsID]
--aggregate claculation and a column alias
, 
	COUNT(*) AS VendorQty
FROM
	Vendors
--column in GROUP BY must be in SELECT
--and only aggregates as the rest of columns
GROUP BY 
	VendorState
,	[DefaultTermsID]

/*
What are the top 5
most popular terms and states in our vendors?
*/
SELECT
--grouping set or tuple
TOP 5
	VendorState
,	[DefaultTermsID]
--aggregate claculation and a column alias
, 
	COUNT(*) AS VendorQty
FROM
	Vendors
--column in GROUP BY must be in SELECT
--and only aggregates as the rest of columns
GROUP BY 
	VendorState
,	[DefaultTermsID]
--sort
ORDER BY
	--DESC largest first
	--ASC smallest first
	--COUNT(*) or positional column
	3 DESC

/*
How many 
terms and states combinations
are there in our vendors?
*/

SELECT
--grouping set or tuple
COUNT
	(
		DISTINCT 
			VendorState
			+
			convert(char(1),DefaultTermsID)
) AS VendorTermsQty
FROM
	Vendors


/*
What terms and states combination in our vendors
have more than one vendor?
*/
SELECT
--grouping set or tuple
	VendorState
,	[DefaultTermsID]
--aggregate claculation and a column alias
, 
	COUNT(*) AS VendorQty
FROM
	Vendors
--column in GROUP BY must be in SELECT
--and only aggregates as the rest of columns
GROUP BY 
	VendorState
,	[DefaultTermsID]
--filter on an aggregate
HAVING COUNT(*) > 1
--sort
ORDER BY
	--DESC largest first
	--ASC smallest first
	--COUNT(*) or positional column
	3 DESC
