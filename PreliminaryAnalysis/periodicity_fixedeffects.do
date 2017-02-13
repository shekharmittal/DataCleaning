cd "D:\data"
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear

/*
merge m:1 DealerTIN using "DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(Nature IECCode Constitution OtherConstitution OptConstitution RegistrationType AnnualTurnoverCategory TurnoverPreviousYear ExpectedTurnover RegistrationDate OwnCapital BankLoan OtherLoan PlantAndMachinery LandAndBuilding OtherAssets TotalSecurity TypeOfSecurity ExpiryBankSecurity RegularDealerType Ward BooleanInterState Boolean201011 Boolean201112 Boolean201213 PhysicalWard BooleanRegisteredIEC BooleanRegisteredCE BooleanServiceTax)
keep if _merge==3
*/

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
*drop AnnualDummy SemiAnnualDummy MonthlyDummy QuarterlyDummy
*drop Mean*
*gen AnnualDummy=0
*gen SemiAnnualDummy=0
*gen QuarterlyDummy=0
*gen MonthlyDummy=0

gen AnnualDummy=1 if TaxYear==1&TaxPeriod=="Annual-2010"
gen SemiAnnualDummy=1 if TaxYear==1&TaxPeriod=="First Halfyear-2010"
gen QuarterlyDummy=1 if TaxYear==1&TaxPeriod=="First Quarter-2010"
gen MonthlyDummy=1 if TaxYear==1&TaxPeriod=="Apr-2010"


by DealerTIN: replace AnnualDummy=AnnualDummy[_n-1] if AnnualDummy>=.
by DealerTIN: replace SemiAnnualDummy=SemiAnnualDummy[_n-1] if SemiAnnualDummy>=.
by DealerTIN: replace QuarterlyDummy=QuarterlyDummy[_n-1] if QuarterlyDummy>=.
by DealerTIN: replace MonthlyDummy=MonthlyDummy[_n-1] if MonthlyDummy>=.

//keep if AnnualDummy==1|SemiAnnualDummy==1
keep if AnnualDummy==1|(QuarterlyDummy==1

drop if AnnualDummy==1&SemiAnnualDummy==1
drop if AnnualDummy==1&QuarterlyDummy==1
drop if AnnualDummy==1&MonthlyDummy==1

drop if QuarterlyDummy==1&SemiAnnualDummy==1
drop if MonthlyDummy==1&QuarterlyDummy==1

replace AnnualDummy=0 if AnnualDummy==.
replace SemiAnnualDummy=0 if SemiAnnualDummy==.
replace QuarterlyDummy=0 if QuarterlyDummy==.
replace MonthlyDummy=0 if MonthlyDummy==.

/*
by DealerTIN: egen MeanAnnualDummy=mean(AnnualDummy)
by DealerTIN: egen MeanSemiAnnualDummy=mean(SemiAnnualDummy)
by DealerTIN: egen MeanQuarterlyDummy=mean(QuarterlyDummy)
by DealerTIN: egen MeanMonthlyDummy=mean(MonthlyDummy)

replace MeanQuarterlyDummy=. if MeanQuarterlyDummy!=0&MeanQuarterlyDummy!=1
replace MeanMonthlyDummy=. if MeanMonthlyDummy!=0&MeanMonthlyDummy!=1
replace MeanSemiAnnualDummy=. if MeanSemiAnnualDummy!=0&MeanSemiAnnualDummy!=1
*/


collapse (mean)AnnualDummy (sum) AggregateAmountPaid TurnoverGross AmountDepositedByDealer TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit, by(DealerTIN TaxYear)



tab TaxYear, gen(year)
destring DealerTIN, replace
xtset DealerTIN TaxYear

gen Post=1 if TaxYear>2
replace Post=0 if Post==.
gen Treat=AnnualDummy*Post
xtreg TurnoverGross year* Post Treat, cluster(DealerTIN) fe

gen AnnualYear1=AnnualDummy*year1
gen AnnualYear2=AnnualDummy*year2
gen AnnualYear3=AnnualDummy*year3
gen AnnualYear4=AnnualDummy*year4
gen AnnualYear5=AnnualDummy*year5

xtreg TurnoverGross AnnualYear* year* Post Treat, cluster(DealerTIN) fe

/*

xtreg TurnoverGross AnnualYear* year* Post Treat, cluster(DealerTIN) fe
note: AnnualYear2 omitted because of collinearity
note: AnnualYear5 omitted because of collinearity
note: year1 omitted because of collinearity
note: year4 omitted because of collinearity

Fixed-effects (within) regression               Number of obs      =    427944
Group variable: DealerTIN                       Number of groups   =     87261

R-sq:  within  = 0.0011                         Obs per group: min =         1
       between = 0.0036                                        avg =       4.9
       overall = 0.0009                                        max =         5

                                                F(8,87260)         =     66.06
corr(u_i, Xb)  = 0.0123                         Prob > F           =    0.0000

                          (Std. Err. adjusted for 87261 clusters in DealerTIN)
------------------------------------------------------------------------------
             |               Robust
TurnoverGr~s |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
 AnnualYear1 |    2548253   604669.3     4.21   0.000      1363106     3733399
 AnnualYear2 |          0  (omitted)
 AnnualYear3 |  -300729.3   789424.4    -0.38   0.703     -1847994     1246535
 AnnualYear4 |  -710840.1   528117.8    -1.35   0.178     -1745946    324266.1
 AnnualYear5 |          0  (omitted)
       year1 |          0  (omitted)
       year2 |    3026902   190793.2    15.86   0.000      2652949     3400855
       year3 |   -1499469   518809.2    -2.89   0.004     -2516331   -482607.9
       year4 |          0  (omitted)
       year5 |   3516.971   346643.4     0.01   0.992      -675901    682934.9
        Post |    8353545   587289.1    14.22   0.000      7202464     9504627
       Treat |   -3111124   780956.2    -3.98   0.000     -4641791    -1580456
       _cons |   1.29e+07   354148.9    36.56   0.000     1.23e+07    1.36e+07
-------------+----------------------------------------------------------------
     sigma_u |  1.126e+08
     sigma_e |  1.019e+08
         rho |    .549732   (fraction of variance due to u_i)
------------------------------------------------------------------------------
*/



/*
gen pt = post*treatment
reg gruppe pt post treatment
The coefficient on pt is the difference-in-difference estimator. The t-statistic on that regression coefficient is the t-test for equality of the differences.
*/

xtreg TurnoverGross year* AnnualDummy Post Treat, cluster(DealerTIN) fe
xtreg ratio year* AnnualDummy Post treat, cluster(DealerTIN) 
xtreg AmountDeposited year* AnnualDummy Post Treat, cluster(DealerTIN) fe
xtreg Aggregate year* AnnualDummy Post Treat, cluster(DealerTIN) fe


/*
 xtreg TurnoverGross year* AnnualDummy Post treat, cluster(DealerTIN) fe
note: year1 omitted because of collinearity
note: year4 omitted because of collinearity
note: AnnualDummy omitted because of collinearity

Fixed-effects (within) regression               Number of obs      =    501837
Group variable: DealerTIN                       Number of groups   =    114365

R-sq:  within  = 0.0008                         Obs per group: min =         1
       between = 0.0052                                        avg =       4.4
       overall = 0.0016                                        max =         5

                                                F(5,114364)        =     71.16
corr(u_i, Xb)  = 0.0257                         Prob > F           =    0.0000

                         (Std. Err. adjusted for 114365 clusters in DealerTIN)
------------------------------------------------------------------------------
             |               Robust
TurnoverGr~s |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
       year1 |          0  (omitted)
       year2 |    2034643   217187.3     9.37   0.000      1608959     2460327
       year3 |   -1393970   378451.8    -3.68   0.000     -2135730     -652210
       year4 |          0  (omitted)
       year5 |   371744.3     281431     1.32   0.187    -179856.1    923344.8
 AnnualDummy |          0  (omitted)
        Post |    6835923   540891.1    12.64   0.000      5775784     7896061
       treat |   -4086689   812058.3    -5.03   0.000     -5678311    -2495067
       _cons |   1.29e+07   299117.2    43.26   0.000     1.24e+07    1.35e+07
-------------+----------------------------------------------------------------
     sigma_u |  1.036e+08
     sigma_e |   99531249
         rho |  .52004385   (fraction of variance due to u_i)
------------------------------------------------------------------------------
*/


preserve
collapse (sum) TurnoverGross AmountDepositedByDealer TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit, by(TaxYear AnnualDummy)
collapse (mean) AggregateAmountPaid TurnoverGross AmountDepositedByDealer TotalOutputTax PurchaseUnregisteredDealer TotalTaxCredit, by(Post AnnualDummy)


table AnnualDummy Post, c(mean TurnoverGross)
table AnnualDummy Post, c(mean Aggregate)
	
