Use Examples;

SELECT
	--Divergence	Minkin, D.
	VendorName
	,VendorContactLName
		+', '
		+ LEFT(VendorContactFName,1)
		+ '.'
			AS ContactName
	--(209) 555-7785
	,VendorPhone
	,SUBSTRING(VendorPhone,2,3) As AreaCode
	,SUBSTRING(VendorPhone,7,3) As Prefix
	,SUBSTRING(VendorPhone,11,4) As Extension
FROM
Vendors
	WHERE SUBSTRING(VendorPhone,2,3) = 800 
;
SELECT 
	*
FROM
	StringSample
ORDER BY ID
;
SELECT 
	*
FROM
	StringSample
ORDER BY CAST(ID AS int)
;
--text breaking
SELECT 
	[Name]
	,LEFT([Name],CHARINDEX(' ',[Name]) -1) AS FirstName
	,RIGHT([Name],LEN([Name]) - CHARINDEX(' ',[Name])) AS LastName
	,LEN([Name]) NameLength
	,CHARINDEX(' ',[Name]) SpacePosition
FROM
	StringSample
;
SELECT 
	*
FROM
	RealSample
WHERE R BETWEEN 0.99 AND 1.01
;
SELECT 
	*
	, (R - ROUND(R,2)) * 10000000000 AS Precision_Invisible
	,ROUND(R,2) AS [Rounded_2_digits]
	,ROUND(R,2,1) AS [Rounded_2_digits_truncate_or_floor]
FROM
	RealSample
WHERE 
	ROUND(R,2) = 1
;
SELECT 
	*
	,CAST(StartDate AS time)
FROM
	DateSample
WHERE CAST(StartDate AS time) = '10:00:00' 

SELECT 
	*
FROM
	DateSample
	;

SELECT 
	*
	,DATEPART(YEAR,StartDate) YR
	,DATEPART(MONTH,StartDate)   MON
	,DATEPART(DAY, StartDate)	DAY
	,DATEPART(SECOND,StartDate) SEC
	,DATEPART(MINUTE,StartDate) MIN
	,DATEPART(HOUR,StartDate)   HOU
	,CONVERT(time, StartDate)	time
FROM
	DateSample
WHERE DATEPART(HOUR,StartDate)  BETWEEN 9 AND 13

--how many days have I been alive?
SELECT DATEDIFF(DAY,'Apr 16 1970 03:25 AM',GETDATE())
--19202
--how many seconds have I been alive?
SELECT DATEDIFF(SECOND,'Apr 16 1970 03:25 AM',GETDATE())
--Is 20151208	42344 days from Apr 1 1970 -unixtime
SELECT DATEADD(SECOND,1700000000,'Apr 16 1970 03:25 AM')
SELECT DATEADD(DAY,-42344,'Dec 08 2015')
--2024-02-28 01:38:20.000