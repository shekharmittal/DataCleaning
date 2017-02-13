// First we identify dealers which trader in ghee for time before 2013 (in the returns file itself)

cd "D:\data\"

use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear

gen CommodityCode1 = regexs(0) if(regexm(T312149, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
gen CommodityCode2 = regexs(0) if(regexm(T312150, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
gen CommodityCode3 = regexs(0) if(regexm(T312151, "[0-9][0-9][0-9][0-9][0-9][0-9]"))

keep if CommodityCode1=="405000"|CommodityCode2=="405000"|CommodityCode3=="405000"
save "PreliminaryAnalysis\commodity wise returns\form16_data_v3_0901_onlypetrol_internal.dta"

keep if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"
tab TaxPeriod

gen year=0
replace year=1 if TaxPeriod=="Annual-2010"
replace year=2 if TaxPeriod=="Annual-2011"
replace year=3 if TaxPeriod=="Annual-2012"

label define year 1 "2010-11" 2 "2011-12" 3 "2012-13" 4 "2013-14" 5 "2014-15" 6 "2015-16"
label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"
label values quarter quarter
label values year year

save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_data_v3_0901_onlypetrol_internal_annual.dta"
//We create a table for half yearly return filings
use "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_data_v3_0901_onlypetrol_internal.dta", clear
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

label define year 1 "2010-11" 2 "2011-12" 3 "2012-13" 4 "2013-14" 5 "2014-15" 6 "2015-16"
label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"
label values quarter quarter
label values year year

save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_data_v3_0901_onlypetrol_internal_halfyearly.dta"

//We create a table for quarterly return filings
use "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_data_v3_0901_onlypetrol_internal.dta", clear
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

label define year 1 "2010-11" 2 "2011-12" 3 "2012-13" 4 "2013-14" 5 "2014-15" 6 "2015-16"
label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"
label values quarter quarter
label values year year

save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_data_v3_0901_onlypetrol_internal_quarterly.dta"


//We create a table for monthly return filings
use "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_data_v3_0901_onlypetrol_internal.dta", clear
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

label define year 1 "2010-11" 2 "2011-12" 3 "2012-13" 4 "2013-14" 5 "2014-15" 6 "2015-16"
label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"
label values quarter quarter
label values year year

save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_data_v3_0901_onlypetrol_internal_monthly.dta", replace

//Now we do aggregations

//First at the annual level
use "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_data_v3_0901_onlypetrol_internal_annual.dta", clear
collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Annual Returns"
gen CommodityCode="405000"
save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_annual_v3_0907_petrol.dta"

//THen we use the semi-annual returns
use "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_data_v3_0901_onlypetrol_internal_halfyearly.dta", clear
collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Half Yearly Returns"
gen CommodityCode="405000"
append using "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_annual_v3_0907_petrol.dta"
save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_annual_v3_0907_petrol.dta", replace

//Then we use the quarterly returns
//Now we will aggregate both at the quarterly and the annual level
use "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_data_v3_0901_onlypetrol_internal_quarterly.dta", clear

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Quarterly Returns"
gen CommodityCode="405000"
append using "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_annual_v3_0907_petrol.dta"
save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_annual_v3_0907_petrol.dta", replace

//Now we do the quarterly collapse
collapse (sum)RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter) fast
gen SourceFile="Quarterly Returns"
gen CommodityCode="405000"
save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_quarter_v3_0907_petrol.dta"


//Finally we use the monthly returns
use "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_data_v3_0901_onlypetrol_internal_monthly.dta", clear

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Monthly Returns"
gen CommodityCode="405000"
append using "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_annual_v3_0907_petrol.dta"
save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_annual_v3_0907_petrol.dta", replace

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter) fast
gen SourceFile="Monthly Returns"
gen CommodityCode="405000"
append using "D:\data\preliminary analysis\commodity wise returns\form16_aggregate_quarter_v3_0907_petrol.dta"
save "D:\data\preliminary analysis\commodity wise returns\form16_aggregate_quarter_v3_0907_petrol.dta", replace

//Now we add all the returns at the annual level
use "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_annual_v3_0907_petrol.dta", clear

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year CommodityCode) fast

save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_annual_final_0907_petrol.dta", replace

//Now we add all the returns at the Quarterly level
use "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_quarter_v3_0907_petrol.dta", clear

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter CommodityCode) fast

save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_quarter_final_0907_petrol.dta", replace

use "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_quarter_final_laterhalf_commoditywise.dta", clear
keep if CommodityCode==405000
collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter CommodityCode) fast
tostring CommodityCode, replace
append using "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_quarter_final_0907_petrol.dta"
save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_quarter_final_0907_petrol_including_laterhalf.dta", replace


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

use "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_quarter_final_0907_petrol_including_laterhalf.dta", clear

twoway (connected TurnoverGross quarter, yaxis(2)) (connected TurnoverLocal quarter, yaxis(2)) (connected TurnoverCentral quarter, yaxis(2)) (connected AggregateAmountPaid quarter),  xlabel(, labels angle(vertical) valuelabel) xmtick(, valuelabel)
twoway (connected RefundClaimed quarter) (connected NetTax quarter) (connected TurnoverLocal quarter, yaxis(2)) (connected AggregateAmountPaid quarter),  xlabel(, labels angle(vertical) valuelabel) xmtick(, valuelabel)


// Now we add all the retunrs at the annual level
use "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_quarter_final_laterhalf_commoditywise.dta", clear
keep if CommodityCode==405000
tostring CommodityCode , replace
collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year CommodityCode) fast

append using "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_annual_final_0907_petrol.dta"

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

save "PreliminaryAnalysis\CommodityWiseReturns\petrol\form16_aggregate_annual_final_0907_petrol_including laterhalf.dta"


twoway (connected TurnoverGross year, yaxis(2)) (connected TurnoverLocal year, yaxis(2)) (connected TurnoverCentral year, yaxis(2)) (connected AggregateAmountPaid year), xline(3, lcolor(green) extend)
twoway (connected RefundClaimed year) (connected NetTax year) (connected TurnoverLocal year, yaxis(2)) (connected AggregateAmountPaid year), xline(3, lcolor(green) extend)
