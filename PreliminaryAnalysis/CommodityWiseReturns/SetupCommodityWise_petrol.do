cd "D:\data"

use "TableCommodityCode.dta", clear
drop if id==""
gsort  id DealerTIN CommodityCode
br id DealerTIN CommodityCode
duplicates drop id DealerTIN CommodityCode, force

save "PreliminaryAnalysis\CommodityWiseReturns\TableCommodityCodes_unique_v2_0930.dta"

keep if CommodityCode=="405000"

merge 1:1 id DealerTIN using "PreliminaryAnalysis\returns\form16_data_v3_0901.dta"

/*I first identify dealers who traded in ghee at some point of time*/
use "D:\data\PreliminaryAnalysis\CommodityWiseReturns\TableCommodityCodes_unique_v2_0930.dta", clear
keep if CommodityCode=="405000"|CommodityCode=="404000"
gsort DealerTIN id
by DealerTIN:gen ReturnCount=_n
tab ReturnCount
keep if ReturnCount==1
gen PetrolDummy=1
save "PreliminaryAnalysis\CommodityWiseReturns\dealers_petrol.dta"


/* Then I will do analysis only on those dealers which traded in ghee*/
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
merge m:1 DealerTIN using "PreliminaryAnalysis\CommodityWiseReturns\dealers_petrol.dta", keepusing(CommodityCode CommodityDescription PetrolDummy CommodityTaxRate)
keep if _merge==3

save "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyperol.dta"

/*Aggregate analysis time wise, not at the dealer level*/
{
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

preserve
//Now we do aggregations
//First at the annual level
collapse (sum) MoneyDeposited RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(TaxYear) fast
gen CommodityCode="405000"
save "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_annual_v4_1009_petrol_final.dta"

merge 1:m TaxYear using "D:\data\PreliminaryAnalysis\CommodityWiseReturns\petrol\petrol_prices_dollars.dta", keepusing(YearlyPrice)
save "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_annual_v4_1009_petrol_final.dta"

restore
preserve
//Then we use the quarterly returns
//Now we do the quarterly collapse
collapse (sum) MoneyDeposited RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(TaxQuarter) fast
gen CommodityCode="405000"
save "PreliminaryAnalysis\CommodityWiseReturns\form16_aggregate_quarterly_v4_1009_petrol_final.dta", replace

restore

drop _merge
merge 1:1 TaxQuarter using "D:\data\PreliminaryAnalysis\CommodityWiseReturns\petrol\petrol_prices_dollars.dta", keepusing(QuarterlyPrice)

//Looking at quarter wise graphs
twoway (connected TurnoverGross TaxQuarter, yaxis(2)) (connected TurnoverLocal TaxQuarter, yaxis(2)) (connected TurnoverCentral TaxQuarter, yaxis(2)) (connected MoneyDeposited TaxQuarter), xline(9 10 12) note("9 - 2A2B begins, 10 - petrol price cap, 12 - petrol price cap ends, first point taxation begins")
twoway (connected RefundClaimed quarter) (connected NetTax quarter) (connected TurnoverLocal quarter, yaxis(2)) (connected AggregateAmountPaid quarter), xline(11, lcolor(green) extend)


//Looking at year wise graphs
twoway (connected TurnoverGross TaxYear, yaxis(2)) (connected TurnoverLocal TaxYear, yaxis(2)) (connected TurnoverCentral TaxYear, yaxis(2)) (connected MoneyDeposited TaxYear)
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
use "PreliminaryAnalysis\CommodityWiseReturns\form16_data_v4_1005_onlyperol.dta", clear

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

collapse (sum) TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 InterStateSaleCD InterStatePurchaseCD TotalInterStateSale TotalInterStatePurchase CSTAdjustmentVAT AdjustCSTLiability MoneyDeposited AggregateAmountPaid TurnoverGross TurnoverCentral TurnoverLocal AmountDepositedByDealer TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit, by(DealerTIN TaxQuarter)
merge m:1 TaxQuarter using "D:\data\PreliminaryAnalysis\CommodityWiseReturns\petrol\petrol_prices_dollars.dta", keepusing(QuarterlyPrice)


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
