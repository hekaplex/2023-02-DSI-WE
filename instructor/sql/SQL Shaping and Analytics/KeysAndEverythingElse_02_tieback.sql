--The tieback
--two columns, table (key/nonkey) and count
select 
TABLE_NAME
,

		IIF(
			COLUMN_NAME LIKE '%ID'
			OR 
			COLUMN_NAME LIKE '%Key'
		,
			'key'
		,
			'nonkey'
		) col_type
,
	COUNT(*) column_qty
from 
INFORMATION_SCHEMA.COLUMNS
GROUP BY
	TABLE_NAME
	,
	
		IIF(
			COLUMN_NAME LIKE '%ID'
			OR 
			COLUMN_NAME LIKE '%Key'
		,
			'key'
		,
			'nonkey'
		)

ORDER BY 1 DESC 
