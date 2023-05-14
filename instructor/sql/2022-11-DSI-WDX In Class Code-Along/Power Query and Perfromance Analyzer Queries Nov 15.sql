--vendorState added to invoices in Power Query
select [$Outer].[InvoiceID] as [InvoiceID],
    [$Outer].[VendorID2] as [VendorID],
    [$Outer].[InvoiceNumber] as [InvoiceNumber],
    [$Outer].[InvoiceDate] as [InvoiceDate],
    [$Outer].[InvoiceTotal] as [InvoiceTotal],
    [$Outer].[PaymentTotal] as [PaymentTotal],
    [$Outer].[CreditTotal] as [CreditTotal],
    [$Outer].[TermsID] as [TermsID],
    [$Outer].[InvoiceDueDate] as [InvoiceDueDate],
    [$Outer].[PaymentDate] as [PaymentDate],
    [$Inner].[VendorState] as [Vendors.VendorState]
from 
(
    select [_].[InvoiceID] as [InvoiceID],
        [_].[VendorID] as [VendorID2],
        [_].[InvoiceNumber] as [InvoiceNumber],
        [_].[InvoiceDate] as [InvoiceDate],
        [_].[InvoiceTotal] as [InvoiceTotal],
        [_].[PaymentTotal] as [PaymentTotal],
        [_].[CreditTotal] as [CreditTotal],
        [_].[TermsID] as [TermsID],
        [_].[InvoiceDueDate] as [InvoiceDueDate],
        [_].[PaymentDate] as [PaymentDate]
    from [dbo].[Invoices] as [_]
) as [$Outer]
left outer join [dbo].[Vendors] as [$Inner] on ([$Outer].[VendorID2] = [$Inner].[VendorID])


/*
View of terms, vendorstate and payment
// DAX Query
DEFINE
  VAR __DS0Core = 
    SUMMARIZECOLUMNS(
      ROLLUPADDISSUBTOTAL(
        ROLLUPGROUP('Terms'[TermsDescription], 'Vendors'[VendorState]), "IsGrandTotalRowTotal"
      ),
      "SumPaymentTotal", CALCULATE(SUM('Invoices'[PaymentTotal]))
    )

  VAR __DS0PrimaryWindowed = 
    TOPN(
      502,
      __DS0Core,
      [IsGrandTotalRowTotal],
      0,
      [SumPaymentTotal],
      0,
      'Terms'[TermsDescription],
      1,
      'Vendors'[VendorState],
      1
    )

EVALUATE
  __DS0PrimaryWindowed

ORDER BY
  [IsGrandTotalRowTotal] DESC,
  [SumPaymentTotal] DESC,
  'Terms'[TermsDescription],
  'Vendors'[VendorState]


// Direct Query
*/
SELECT 
TOP (1000001) *
FROM 
(

SELECT [t0].[VendorState] AS [c6],[t3].[TermsDescription] AS [c30],SUM([t2].[PaymentTotal])
 AS [a0]
FROM 
(
((
select [$Outer].[InvoiceID] as [InvoiceID],
    [$Outer].[VendorID2] as [VendorID],
    [$Outer].[InvoiceNumber] as [InvoiceNumber],
    [$Outer].[InvoiceDate] as [InvoiceDate],
    [$Outer].[InvoiceTotal] as [InvoiceTotal],
    [$Outer].[PaymentTotal] as [PaymentTotal],
    [$Outer].[CreditTotal] as [CreditTotal],
    [$Outer].[TermsID] as [TermsID],
    [$Outer].[InvoiceDueDate] as [InvoiceDueDate],
    [$Outer].[PaymentDate] as [PaymentDate],
    [$Inner].[VendorState] as [Vendors.VendorState]
from 
(
    select [_].[InvoiceID] as [InvoiceID],
        [_].[VendorID] as [VendorID2],
        [_].[InvoiceNumber] as [InvoiceNumber],
        [_].[InvoiceDate] as [InvoiceDate],
        [_].[InvoiceTotal] as [InvoiceTotal],
        [_].[PaymentTotal] as [PaymentTotal],
        [_].[CreditTotal] as [CreditTotal],
        [_].[TermsID] as [TermsID],
        [_].[InvoiceDueDate] as [InvoiceDueDate],
        [_].[PaymentDate] as [PaymentDate]
    from [dbo].[Invoices] as [_]
) as [$Outer]
left outer join [dbo].[Vendors] as [$Inner] on ([$Outer].[VendorID2] = [$Inner].[VendorID])
) AS [t2]

 LEFT OUTER JOIN 

(
select [$Table].[VendorID] as [VendorID],
    [$Table].[VendorName] as [VendorName],
    [$Table].[VendorAddress1] as [VendorAddress1],
    [$Table].[VendorAddress2] as [VendorAddress2],
    [$Table].[VendorCity] as [VendorCity],
    [$Table].[VendorState] as [VendorState],
    [$Table].[VendorZipCode] as [VendorZipCode],
    [$Table].[VendorPhone] as [VendorPhone],
    [$Table].[VendorContactLName] as [VendorContactLName],
    [$Table].[VendorContactFName] as [VendorContactFName],
    [$Table].[DefaultTermsID] as [DefaultTermsID],
    [$Table].[DefaultAccountNo] as [DefaultAccountNo]
from [dbo].[Vendors] as [$Table]
) AS [t0] on 
(
[t2].[VendorID] = [t0].[VendorID]
)
)


 LEFT OUTER JOIN 

(
select [$Table].[TermsID] as [TermsID],
    [$Table].[TermsDescription] as [TermsDescription],
    [$Table].[TermsDueDays] as [TermsDueDays]
from [dbo].[Terms] as [$Table]
) AS [t3] on 
(
[t0].[DefaultTermsID] = [t3].[TermsID]
)
)

GROUP BY [t0].[VendorState],[t3].[TermsDescription]
)
 AS [MainTable]
WHERE 
(

NOT(
(
[a0] IS NULL 
)
)

)
 
