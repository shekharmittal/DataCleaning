cd "D:\data"

use "TableCommodityCode.dta", clear
drop if id==""
gsort  id DealerTIN

keep if CommodityCode=="405000"|CommodityCode=="111000"|CommodityCode=="813003"|CommodityCode=="324002"|CommodityCode=="505000"|CommodityCode=="311000"|CommodityCode=="802000"|CommodityCode=="507000"|CommodityCode=="507506"|CommodityCode=="507000"|CommodityCode=="324000"|CommodityCode=="501000"|CommodityCode=="124000"|CommodityCode=="324001"|CommodityCode=="325000"|CommodityCode=="813000"|CommodityCode=="123000"|CommodityCode=="90206"|CommodityCode=="502000"|CommodityCode=="110000"|CommodityCode=="112000"|CommodityCode=="406000"|CommodityCode=="125000"|CommodityCode=="323001"|CommodityCode=="109000"
save "PreliminaryAnalysis\CommodityWiseReturns\TableCommodityCodes_uniqueidtin_somecommodites.dta"

use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
merge 1:1 id DealerTIN using "PreliminaryAnalysis\CommodityWiseReturns\TableCommodityCodes_uniqueidtin_somecommodites.dta", keepusing(CommodityCode CommodityDescription CommodityPercentageContribution)
keep if _merge==3

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

gen CommodityCode1 = regexs(0) if(regexm(T312149, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
gen CommodityCode2 = regexs(0) if(regexm(T312150, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
gen CommodityCode3 = regexs(0) if(regexm(T312151, "[0-9][0-9][0-9][0-9][0-9][0-9]"))

keep if CommodityCode1=="405000"|CommodityCode1=="111000"|CommodityCode1=="813003"|CommodityCode1=="324002"|CommodityCode1=="505000"|CommodityCode1=="311000"|CommodityCode1=="802000"|CommodityCode1=="507000"|CommodityCode1=="507506"|CommodityCode1=="507000"|CommodityCode1=="324000"|CommodityCode1=="501000"|CommodityCode1=="124000"|CommodityCode1=="324001"|CommodityCode1=="325000"|CommodityCode1=="813000"|CommodityCode1=="123000"|CommodityCode1=="90206"|CommodityCode1=="502000"|CommodityCode1=="110000"|CommodityCode1=="112000"|CommodityCode1=="406000"|CommodityCode1=="125000"|CommodityCode1=="323001"|CommodityCode1=="109000"|CommodityCode2=="405000"|CommodityCode2=="111000"|CommodityCode2=="813003"|CommodityCode2=="324002"|CommodityCode2=="505000"|CommodityCode2=="311000"|CommodityCode2=="802000"|CommodityCode2=="507000"|CommodityCode2=="507506"|CommodityCode2=="507000"|CommodityCode2=="324000"|CommodityCode2=="501000"|CommodityCode2=="124000"|CommodityCode2=="324001"|CommodityCode2=="325000"|CommodityCode2=="813000"|CommodityCode2=="123000"|CommodityCode2=="90206"|CommodityCode2=="502000"|CommodityCode2=="110000"|CommodityCode2=="112000"|CommodityCode2=="406000"|CommodityCode2=="125000"|CommodityCode2=="323001"|CommodityCode2=="109000"|CommodityCode3=="405000"|CommodityCode3=="111000"|CommodityCode3=="813003"|CommodityCode3=="324002"|CommodityCode3=="505000"|CommodityCode3=="311000"|CommodityCode3=="802000"|CommodityCode3=="507000"|CommodityCode3=="507506"|CommodityCode3=="507000"|CommodityCode3=="324000"|CommodityCode3=="501000"|CommodityCode3=="124000"|CommodityCode3=="324001"|CommodityCode3=="325000"|CommodityCode3=="813000"|CommodityCode3=="123000"|CommodityCode3=="90206"|CommodityCode3=="502000"|CommodityCode3=="110000"|CommodityCode3=="112000"|CommodityCode3=="406000"|CommodityCode3=="125000"|CommodityCode3=="323001"|CommodityCode3=="109000"

keep if CommodityCode1=="110000"|CommodityCode2=="110000"|CommodityCode3=="110000"
save "PreliminaryAnalysis\CommodityWiseReturns\ghee\form16_data_v3_0901_onlyghee_internal.dta"

keep if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"
tab TaxPeriod

gen year=0
replace year=1 if TaxPeriod=="Annual-2010"
replace year=2 if TaxPeriod=="Annual-2011"
replace year=3 if TaxPeriod=="Annual-2012"

save "PreliminaryAnalysis\CommodityWiseReturns\ghee\form16_data_v3_0901_onlyghee_internal_annual.dta"
//We create a table for half yearly return filings
use "PreliminaryAnalysis\CommodityWiseReturns\ghee\form16_data_v3_0901_onlyghee_internal.dta", clear
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

save "PreliminaryAnalysis\CommodityWiseReturns\ghee\form16_data_v3_0901_onlyghee_internal_halfyearly.dta"

//We create a table for quarterly return filings
use "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v3_0901_onlyghee_internal.dta", clear
keep if TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Third Quarter-2012"|TaxPeriod=="Third Quarter-2014"|TaxPeriod=="Third Quarter-2013"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="First Quarter-2012"|TaxPeriod=="First Quarter-2014"|TaxPeriod=="First Quarter-2013"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Second Quarter-2014"|TaxPeriod=="Second Quarter-2013"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"|TaxPeriod=="Fourth Quarter-2012"|TaxPeriod=="Fourth Quarter-2014"|TaxPeriod=="Fourth Quarter-2013"

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

save "PreliminaryAnalysis\CommodityWiseReturns\ghee\form16_data_v3_0901_onlyghee_internal_quarterly.dta"


//We create a table for monthly return filings
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
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
replace quarter=14 if month>39&month<=42
replace quarter=15 if month>42&month<=45
replace quarter=16 if month>45&month<=48
replace quarter=17 if month>48&month<=51
replace quarter=18 if month>51&month<=54
replace quarter=19 if month>54&month<=57
replace quarter=20 if month>57&month<=60


save "PreliminaryAnalysis\CommodityWiseReturns\ghee\form16_data_v3_0901_onlyghee_internal_monthly.dta", replace


use "PreliminaryAnalysis\CommodityWiseReturns\ghee\form16_data_v3_0901_quarterly filings_commodities included.dta", clear
collapse (mean) CommodityCode year (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter CommodityDescription) fast
save "PreliminaryAnalysis\CommodityWiseReturns\ghee\form16_aggregate_quarter_final_laterhalf_commoditywise.dta"
