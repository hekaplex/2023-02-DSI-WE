-- how many keys of different names do we have??

--Phase 0 : group, filter (sarg is true), sort

select 
COLUMN_NAME 
,COUNT(*) key_count
--SELECT * 
from 
INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%ID'
OR COLUMN_NAME LIKE '%Key'
GROUP BY
COLUMN_NAME 
ORDER BY 2 DESC 
--ORDER BY key_count
--ORDER BY COUNT(*)
--ordinal or positional assignment
--default sort is ascending lowest->greatest

/*
COLUMN_NAME	key_count
DateKey	7
CustomerKey	6
CurrencyKey	5
ProductKey	5
SalesTerritoryKey	5
GeographyKey	4
ProductCategoryKey	3
EmployeeKey	3
ProductSubcategoryKey	3
PromotionKey	3
DueDateKey	2
id	2
CustomerAlternateKey	2
AccountKey	2
DepartmentGroupKey	2
OrderDateKey	2
OrganizationKey	2
ScenarioKey	2
ShipDateKey	2
ResellerKey	2
SalesReasonKey	2
SalesTerritoryAlternateKey	1
SalesQuotaKey	1
SalesReasonAlternateKey	1
SurveyResponseKey	1
ParentAccountCodeAlternateKey	1
ParentAccountKey	1
ParentDepartmentGroupKey	1
ParentEmployeeKey	1
ParentEmployeeNationalIDAlternateKey	1
ParentOrganizationKey	1
principal_id	1
ProductAlternateKey	1
ProductCategoryAlternateKey	1
diagram_id	1
AccountCodeAlternateKey	1
CurrencyAlternateKey	1
LoginID	1
EmployeeNationalIDAlternateKey	1
FactCallCenterID	1
FinanceKey	1
FullDateAlternateKey	1
ProspectAlternateKey	1
ProspectiveBuyerKey	1
ResellerAlternateKey	1
PromotionAlternateKey	1
ProductSubcategoryAlternateKey	1
*/