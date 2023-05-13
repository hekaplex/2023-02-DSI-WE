-- reference COLLATE

				SELECT
--				CHARINDEX(',',[Players])
				Players
				,substring([Players],1,CHARINDEX(',',[Players])-1) Lastname
				--,LEN(Players)
				,substring(
					[Players]
					,CHARINDEX(',',[Players])+2
					,LEN(Players)- CHARINDEX(',',[Players])+2
					) Firstname
				,RIGHT([Players],CHARINDEX(',',[Players])-1) FirstNameEasier
				,LEFT([Players],CHARINDEX(',',[Players])-1) LastNameEasier
				from
					[dbo].[BSN_playersStats]
				where [Players] is not null
				and FG = '49%'
				and teams = 'Leones'

				select
				--65533
				UNICODE(
				substring([Players],7,1))
				,Players
				from
					[dbo].[BSN_playersStats]
				where [Players] is not null
				and FG = '49%'
				and teams = 'Leones'

SELECT COUNT(*)
FROM
[dbo].[BSN_playersStats]
WHERE 
	CHARINDEX(NCHAR(65533),[Players])
	<> 0

--	REPLACE

				SELECT NCHAR(123)
				SELECT UNICODE('{')

