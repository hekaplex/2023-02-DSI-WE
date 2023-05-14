
open master key decryption by password = 'DSIWD2022!Divergence';
GO
CREATE DATABASE SCOPED CREDENTIAL AP_ADLS_SAS_Credential
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = 'sv=2021-04-10&st=2022-09-14T00%3A49%3A54Z&se=2023-11-15T01%3A49%3A00Z&sr=c&sp=racwdl&sig=qvSo7YElfZjTOMIRNnOeVOlmQ4FdzQUfudnuRTOQx%2BQ%3D';
GO
close master key;

/*
check if you have master key for storing credential:

	select name from sys.databases where is_master_key_encrypted_by_server=1
*/

CREATE EXTERNAL DATA SOURCE Sample_ADLS_CSV
    WITH (
        TYPE = BLOB_STORAGE,
        LOCATION = 'https://2022dsidatalake.blob.core.windows.net/users/synapse/workspaces/2022-dsi-synapse-ws/warehouse/model_sample/',
        CREDENTIAL = AP_ADLS_SAS_Credential
    );

SELECT * FROM OPENROWSET(
   BULK 'test_data.csv',
   DATA_SOURCE = 'Sample_ADLS_CSV',
SINGLE_CLOB
--   , FIRSTROW = 2
----      , FIELDQUOTE = '\'
--      , FIELDTERMINATOR = ','
, ROWTERMINATOR = '0x0a'
   ) AS DataFile;


select @@version


CREATE TABLE [dbo].[Ships_template](
	[lrno] [int] NOT NULL,
	[vesselname] [nvarchar](max) NOT NULL,
	[owner] [nvarchar](max) NOT NULL,
	[shipmanager] [nvarchar](max) NOT NULL,
	[operator] [nvarchar](max) NOT NULL,
	[flag] [nvarchar](50) NOT NULL,
	[dwt] [int] NOT NULL,
	[loa] [float] NOT NULL,
	[breadth] [float] NOT NULL,
	[depth] [float] NOT NULL,
	[statdecode] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
