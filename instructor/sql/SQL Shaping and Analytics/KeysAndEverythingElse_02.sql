--How many
--key and non-key columns per table?
/*
column name
----------
qty_key_col_t --How many key columns 
TABLE_NAME		--per table
qty_key_col_f --How many non-key columns 
*/

--Phase 2: filter in 2 aggs, sort
select 
TABLE_NAME
,
	SUM(
		IIF(
			COLUMN_NAME LIKE '%ID'
			OR 
			COLUMN_NAME LIKE '%Key'
		,
			1 --TRUE
		,
			0 --FALSE
		)
	) keys --[qty_key_col_t]
,
	SUM(
		IIF(
			COLUMN_NAME LIKE '%ID'
			OR 
			COLUMN_NAME LIKE '%Key'
		,
			0 --FALSE
		,
			1 --TRUE
		)
	) nonkeys --[qty_key_col_f]
from 
INFORMATION_SCHEMA.COLUMNS
GROUP BY
	TABLE_NAME
ORDER BY 1 DESC 
