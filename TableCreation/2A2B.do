/* In the MSSQL Server tables are per return period
2A-2B was started in 2012-13. For the first year the annexure was collected at Monthly Frequency
To match 2A-2B filing with the returns we will have to sum up the monthly returns at quarterly level.
For the subsequent years it was collected at Quarterly Frequency.*/
cd "D:\data\"
/* First we create a file only for 2012-13 period at the monthly level*/
dbc load, table("dbo.t9851012") noquote
gen SourceFile="t9851012"
save "annexure_2A2B_monthly_201213.dta", replace


odbc load, table("dbo.t9851112") noquote
gen SourceFile="t9851112"
append using "annexure_2A2B_monthly_201213.dta"
save "annexure_2A2B_monthly_201213.dta", replace
clear 

/* Third we load the t985113 file for 2A2B**/
odbc load, table("dbo.t985113") noquote
gen SourceFile="t985113"
append using "annexure_2A2B_monthly_201213.dta"
save "annexure_2A2B_monthly_201213.dta", replace
clear 

/* Fourth we load the t9851212 file for 2A2B**/
odbc load, table("dbo.t9851212") noquote
gen SourceFile="t9851212"
append using "annexure_2A2B_monthly_201213.dta"
save "annexure_2A2B_monthly_201213.dta", replace
clear 

/* Fifth we load the t985213 file for 2A2B**/
odbc load, table("dbo.t985213") noquote
gen SourceFile="t985213"
append using "annexure_2A2B_monthly_201213.dta"
save "annexure_2A2B_monthly_201213.dta", replace
clear 

/* Sixth we load the t985313 file for 2A2B**/
odbc load, table("dbo.t985313") noquote
gen SourceFile="t985313"
append using "annexure_2A2B_monthly_201213.dta"
save "annexure_2A2B_monthly_201213.dta", replace
clear


/* Ninth we load the t985412 file for 2A2B**/
odbc load, table("dbo.t985412") noquote
gen SourceFile="t985412"
append using "annexure_2A2B_monthly_201213.dta"
save "annexure_2A2B_monthly_201213.dta", replace
clear

odbc load, table("dbo.t985512") noquote
gen SourceFile="t985512"
append using "annexure_2A2B_monthly_201213.dta"
save "annexure_2A2B_monthly_201213.dta", replace
clear

odbc load, table("dbo.t985612") noquote
gen SourceFile="t985612"
append using "annexure_2A2B_monthly_201213.dta"
save "annexure_2A2B_monthly_201213.dta", replace
clear

odbc load, table("dbo.t985712") noquote
gen SourceFile="t985712"
append using "annexure_2A2B_monthly_201213.dta"
save "annexure_2A2B_monthly_201213.dta", replace
clear

odbc load, table("dbo.t985812") noquote
gen SourceFile="t985812"
append using "annexure_2A2B_monthly_201213.dta"
save "annexure_2A2B_monthly_201213.dta", replace
clear

odbc load, table("dbo.t985912") noquote
gen SourceFile="t985912"
append using "annexure_2A2B_monthly_201213.dta"
save "annexure_2A2B_monthly_201213.dta", replace
clear


/* Second,  we create a file only for 2013-14 period at the quarterly level*/
odbc load, table("dbo.t9854213") noquote
gen SourceFile="t9854213"
save "annexure_2A2B_quarterly_2013.dta", replace
clear

odbc load, table("dbo.t9854113") noquote
gen SourceFile="t9854113"
append using "annexure_2A2B_quarterly_2013.dta.dta"
save "annexure_2A2B_quarterly_2013.dta.dta", replace
clear

odbc load, table("dbo.t9854413") noquote
gen SourceFile="t9854413"
append using "annexure_2A2B_quarterly_2013.dta.dta"
save "annexure_2A2B_quarterly_2013.dta.dta", replace
clear

odbc load, table("dbo.t9854313") noquote
gen SourceFile="t9854313"
append using "annexure_2A2B_quarterly_2013.dta"
save "annexure_2A2B_quarterly_2013.dta", replace
clear


/* Third,  we create a file only for 2014-15 period at the quarterly level*/
odbc load, table("dbo.t9854114") noquote
gen SourceFile="t9854114"
save "annexure_2A2B_quarterly_2014.dta", replace
clear

/* Eleventh we load the t9854214 file for 2A2B**/
odbc load, table("dbo.t9854214") noquote
gen SourceFile="t9854214"
append using "annexure_2A2B_quarterly_2014.dta"
save "annexure_2A2B_quarterly_2014.dta", replace
clear

odbc load, table("dbo.t9854314") noquote
gen SourceFile="t9854314"
append using "annexure_2A2B_quarterly_2014.dta"
save "annexure_2A2B_quarterly_2014.dta", replace
clear

odbc load, table("dbo.t9854414") noquote
gen SourceFile="t9854414"
append using "annexure_2A2B_quarterly_2014.dta"
save "annexure_2A2B_quarterly_2014.dta", replace



//Now we rename all the variables for all the three files.
rename T985001 SaleOrPurchase
rename T985002 SalePurchaseType
rename T985003 DealerGoodType
rename T985004 TransactionType
rename T985005 Rate
rename T985006 Amount	
rename T985007 TaxAmount	
rename T985008 TotalAmount	
rename T985009 SellerBuyerTIN
rename T985010 DealerName	
rename T985011 DealerTIN	
rename T985012 Month
rename T985013 Year
rename T985014 DateTime	
rename T985015 ReceiptId	
rename T985016 Date
rename T985017 FormsStatus
rename T985018 TaxRate
rename T985019 AEBoolean

	
label variable SaleOrPurchase "AN-Purchase not eligible/AE- Purchase Eligible/BF - 2B Sales T985001"
label variable SalePurchaseType "IOI/HSP/PEU/PUC/PTEG/CG/ISPC/ISPH/ISPN/E1E2/SBT/SCT/OT/ISBCT/EOI/HSS/ISS/LS	T985002"
label variable DealerGoodType "CG/OT/RD/UD	T985003"
label variable TransactionType "None/Exempted/H/I/E1E2/C/J/GD/WC	T985004"
label variable SellerBuyerTIN "Tin of the dealer whom the current dealer sold to or bought from"
label variable DealerName "Name of the current dealer"
label variable DealerTIN "Tin number of the current dealer"
label variable DateTime "Date time	T985014"
label variable ReceiptId "Receipt Id	T985015"
label variable Date "ate(Month Year important)	T985016"
label variable FormsStatus "Forms Status	T985017"
label variable TaxRate "Rate of Tax	T985018"
label variable AEBoolean "Yes/No in AE cases	T985019"


gen Quarter=0
replace Quarter=1 if SourceFile=="t9854114"
replace Quarter=2 if SourceFile=="t9854214"
replace Quarter=3 if SourceFile=="t9854314"
replace Quarter=4 if SourceFile=="t9854414"
