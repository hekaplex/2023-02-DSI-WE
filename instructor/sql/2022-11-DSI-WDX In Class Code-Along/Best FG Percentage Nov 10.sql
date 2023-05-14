--Best pctg FG player by Team
with base as
(
select
[Teams], [Players], [FG]
from
[dbo].[BSN_playersStats]
where [Players] is not null
)
,
window
as
(select 
	*
	,row_number() 
	--windowing function
	over (---group by for the query
			partition by teams 
			---aggregate criteria per tuple
			order by FG desc) as fg_rank
from base)
select [Teams], [Players], [FG]
from window where fg_rank = 1



--Best pctg FG player by Team
with base as
,
window
as
(select 
	*
	,row_number() 
	--windowing function
	over (---group by for the query
			partition by teams 
			---aggregate criteria per tuple
			order by FG desc) as fg_rank
from (
select
[Teams], [Players], [FG]
from
[dbo].[BSN_playersStats]
where [Players] is not null
)
 base)
select [Teams], [Players], [FG]
from window where fg_rank = 1