USE [AP]
GO
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
--wildcard
--SELECT statement
--TOP clause
TOP (1000) 
--column list
	--[VendorID]
 --     ,[VendorName]
 --     ,[VendorAddress1]
 --     ,[VendorAddress2]
 --     ,[VendorCity]
 --     ,[VendorState]
 --     ,[VendorZipCode]
 --     ,[VendorPhone]
 --     ,[VendorContactLName]
 --     ,[VendorContactFName]
 --     ,[DefaultTermsID]
 --     ,[DefaultAccountNo]
FROM 
  --Fully qualified name
  --database.schema.table_name
  --[AP].[dbo].
  [Vendors]