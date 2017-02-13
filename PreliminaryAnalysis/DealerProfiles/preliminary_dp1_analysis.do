cd "E:\data"
use "DealerProfile.dta", clear


use "E:\data\DataVerification\step3\DealerProfile_uniqueTin.dta" 

//This ended up being an analysis of registration pattern in the last 5 years

// First we import the date from the registration date
gen RegistrationYear=dofc(RegistrationDate)
format %td RegistrationYear //change it into date format
//Import just the year inf
gen StartYear=yofd(RegistrationYear)
gen StartMonth=mofd(RegistrationYear)
//Changing the format to appropriate year form

format %tm StartMonth
format %ty StartYear 

/* Begin analysis for number of registrations between 2010 and 2015*/
gen month=StartMonth
gen year=1 if month>602&month<=614
replace year=2 if month>614&month<=626
replace year=3 if month>626&month<=638
replace year=4 if month>638&month<=650
replace year=5 if month>650&month<=662
replace year=6 if month>662&month<=674
//In this definition month=1 is January 2010
//replace month=month-599 
//In this definition month=1 is April 2010
replace month=month-602 
gen dummy=1

preserve
collapse (count) dummy (mean) year StartYear StartMonth, by(month)
twoway (connected dummy month if year!=.&month<66), xline(25)
restore

preserve
collapse (count) dummy (mean) year , by(month)
twoway (connected dummy month if year!=.), xline(25)
restore



preserve
collapse (sum) dummy (mean) StartYear, by(year)
twoway (connected dummy StartYear if year!=.)
restore
/* End analysis for number of registrations between 2010 and 2015*/


//Now I categorize dealears based on the decade in which they were registered
gen decade=1 if StartYear<=1955
replace decade=2 if StartYear>1955&StartYear<=1965
replace decade=3 if StartYear>1965&StartYear<=1975
replace decade=4 if StartYear>1975&StartYear<=1985
replace decade=5 if StartYear>1985&StartYear<=1995
replace decade=6 if StartYear>1995&StartYear<=2005
replace decade=7 if StartYear>2005&StartYear<=2015
replace decade=8 if StartYear>2015&StartYear!=.


//Now we keep only the latest dealer profile for a dealer tin
gsort DealerTIN -idDP
drop if DealerTIN==""
by DealerTIN: gen FileCount=_n
tab FileCount
keep if FileCount ==1

save "PreliminaryAnalysis\DealerProfiles\unique dealer profiles with year.dta"


//1. First we start with annual filings
use "PreliminaryAnalysis\returns\form16_data_v3_0901_annual filings.dta", clear
merge m:1 DealerTIN using "PreliminaryAnalysis\DealerProfiles\unique dealer profiles with year.dta", keepusing(RegistrationDate decade StartYear StartMonth RegistrationYear)
/*
Result                           # of obs.
-----------------------------------------
not matched                       310,035
from master                    16,890	(_merge==1)
from using                    293,145	(_merge==2)

matched                            35,245	(_merge==3)
-----------------------------------------

*/

keep if _merge==3
*save "PreliminaryAnalysis\DealerProfiles\form16_annual returns_with dealer profile_0902.dta"

collapse (sum) TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year decade) fast
gen SourceFile="Annual Returns"
save "PreliminaryAnalysis\DealerProfiles\form16_aggregate_annual_with dealer profile_0902.dta"


//2. THen we do the semi-annual returns
use "PreliminaryAnalysis\returns\form16_data_v3_0901_halfyearly filings.dta", clear
merge m:1 DealerTIN using "PreliminaryAnalysis\DealerProfiles\unique dealer profiles with year.dta", keepusing(RegistrationDate decade StartYear StartMonth RegistrationYear)

/*	Result                           # of obs.
	-----------------------------------------
	not matched                       292,830
	from master                    28,274	(_merge==1)
	from using                    264,556	(_merge==2)

	matched                           174,013	(_merge==3)
	-----------------------------------------

. 
*/
keep if _merge==3

collapse (sum) TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year decade) fast
gen SourceFile="Half Yearly Returns"
append using "PreliminaryAnalysis\DealerProfiles\form16_aggregate_annual_with dealer profile_0902.dta"
save "PreliminaryAnalysis\DealerProfiles\form16_aggregate_annual_with dealer profile_0902.dta", replace

//3. THen we do the quarterly returns
//Now we will aggregate both at the quarterly and the annual level
use "PreliminaryAnalysis\returns\form16_data_v3_0901_quarterly filings.dta", clear
merge m:1 DealerTIN using "PreliminaryAnalysis\DealerProfiles\unique dealer profiles with year.dta", keepusing(RegistrationDate decade StartYear StartMonth RegistrationYear)
 /*
 Result                           # of obs.
    -----------------------------------------
    not matched                       409,830
        from master                   372,150  (_merge==1)
        from using                     37,680  (_merge==2)

    matched                         3,212,000  (_merge==3)
    -----------------------------------------

*/
keep if _merge==3
preserve
collapse (sum) TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year decade) fast
gen SourceFile="Quarterly Returns"
append using "PreliminaryAnalysis\DealerProfiles\form16_aggregate_annual_with dealer profile_0902.dta"
save "PreliminaryAnalysis\DealerProfiles\form16_aggregate_annual_with dealer profile_0902.dta", replace

restore

//Now we do the quarterly collapse
collapse (sum) TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter decade) fast
gen SourceFile="Quarterly Returns"
save "PreliminaryAnalysis\DealerProfiles\form16_aggregate_quarterly_with dealer profile_0902.dta", replace


//4. Finally we do the monthly returns
use "PreliminaryAnalysis\DealerProfiles\form16_data_v3_0901_monthly filings.dta", clear
merge m:1 DealerTIN using "PreliminaryAnalysis\DealerProfiles\unique dealer profiles with year.dta", keepusing(RegistrationDate decade StartYear StartMonth RegistrationYear)

/*

    Result                           # of obs.
    -----------------------------------------
    not matched                       350,920
        from master                    54,310  (_merge==1)
        from using                    296,610  (_merge==2)

    matched                           477,268  (_merge==3)
    -----------------------------------------


*/
keep if _merge==3
preserve

collapse (sum) TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year decade) fast
gen SourceFile="Monthly Returns"
append using "PreliminaryAnalysis\DealerProfiles\form16_aggregate_annual_with dealer profile_0902.dta"
save "PreliminaryAnalysis\DealerProfiles\form16_aggregate_annual_with dealer profile_0902.dta", replace

//Now we do the quarterly collapse
collapse (sum) TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter decade) fast
gen SourceFile="Monthly Returns"
append using "PreliminaryAnalysis\DealerProfiles\form16_aggregate_quarterly_with dealer profile_0902.dta"
save "PreliminaryAnalysis\DealerProfiles\form16_aggregate_quarterly_with dealer profile_0902.dta", replace


//Now we add all the returns at the annual level
use "PreliminaryAnalysis\DealerProfiles\form16_aggregate_annual_with dealer profile_0902.dta", replace

collapse (sum) TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year decade) fast

save "PreliminaryAnalysis\DealerProfiles\form16_aggregate_annual_with dealer profile_0902_final.dta", replace
gen lTurnoverGross=log(TurnoverGross)
gen lTurnoverCentral=log(TurnoverCentral)
gen lTurnoverLocal=log(TurnoverLocal)
gen lTotalOutputTax=log(TotalOutputTax)
gen lPurchaseUnregisteredDealer=log(PurchaseUnregisteredDealer)
gen lNetTax=log(NetTax)
gen lPurchaseIneligibleForITC=log(PurchaseIneligibleForITC)
gen lTotalTaxCredit=log(TotalTaxCredit)
gen lNetBalance=log(NetBalance)
gen lAggregateAmountPaid=log(AggregateAmountPaid)
gen lCarryForwardTaxCredit=log(CarryForwardTaxCredit)
gen lBalancePayable=log(BalancePayable)
gen lTotalInterStateSale=log(TotalInterStateSale)
gen lTotalInterStatePurchase=log(TotalInterStatePurchase)
save "PreliminaryAnalysis\DealerProfiles\form16_aggregate_annual_with dealer profile_0902_final.dta", replace

//Finally a graph that looks good trying all of them at the annual level
twoway (line NetBalance year, sort) (line NetTax year) (line TotalOutputTax year) (line CarryForwardTaxCredit year) if decade==7
twoway (line lTurnoverGross year, sort) (line lTurnoverCentral year) (connected lTurnoverLocal year) (connected lPurchaseUnregisteredDealer year, sort) (line lTotalInterStateSale year) (line lTotalInterStatePurchase year) if decade==7


twoway (line lTurnoverGross year if decade==1, sort) (connected lTurnoverGross year if decade==2) (connected lTurnoverGross year if decade==3)(connected lTurnoverGross year if decade==4) (connected lTurnoverGross year if decade==5)(connected lTurnoverGross year if decade==6)(connected lTurnoverGross year if decade==7)
twoway (line lTurnoverGross year if decade==6, sort) (connected lTurnoverGross year if decade==7) 

twoway (line lTotalInterStateSale year, sort) (connected lTotalInterStatePurchase year) (connected lBalancePayable year), by(decade) 
twoway (line TotalInterStateSale year, sort) (connected TotalInterStatePurchase year) (connected BalancePayable year), by(decade)
twoway (connected BalancePayable year), by(decade)  
twoway (connected BalancePayable year if decade==7)
twoway (connected PurchaseUnregisteredDealer year), by(decade)  

twoway (connected lPurchaseUnregisteredDealer year), by(decade)  

//Now we add all the returns at the quarter

use "PreliminaryAnalysis\DealerProfiles\form16_aggregate_quarterly_with dealer profile_0902.dta", replace
collapse (sum) TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter decade) fast
save "PreliminaryAnalysis\DealerProfiles\form16_aggregate_quarterly_with dealer profile_0902_final.dta", replace
gen lTurnoverGross=log(TurnoverGross)
gen lTurnoverCentral=log(TurnoverCentral)
gen lTurnoverLocal=log(TurnoverLocal)
gen lTotalOutputTax=log(TotalOutputTax)
gen lPurchaseUnregisteredDealer=log(PurchaseUnregisteredDealer)
gen lNetTax=log(NetTax)
gen lPurchaseIneligibleForITC=log(PurchaseIneligibleForITC)
gen lTotalTaxCredit=log(TotalTaxCredit)
gen lNetBalance=log(NetBalance)
gen lAggregateAmountPaid=log(AggregateAmountPaid)
gen lCarryForwardTaxCredit=log(CarryForwardTaxCredit)
gen lBalancePayable=log(BalancePayable)
gen lTotalInterStateSale=log(TotalInterStateSale)
gen lTotalInterStatePurchase=log(TotalInterStatePurchase)
save "PreliminaryAnalysis\DealerProfiles\form16_aggregate_quarterly_with dealer profile_0902_final.dta", replace
