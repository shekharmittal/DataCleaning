/* In this file, we start from the original file and try to include all the variables that we left out.
Add more variables from v2
BalanceBroughtForward RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule 
*/
cd "D:\data"

//First we use the annual returns
use "PreliminaryAnalysis\returns\form16_data_v3_0901_annual filings.dta", clear

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Annual Returns"
save "PreliminaryAnalysis\returns\form16_aggregate_annual_v2_0902.dta", replace


//THen we use the semi-annual returns
use "PreliminaryAnalysis\returns\form16_data_v3_0901_halfyearly filings.dta", clear
collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Half Yearly Returns"
append using "PreliminaryAnalysis\returns\form16_aggregate_annual_v2_0902.dta"
save "PreliminaryAnalysis\returns\form16_aggregate_annual_v2_0902.dta", replace

//Then we use the quarterly returns
//Now we will aggregate both at the quarterly and the annual level
use "PreliminaryAnalysis\returns\form16_data_v3_0901_quarterly filings.dta", clear

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Quarterly Returns"
append using "PreliminaryAnalysis\returns\form16_aggregate_annual_v2_0902.dta"
save "PreliminaryAnalysis\returns\form16_aggregate_annual_v2_0902.dta", replace

//Now we do the quarterly collapse
collapse (sum)RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter) fast
gen SourceFile="Quarterly Returns"
save "PreliminaryAnalysis\returns\form16_aggregate_quarterly_v2_0902.dta", replace


//Finally we use the monthly returns
use "PreliminaryAnalysis\returns\form16_data_v3_0901_monthly filings.dta", clear

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast
gen SourceFile="Monthly Returns"
append using "PreliminaryAnalysis\returns\form16_aggregate_annual_v2_0902.dta"
save "PreliminaryAnalysis\returns\form16_aggregate_annual_v2_0902.dta", replace

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter) fast
gen SourceFile="Monthly Returns"
append using "PreliminaryAnalysis\returns\form16_aggregate_quarterly_v2_0902.dta"
save "PreliminaryAnalysis\returns\form16_aggregate_quarterly_v2_0902.dta", replace

//Now we add all the returns at the annual level
use "PreliminaryAnalysis\returns\form16_aggregate_annual_v2_0902.dta", replace

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(year) fast

save "PreliminaryAnalysis\returns\form16_aggregate_annual_final_v2_0902.dta", replace
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
save "PreliminaryAnalysis\returns\form16_aggregate_annual_final_v2_0902.dta", replace

//Finally a graph that looks good
twoway (line NetBalance year, sort) (line NetTax year) (line TotalOutputTax year) (line CarryForwardTaxCredit year)
twoway (line lTurnoverGross year, sort) (line lTurnoverCentral year) (connected lTurnoverLocal year) (connected lPurchaseUnregisteredDealer year, sort) (line lTotalInterStateSale year) (line lTotalInterStatePurchase year)



//Now we add all the returns at the Quarterly level
use "PreliminaryAnalysis\returns\form16_aggregate_quarterly_v2_0902.dta", replace

collapse (sum) RefundClaimed DieselSale InterStateSaleCD InterStatePurchaseCD InterStateSaleCE1E2 InterStatePurchaseCE1E2 PurchaseExemptedGoodsCST SaleExemptedGoodsCST PurchaseExemptedGoodsSchedule SaleExemptedGoodsSchedule TurnoverGross TurnoverCentral TurnoverLocal TurnoverAt1 OutputTaxAt1 TurnoverAt5 OutputTaxAt5 TurnoverAt125 OutputTaxAt125 TurnoverAt20 OutputTaxAt20 WCTurnoverAt5 WCOutputTaxAt5 WCTurnoverAt125 WCOutputTaxAt125 ExemptedSales PurchaseOtherGoods OutputTaxBeforeAdjustment AdjustmentOutputTax TotalOutputTax PurchaseCapitalGoods CreditCapitalGoods CreditGoodsAt1 PurchaseGoodsAt5 CreditGoodsAt5 PurchaseGoodsAt125 CreditGoodsAt125 PurchaseGoodsAt20 CreditGoodsAt20 WCPurchaseAt5 WCCreditAt5 WCPurchaseAt125 WCCreditAt125 CreditOtherGoods TaxCreditBeforeAdjustment AdjustmentTaxCredit TotalTaxCredit NetTax InterestPayable PenaltyPayable BalancePayable AmountDepositedByDealer AggregateAmountPaid NetBalance BalanceBroughtForward AdjustCSTLiability BalanceCarriedNextTaxPeriod InterStateExportsAgainstH InterStateImportsAgainstH InterStateExportsAgainstI InterStateImportsAgainstI InterStateExportsAgainstJ InterStateImportsAgainstJ ExportFromIndia ImportToIndia InterStateSaleOther InterStatePurchaseOther InterStateSaleCapital InterStatePurchaseCapital TotalInterStateSale TotalInterStatePurchase PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods DieselPurchase PurchaseIneligibleForITC PurchaseDelhiFormH PurchaseCapitalNonCreditGood CarryForwardTaxCredit CSTAdjustmentVAT HighSeaSale HighSeaPurchase, by(quarter) fast

save "PreliminaryAnalysis\returns\form16_aggregate_quarterly_final_v2_0902.dta", replace
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


save "PreliminaryAnalysis\returns\form16_aggregate_quarterly_final_v2_0902.dta", replace
twoway (line NetBalance quarter, sort) (line NetTax quarter) (line AggregateAmountPaid quarter) (line CarryForwardTaxCredit quarter) (line TotalOutputTax quarter) (line TotalTaxCredit quarter) (line BalancePayable quarter) (line CarryForwardTaxCredit quarter) 
twoway (line lNetBalance quarter, sort) (line lNetTax quarter) (line lAggregateAmountPaid quarter) (line lCarryForwardTaxCredit quarter) (line lTotalOutputTax quarter) (line lTotalTaxCredit quarter) (line lBalancePayable quarter) (line lCarryForwardTaxCredit quarter) (line lTotalInterStateSale quarter) (line lTotalInterStatePurchase quarter)

//Finally a graph that looks good
twoway (line NetBalance quarter, sort) (line NetTax quarter) (line TotalOutputTax quarter) (line CarryForwardTaxCredit quarter)
twoway (line lTurnoverGross quarter, sort) (line lTurnoverCentral quarter) (connected lTurnoverLocal quarter) (connected lPurchaseUnregisteredDealer quarter, sort) (line lTotalInterStateSale quarter) (line lTotalInterStatePurchase quarter)

twoway (connected PurchaseUnregisteredDealer quarter) (connected TurnoverLocal quarter, sort) (connected PurchaseOtherGoods quarter), ytitle(Purchases) ylabel(#5) xtitle(Quarter) xline(6 9, lpattern(dash) lcolor(green)) xlabel(#10, angle(vertical) valuelabel) title(Purchase from Unregistered Dealers) caption(, size(small) bexpand) note(Q2 2011: First 2A 2B notice we could find. Q1 2012: First 2A 2B data that we have) legend(on order(1 "Purchase: Unregistered" 3 "Local Turnover"  2 "Purchase: Other Dealers")) xsize(11) ysize(8)


//We merged Registration and cancellation data with collapsed data
//All graphs can be seen in the folder

twoway (connected TotalRegistrations year) (connected TotalCancellations year) (connected NetTax year, yaxis(2)) (connected AmountDepositedByDealer year, yaxis(2)) (connected TotalTaxCredit year, yaxis(2)) (line BalancePayable year, yaxis(2)) (line NetBalance year, yaxis(2)) if year<6
twoway (connected TotalRegistrations year) (connected TotalCancellations year) (connected TurnoverGross year, yaxis(2)) (connected TurnoverCentral year, sort yaxis(2)) (connected TurnoverLocal year, yaxis(2)) if year<6
twoway (connected TotalRegistrations year) (connected TotalCancellations year) (connected lTurnoverGross year, yaxis(2)) (connected lTurnoverCentral year, sort yaxis(2)) (connected lTurnoverLocal year, yaxis(2)) if year<6



//Now creating graphs on purchases
gen lPurchaseCapitalGoods=log(PurchaseCapitalGoods)
gen lPurchaseOtherGoods=log(PurchaseOtherGoods)
gen lHighSeaSale=log(HighSeaSale)
gen lHighSeaPurchase=log(HighSeaPurchase)
gen lDieselSale=log(DieselSale)
gen lDieselPurchase=log(DieselPurchase)
gen lTurnoverAt20=log(TurnoverAt20)
gen lOutputTaxAt20=log(OutputTaxAt20)
gen lPurchaseGoodsAt20=log(PurchaseGoodsAt20)
gen lCreditGoodsAt20=log(CreditGoodsAt20)
PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods


twoway (connected lTurnoverGross year, yaxis(2)) (connected lPurchaseCapitalGoods year, yaxis(2)) (connected lPurchaseUnregisteredDealer year, sort yaxis(2)) (connected lPurchaseIneligibleForITC year, yaxis(2)) (connected lPurchaseCompositionDealer year, yaxis(2)) (line lTotalTaxCredit year, yaxis(2)) (line lTotalInterStatePurchase year, yaxis(2)) (connected lTotalInterStateSale year, sort yaxis(2)) (connected lPurchaseOtherGoods year, yaxis(2)) if year<6
twoway (connected lTurnoverGross year, yaxis(2)) (connected lPurchaseUnregisteredDealer year, sort yaxis(2)) (connected lPurchaseCompositionDealer year, yaxis(2)) (line lTotalInterStatePurchase year, yaxis(2)) (connected lTotalInterStateSale year, sort yaxis(2)) (line lHighSeaPurchase year, yaxis(2)) (line lHighSeaSale year, yaxis(2)) if year<6
twoway (connected DieselSale year) (connected DieselPurchase year) (line TurnoverAt20 year) (connected OutputTaxAt20 year) (connected PurchaseGoodsAt20 year) (connected CreditGoodsAt20 year)
twoway (connected TurnoverLocal year)(connected DieselSale year) (connected DieselPurchase year) (line TurnoverAt20 year) (connected OutputTaxAt20 year) (connected PurchaseGoodsAt20 year) (connected CreditGoodsAt20 year)

twoway (connected lTurnoverLocal year)(connected lDieselSale year) (connected lDieselPurchase year) (line lTurnoverAt20 year) (connected lOutputTaxAt20 year) (connected lPurchaseGoodsAt20 year) (connected lCreditGoodsAt20 year)

//Now we do a few quarterly graphs (repeat of above)
use "PreliminaryAnalysis\form16_aggregate_annual_with dealer profile_0902_final.dta", clear


gen lPurchaseCapitalGoods=log(PurchaseCapitalGoods)
gen lPurchaseOtherGoods=log(PurchaseOtherGoods)
gen lHighSeaSale=log(HighSeaSale)
gen lHighSeaPurchase=log(HighSeaPurchase)
gen lPurchaseCompositionDealer=log(PurchaseCompositionDealer)
gen lDieselSale=log(DieselSale)
gen lDieselPurchase=log(DieselPurchase)
gen lTurnoverAt20=log(TurnoverAt20)
gen lOutputTaxAt20=log(OutputTaxAt20)
gen lPurchaseGoodsAt20=log(PurchaseGoodsAt20)
gen lCreditGoodsAt20=log(CreditGoodsAt20)

twoway (connected RefundClaimed quarter, sort) (connected AmountDepositedByDealer quarter, sort) (line NetBalance quarter, sort) (line NetTax quarter) (line TotalOutputTax quarter) (line CarryForwardTaxCredit quarter)
twoway (connected lPurchaseOtherGoods quarter, sort)(connected lPurchaseCapitalGoods quarter, sort)(line lTurnoverGross quarter, sort) (line lTurnoverCentral quarter) (connected lTurnoverLocal quarter) (connected lPurchaseUnregisteredDealer quarter, sort) (line lTotalInterStateSale quarter) (line lTotalInterStatePurchase quarter)

twoway (connected AmountDepositedByDealer quarter) (line TotalTaxCredit quarter) (connected RefundClaimed quarter, sort) (connected NetTax quarter)

twoway (connected lTurnoverGross quarter, yaxis(2)) (connected lPurchaseCapitalGoods quarter, yaxis(2)) (connected lPurchaseUnregisteredDealer quarter, sort yaxis(2)) (connected lPurchaseIneligibleForITC quarter, yaxis(2)) (connected lPurchaseCompositionDealer quarter, yaxis(2)) (connected lTotalTaxCredit quarter, yaxis(2)) (line lTotalInterStatePurchase quarter, yaxis(2)) (connected lTotalInterStateSale quarter, sort yaxis(2)) (connected lPurchaseOtherGoods quarter, yaxis(2)) 
twoway (connected lTurnoverGross quarter, yaxis(2)) (connected lPurchaseUnregisteredDealer quarter, sort yaxis(2)) (connected lPurchaseCompositionDealer quarter, yaxis(2)) (line lTotalInterStatePurchase quarter, yaxis(2)) (connected lTotalInterStateSale quarter, sort yaxis(2)) (line lHighSeaPurchase quarter, yaxis(2)) (line lHighSeaSale quarter, yaxis(2))


twoway (connected lTurnoverLocal quarter)(connected lDieselSale quarter) (connected lDieselPurchase quarter) (connected lTurnoverAt20 quarter) (connected lOutputTaxAt20 quarter) (connected lPurchaseGoodsAt20 quarter) (connected lCreditGoodsAt20 quarter)



/* Rough
(line TotalInterStateSale quarter) (line TotalInterStatePurchase quarter)
