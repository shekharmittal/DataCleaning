cd "D:\data"

use "TableCommodityCode.dta", clear
drop if id==""
gsort  id DealerTIN CommodityCode
br id DealerTIN CommodityCode
duplicates drop id DealerTIN CommodityCode, force

save "PreliminaryAnalysis\CommodityWiseReturns\TableCommodityCodes_unique_v2_0930.dta"

keep if CommodityCode=="110000"

merge 1:1 id DealerTIN using "PreliminaryAnalysis\returns\form16_data_v3_0901.dta"

/*I first identify dealers who traded in ghee at some point of time*/
use "D:\data\PreliminaryAnalysis\CommodityWiseReturns\TableCommodityCodes_unique_v2_0930.dta", clear
keep if CommodityCode=="110000"
gsort DealerTIN id
by DealerTIN:gen ReturnCount=_n
tab ReturnCount
keep if ReturnCount==1
gen GheeDummy=1
save "PreliminaryAnalysis\CommodityWiseReturns\dealers_ghee.dta"


/* Then I will do analysis only on those dealers which traded in ghee*/
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
merge m:1 DealerTIN using "PreliminaryAnalysis\CommodityWiseReturns\dealers_ghee.dta", keepusing(CommodityCode CommodityDescription GheeDummy CommodityTaxRate)
keep if _merge==3

save "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee.dta"

/*Aggregate analysis time wise, not at the dealer level*/
{
keep if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"
tab TaxPeriod

gen year=0
replace year=1 if TaxPeriod=="Annual-2010"
replace year=2 if TaxPeriod=="Annual-2011"
replace year=3 if TaxPeriod=="Annual-2012"

save "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee_annual.dta"

//We create a table for half yearly return filings
use "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee.dta"
keep if TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="First Halfyear-2010"

gen halfyear=0
replace halfyear=1 if TaxPeriod=="First Halfyear-2010"
replace halfyear=2 if TaxPeriod=="Second Halfyear-2010"
replace halfyear=3 if TaxPeriod=="First Halfyear-2011"
replace halfyear=4 if TaxPeriod=="Second Halfyear-2011"
replace halfyear=5 if TaxPeriod=="First Halfyear-2012"
replace halfyear=6 if TaxPeriod=="Second Halfyear-2012"

gen year=0
replace year=1 if TaxPeriod=="First Halfyear-2010"|TaxPeriod=="Second Halfyear-2010"
replace year=2 if TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"
replace year=3 if TaxPeriod=="First Halfyear-2012"|TaxPeriod=="Second Halfyear-2012"

save "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee_halfyearly.dta"

//We create a table for quarterly return filings
use "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee.dta", clear
keep if TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Third Quarter-2012"|TaxPeriod=="Third Quarter-2014"|TaxPeriod=="Third Quarter-2013"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="First Quarter-2012"|TaxPeriod=="First Quarter-2014"|TaxPeriod=="First Quarter-2013"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Second Quarter-2014"|TaxPeriod=="Second Quarter-2013"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"|TaxPeriod=="Fourth Quarter-2012"|TaxPeriod=="Fourth Quarter-2014"|TaxPeriod=="Fourth Quarter-2013"
tab TaxPeriod

gen quarter=0
replace quarter=1 if TaxPeriod=="First Quarter-2010"
replace quarter=2 if TaxPeriod=="Second Quarter-2010"
replace quarter=3 if TaxPeriod=="Third Quarter-2010"
replace quarter=4 if TaxPeriod=="Fourth Quarter-2010"
replace quarter=5 if TaxPeriod=="First Quarter-2011"
replace quarter=6 if TaxPeriod=="Second Quarter-2011"
replace quarter=7 if TaxPeriod=="Third Quarter-2011"
replace quarter=8 if TaxPeriod=="Fourth Quarter-2011"
replace quarter=9 if TaxPeriod=="First Quarter-2012"
replace quarter=10 if TaxPeriod=="Second Quarter-2012"
replace quarter=11 if TaxPeriod=="Third Quarter-2012"
replace quarter=12 if TaxPeriod=="Fourth Quarter-2012"
replace quarter=13 if TaxPeriod=="First Quarter-2013"
replace quarter=14 if TaxPeriod=="Second Quarter-2013"
replace quarter=15 if TaxPeriod=="Third Quarter-2013"
replace quarter=16 if TaxPeriod=="Fourth Quarter-2013"
replace quarter=17 if TaxPeriod=="First Quarter-2014"
replace quarter=18 if TaxPeriod=="Second Quarter-2014"
replace quarter=19 if TaxPeriod=="Third Quarter-2014"
replace quarter=20 if TaxPeriod=="Fourth Quarter-2014"

gen year=0
replace year=1 if quarter<=4
replace year=2 if quarter>4&quarter<=8
replace year=3 if quarter>8&quarter<=12
replace year=4 if quarter>12&quarter<=16
replace year=5 if quarter>16&quarter<=20

save "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee_quarterly.dta"


//We create a table for monthly return filings
use "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee.dta", clear
drop if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"
drop if TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Third Quarter-2012"|TaxPeriod=="Third Quarter-2014"|TaxPeriod=="Third Quarter-2013"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="First Quarter-2012"|TaxPeriod=="First Quarter-2014"|TaxPeriod=="First Quarter-2013"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Second Quarter-2014"|TaxPeriod=="Second Quarter-2013"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"|TaxPeriod=="Fourth Quarter-2012"|TaxPeriod=="Fourth Quarter-2014"|TaxPeriod=="Fourth Quarter-2013"
drop if TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="First Halfyear-2010"

gen month=0
replace month=1 if TaxPeriod=="Apr-2010"
replace month=2 if TaxPeriod=="May-2010"
replace month=3 if TaxPeriod=="Jun-2010"
replace month=4 if TaxPeriod=="Jul-2010"
replace month=5 if TaxPeriod=="Aug-2010"
replace month=6 if TaxPeriod=="Sep-2010"
replace month=7 if TaxPeriod=="Oct-2010"
replace month=8 if TaxPeriod=="Nov-2010"
replace month=9 if TaxPeriod=="Dec-2010"
replace month=10 if TaxPeriod=="Jan-2011"
replace month=11 if TaxPeriod=="Feb-2011"
replace month=12 if TaxPeriod=="Mar-2011"
replace month=13 if TaxPeriod=="Apr-2011"
replace month=14 if TaxPeriod=="May-2011"
replace month=15 if TaxPeriod=="Jun-2011"
replace month=16 if TaxPeriod=="Jul-2011"
replace month=17 if TaxPeriod=="Aug-2011"
replace month=18 if TaxPeriod=="Sep-2011"
replace month=19 if TaxPeriod=="Oct-2011"
replace month=20 if TaxPeriod=="Nov-2011"
replace month=21 if TaxPeriod=="Dec-2011"
replace month=22 if TaxPeriod=="Jan-2012"
replace month=23 if TaxPeriod=="Feb-2012"
replace month=24 if TaxPeriod=="Mar-2012"
replace month=25 if TaxPeriod=="Apr-2012"
replace month=26 if TaxPeriod=="May-2012"
replace month=27 if TaxPeriod=="Jun-2012"
replace month=28 if TaxPeriod=="Jul-2012"
replace month=29 if TaxPeriod=="Aug-2012"
replace month=30 if TaxPeriod=="Sep-2012"
replace month=31 if TaxPeriod=="Oct-2012"
replace month=32 if TaxPeriod=="Nov-2012"
replace month=33 if TaxPeriod=="Dec-2012"
replace month=34 if TaxPeriod=="Jan-2013"
replace month=35 if TaxPeriod=="Feb-2013"
replace month=36 if TaxPeriod=="Mar-2013"
replace month=37 if TaxPeriod=="Apr-2013"
replace month=38 if TaxPeriod=="May-2013"

gen year=0
replace year=1 if month<=12
replace year=2 if month>12&month<=24
replace year=3 if month>24&month<=36
replace year=4 if month>36

gen quarter=0
replace quarter=1 if month<=3
replace quarter=2 if month>3&month<=6
replace quarter=3 if month>6&month<=9
replace quarter=4 if month>9&month<=12
replace quarter=5 if month>12&month<=15
replace quarter=6 if month>15&month<=18
replace quarter=7 if month>18&month<=21
replace quarter=8 if month>21&month<=24
replace quarter=9 if month>24&month<=27
replace quarter=10 if month>27&month<=30
replace quarter=11 if month>30&month<=33
replace quarter=12 if month>33&month<=36
replace quarter=13 if month>36&month<=39

save "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee_monthly.dta"

//Now we do aggregations

//First at the annual level
use "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee_annual.dta", clear
collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Annual Returns"
gen CommodityCode="110000"
save "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_annual_v4_100507_ghee.dta"

//THen we use the semi-annual returns
use "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee_halfyearly.dta", clear
collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Half Yearly Returns"
gen CommodityCode="110000"
append using "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_annual_v4_100507_ghee.dta"
save "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_annual_v4_100507_ghee.dta", replace

//Then we use the quarterly returns
//Now we will aggregate both at the quarterly and the annual level
use "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee_quarterly.dta", clear

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Quarterly Returns"
gen CommodityCode="110000"
append using "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_annual_v4_100507_ghee.dta"
save "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_annual_v4_100507_ghee.dta", replace

//Now we do the quarterly collapse
collapse (sum)RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter) fast
gen SourceFile="Quarterly Returns"
gen CommodityCode="110000"
save "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_quarter_v4_100507_ghee.dta"


//Finally we use the monthly returns
use "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee_monthly.dta", clear

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Monthly Returns"
gen CommodityCode="110000"
append using "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_annual_v4_100507_ghee.dta"
save "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_annual_v4_100507_ghee.dta", replace

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter) fast
gen SourceFile="Monthly Returns"
gen CommodityCode="110000"
append using "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_quarter_v4_100507_ghee.dta"
save "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_quarter_v4_100507_ghee.dta", replace

//Now we add all the returns at the annual level
use "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_annual_v4_100507_ghee.dta", clear
collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year CommodityCode) fast
save "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_annual_v4_100507_ghee_final.dta"

//Now we add all the returns at the Quarterly level
use "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_quarter_v4_100507_ghee.dta", clear
collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter CommodityCode) fast
save "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_quarter_v4_100507_ghee_final.dta", replace



//Looking at quarter wise graphs
twoway (connected TurnoverGross quarter, yaxis(2)) (connected TurnoverLocal quarter, yaxis(2)) (connected TurnoverCentral quarter, yaxis(2)) (connected AggregateAmountPaid quarter), xline(13, lcolor(green) extend)
twoway (connected RefundClaimed quarter) (connected NetTax quarter) (connected TurnoverLocal quarter, yaxis(2)) (connected AggregateAmountPaid quarter), xline(11, lcolor(green) extend)


//Looking at year wise graphs
twoway (connected TurnoverGross year, yaxis(2)) (connected TurnoverLocal year, yaxis(2)) (connected TurnoverCentral year, yaxis(2)) (connected AggregateAmountPaid year), xline(3, lcolor(green) extend)
twoway (connected RefundClaimed year) (connected NetTax year) (connected TurnoverLocal year, yaxis(2)) (connected AggregateAmountPaid year), xline(3, lcolor(green) extend)

twoway (connected TurnoverGross year, yaxis(2)) (connected AggregateAmountPaid year), xline(3, lcolor(green) extend)
twoway (connected TurnoverGross year, yaxis(2)) (connected AmountDepositedByDealer year), xline(3, lcolor(green) extend)

twoway (connected TurnoverGross year, yaxis(2)) (connected TurnoverLocal year, yaxis(2)) (connected TurnoverCentral year, yaxis(2)) (connected MoneyDeposited year), xline(3, lcolor(green) extend)



twoway (connected TurnoverLocal year, yaxis(2)) (connected MoneyDeposited year), xline(3, lcolor(green) extend)
twoway (connected lTurnoverGross year, yaxis(2)) (connected lMoneyDeposited year), xline(3, lcolor(green) extend)

gen MoneyDeposited=AggregateAmountPaid if AggregateAmountPaid>AmountDepositedByDealer
replace MoneyDeposited=AmountDepositedByDealer  if AggregateAmountPaid<=AmountDepositedByDealer

gen lMoneyDeposited=log(MoneyDeposited)
gen lTurnoverGross=log(TurnoverGross)
gen lTurnoverCentral=log(TurnoverCentral)
gen lTurnoverLocal=log(TurnoverLocal)


twoway (connected lTurnoverGross year, yaxis(2)) (connected lTurnoverLocal year, yaxis(2)) (connected lTurnoverCentral year, yaxis(2)) (connected lMoneyDeposited year), xline(3, lcolor(green) extend)

gen year=0
replace year=1 if quarter<=4
replace year=2 if quarter>4&quarter<=8
replace year=3 if quarter>8&quarter<=12
replace year=4 if quarter>12&quarter<=16
replace year=5 if quarter>16&quarter<=20

label define year 1 "2010-11" 2 "2011-12" 3 "2012-13" 4 "2013-14" 5 "2014-15" 6 "2015-16"
label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"


label values quarter quarter 
label values year year

}





/*Aggregate analysis at the dealer level*/
{
use "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyghee.dta", clear

gen TaxYear=0
replace TaxYear=1 if TaxPeriod=="Annual-2010"
replace TaxYear=2 if TaxPeriod=="Annual-2011"
replace TaxYear=3 if TaxPeriod=="Annual-2012"

gen TaxHalfyear=0
replace TaxHalfyear=1 if TaxPeriod=="First Halfyear-2010"
replace TaxHalfyear=2 if TaxPeriod=="Second Halfyear-2010"
replace TaxHalfyear=3 if TaxPeriod=="First Halfyear-2011"
replace TaxHalfyear=4 if TaxPeriod=="Second Halfyear-2011"
replace TaxHalfyear=5 if TaxPeriod=="First Halfyear-2012"
replace TaxHalfyear=6 if TaxPeriod=="Second Halfyear-2012"

replace TaxYear=1 if TaxPeriod=="First Halfyear-2010"|TaxPeriod=="Second Halfyear-2010"
replace TaxYear=2 if TaxPeriod=="First Halfyear-2011"|TaxPeriod=="Second Halfyear-2011"
replace TaxYear=3 if TaxPeriod=="First Halfyear-2012"|TaxPeriod=="Second Halfyear-2012"


gen TaxQuarter=0
replace TaxQuarter=1 if TaxPeriod=="First Quarter-2010"
replace TaxQuarter=2 if TaxPeriod=="Second Quarter-2010"
replace TaxQuarter=3 if TaxPeriod=="Third Quarter-2010"
replace TaxQuarter=4 if TaxPeriod=="Fourth Quarter-2010"
replace TaxQuarter=5 if TaxPeriod=="First Quarter-2011"
replace TaxQuarter=6 if TaxPeriod=="Second Quarter-2011"
replace TaxQuarter=7 if TaxPeriod=="Third Quarter-2011"
replace TaxQuarter=8 if TaxPeriod=="Fourth Quarter-2011"
replace TaxQuarter=9 if TaxPeriod=="First Quarter-2012"
replace TaxQuarter=10 if TaxPeriod=="Second Quarter-2012"
replace TaxQuarter=11 if TaxPeriod=="Third Quarter-2012"
replace TaxQuarter=12 if TaxPeriod=="Fourth Quarter-2012"
replace TaxQuarter=13 if TaxPeriod=="First Quarter-2013"
replace TaxQuarter=14 if TaxPeriod=="Second Quarter-2013"
replace TaxQuarter=15 if TaxPeriod=="Third Quarter-2013"
replace TaxQuarter=16 if TaxPeriod=="Fourth Quarter-2013"
replace TaxQuarter=17 if TaxPeriod=="First Quarter-2014"
replace TaxQuarter=18 if TaxPeriod=="Second Quarter-2014"
replace TaxQuarter=19 if TaxPeriod=="Third Quarter-2014"
replace TaxQuarter=20 if TaxPeriod=="Fourth Quarter-2014"


replace TaxYear=1 if TaxQuarter>0&TaxQuarter<=4
replace TaxYear=2 if TaxQuarter>4&TaxQuarter<=8
replace TaxYear=3 if TaxQuarter>8&TaxQuarter<=12
replace TaxYear=4 if TaxQuarter>12&TaxQuarter<=16
replace TaxYear=5 if TaxQuarter>16&TaxQuarter<=20

gen TaxMonth=0
replace TaxMonth=1 if TaxPeriod=="Apr-2010"
replace TaxMonth=2 if TaxPeriod=="May-2010"
replace TaxMonth=3 if TaxPeriod=="Jun-2010"
replace TaxMonth=4 if TaxPeriod=="Jul-2010"
replace TaxMonth=5 if TaxPeriod=="Aug-2010"
replace TaxMonth=6 if TaxPeriod=="Sep-2010"
replace TaxMonth=7 if TaxPeriod=="Oct-2010"
replace TaxMonth=8 if TaxPeriod=="Nov-2010"
replace TaxMonth=9 if TaxPeriod=="Dec-2010"
replace TaxMonth=10 if TaxPeriod=="Jan-2011"
replace TaxMonth=11 if TaxPeriod=="Feb-2011"
replace TaxMonth=12 if TaxPeriod=="Mar-2011"
replace TaxMonth=13 if TaxPeriod=="Apr-2011"
replace TaxMonth=14 if TaxPeriod=="May-2011"
replace TaxMonth=15 if TaxPeriod=="Jun-2011"
replace TaxMonth=16 if TaxPeriod=="Jul-2011"
replace TaxMonth=17 if TaxPeriod=="Aug-2011"
replace TaxMonth=18 if TaxPeriod=="Sep-2011"
replace TaxMonth=19 if TaxPeriod=="Oct-2011"
replace TaxMonth=20 if TaxPeriod=="Nov-2011"
replace TaxMonth=21 if TaxPeriod=="Dec-2011"
replace TaxMonth=22 if TaxPeriod=="Jan-2012"
replace TaxMonth=23 if TaxPeriod=="Feb-2012"
replace TaxMonth=24 if TaxPeriod=="Mar-2012"
replace TaxMonth=25 if TaxPeriod=="Apr-2012"
replace TaxMonth=26 if TaxPeriod=="May-2012"
replace TaxMonth=27 if TaxPeriod=="Jun-2012"
replace TaxMonth=28 if TaxPeriod=="Jul-2012"
replace TaxMonth=29 if TaxPeriod=="Aug-2012"
replace TaxMonth=30 if TaxPeriod=="Sep-2012"
replace TaxMonth=31 if TaxPeriod=="Oct-2012"
replace TaxMonth=32 if TaxPeriod=="Nov-2012"
replace TaxMonth=33 if TaxPeriod=="Dec-2012"
replace TaxMonth=34 if TaxPeriod=="Jan-2013"
replace TaxMonth=35 if TaxPeriod=="Feb-2013"
replace TaxMonth=36 if TaxPeriod=="Mar-2013"
replace TaxMonth=37 if TaxPeriod=="Apr-2013"
replace TaxMonth=38 if TaxPeriod=="May-2013"


replace TaxYear=1 if TaxMonth>0&TaxMonth<=12
replace TaxYear=2 if TaxMonth>12&TaxMonth<=24
replace TaxYear=3 if TaxMonth>24&TaxMonth<=36
replace TaxYear=4 if TaxMonth>36

replace TaxQuarter=1 if TaxMonth>0&TaxMonth<=3
replace TaxQuarter=2 if TaxMonth>3&TaxMonth<=6
replace TaxQuarter=3 if TaxMonth>6&TaxMonth<=9
replace TaxQuarter=4 if TaxMonth>9&TaxMonth<=12
replace TaxQuarter=5 if TaxMonth>12&TaxMonth<=15
replace TaxQuarter=6 if TaxMonth>15&TaxMonth<=18
replace TaxQuarter=7 if TaxMonth>18&TaxMonth<=21
replace TaxQuarter=8 if TaxMonth>21&TaxMonth<=24
replace TaxQuarter=9 if TaxMonth>24&TaxMonth<=27
replace TaxQuarter=10 if TaxMonth>27&TaxMonth<=30
replace TaxQuarter=11 if TaxMonth>30&TaxMonth<=33
replace TaxQuarter=12 if TaxMonth>33&TaxMonth<=36
replace TaxQuarter=13 if TaxMonth>36&TaxMonth<=39

label define year 1 "2010-11" 2 "2011-12" 3 "2012-13" 4 "2013-14" 5 "2014-15" 6 "2015-16"
label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"

label values TaxQuarter quarter
label values TaxYear year	

gsort DealerTIN TaxYear TaxHalfyear TaxQuarter TaxMonth

*gen MoneyDeposited=AggregateAmountPaid if AggregateAmountPaid>=AmountDepositedByDealer
*replace MoneyDeposited=AmountDepositedByDealer if AggregateAmountPaid<AmountDepositedByDealer

gen MoneyDeposited=max(AggregateAmountPaid, AmountDepositedByDealer)

collapse (sum) TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 InterStateSaleCD InterStatePurchaseCD TotalInterStateSale TotalInterStatePurchase CSTAdjustmentVAT AdjustCSTLiability MoneyDeposited AggregateAmountPaid TurnoverGross TurnoverCentral TurnoverLocal AmountDepositedByDealer TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit, by(DealerTIN TaxYear)

egen idDealer = group(DealerTIN)

twoway (scatter MoneyDeposited TurnoverGross if TaxYear==1) (scatter MoneyDeposited TurnoverGross if TaxYear==2) (scatter MoneyDeposited TurnoverGross if TaxYear==3) (scatter MoneyDeposited TurnoverGross if TaxYear==4) (scatter MoneyDeposited TurnoverGross if TaxYear==5, msymbol(triangle))
	 twoway (connected MoneyDeposited TaxYear) (connected AdjustCSTLiability TaxYear, yaxis(2)) (connected CSTAdjustmentVAT TaxYear, yaxis(2)) if idDealer==24, title("idDealer 24")

br TaxYear idDealer MoneyDeposited OutputTaxAt5 TurnoverAt5 OutputTaxAt125 TurnoverAt125 TurnoverGross TurnoverCentral TurnoverLocal CreditGoodsAt5 PurchaseGoodsAt5 CreditGoodsAt125  PurchaseGoodsAt125 if idDealer==86
	 
forvalues num = 1(1)363 {
     twoway (connected MoneyDeposited TaxYear) (connected TurnoverGross TaxYear, yaxis(2)) (connected TurnoverLocal TaxYear, yaxis(2)) (connected TurnoverCentral TaxYear, yaxis(2)) if idDealer==`num', title("idDealer `num'")
     graph export "PreliminaryAnalysis\CommodityWiseReturns\ghee\ghee_all turnovers_amount paid_annual_id`num'.pdf", as(pdf) replace 
	 twoway (connected MoneyDeposited TaxYear) (connected TotalOutputTax TaxYear, yaxis(2)) (connected TotalTaxCredit TaxYear, yaxis(2)) (connected PurchaseUnregisteredDealer TaxYear) if idDealer==`num', title("idDealer `num'")
     graph export "PreliminaryAnalysis\CommodityWiseReturns\ghee\ghee_credits and purchases_annual_id`num'.pdf", as(pdf) replace 
	 twoway (connected MoneyDeposited TaxYear) (connected AdjustCSTLiability TaxYear, yaxis(2)) (connected CSTAdjustmentVAT TaxYear, yaxis(2)) if idDealer==`num', title("idDealer `num'")
  
	 

	 
        }



gen dummy=1
by DealerTIN: egen YearCount=sum(dummy)
tab YearCount
keep if YearCount==5


}


/* Playing test commands*/
histogram TurnoverGross if GheeDummy==1&TaxPeriod=="Third Quarter-2014"
histogram TurnoverGross if GheeDummy==1&TaxPeriod=="Third Quarter-2014", bin(10000)
histogram TurnoverGross if GheeDummy==1&TaxPeriod=="Third Quarter-2014", width(100000) fraction
twoway (scatter AggregateAmountPaid TurnoverGross if GheeDummy==1&TaxPeriod=="Third Quarter-2014")
twoway (scatter AggregateAmountPaid TurnoverGross if GheeDummy==1&TaxPeriod=="Third Quarter-2014"&TurnoverGross<200000000)
twoway (scatter AggregateAmountPaid TurnoverGross if GheeDummy==1&TaxPeriod=="Third Quarter-2014"&TurnoverGross<100000000)
sum TurnoverGross if GheeDummy==1&TaxPeriod=="Third Quarter-2014"&TurnoverGross<100000000, detail
twoway (scatter AggregateAmountPaid TurnoverGross if GheeDummy==1&TaxPeriod=="Third Quarter-2014"&TurnoverGross<40000000)
twoway (scatter AggregateAmountPaid TurnoverGross if GheeDummy==1&TaxPeriod=="Third Quarter-2014"&TurnoverGross<10000000)
twoway (scatter AmountDepositedByDealer TurnoverGross if GheeDummy==1&TaxPeriod=="Third Quarter-2014"&TurnoverGross<10000000)
sum AmountDepositedByDealer  if GheeDummy==1&TaxPeriod=="Third Quarter-2014"&TurnoverGross<100000000, detail
sum AggregateAmountPaid if GheeDummy==1&TaxPeriod=="Third Quarter-2014"&TurnoverGross<100000000, detail
br RefundClaimedBoolean DealerTIN TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax TotalTaxCredit AggregateAmountPaid InterStateSaleCD InterStatePurchaseCD InterStatePurchaseOther InterStateSaleOther TotalInterStateSale TotalInterStatePurchase
sum AggregateAmountPaid if GheeDummy==1&TaxPeriod=="Third Quarter-2014"&TurnoverGross<100000000&&TurnoverGross>0, detail
sum AggregateAmountPaid if GheeDummy==1&TaxPeriod=="Third Quarter-2014"&TurnoverGross<100000000&TurnoverGross>0, detail
