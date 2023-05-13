-- how many keys of different names do we have??
-- BONUS: how many columns are not keys??
--Phase 1 : derived (conditional - sarg is true or false) column -> group, 

--the long way
--1. SUM all rows
--2. make Phase 1 query
--3. SUM results Phase 1 query
--4. subtract 4. from 1.

select 
IIF(
		(COLUMN_NAME LIKE '%ID'
		OR 
		COLUMN_NAME LIKE '%Key'
		)
		AND
		COLUMN_NAME NOT LIKE '%guid'

	,
		COLUMN_NAME 
	,
		'everything else'
	)
	AS [Column Name]
,
	COUNT(*) [Key Count]
from 
INFORMATION_SCHEMA.COLUMNS
GROUP BY
IIF(
		(COLUMN_NAME LIKE '%ID'
		OR 
		COLUMN_NAME LIKE '%Key'
		)
		AND
		COLUMN_NAME NOT LIKE '%guid'
	,
		COLUMN_NAME 
	,
		'everything else'
	)
ORDER BY 2 DESC 
--ORDER BY key_count
--ORDER BY COUNT(*)
--ordinal or positional assignment
--default sort is ascending lowest->greatest
