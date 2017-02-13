/* This files extracts and renames the returns data*/
cd "D:\data"
/* First we load the Form 16 filings for year 2010-11*/
odbc load, table("dbo.F16T3121011") noquote clear
gen SourceFile="F16T3121011"
save "form16_data.dta", replace
clear

/* Second we load the Form 16 filings for year 2011-12*/
odbc load, table("dbo.F16T3121112") noquote
gen SourceFile="F16T3121112"
append using "form16_data.dta"
save "form16_data.dta", replace
clear 

/* Third we load the Form 16 filings for year 2012-13*/
odbc load, table("dbo.F16T3121213") noquote
gen SourceFile="F16T3121213"
append using "form16_data.dta"
save "form16_data.dta", replace
clear

/* Fourth we load the Form 16 filings for year 2013-14*/
odbc load, table("dbo.F16T3121314") noquote
gen SourceFile="F16T3121314"
append using "form16_data.dta"
save "form16_data.dta", replace
clear

/* Fifth we load the Form 16 filings for year 2014-15*/
odbc load, table("dbo.F16T3121415") noquote
gen SourceFile="F16T3121415"
append using "form16_data.dta"
save "form16_data.dta", replace
clear

/* Renaming all the variables appropriately. Please refer codebook*/
rename T312001 id
rename T312003 RefundClaimedBoolean
rename T312004 TaxPeriod
rename T312005 PeriodBegin
rename T312006 PeriodEnd
rename T312007 Tin
rename T312008 DealerName
rename T312009 DealerAddress
rename T312010 DealerTelephone
rename T312014 Frequency
rename T312015 TurnoverGross
rename T312016 TurnoverCentral
rename T312017 TurnoverLocal
rename T312018 TurnoverAt1
rename T312019 OutputTaxAt1
rename T312022 TurnoverAt5
rename T312023 OutputTaxAt5
rename T312024 TurnoverAt125
rename T312025 OutputTaxAt125
rename T312026 TurnoverAt20
rename T312027 OutputTaxAt20
rename T312030 WCTurnoverAt5
rename T312031 WCOutputTaxAt5
rename T312032 WCTurnoverAt125
rename T312033 WCOutputTaxAt125
rename T312034 ExemptedSales
rename T312179 LaborCharges
rename T312180 LandCharges
rename T312171 DieselSale
rename T312181 SaleDelhiFormH
rename T312036 OutputTaxBeforeAdjustment
rename T312037 AdjustmentOutputTax
rename T312038 TotalOutputTax
rename T312039 PurchaseCapitalGoods
rename T312040 CreditCapitalGoods
rename T312035 PurchaseOtherGoods
rename T312058 CreditOtherGoods
rename T312041 PurchaseGoodsAt1
rename T312042 CreditGoodsAt1
rename T312045 PurchaseGoodsAt5
rename T312046 CreditGoodsAt5
rename T312047 PurchaseGoodsAt125
rename T312048 CreditGoodsAt125
rename T312049 PurchaseGoodsAt20
rename T312050 CreditGoodsAt20
rename T312053 WCPurchaseAt5
rename T312054 WCCreditAt5
rename T312055 WCPurchaseAt125
rename T312056 WCCreditAt125
rename T312168 PurchaseUnregisteredDealer
rename T312174 PurchaseCompositionDealer
rename T312175 PurchaseNonCreditableGoods
rename T312177 PurchaseTaxFreeGoods
rename T312182 WCLabourPurchase 
rename T312183 PurchaseIneligibleForITC
rename T312176 PurchaseRetailInvoice
rename T312172 DieselPurchase
rename T312184 PurchaseDelhiFormH
rename T312185 PurchaseCapitalNonCreditGood
rename T312059 TaxCreditBeforeAdjustment
rename T312060 AdjustmentTaxCredit
rename T312061 TotalTaxCredit
rename T312062 NetTax
rename T312063 InterestPayable
rename T312064 PenaltyPayable
rename T312065 TDSCertificates
rename T312186 CarryForwardTaxCredit
rename T312187 CSTAdjustmentVAT
rename T312066 BalancePayable
rename T312067 AmountDepositedByDealer
rename T312068 AggregateAmountPaid
rename T312069 NetBalance
rename T312070 BalanceBroughtForward
rename T312071 AdjustCSTLiability
rename T312072 RefundClaimed
rename T312073 BalanceCarriedNextTaxPeriod
rename T312074 AccountNumber
rename T312075 AccountType
rename T312076 MICR
rename T312077 BankDetails
rename T312078 InterStateSaleCD
rename T312079 InterStatePurchaseCD
rename T312080 InterStateSaleCE1E2
rename T312081 InterStatePurchaseCE1E2
rename T312188 OutwardStockTransferBranchF //Need to verify this is correct
rename T312189 InwardStockTransferBranchF //Need to verify this is correct
rename T312190 OutwardStockTransferConsignmentF //Need to verify this is correct
rename T312191 InwardStockTransferConsignmentF //Need to verify this is correct
rename T312192 OwnGoodsTransferredAfterJobF //Need to verify this is correct
rename T312193 OwnGoodsReceivedAfterJobF //Need to verify this is correct
rename T312194 OtherDealersGoodsTrJobF //Need to verify this is correct
rename T312195 OtherDealersGoodsReJobF //Need to verify this is correct
rename T312084 InterStateExportsAgainstH
rename T312085 InterStateImportsAgainstH
rename T312086 InterStateExportsAgainstI
rename T312087 InterStateImportsAgainstI
rename T312088 InterStateExportsAgainstJ
rename T312089 InterStateImportsAgainstJ
rename T312090 ExportFromIndia //Need to verifty
rename T312091 ImportToIndia //Need to verify
rename T312196 SaleExemptedGoodsSchedule //Need to verify
rename T312197 PurchaseExemptedGoodsSchedule //Need to verify
rename T312198 SaleExemptedGoodsCST //Need to verify
rename T312199 PurchaseExemptedGoodsCST //Need to verify
rename T312200 HighSeaSale //Need to verify
rename T312201 HighSeaPurchase //Need to verify
rename T312094 InterStateSaleOther
rename T312095 InterStatePurchaseOther
rename T312096 InterStateSaleCapital
rename T312097 InterStatePurchaseCapital
rename T312098 TotalInterStateSale
rename T312099 TotalInterStatePurchase
rename T312100 Name
rename T312101 Designation
rename T312102 Place
rename T312103 Date
rename T312143 WardName
rename T312144 TDSDetails
rename T312145 Status
rename T312146 ApprovalDate
rename T312147 AcknowledgementNumber
rename T312148 Year
rename T312169 ReturnType
rename T312135 TDSString
rename T312136 Receipt2A2B
rename T312173 Signatory

/* Labelling variables where needed*/
label variable id "This is the internal id. I think this is the primary key"
label variable RefundClaimedBoolean "Tinyint(1-Yes, 0-No)"
label variable TaxPeriod "The tax period for which the returns has been filed"
label variable WCTurnoverAt5 "R5.5 Work contract taxable at 5%  - Turnover(Rs.)	T312030"
label variable WCOutputTaxAt5 "R5.5 Work contract taxable at 5%  - Output Tax(Rs)	T312031"
label variable WCTurnoverAt125 "R5.6 Work contract taxable at 12.5%  - Turnover(Rs.)	T312032"
label variable WCOutputTaxAt125 "R5.6 Work contract taxable at 12.5%  - Output Tax(Rs)	T312033"
label variable ExemptedSales "R5.7 Exempted sales	T312034"
label variable LaborCharges "R5.8 Charges towards labour, services and other like charges	T312179"
label variable LandCharges "R5.9 Charges towards cost of land, if any, in civil works contracts	T312180"
label variable DieselSale "R5.10Sale of Diesel & Petrol as have suffered tax in the hands of various Oil Marketing Companies in Delhi	T312171"
label variable SaleDelhiFormH "R5.11 sales within Delhi against Form 'H'	T312181"
label variable OutputTaxBeforeAdjustment "R5.12 Output Tax before Adjustment - SubTotal (A)	T312036"
label variable AdjustmentOutputTax "R5.13 Adjustment to Output Tax(Complete Annexure and enter Total A2 here) - (B)	T312037"
label variable TotalOutputTax "R5.14 Total OutPut Tax (A+B)	T312038"
label variable PurchaseCapitalGoods "R6.1 Capital Goods - Purchases(Rs.)	T312039"
label variable CreditCapitalGoods "R6.1 Capital Goods - Tax Credit(Rs.)	T312040"
label variable PurchaseOtherGoods "R6.2 Other Goods - Purchases(Rs.)	T312035"
label variable CreditOtherGoods "R6.2 Other Goods - Tax Credit(Rs.)	T312058"
label variable PurchaseGoodsAt1 "R6.2(1) Goods taxable at 1% - Purchases(Rs.)	T312041"
label variable CreditGoodsAt1 "R6.2(1) Goods taxable at 1% - Tax Credit(Rs.)	T312042"
label variable PurchaseGoodsAt5 "R6.2(2) Goods taxable at 5% - Purchases(Rs.)	T312045"
label variable CreditGoodsAt5 "R6.2(2) Goods taxable at 5% - Tax Credit(Rs.)	T312046"
label variable PurchaseGoodsAt125 "R6.2(3) Goods taxable at 12.5% - Purchases(Rs.)	T312047"
label variable CreditGoodsAt125 "R6.2(3) Goods taxable at 12.5% - Tax Credit(Rs.)	T312048"
label variable PurchaseGoodsAt20 "R6.2(4) Goods taxable at 20% - Purchases(Rs.)	T312049"
label variable CreditGoodsAt20 "R6.2(4) Goods taxable at 20% - Tax Credit(Rs.)	T312050"
label variable WCPurchaseAt5 "R6.2(5) Work contract taxable at 5% - Purchases(Rs.)	T312053"
label variable WCCreditAt5 "R6.2(5) Work contract taxable at 5% - Tax Credit(Rs.)	T312054"
label variable WCPurchaseAt125 "R6.2(6) Work contract taxable at 12.5% - Purchases(Rs.)	T312055"
label variable WCCreditAt125 "R6.2(6) Work contract taxable at 12.5% - Tax Credit(Rs.)	T312056"
label variable PurchaseUnregisteredDealer "R 6.3(1)  PUECHASE FROM UNREGISTERED DEALER	T312168"
label variable PurchaseCompositionDealer "R 6.3(2) Purchase from composition Dealer 	T312174"
label variable PurchaseNonCreditableGoods "R 6.3(3) Purchase from Non Creditable Goods :	T312175"
label variable PurchaseTaxFreeGoods "R6.3(4) Purchase from Tax free Goods :	T312177"
label variable WCLabourPurchase "R6.3(5) Purchase of labour and services related to works contract	T312182"
label variable PurchaseIneligibleForITC "R6.3(6) Purchase againsttax Invoices not eligible for ITC :	T312183"
label variable PurchaseRetailInvoice "R6.3(7) Purchase against Retail Invoices :	T312176"
label variable DieselPurchase "R6.3(8) Purchase of Diesel & petrol as have suffered tax in the hands of various Oil Marketing Companies in Delhi	T312172"
label variable PurchaseDelhiFormH "R6.3(9) Purchase from delhi dealers against Form 'H'	T312184"
label variable PurchaseCapitalNonCreditGood "R6.3(10) Purchase of Capital Goods (Used for manufacturing of non-creditable goods)	T312185"
label variable TaxCreditBeforeAdjustment "R6.4 Tax Credit before Adjustment - Sub Total (A) amount	T312059"
label variable AdjustmentTaxCredit "R6.5 Adjustment of Tax credits(Complete Annexure and enter Total A4 here) - (B)	T312060"
label variable TotalTaxCredit "R6.6 Total Tax Credit (A + B)	T312061"
label variable NetTax "R7.1 Net Tax  (R5.14 - R6.6)	T312062"
label variable InterestPayable "R7.2 Add: Interest,If Payble	T312063"
label variable PenaltyPayable "R7.3 Add: Panelty,If Payble	T312064"
label variable TDSCertificates "R7.4 Tax Deducted at source (Attach  No of TDS Certificates in Original :)	T312065"
label variable CarryForwardTaxCredit "R7.5 Tax Credit carried forward from previous tax period	T312186"
label variable CSTAdjustmentVAT "R7.6 Adjustment of excess balance under CST towards DVAT liability	T312187"
label variable BalancePayable "R7.7 Balance Payable ((R7.1 + R7.2 + R7.3 )-( R7.4+R7.5+R7.6))	T312066"
label variable AmountDepositedByDealer "R7.8  Amount Deposited by the Dealer (attach proof of payment)	T312067"
label variable AggregateAmountPaid "Aggregate Amount Paid(Sum total of Challan)	T312068"
label variable NetBalance "R8. Net Balance * (R7.7 - R7.8) :	T312069"
label variable BalanceBroughtForward "R9.0 Balance Brought forward from line (positive value)	T312070"
label variable AdjustCSTLiability "R9.1 Adjust against laibility under Central Sales Tax	T312071"
label variable RefundClaimed "R9.2 Refund Claimed	T312072"
label variable BalanceCarriedNextTaxPeriod "R9.3 Balance Carried forward to Next Tax Period	T312073"
label variable AccountNumber "R10.1 Account No	T312074"
label variable AccountType "R10.2 Account Type(Saving/Current etc.)	T312075"
label variable MICR "R10.3 MICR No	T312076"
label variable BankDetails "R10.4 Name of Bank and Branch	T312077"
label variable InterStateSaleCD "R11.1 Againts C/D Forms Inter - State Sales Exports	T312078"
label variable InterStatePurchaseCD "R11.1 Againts C/D Forms Inter - State Purchase/Imports	T312079"
label variable InterStateSaleCE1E2 "R11.2 Against C+ E1/E2 Forms - Inter State Sales Exports	T312080"
label variable InterStatePurchaseCE1E2 "R11.2 Against C+ E1/E2 Forms - Inter-State Purchase/Imports	T312081"
label variable OutwardStockTransferBranchF "R11.3 Inward/outward Stock Transfer(Branch) against F Forms	T312188"
label variable InwardStockTransferBranchF "R11.3 Inward/outward Stock Transfer(Branch) against F Forms	T312189"
label variable OutwardStockTransferConsignmentF "R11.4 Inward/outward Stock Transfer(Consignment) against F Forms	T312190"
label variable InwardStockTransferConsignmentF "R11.4 Inward/outward Stock Transfer(Consignment) against F Forms	T312191"
label variable OwnGoodsTransferredAfterJobF "R11.5 Own goods received/tranferered after job work against F Forms	T312192"
label variable OwnGoodsReceivedAfterJobF "R11.5 Own goods received/tranferered after job work against F Forms	T312193"
label variable OtherDealersGoodsTrJobF "R11.6 Other Dealers goods received/returned after job work against F Forms	T312194"
label variable OtherDealersGoodsReJobF "R11.6 Other Dealers goods received/returned after job work against F Forms	T312195"
label variable InterStateExportsAgainstH "R11.7 Against H Forms - Inter State Sales Exports	T312084"
label variable InterStateImportsAgainstH "R11.7 Against H Forms - Inter-State Purchase/Imports	T312085"
label variable InterStateExportsAgainstI "R11.8 Against I Forms - Inter State Sales Exports	T312086"
label variable InterStateImportsAgainstI "R11.8 Against I Forms - Inter-State Purchase/Imports	T312087"
label variable InterStateExportsAgainstJ "R11.9 Against J Forms - Inter State Sales Exports	T312088"
label variable InterStateImportsAgainstJ "R11.9 Against J Forms - Inter State Purchase/Imports	T312089"
label variable ExportFromIndia "R11.10 Export to/Import from outside India - Inter State Sales Exports	T312090"
label variable ImportToIndia "R11.10 Export to/Import from outside India - Inter-State Purchase/Imports	T312091"
label variable SaleExemptedGoodsSchedule "R11.11 Sae of Exempted Goods(Schedule 1)	T312196"
label variable PurchaseExemptedGoodsSchedule "R11.11 Sae of Exempted Goods(Schedule 1)	T312197"
label variable SaleExemptedGoodsCST "R11.12 Purchase of Exempted Goods (Section 8(5) ) of CST Act)	T312198"
label variable PurchaseExemptedGoodsCST "R11.12 Purchase of Exempted Goods (Section 8(5) ) of CST Act)	T312199"
label variable HighSeaSale "R11.13 High Sea Sales/Purchases	T312200"
label variable HighSeaPurchase "R11.13 High Sea Sales/Purchases	T312201"
label variable InterStateSaleOther "R11.14 Other(Not Supported by any form)- Inter State Sales Exports	T312094"
label variable InterStatePurchaseOther "R11.14 Other(Not Supported by any form)- Inter-State Purchase/Imports	T312095"
label variable InterStateSaleCapital "R11.15 Capital Goods- Inter State Sales Exports	T312096"
label variable InterStatePurchaseCapital "R11.15 Capital Goods- Inter-State Purchase/Imports	T312097"
label variable TotalInterStateSale "R11.16 Total Inter State Sales Exports	T312098"
label variable TotalInterStatePurchase "R11.16 Total  Inter-State Purchase/Imports	T312099"
label variable Name "Full Name (First, Middle, Surname)	T312100"
label variable Designation "Designation/Status	T312101"
label variable Place "Place	T312102"
label variable Date "Date	T312103"
label variable WardName "Ward Name	T312143"
label variable TDSDetails "R7.4 Details of TDS(no of Attachment)	T312144"
label variable Status "Status	T312145"
label variable ApprovalDate "Approval Date	T312146"
label variable AcknowledgementNumber "Acknowledgement No(Receipt ID)	T312147"
label variable Year "Year	T312148"
label variable ReturnType "ReturnType	T312169"
label variable TDSString "TDS STRING	T312135"
label variable Receipt2A2B "2A AND 2B RECEIPT	T312136"
label variable Signatory "Authorized Signatory + Designation	T312173"


save "form16_data.dta", replace

/* These are the variables that we need the key for */
br id T312002 T312011 T312012 T312013 T312020 T312021 T312028 T312029 T312043 T312044 T312051 T312052 T312082 T312083 T312092 T312093 T312104 T312105 T312106 T312107 T312108 T312109 T312110 T312111 T312112 T312113 T312114 T312115 T312116 T312117 T312118 T312119 T312120 T312121 T312122 T312123 T312124 T312125 T312126 T312127 T312128 T312129 T312130 T312131 T312132 T312133 T312134 T312137 T312138 T312139 T312140 T312141 T312142 T312149 T312150 T312151 T312152 T312153 T312154 T312155 T312156 T312157 T312158 T312159 T312160 T312161 T312162 T312163 T312164 T312165 T312166 T312167 T312170 T312DF1 T312DF2 T312DF3 T312DF4 T312DF5 T312DF6 T312DF7 T312DF8 T312178 T312203 T312202

