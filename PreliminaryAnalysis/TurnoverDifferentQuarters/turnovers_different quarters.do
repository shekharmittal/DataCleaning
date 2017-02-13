* Now we want to look at distribution of turnovers for dealers who registered in different time periods
cd "D:\data\"

use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear

merge m:1 DealerTIN using "DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(Nature IECCode Constitution OtherConstitution OptConstitution RegistrationType AnnualTurnoverCategory TurnoverPreviousYear ExpectedTurnover RegistrationDate OwnCapital BankLoan OtherLoan PlantAndMachinery LandAndBuilding OtherAssets TotalSecurity TypeOfSecurity ExpiryBankSecurity RegularDealerType Ward BooleanInterState Boolean201011 Boolean201112 Boolean201213 PhysicalWard BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax)

/*
(note: variable DealerTIN was str11, now str25 to accommodate	using	data's	values)

Result                           # of obs.
-----------------------------------------
not matched                       509,074
from master                   471,624  (_merge==1)
from using                     37,450  (_merge==2)

matched                         3,898,526  (_merge==3)
-----------------------------------------

. 
end of do-file

. tab TaxPeriod if _merge==1

The tax period for 
which the returns has 
been filed       Freq.     Percent        Cum.

Annual-2010       8,953        1.90        1.90
Annual-2011       7,778        1.65        3.55
Annual-2012         159        0.03        3.58
Apr-2010       1,914        0.41        3.99
Apr-2011       1,642        0.35        4.34
Apr-2012       1,579        0.33        4.67
Apr-2013         101        0.02        4.69
Aug-2010       1,793        0.38        5.07
Aug-2011       1,521        0.32        5.39
Aug-2012       1,319        0.28        5.67
Dec-2010       1,693        0.36        6.03
Dec-2011       1,404        0.30        6.33
Dec-2012       1,181        0.25        6.58
Feb-2011       1,622        0.34        6.92
Feb-2012       1,334        0.28        7.21
Feb-2013       1,077        0.23        7.44
First Halfyear-2010       7,879        1.67        9.11
First Halfyear-2011       6,705        1.42       10.53
First Halfyear-2012          38        0.01       10.54
First Quarter-2010      18,187        3.86       14.39
First Quarter-2011      17,567        3.72       18.12
First Quarter-2012      27,566        5.84       23.96
First Quarter-2013      23,590        5.00       28.96
First Quarter-2014      10,763        2.28       31.25
Fourth Quarter-2010      19,591        4.15       35.40
Fourth Quarter-2011      17,421        3.69       39.09
Fourth Quarter-2012      28,353        6.01       45.11
Fourth Quarter-2013      11,946        2.53       47.64
Fourth Quarter-2014       8,675        1.84       49.48
Jan-2011       1,662        0.35       49.83
Jan-2012       1,376        0.29       50.12
Jan-2013       1,115        0.24       50.36
Jul-2010       1,821        0.39       50.74
Jul-2011       1,553        0.33       51.07
Jul-2012       1,358        0.29       51.36
Jun-2010       1,849        0.39       51.75
Jun-2011       1,588        0.34       52.09
Jun-2012       1,471        0.31       52.40
Mar-2011       1,606        0.34       52.74
Mar-2012       1,293        0.27       53.02
Mar-2013       1,030        0.22       53.24
May-2010       1,865        0.40       53.63
May-2011       1,616        0.34       53.97
May-2012       1,527        0.32       54.30
May-2013           2        0.00       54.30
Nov-2010       1,722        0.37       54.66
Nov-2011       1,434        0.30       54.97
Nov-2012       1,215        0.26       55.22
Oct-2010       1,747        0.37       55.60
Oct-2011       1,457        0.31       55.90
Oct-2012       1,242        0.26       56.17
Second Halfyear-2010       7,537        1.60       57.77
Second Halfyear-2011       6,114        1.30       59.06
Second Halfyear-2012           1        0.00       59.06
Second Quarter-2010      18,689        3.96       63.02
Second Quarter-2011      17,706        3.75       66.78
Second Quarter-2012      28,141        5.97       72.75
Second Quarter-2013      20,751        4.40       77.15
Second Quarter-2014       9,982        2.12       79.26
Sep-2010       1,778        0.38       79.64
Sep-2011       1,509        0.32       79.96
Sep-2012       1,294        0.27       80.23
Third Quarter-2010      19,104        4.05       84.28
Third Quarter-2011      17,970        3.81       88.09
Third Quarter-2012      28,415        6.02       94.12
Third Quarter-2013      18,364        3.89       98.01
Third Quarter-2014       9,369        1.99      100.00

Total     471,624      100.00

. tab TaxPeriod if _merge==3

The tax period for 
which the returns has 
been filed       Freq.     Percent        Cum.

Annual-2010      17,270        0.44        0.44
Annual-2011      17,729        0.45        0.90
Annual-2012         246        0.01        0.90
Apr-2010      11,017        0.28        1.19
Apr-2011      12,949        0.33        1.52
Apr-2012      15,694        0.40        1.92
Apr-2013       1,061        0.03        1.95
Aug-2010      11,070        0.28        2.23
Aug-2011      12,907        0.33        2.56
Aug-2012      15,671        0.40        2.97
Dec-2010      11,060        0.28        3.25
Dec-2011      12,930        0.33        3.58
Dec-2012      15,670        0.40        3.98
Feb-2011      11,073        0.28        4.27
Feb-2012      12,946        0.33        4.60
Feb-2013      15,659        0.40        5.00
First Halfyear-2010      42,863        1.10        6.10
First Halfyear-2011      43,941        1.13        7.23
First Halfyear-2012          47        0.00        7.23
First Quarter-2010      70,069        1.80        9.03
First Quarter-2011      80,869        2.07       11.10
First Quarter-2012     159,333        4.09       15.19
First Quarter-2013     216,399        5.55       20.74
First Quarter-2014     233,245        5.98       26.72
Fourth Quarter-2010      79,250        2.03       28.75
Fourth Quarter-2011      92,780        2.38       31.13
Fourth Quarter-2012     194,883        5.00       36.13
Fourth Quarter-2013     229,239        5.88       42.01
Fourth Quarter-2014     246,390        6.32       48.33
Jan-2011      11,078        0.28       48.62
Jan-2012      12,952        0.33       48.95
Jan-2013      15,682        0.40       49.35
Jul-2010      11,064        0.28       49.64
Jul-2011      12,928        0.33       49.97
Jul-2012      15,674        0.40       50.37
Jun-2010      11,073        0.28       50.65
Jun-2011      12,952        0.33       50.98
Jun-2012      15,708        0.40       51.39
Mar-2011      11,098        0.28       51.67
Mar-2012      12,963        0.33       52.01
Mar-2013      15,672        0.40       52.41
May-2010      11,042        0.28       52.69
May-2011      12,948        0.33       53.02
May-2012      15,677        0.40       53.42
May-2013           6        0.00       53.42
Nov-2010      11,066        0.28       53.71
Nov-2011      12,934        0.33       54.04
Nov-2012      15,671        0.40       54.44
Oct-2010      11,085        0.28       54.73
Oct-2011      12,925        0.33       55.06
Oct-2012      15,678        0.40       55.46
Second Halfyear-2010      43,220        1.11       56.57
Second Halfyear-2011      43,937        1.13       57.70
Second Halfyear-2012           5        0.00       57.70
Second Quarter-2010      73,163        1.88       59.57
Second Quarter-2011      84,898        2.18       61.75
Second Quarter-2012     173,200        4.44       66.19
Second Quarter-2013     221,347        5.68       71.87
Second Quarter-2014     237,833        6.10       77.97
Sep-2010      11,067        0.28       78.26
Sep-2011      12,928        0.33       78.59
Sep-2012      15,690        0.40       78.99
Third Quarter-2010      76,005        1.95       80.94
Third Quarter-2011      88,829        2.28       83.22
Third Quarter-2012     185,236        4.75       87.97
Third Quarter-2013     225,668        5.79       93.76
Third Quarter-2014     243,364        6.24      100.00

Total   3,898,526      100.00

*/
keep if _merge==3

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

// First we import the date from the registration date
gen newRegistrationDate=dofc(RegistrationDate)
format %td newRegistrationDate 
//change it into date format
//Import just the year inf
gen StartYear=yofd(newRegistrationDate)
gen StartMonth=mofd(newRegistrationDate)
format %tm StartMonth
format %ty StartYear //Changing the format to appropriate year form

/* Begin analysis for number of registrations between 2010 and 2015*/
gen month=StartMonth
gen RegistrationYear=1 if month>602&month<=614
replace RegistrationYear=2 if month>614&month<=626
replace RegistrationYear=3 if month>626&month<=638
replace RegistrationYear=4 if month>638&month<=650
replace RegistrationYear=5 if month>650&month<=662
replace RegistrationYear=6 if month>662&month<=674
replace month=month-599
gen dummy=1

gen RegistrationQuarter=.
replace RegistrationQuarter=0 if month>0&month<=3
replace RegistrationQuarter=1 if month>3&month<=6
replace RegistrationQuarter=2 if month>6&month<=9
replace RegistrationQuarter=3 if month>9&month<=12
replace RegistrationQuarter=4 if month>12&month<=15
replace RegistrationQuarter=5 if month>15&month<=18
replace RegistrationQuarter=6 if month>18&month<=21
replace RegistrationQuarter=7 if month>21&month<=24
replace RegistrationQuarter=8 if month>24&month<=27
replace RegistrationQuarter=9 if month>27&month<=30
replace RegistrationQuarter=10 if month>30&month<=33
replace RegistrationQuarter=11 if month>33&month<=36
replace RegistrationQuarter=12 if month>36&month<=39
replace RegistrationQuarter=13 if month>39&month<=42
replace RegistrationQuarter=14 if month>42&month<=45
replace RegistrationQuarter=15 if month>45&month<=48
replace RegistrationQuarter=16 if month>48&month<=51
replace RegistrationQuarter=17 if month>51&month<=54
replace RegistrationQuarter=18 if month>54&month<=57
replace RegistrationQuarter=19 if month>57&month<=60
replace RegistrationQuarter=20 if month>60&month<=63

rename month RegistrationMonth
replace RegistrationMonth=RegistrationMonth-3

label define year 1 "2010-11" 2 "2011-12" 3 "2012-13" 4 "2013-14" 5 "2014-15" 6 "2015-16"
label define quarter 1 "Q1, 2010-11" 2 "Q2, 2010-11" 3 "Q3, 2010-11" 4 "Q4, 2010-11" 5 "Q1, 2011-12" 6 "Q2, 2011-12" 7 "Q3, 2011-12" 8 "Q4, 2011-12" 9 "Q1, 2012-13" 10 "Q2, 2012-13" 11 "Q3, 2012-13" 12 "Q4, 2012-13" 13 "Q1, 2013-14" 14 "Q2, 2013-14" 15 "Q3, 2013-14" 16 "Q4, 2013-14" 17 "Q1, 2014-15" 18 "Q2, 2014-15" 19 "Q3, 2014-15" 20 "Q4, 2014-15"

label values RegistrationQuarter TaxQuarter quarter
label values RegistrationYear TaxYear year

histogram TurnoverGross if ((RegistrationQuarter==10&TaxQuarter==11)|(RegistrationQuarter==9&TaxQuarter==10)|(RegistrationQuarter==11&TaxQuarter==12))&TurnoverGross<2000000, width(25000) fraction ylabel(, angle(horizontal)) xlabel(, angle(vertical)) by(, caption(, size(vsmall) box lcolor(black) justification(left) alignment(bottom))) by(RegistrationQuarter)
/*
label values RegistrationQuarter quarter
label values RegistrationYear  year
histogram RegistrationQuarter, discrete width(1) frequency xline(10 13 14, lwidth(vvvthin) lpattern(solid) lcolor(green) extend) xlabel(#10, angle(vertical) valuelabel) caption("Q2 2012- no security for the first time, Q1 2013 - Closure of CRC and increase of limit from 10 to 20 lac, Q2 2013- Online registration", size(vsmall) box lcolor(black) justification(left) alignment(bottom))
histogram RegistrationMonth if RegistrationMonth>0&RegistrationMonth<61, discrete width(1) frequency xline(29 37 40, lwidth(vvvthin) lpattern(solid) lcolor(green) extend) xlabel(#10, angle(vertical) valuelabel) caption("29- no security for the first time, 37 - Closure of CRC and increase of limit from 10 to 20 lac, 40- Online registration", size(vsmall) box lcolor(black) justification(left) alignment(bottom))
*/

log using "PreliminaryAnalysis\TurnoverDifferentQuarters\turnovers for different quarters.smcl", replace
/* Now to look at the impact of no security, we will first look at the policies impact on turnovers filed by dealers in their first full quarter*/
/* Policy was started in the middle of quarter 10*/
/* So we look at dealers who registered in quarter 9 and their returns in quarter 10. Then we look at dealers who registered in quarter 10 and their returns in quarter 11. 
Finally we look at dealers who registered in quarter 11 and their returns in quarter 12.*/

//sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==9&TaxQuarter==10))&AmountDepositedByDealer<200000&AmountDepositedByDealer>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==9&TaxQuarter==10))&TurnoverGross<12500000&TurnoverGross>0, detail

//sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==10&TaxQuarter==11))&AmountDepositedByDealer<200000&AmountDepositedByDealer>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==10&TaxQuarter==11))&TurnoverGross<12500000&TurnoverGross>0, detail

//sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==11&TaxQuarter==12))&AmountDepositedByDealer<200000&AmountDepositedByDealer>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==11&TaxQuarter==12))&TurnoverGross<12500000&TurnoverGross>0, detail
*log close

sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==9&TaxQuarter==10))&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==10&TaxQuarter==11))&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==11&TaxQuarter==12))&TurnoverGross>0, detail

//sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==10&TaxQuarter==11))&AmountDepositedByDealer<200000&AmountDepositedByDealer>0, detail

//sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==11&TaxQuarter==12))&AmountDepositedByDealer<200000&AmountDepositedByDealer>0, detail


preserve

collapse (mean)RegistrationYear RegistrationQuarter (sum) TurnoverGross AmountDepositedByDealer TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit, by(DealerTIN TaxYear)

/*what is the impact of no security?
Quarter 9 had the security limitation
Quarter 10 was the one when security limitation was removed,
Quarter 11 was teh first complete quarter without any security restriction
So we look at first the summary stats for firms which were registered in these quarters in year 2013-14 and 2014-15.
*/

* For year 2013-14
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==11&TaxYear==4))&AmountDepositedByDealer<200000&AmountDepositedByDealer>0, detail

sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==9&TaxYear==4))&TurnoverGross<50000000&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==10&TaxYear==4))&TurnoverGross<50000000&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==11&TaxYear==4))&TurnoverGross<50000000&TurnoverGross>0, detail

sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==9&TaxYear==4))&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==10&TaxYear==4))&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==11&TaxYear==4))&TurnoverGross>0, detail

* For year 2014-15
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==9&TaxYear==5))&TurnoverGross<50000000&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==10&TaxYear==5))&TurnoverGross<50000000&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==11&TaxYear==5))&TurnoverGross<50000000&TurnoverGross>0, detail

sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==9&TaxYear==5))&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==10&TaxYear==5))&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==11&TaxYear==5))&TurnoverGross>0, detail


/*What is the impact of increase in turnover limit from 10lac to 20lac
Quarter 12 had the limit as 10 lac
Quarter 13 had the limit as 20 lac
So we look at first the summary stats for firms which were registered in these quarters in year 2013-14 and 2014-15.
*/
* For year 2013-14
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==12&TaxYear==4))&TurnoverGross<50000000&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==13&TaxYear==4))&TurnoverGross<50000000&TurnoverGross>0, detail

sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==12&TaxYear==4))&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==13&TaxYear==4))&TurnoverGross>0, detail


* For year 2014-15
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==12&TaxYear==5))&TurnoverGross<50000000&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==13&TaxYear==5))&TurnoverGross<50000000&TurnoverGross>0, detail

sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==12&TaxYear==5))&TurnoverGross>0, detail
sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if ((RegistrationQuarter==13&TaxYear==5))&TurnoverGross>0, detail


log close


*sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if (TaxYear==4)&TurnoverGross>0, detail
* sum AmountDepositedByDealer TurnoverGross TotalOutputTax TotalTaxCredit  if (TaxYear==5)&TurnoverGross>0, detail



tab quarter, gen(quarter)

sum TurnoverGross if quarter12==1&TaxPeriod=="Fourth Quarter-2012"&TurnoverGross<2000000, detail
sum TurnoverGross if quarter8==1&TaxPeriod=="Fourth Quarter-2011"&TurnoverGross<2000000, detail
sum TurnoverGross if quarter16==1&TaxPeriod=="Fourth Quarter-2013"&TurnoverGross<2000000, detail
sum TurnoverGross if quarter20==1&TaxPeriod=="Fourth Quarter-2014"&TurnoverGross<2000000, detail


sum TurnoverGross if TaxPeriod=="Second Quarter-2010"&TurnoverGross<2000000, detail
sum TurnoverGross if quarter3==1&TaxPeriod=="Third Quarter-2010"&TurnoverGross<2000000, detail
sum TurnoverGross if quarter4==1&TaxPeriod=="Fourth-2010"&TurnoverGross<2000000, detail
sum TurnoverGross if quarter4==1&TaxPeriod=="Fourth Quarter-2010"&TurnoverGross<2000000, detail
