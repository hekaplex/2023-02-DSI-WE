USE [Pre_BIO]
GO

/****** Object:  Table [dbo].[cust_template]    Script Date: 9/12/2022 12:26:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[cust_template](
	[HOME_OWNERSHIP_IND] [varchar](1) NULL,
	[MARRIED_IND] [varchar](1) NULL,
	[SOLICITATION_IND] [varchar](1) NULL,
	[CUSTOMER_ID] [varchar](10) NULL,
	[BANK_NUMBER] [varchar](5) NULL,
	[DATE_BIRTH] [datetime] NULL,
	[DEPENDENT_CNT] [float] NULL,
	[ETHNICITY_CODE] [varchar](5) NULL,
	[GENDER_CODE] [varchar](5) NULL,
	[INCOME_AMT] [float] NULL,
	[STATE_CODE] [varchar](3) NULL,
	[ZIP_CODE] [float] NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[acct_12mth_template](
	[account_closed_reason] [varchar](1) NULL,
	[Online_banking_tran_ind] [varchar](1) NULL,
	[teller_banking_tran_ind] [varchar](1) NULL,
	[pymt_method_code] [varchar](1) NULL,
	[ATM_BANKING_TRAN_IND] [varchar](1) NULL,
	[BANKRUPTCY_IND] [varchar](1) NULL,
	[INSURANCE_IND] [varchar](1) NULL,
	[OVRDRFT_IND] [varchar](1) NULL,
	[TELEPHONE_BANKING_TRAN_IND] [varchar](1) NULL,
	[ACCOUNT_NUMBER] [varchar](30) NULL,
	[ACCOUNT_TYPE] [varchar](3) NULL,
	[BANK_NUMBER] [varchar](5) NULL,
	[ACCOUNT_STATUS] [varchar](1) NULL,
	[ACCOUNT_SUB_TYPE] [varchar](25) NULL,
	[ACCOUNT_TYPE_DESC] [varchar](15) NULL,
	[BAL_AMT] [float] NULL,
	[BAL_AMT_ORIG] [float] NULL,
	[BRANCH_PRIMARY_ID] [varchar](5) NULL,
	[CREDIT_AMT_MTD] [float] NULL,
	[CREDIT_AMT_YTD] [float] NULL,
	[DATE_CHARGEOFF] [datetime] NULL,
	[DATE_CLOSE] [datetime] NULL,
	[DATE_DEPOSIT_LAST] [datetime] NULL,
	[DATE_DEPOSIT_ORIG] [datetime] NULL,
	[DATE_FEE_LATE_LAST] [datetime] NULL,
	[DATE_FEE_SRVC_LAST] [datetime] NULL,
	[DATE_INTEREST_EFFECTIVE] [datetime] NULL,
	[DATE_MATURITY] [datetime] NULL,
	[DATE_MATURITY_ORIG] [datetime] NULL,
	[DATE_OPEN] [datetime] NULL,
	[DATE_PAYOFF] [datetime] NULL,
	[DATE_PYMT_LAST] [datetime] NULL,
	[DATE_PYMT_ORIG] [datetime] NULL,
	[DATE_RENEWAL] [datetime] NULL,
	[DATE_WTHDRW_LAST] [datetime] NULL,
	[DATE_WTHDRW_ORIG] [datetime] NULL,
	[DEBIT_AMT_MTD] [float] NULL,
	[DEBIT_AMT_YTD] [float] NULL,
	[DELINQUENCY_DAY_CNT] [float] NULL,
	[DELINQUENT_120_CNT] [float] NULL,
	[DELINQUENT_150_CNT] [float] NULL,
	[DELINQUENT_180_AND_OVER_CNT] [float] NULL,
	[DELINQUENT_30_CNT] [float] NULL,
	[DELINQUENT_60_CNT] [float] NULL,
	[DELINQUENT_90_CNT] [float] NULL,
	[FEE_LATE_AMT_LAST] [float] NULL,
	[FEE_LATE_AMT_MTD] [float] NULL,
	[FEE_LATE_AMT_MTD_WAIVE] [float] NULL,
	[FEE_LATE_AMT_YTD] [float] NULL,
	[FEE_LATE_AMT_YTD_WAIVE] [float] NULL,
	[FEE_SRVC_AMT_LAST] [float] NULL,
	[FEE_SRVC_AMT_MTD] [float] NULL,
	[FEE_SRVC_AMT_MTD_WAIVE] [float] NULL,
	[FEE_SRVC_AMT_YTD] [float] NULL,
	[FEE_SRVC_AMT_YTD_WAIVE] [float] NULL,
	[INTEREST_AMT_MTD] [float] NULL,
	[INTEREST_AMT_YTD] [float] NULL,
	[INTEREST_RATE] [float] NULL,
	[INTEREST_RATE_ORIG] [float] NULL,
	[PYMT_BILL_AMT_LAST] [float] NULL,
	[PYMT_BILL_AMT_YTD] [float] NULL,
	[PYMT_COLL_AMT_LAST] [float] NULL,
	[PYMT_COLL_AMT_YTD] [float] NULL
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[acct_template]    Script Date: 9/12/2022 12:25:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[acct_template](
	[account_closed_reason] [varchar](1) NULL,
	[Online_banking_tran_ind] [varchar](1) NULL,
	[teller_banking_tran_ind] [varchar](1) NULL,
	[pymt_method_code] [varchar](1) NULL,
	[ATM_BANKING_TRAN_IND] [varchar](1) NULL,
	[BANKRUPTCY_IND] [varchar](1) NULL,
	[INSURANCE_IND] [varchar](1) NULL,
	[OVRDRFT_IND] [varchar](1) NULL,
	[TELEPHONE_BANKING_TRAN_IND] [varchar](1) NULL,
	[ACCOUNT_NUMBER] [varchar](30) NULL,
	[ACCOUNT_TYPE] [varchar](3) NULL,
	[BANK_NUMBER] [varchar](5) NULL,
	[ACCOUNT_STATUS] [varchar](1) NULL,
	[ACCOUNT_SUB_TYPE] [varchar](25) NULL,
	[ACCOUNT_TYPE_DESC] [varchar](15) NULL,
	[BAL_AMT] [float] NULL,
	[BAL_AMT_ORIG] [float] NULL,
	[BRANCH_PRIMARY_ID] [varchar](5) NULL,
	[CREDIT_AMT_MTD] [float] NULL,
	[CREDIT_AMT_YTD] [float] NULL,
	[DATE_CHARGEOFF] [datetime] NULL,
	[DATE_CLOSE] [datetime] NULL,
	[DATE_DEPOSIT_LAST] [datetime] NULL,
	[DATE_DEPOSIT_ORIG] [datetime] NULL,
	[DATE_FEE_LATE_LAST] [datetime] NULL,
	[DATE_FEE_SRVC_LAST] [datetime] NULL,
	[DATE_INTEREST_EFFECTIVE] [datetime] NULL,
	[DATE_MATURITY] [datetime] NULL,
	[DATE_MATURITY_ORIG] [datetime] NULL,
	[DATE_OPEN] [datetime] NULL,
	[DATE_PAYOFF] [datetime] NULL,
	[DATE_PYMT_LAST] [datetime] NULL,
	[DATE_PYMT_ORIG] [datetime] NULL,
	[DATE_RENEWAL] [datetime] NULL,
	[DATE_WTHDRW_LAST] [datetime] NULL,
	[DATE_WTHDRW_ORIG] [datetime] NULL,
	[DEBIT_AMT_MTD] [float] NULL,
	[DEBIT_AMT_YTD] [float] NULL,
	[DELINQUENCY_DAY_CNT] [float] NULL,
	[DELINQUENT_120_CNT] [float] NULL,
	[DELINQUENT_150_CNT] [float] NULL,
	[DELINQUENT_180_AND_OVER_CNT] [float] NULL,
	[DELINQUENT_30_CNT] [float] NULL,
	[DELINQUENT_60_CNT] [float] NULL,
	[DELINQUENT_90_CNT] [float] NULL,
	[FEE_LATE_AMT_LAST] [float] NULL,
	[FEE_LATE_AMT_MTD] [float] NULL,
	[FEE_LATE_AMT_MTD_WAIVE] [float] NULL,
	[FEE_LATE_AMT_YTD] [float] NULL,
	[FEE_LATE_AMT_YTD_WAIVE] [float] NULL,
	[FEE_SRVC_AMT_LAST] [float] NULL,
	[FEE_SRVC_AMT_MTD] [float] NULL,
	[FEE_SRVC_AMT_MTD_WAIVE] [float] NULL,
	[FEE_SRVC_AMT_YTD] [float] NULL,
	[FEE_SRVC_AMT_YTD_WAIVE] [float] NULL,
	[INTEREST_AMT_MTD] [float] NULL,
	[INTEREST_AMT_YTD] [float] NULL,
	[INTEREST_RATE] [float] NULL,
	[INTEREST_RATE_ORIG] [float] NULL,
	[PYMT_BILL_AMT_LAST] [float] NULL,
	[PYMT_BILL_AMT_YTD] [float] NULL,
	[PYMT_COLL_AMT_LAST] [float] NULL,
	[PYMT_COLL_AMT_YTD] [float] NULL
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[tran_template]    Script Date: 9/12/2022 12:24:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tran_template](
	[ACCOUNT_NUMBER] [varchar](30) NULL,
	[ACCOUNT_TYPE] [varchar](3) NULL,
	[BANK_NUMBER] [varchar](5) NULL,
	[SEQUENCE_NUMBER] [int] NULL,
	[TRANSACTION_DATE] [datetime] NULL,
	[EFFECTIVE_DATE] [datetime] NULL,
	[DATE_PYMT_DUE] [datetime] NULL,
	[TRANSACTION_CODE] [varchar](3) NULL,
	[TRANSACTION_CODE_EXTERNAL] [varchar](3) NULL,
	[DEBIT_CREDIT_CODE] [varchar](1) NULL,
	[REVERSAL_CODE] [varchar](1) NULL,
	[FEE_CODE] [int] NULL,
	[INTEREST_TYPE] [varchar](1) NULL,
	[SOURCE_OF_TRANSACTION] [varchar](10) NULL,
	[TRANSACTION_AMOUNT] [float] NULL,
	[TRANSACTION_DESCRIPTION] [varchar](30) NULL,
	[LOAN_FEE_AMOUNT] [float] NULL,
	[ESCROW_BAL_AMOUNT] [float] NULL,
	[PRINCIPAL_BALANCE_AFTER_POST] [float] NULL
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[xref_template]    Script Date: 9/12/2022 12:24:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[xref_template](
	[ACCOUNT_NUMBER] [varchar](30) NULL,
	[BANK_NUMBER] [varchar](5) NULL,
	[ACCOUNT_TYPE] [varchar](3) NULL,
	[CUSTOMER_ID] [varchar](10) NULL,
	[CUSTOMER_ACCOUNT_REL] [varchar](3) NULL
) ON [PRIMARY]
GO


--example bulk insert
BULK INSERT acct_12mth_template
FROM 'C:\divergence\Bank\Initial\snfl_acct_12mth_base.csv'
WITH (FORMAT = 'CSV'
      , FIRSTROW = 2
--      , FIELDQUOTE = '\'
      , FIELDTERMINATOR = ','
      , ROWTERMINATOR = '0x0a');
