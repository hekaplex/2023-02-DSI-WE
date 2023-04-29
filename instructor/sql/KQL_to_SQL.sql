/*
KQL Example:
StormEvents
| where StartTime >= datetime(2010-01-01) and StartTime < datetime(2011-01-01)
| summarize event_count = count() by State
| order by event_count desc
| limit 10
*/
SELECT 
	TOP 10 State
	, COUNT(*) as event_count
	, AVG(WindSpeed) as event_avg
FROM 
	StormEvents
WHERE 
	StartTime >= '2010-01-01' 
	AND 
	StartTime < '2011-01-01'
GROUP BY 
	State
ORDER BY 
	event_count DESC


/*
KQL Example:
StormEvents
| where StartTime >= datetime(2010-01-01) and StartTime < datetime(2011-01-01)
| extend year = toint(format_datetime(StartTime, 'yyyy'))
| summarize event_count = count() by year, EventType
| order by year, event_count desc

*/
SELECT 
	YEAR(StartTime) as year
	, EventType, COUNT(*) as event_count
FROM 
	StormEvents
WHERE 
	StartTime >= '2010-01-01' 
	AND 
	StartTime < '2011-01-01'
GROUP BY 
	YEAR(StartTime), EventType
ORDER BY 
	YEAR(StartTime), event_count DESC


/*
KQL Example:
let sourceMapping = dynamic(
  {
    "Emergency Manager" : "Public",
    "Utility Company" : "Private"
  });
StormEvents
| where Source == "Emergency Manager" or Source == "Utility Company"
| project EventId, Source, FriendlyName = sourceMapping[Source]
*/
WITH sourceMapping AS (
  SELECT 'Emergency Manager' AS Source, 'Public' AS FriendlyName
  UNION ALL
  SELECT 'Utility Company' AS Source, 'Private' AS FriendlyName
)
SELECT EventId, Source, sourceMapping.FriendlyName AS FriendlyName
FROM StormEvents
JOIN sourceMapping ON StormEvents.Source = sourceMapping.Source
WHERE Source IN ('Emergency Manager', 'Utility Company')


/*
KQL Example:
let Events = MyLogTable | where type=="Event" ;
Events
| where Name == "Start"
| project Name, City, ActivityId, StartTime=timestamp
| join (Events
    | where Name == "Stop"
        | project StopTime=timestamp, ActivityId)
    on ActivityId
| project City, ActivityId, StartTime, StopTime, Duration = StopTime - StartTime
*/

SELECT
E.StopTime - E.StartTime AS Duration 
,V.City
, V.ActivityId
, E.StartTime
, E.StopTime
FROM 
Events V
JOIN
(
	SELECT * FROM 
	Events
    where Name = 'Stop'
	) E
on E.StartTime = V.StartTime
where V.Name = 'Start'

| join        

    on ActivityId
 
