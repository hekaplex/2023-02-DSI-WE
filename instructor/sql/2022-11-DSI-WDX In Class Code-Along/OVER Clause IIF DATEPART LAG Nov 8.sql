WITH
Base
	AS
		(
			Select 
				--Year, Month, Territory, Sales
				DATEPART(YEAR,OrderDate) SalesYear
				,DATEPART(MONTH,OrderDate) Salesmonth
				,SalesTerritoryKey Territory
				,SUM(SalesAmount) SalesTotal
			from 
				FactInternetSales
			GROUP BY
				DATEPART(YEAR,OrderDate) 
				,DATEPART(MONTH,OrderDate)
				,SalesTerritoryKey
		)
, agg_2
as
(
SELECT
	*
	,SUM(SalesTotal) OVER (PARTITION BY Territory, SalesYear) AS YearByTerritory
	,SUM(SalesTotal) OVER (PARTITION BY Territory, SalesYear ORDER BY SalesMonth ASC) AS YearToDate
	,LAG(SalesTotal,1,0) OVER (PARTITION BY Territory, SalesYear ORDER BY SalesMonth ASC) AS PrevMonth
FROM
	base
)
select 
	*
	,SalesTotal/YearByTerritory as PctofYearByTerritory
	, 
	--pct change = (newval- oldval)/oldval
	IIF
		(
			--conditional statement to evaluate
			PrevMonth = 0
			--result if true
			,0
			--result if false
			,(SalesTotal- PrevMonth)/PrevMonth
		)
	as PctChangeFromPrevMonth
from agg_2