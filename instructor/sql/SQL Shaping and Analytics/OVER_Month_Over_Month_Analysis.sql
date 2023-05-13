--How every territory is doing by MOM (Month over Month) Calculation?

WITH
	BaseAgg
	AS
		(
			SELECT 
				TOP 100 PERCENT 
				SalesTerritoryKey Territory
				,YEAR(OrderDate) [SalesYear]
				,MONTH(OrderDate) [SalesMonth]
				--top version for DW20, Bottom for DW19
				--,YEAR(CONVERT(char(20),[OrderDateKey],112)) SalesYear
				-- ,Month(CONVERT(char(20),[OrderDateKey],112)) SalesMonth
				,SUM(SalesAmount) SalesTotal
			FROM
				FactResellerSales
			GROUP BY 
				SalesTerritoryKey 
				,YEAR(OrderDate)
				,MONTH(OrderDate)
				--top version for DW20, Bottom for DW19
				--,YEAR(CONVERT(char(20),[OrderDateKey],112)) 
				--,Month(CONVERT(char(20),[OrderDateKey],112)) 
				)
		--select * from BaseAgg
		--ORDER BY 				
		--		2 ASC, 3 ASC, 1 ASC
		
,
BaseAggOver
	AS
		(
			SELECT
				*
				,SUM(SalesTotal) 
					OVER
						(
							PARTITION BY Territory, SalesYear
							ORDER BY SalesMonth ASC
						) YearToDate
				,LAG(SalesTotal,1,0) 
					OVER
						(
							PARTITION BY Territory, SalesYear
							ORDER BY SalesMonth ASC
						) PrevMon
			from BaseAgg
			--MOM % Change (SalesTotal - PrevMon)/PrevMon
	)
	--SELECT * from BaseAggOver
,MOM
	AS
		(
				SELECT 
					* 
				--MOM % Change (SalesTotal - PrevMon)/PrevMon
					,
						ROUND(
							IIF
								(
					
									PrevMon = 0
									,
									0
									,
									(
											(
												SalesTotal - PrevMon
											)
										/
											PrevMon
									)
								*
								100.0
								)
							,
							2
							)

							AS Sales_MOM_Pct
				FROM 
					BaseAggOver
		)
		--SELECT * from MOM
SELECT
	Territory
	,
		AVG(Sales_MOM_Pct) avgMOM -- baseline - higher is better
		,STDEV(Sales_MOM_Pct) stdvMOM --variance - lower is better
	FROM 
	MOM
	group by Territory
	order by 2 ASC