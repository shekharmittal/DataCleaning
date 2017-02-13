cd "D:\data\"

use "CancellationForm.dta", clear

gen CancellationYear=dofc(CancellationDate)
format %td CancellationYear //change it into date format
gen Year=yofd(CancellationYear)
gen Month=mofd(CancellationYear)
format %tm Month
format %ty Year //Changing the format to appropriate year form

gen CancellationMonth=Month

gen year=1 if CancellationMonth>602&CancellationMonth<=614
replace year=2 if CancellationMonth>614&CancellationMonth<=626
replace year=3 if CancellationMonth>626&CancellationMonth<=638
replace year=4 if CancellationMonth>638&CancellationMonth<=650
replace year=5 if CancellationMonth>650&CancellationMonth<=662
replace year=6 if CancellationMonth>662&CancellationMonth<=674

replace CancellationMonth=CancellationMonth-599

gen dummy=1
collapse (count) dummy (mean) year Month, by(CancellationMonth)
twoway (connected dummy CancellationMonth if year!=.)

rename dummy TotalCancellations

gen quarter=0
replace quarter=1 if month>3&month<=6
replace quarter=2 if month>6&month<=9
replace quarter=3 if month>9&month<=12
replace quarter=4 if month>12&month<=15
replace quarter=5 if month>15&month<=18
replace quarter=6 if month>18&month<=21
replace quarter=7 if month>21&month<=24
replace quarter=8 if month>24&month<=27
replace quarter=9 if month>27&month<=30
replace quarter=10 if month>30&month<=33
replace quarter=11 if month>33&month<=36
replace quarter=12 if month>36&month<=39
replace quarter=13 if month>39&month<=42
replace quarter=14 if month>42&month<=45
replace quarter=15 if month>45&month<=48
replace quarter=16 if month>48&month<=51
replace quarter=17 if month>51&month<=54
replace quarter=18 if month>54&month<=57
replace quarter=19 if month>57&month<=60
replace quarter=20 if month>60&month<=63

label define year 1 "2010-11" 2 "2011-12" 3 "2012-13" 4 "2013-14" 5 "2014-15" 6 "2015-16"
label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"

label values quarter quarter
label values year year

keep if year!=.
keep if quarter!=0
collapse (sum) TotalRegistrations TotalCancellations, by(quarter)
twoway (connected TotalRegistrations quarter) (connected TotalCancellations quarter), xline(11)


twoway (connected TotalRegistrations quarter) (connected TotalCancellations quarter), ytitle(Number) xtitle(Quarter) xline(13 14, lpattern(dash) lcolor(green)) xlabel(#10, angle(vertical) valuelabel) caption("Q1 2013- Closing of CRC and limit raised from 10 lac to 20 lac. 
Q2 2013- Online Registration and removal of security") legend(on order(1 "Total Registrations" 2 "Total Cancellations"))

twoway (connected TotalRegistrations quarter) (connected TotalCancellations quarter), ylabel(#5, angle(horizontal)) xtitle(Quarter) xline(13 14, lpattern(dash) lcolor(green)) xlabel(#10, angle(vertical) valuelabel) title(Quarterly registrations and cancellations) caption(, size(small) bexpand) note(Q1 2013- Closing of CRC and limit raised from 10 lac to 20 lac. Q2 2013- Online Registration and removal of security) legend(on order(1 "Total Registrations" 2 "Total Cancellations")) xsize(11) ysize(8)
graph export "PreliminaryAnalysis\cancellations\cancellations vs registrations_quarterly.pdf", as(pdf) replace

collapse (sum) TotalRegistrations TotalCancellations, by(year)
twoway (connected TotalRegistrations year)
twoway (connected TotalRegistrations year) (connected TotalCancellations year)
graph save Graph "PreliminaryAnalysis\cancellations\cancellations vs registrations_annual.gph"
graph export "PreliminaryAnalysis\cancellations\cancellations vs registrations_annual.pdf", as(pdf) replace

merge 1:1 quarter using "PreliminaryAnalysis\returns\form16_aggregate_quarterly_final_v2_0902.dta"


merge 1:1 year using "PreliminaryAnalysis\returns\form16_aggregate_annual_final_v2_0902.dta"
save "PreliminaryAnalysis\returns\form16_aggregate_annual_final_with cancellations_0903.dta"

twoway (connected TotalRegistrations year) (connected TotalCancellations year) (connected NetTax year, yaxis(2)) (connected AmountDepositedByDealer year, yaxis(2)) (connected TotalTaxCredit year, yaxis(2)) (line BalancePayable year, yaxis(2)) (line NetBalance year, yaxis(2)) if year<6
twoway (connected TotalRegistrations year) (connected TotalCancellations year) (connected TurnoverGross year, yaxis(2)) (connected TurnoverCentral year, sort yaxis(2)) (connected TurnoverLocal year, yaxis(2)) if year<6
twoway (connected TotalRegistrations year) (connected TotalCancellations year) (connected lTurnoverGross year, yaxis(2)) (connected lTurnoverCentral year, sort yaxis(2)) (connected lTurnoverLocal year, yaxis(2)) if year<6

//Now creating graphs on purchases
gen lPurchaseCapitalGoods=log(PurchaseCapitalGoods)
gen lPurchaseOtherGoods=log(PurchaseOtherGoods)
PurchaseUnregisteredDealer PurchaseCompositionDealer PurchaseNonCreditableGoods PurchaseRetailInvoice PurchaseTaxFreeGoods


twoway (connected lTurnoverGross year, yaxis(2)) (connected lPurchaseCapitalGoods year, yaxis(2)) (connected lPurchaseUnregisteredDealer year, sort yaxis(2)) (connected lPurchaseIneligibleForITC year, yaxis(2)) (connected lPurchaseCompositionDealer year, yaxis(2)) (line lTotalTaxCredit year, yaxis(2)) (line lTotalInterStatePurchase year, yaxis(2)) (connected lTotalInterStateSale year, sort yaxis(2)) (connected lPurchaseOtherGoods year, yaxis(2)) if year<6
