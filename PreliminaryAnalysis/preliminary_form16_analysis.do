/*
In this file we categorise returns by their frequency of filing and aggregate them accordingly.
We create separate tables for annual, semi-annual, quarterly and monthly returns.
We collaphse some of the interesting variables at the annual level and at the quarter level and aggregate all of them.
Some variables are missed out on.

*/

cd "E:\data"
use "form16_data_v3_0901.dta", clear

destring id, replace

gsort TaxPeriod DealerTIN -id
by TaxPeriod DealerTIN: gen ReturnCount=_n

/*
. tab TaxPeriod

    The tax period for |
 which the returns has |
            been filed |      Freq.     Percent        Cum.
-----------------------+-----------------------------------
           Annual-2010 |     27,339        0.49        0.49
           Annual-2011 |     26,805        0.48        0.97
           Annual-2012 |        406        0.01        0.98
              Apr-2010 |     15,661        0.28        1.25
              Apr-2011 |     17,131        0.31        1.56
              Apr-2012 |     26,822        0.48        2.04
              Apr-2013 |      1,197        0.02        2.06
              Aug-2010 |     15,107        0.27        2.33
              Aug-2011 |     16,692        0.30        2.63
              Aug-2012 |     24,972        0.45        3.08
              Dec-2010 |     14,775        0.26        3.34
              Dec-2011 |     16,604        0.30        3.64
              Dec-2012 |     25,033        0.45        4.08
              Feb-2011 |     14,657        0.26        4.35
              Feb-2012 |     16,375        0.29        4.64
              Feb-2013 |     24,696        0.44        5.08
   First Halfyear-2010 |     55,093        0.98        6.07
   First Halfyear-2011 |     54,990        0.98        7.05
   First Halfyear-2012 |         85        0.00        7.05
    First Quarter-2010 |    100,082        1.79        8.84
    First Quarter-2011 |    111,081        1.99       10.82
    First Quarter-2012 |    241,628        4.32       15.14
    First Quarter-2013 |    355,256        6.35       21.49
    First Quarter-2014 |    310,204        5.54       27.04
   Fourth Quarter-2010 |    110,656        1.98       29.02
   Fourth Quarter-2011 |    124,050        2.22       31.23
   Fourth Quarter-2012 |    290,246        5.19       36.42
   Fourth Quarter-2013 |    326,205        5.83       42.25
   Fourth Quarter-2014 |    294,438        5.26       47.51
              Jan-2011 |     14,675        0.26       47.78
              Jan-2012 |     16,361        0.29       48.07
              Jan-2013 |     24,768        0.44       48.51
              Jul-2010 |     15,124        0.27       48.78
              Jul-2011 |     16,625        0.30       49.08
              Jul-2012 |     25,605        0.46       49.54
              Jun-2010 |     15,435        0.28       49.81
              Jun-2011 |     17,028        0.30       50.12
              Jun-2012 |     26,271        0.47       50.59
              Mar-2011 |     15,268        0.27       50.86
              Mar-2012 |     17,055        0.30       51.16
              Mar-2013 |     25,802        0.46       51.62
              May-2010 |     15,259        0.27       51.90
              May-2011 |     17,102        0.31       52.20
              May-2012 |     27,038        0.48       52.69
              May-2013 |          8        0.00       52.69
              Nov-2010 |     14,806        0.26       52.95
              Nov-2011 |     16,572        0.30       53.25
              Nov-2012 |     24,649        0.44       53.69
              Oct-2010 |     15,001        0.27       53.96
              Oct-2011 |     16,654        0.30       54.25
              Oct-2012 |     25,368        0.45       54.71
  Second Halfyear-2010 |     54,363        0.97       55.68
  Second Halfyear-2011 |     53,933        0.96       56.64
  Second Halfyear-2012 |          6        0.00       56.64
   Second Quarter-2010 |    103,931        1.86       58.50
   Second Quarter-2011 |    115,273        2.06       60.56
   Second Quarter-2012 |    253,504        4.53       65.09
   Second Quarter-2013 |    432,336        7.73       72.82
   Second Quarter-2014 |    311,551        5.57       78.39
              Sep-2010 |     15,357        0.27       78.66
              Sep-2011 |     17,011        0.30       78.97
              Sep-2012 |     24,958        0.45       79.41
    Third Quarter-2010 |    106,008        1.89       81.31
    Third Quarter-2011 |    119,388        2.13       83.44
    Third Quarter-2012 |    275,430        4.92       88.36
    Third Quarter-2013 |    342,175        6.12       94.48
    Third Quarter-2014 |    308,850        5.52      100.00
-----------------------+-----------------------------------
                 Total |  5,594,834      100.00

*/
. Keep if ReturnCount==1


//Now we count final entries which are unique
/*
 tab TaxPeriod

    The tax period for |
 which the returns has |
            been filed |      Freq.     Percent        Cum.
-----------------------+-----------------------------------
           Annual-2010 |     26,223        0.60        0.60
           Annual-2011 |     25,507        0.58        1.18
           Annual-2012 |        405        0.01        1.19
              Apr-2010 |     12,931        0.30        1.49
              Apr-2011 |     14,591        0.33        1.82
              Apr-2012 |     17,273        0.40        2.22
              Apr-2013 |      1,162        0.03        2.24
              Aug-2010 |     12,863        0.29        2.54
              Aug-2011 |     14,428        0.33        2.87
              Aug-2012 |     16,990        0.39        3.26
              Dec-2010 |     12,753        0.29        3.55
              Dec-2011 |     14,334        0.33        3.88
              Dec-2012 |     16,851        0.39        4.26
              Feb-2011 |     12,695        0.29        4.55
              Feb-2012 |     14,280        0.33        4.88
              Feb-2013 |     16,736        0.38        5.26
   First Halfyear-2010 |     50,742        1.16        6.42
   First Halfyear-2011 |     50,646        1.16        7.58
   First Halfyear-2012 |         85        0.00        7.59
    First Quarter-2010 |     88,256        2.02        9.60
    First Quarter-2011 |     98,436        2.25       11.86
    First Quarter-2012 |    186,899        4.28       16.13
    First Quarter-2013 |    239,989        5.49       21.63
    First Quarter-2014 |    244,008        5.58       27.21
   Fourth Quarter-2010 |     98,841        2.26       29.47
   Fourth Quarter-2011 |    110,201        2.52       31.99
   Fourth Quarter-2012 |    223,236        5.11       37.10
   Fourth Quarter-2013 |    241,185        5.52       42.62
   Fourth Quarter-2014 |    255,065        5.84       48.46
              Jan-2011 |     12,740        0.29       48.75
              Jan-2012 |     14,328        0.33       49.08
              Jan-2013 |     16,797        0.38       49.46
              Jul-2010 |     12,885        0.29       49.75
              Jul-2011 |     14,481        0.33       50.09
              Jul-2012 |     17,032        0.39       50.48
              Jun-2010 |     12,922        0.30       50.77
              Jun-2011 |     14,540        0.33       51.10
              Jun-2012 |     17,179        0.39       51.50
              Mar-2011 |     12,704        0.29       51.79
              Mar-2012 |     14,256        0.33       52.11
              Mar-2013 |     16,702        0.38       52.50
              May-2010 |     12,907        0.30       52.79
              May-2011 |     14,564        0.33       53.13
              May-2012 |     17,204        0.39       53.52
              May-2013 |          8        0.00       53.52
              Nov-2010 |     12,788        0.29       53.81
              Nov-2011 |     14,368        0.33       54.14
              Nov-2012 |     16,886        0.39       54.53
              Oct-2010 |     12,832        0.29       54.82
              Oct-2011 |     14,382        0.33       55.15
              Oct-2012 |     16,920        0.39       55.54
  Second Halfyear-2010 |     50,757        1.16       56.70
  Second Halfyear-2011 |     50,051        1.15       57.84
  Second Halfyear-2012 |          6        0.00       57.84
   Second Quarter-2010 |     91,852        2.10       59.95
   Second Quarter-2011 |    102,604        2.35       62.29
   Second Quarter-2012 |    201,341        4.61       66.90
   Second Quarter-2013 |    242,098        5.54       72.44
   Second Quarter-2014 |    247,815        5.67       78.11
              Sep-2010 |     12,845        0.29       78.40
              Sep-2011 |     14,437        0.33       78.74
              Sep-2012 |     16,984        0.39       79.12
    Third Quarter-2010 |     95,109        2.18       81.30
    Third Quarter-2011 |    106,799        2.44       83.74
    Third Quarter-2012 |    213,651        4.89       88.63
    Third Quarter-2013 |    244,032        5.58       94.22
    Third Quarter-2014 |    252,733        5.78      100.00
-----------------------+-----------------------------------
                 Total |  4,370,150      100.00
*/

collapse (count) DealerTIN, by (TaxPeriod)


histogram TurnoverGross if (TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012")&TurnoverGross<=2000000&TurnoverGross>0, discrete width(10000) by(TaxPeriod)



//We create a table for annual return filings
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
keep if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"
tab TaxPeriod
save "PreliminaryAnalysis\returns\form16_data_v3_0901_annual filings.dta"

gen year=0
replace year=1 if TaxPeriod=="Annual-2010"
replace year=2 if TaxPeriod=="Annual-2011"
replace year=3 if TaxPeriod=="Annual-2012"
save "PreliminaryAnalysis\returns\form16_data_v3_0901_annual filings.dta", replace

//We create a table for half yearly return filings
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
keep if TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="First Halfyear-2010"
save "PreliminaryAnalysis\returns\form16_data_v3_0901_halfyearly filings.dta"

use "PreliminaryAnalysis\returns\form16_data_v3_0901_halfyearly filings.dta", clear
/*
. tab TaxPeriod

    The tax period for |
 which the returns has |
            been filed |      Freq.     Percent        Cum.
-----------------------+-----------------------------------
   First Halfyear-2010 |     50,742       25.08       25.08
   First Halfyear-2011 |     50,646       25.04       50.12
   First Halfyear-2012 |         85        0.04       50.16
  Second Halfyear-2010 |     50,757       25.09       75.25
  Second Halfyear-2011 |     50,051       24.74      100.00
  Second Halfyear-2012 |          6        0.00      100.00
-----------------------+-----------------------------------
                 Total |    202,287      100.00

. 

*/

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

save "PreliminaryAnalysis\returns\form16_data_v3_0901_halfyearly filings.dta", replace

collapse (sum) TurnoverGross TurnoverCentral TurnoverLocal TotalOutputTax PurchaseUnregisteredDealer NetTax PurchaseIneligibleForITC TotalTaxCredit InterStateSaleCD InterStatePurchaseCD, by(year) fast
gen SourceFile="Half Yearly Returns"

//We create a table for quarterly return filings
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
keep if TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Third Quarter-2012"|TaxPeriod=="Third Quarter-2014"|TaxPeriod=="Third Quarter-2013"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="First Quarter-2012"|TaxPeriod=="First Quarter-2014"|TaxPeriod=="First Quarter-2013"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Second Quarter-2014"|TaxPeriod=="Second Quarter-2013"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"|TaxPeriod=="Fourth Quarter-2012"|TaxPeriod=="Fourth Quarter-2014"|TaxPeriod=="Fourth Quarter-2013"
tab TaxPeriod
save "PreliminaryAnalysis\returns\form16_data_v3_0901_quarterly filings.dta"


/*
tab TaxPeriod

The tax period for	
which the returns has	
been filed	Freq.	Percent	Cum.
	
First Quarter-2010	88,256	2.46	2.46
First Quarter-2011	98,436	2.75	5.21
First Quarter-2012	186,899	5.21	10.42
First Quarter-2013	239,989	6.70	17.12
First Quarter-2014	244,008	6.81	23.93
Fourth Quarter-2010	98,841	2.76	26.68
Fourth Quarter-2011	110,201	3.07	29.76
Fourth Quarter-2012	223,236	6.23	35.99
Fourth Quarter-2013	241,185	6.73	42.72
Fourth Quarter-2014	255,065	7.12	49.83
Second Quarter-2010	91,852	2.56	52.40
Second Quarter-2011	102,604	2.86	55.26
Second Quarter-2012	201,341	5.62	60.88
Second Quarter-2013	242,098	6.75	67.63
Second Quarter-2014	247,815	6.91	74.55
Third Quarter-2010	95,109	2.65	77.20
Third Quarter-2011	106,799	2.98	80.18
Third Quarter-2012	213,651	5.96	86.14
Third Quarter-2013	244,032	6.81	92.95
Third Quarter-2014	252,733	7.05	100.00
			
Total	3,584,150	100.00

*/

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

save "PreliminaryAnalysis\returns\form16_data_v3_0901_quarterly filings.dta", replace


//We create a table for monthly return filings
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
drop if TaxPeriod=="Annual-2010"|TaxPeriod=="Annual-2011"|TaxPeriod=="Annual-2012"
drop if TaxPeriod=="Third Quarter-2010"|TaxPeriod=="Third Quarter-2011"|TaxPeriod=="Third Quarter-2012"|TaxPeriod=="Third Quarter-2014"|TaxPeriod=="Third Quarter-2013"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="First Quarter-2012"|TaxPeriod=="First Quarter-2014"|TaxPeriod=="First Quarter-2013"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Second Quarter-2014"|TaxPeriod=="Second Quarter-2013"|TaxPeriod=="Fourth Quarter-2010"|TaxPeriod=="Fourth Quarter-2011"|TaxPeriod=="Fourth Quarter-2012"|TaxPeriod=="Fourth Quarter-2014"|TaxPeriod=="Fourth Quarter-2013"
drop if TaxPeriod=="Second Halfyear-2012"|TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="First Halfyear-2012"|TaxPeriod=="First Halfyear-2011"|TaxPeriod=="First Halfyear-2010"
save "PreliminaryAnalysis\returns\form16_data_v3_0901_monthly filings.dta"

/*
tab TaxPeriod

    The tax period for |
 which the returns has |
            been filed |      Freq.     Percent        Cum.
-----------------------+-----------------------------------
              Apr-2010 |     12,931        2.43        2.43
              Apr-2011 |     14,591        2.74        5.18
              Apr-2012 |     17,273        3.25        8.43
              Apr-2013 |      1,162        0.22        8.65
              Aug-2010 |     12,863        2.42       11.07
              Aug-2011 |     14,428        2.71       13.78
              Aug-2012 |     16,990        3.20       16.98
              Dec-2010 |     12,753        2.40       19.37
              Dec-2011 |     14,334        2.70       22.07
              Dec-2012 |     16,851        3.17       25.24
              Feb-2011 |     12,695        2.39       27.63
              Feb-2012 |     14,280        2.69       30.32
              Feb-2013 |     16,736        3.15       33.46
              Jan-2011 |     12,740        2.40       35.86
              Jan-2012 |     14,328        2.70       38.56
              Jan-2013 |     16,797        3.16       41.72
              Jul-2010 |     12,885        2.42       44.14
              Jul-2011 |     14,481        2.72       46.86
              Jul-2012 |     17,032        3.20       50.07
              Jun-2010 |     12,922        2.43       52.50
              Jun-2011 |     14,540        2.74       55.23
              Jun-2012 |     17,179        3.23       58.47
              Mar-2011 |     12,704        2.39       60.86
              Mar-2012 |     14,256        2.68       63.54
              Mar-2013 |     16,702        3.14       66.68
              May-2010 |     12,907        2.43       69.11
              May-2011 |     14,564        2.74       71.85
              May-2012 |     17,204        3.24       75.08
              May-2013 |          8        0.00       75.09
              Nov-2010 |     12,788        2.41       77.49
              Nov-2011 |     14,368        2.70       80.19
              Nov-2012 |     16,886        3.18       83.37
              Oct-2010 |     12,832        2.41       85.78
              Oct-2011 |     14,382        2.71       88.49
              Oct-2012 |     16,920        3.18       91.67
              Sep-2010 |     12,845        2.42       94.09
              Sep-2011 |     14,437        2.72       96.80
              Sep-2012 |     16,984        3.20      100.00
-----------------------+-----------------------------------
                 Total |    531,578      100.00
	
*/
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

save "PreliminaryAnalysis\returns\form16_data_v3_0901_monthly filings.dta", replace
