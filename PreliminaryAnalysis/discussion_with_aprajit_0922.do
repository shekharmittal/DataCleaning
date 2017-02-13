//Q1 Can we identify if the registration is manual or not?
//Ans: No. I could not find any variable in dealer profile which would do that.

use "D:\data\DealerProfile.dta", clear
codebook StatusManualRegistration
tab VatoActionDate
tab RegistrationType
tab NewStatus
codebook ExpectedTurnover
codebook TurnoverPreviousYear

log using "D:\data\logs_for_aprajit_0922.smcl"
tab AnnualTurnoverCategory
tab GTONil201213
tab StatusManualRegistration
codebook ExpectedTurnover
codebook TurnoverPreviousYear
log off

//Q2 How many traders report number of commodities for each quarter? Pick a particular quarter.
//So I chose Third Quarter 2013

use "D:\data\TableCommodityCode.dta", clear
drop if id==""
merge m:1 id DealerTIN using "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", keepusing(TaxPeriod PeriodBegin PeriodEnd TurnoverGross)

/*
merge m:1 id DealerTIN using "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0
> 901.dta", keepusing(TaxPeriod PeriodBegin PeriodEnd TurnoverGross)

Result                           # of obs.
-----------------------------------------
not matched                     5,523,801
from master                 3,036,057  (_merge==1)
from using                  2,487,744  (_merge==2)

matched                         4,615,832  (_merge==3)
-----------------------------------------


tab TaxPeriod if _merge==2

The tax period for 
which the returns has 
been filed       Freq.	Percent	Cum.
		
Annual-2010      26,223	1.05	1.05
Annual-2011      25,507	1.03	2.08
Annual-2012         405	0.02	2.10
Apr-2010      12,931	0.52	2.62
Apr-2011      14,591	0.59	3.20
Apr-2012      17,273	0.69	3.90
Apr-2013       1,162	0.05	3.94
Aug-2010      12,863	0.52	4.46
Aug-2011      14,428	0.58	5.04
Aug-2012      16,990	0.68	5.72
Dec-2010      12,753	0.51	6.24
Dec-2011      14,334	0.58	6.81
Dec-2012      16,851	0.68	7.49
Feb-2011      12,695	0.51	8.00
Feb-2012      14,280	0.57	8.57
Feb-2013      16,736	0.67	9.25
First Halfyear-2010      50,742	2.04	11.29
First Halfyear-2011      50,646	2.04	13.32
First Halfyear-2012          85	0.00	13.33
First Quarter-2010      88,256	3.55	16.87
First Quarter-2011      98,436	3.96	20.83
First Quarter-2012     186,899	7.51	28.34
First Quarter-2013       7,244	0.29	28.63
First Quarter-2014       7,766	0.31	28.95
Fourth Quarter-2010      98,841	3.97	32.92
Fourth Quarter-2011     110,201	4.43	37.35
Fourth Quarter-2012     223,234	8.97	46.32
Fourth Quarter-2013       9,114	0.37	46.69
Fourth Quarter-2014       8,825	0.35	47.04
Jan-2011      12,740	0.51	47.56
Jan-2012      14,328	0.58	48.13
Jan-2013      16,797	0.68	48.81
Jul-2010      12,885	0.52	49.32
Jul-2011      14,481	0.58	49.91
Jul-2012      17,032	0.68	50.59
Jun-2010      12,922	0.52	51.11
Jun-2011      14,540	0.58	51.69
Jun-2012      17,179	0.69	52.39
Mar-2011      12,704	0.51	52.90
Mar-2012      14,256	0.57	53.47
Mar-2013      16,702	0.67	54.14
May-2010      12,907	0.52	54.66
May-2011      14,564	0.59	55.24
May-2012      17,204	0.69	55.94
May-2013           8	0.00	55.94
Nov-2010      12,788	0.51	56.45
Nov-2011      14,368	0.58	57.03
Nov-2012      16,886	0.68	57.71
Oct-2010      12,832	0.52	58.22
Oct-2011      14,382	0.58	58.80
Oct-2012      16,920	0.68	59.48
Second Halfyear-2010      50,757	2.04	61.52
Second Halfyear-2011      50,051	2.01	63.53
Second Halfyear-2012           6	0.00	63.53
Second Quarter-2010      91,852	3.69	67.23
Second Quarter-2011     102,604	4.12	71.35
Second Quarter-2012     201,340	8.09	79.44
Second Quarter-2013      22,637	0.91	80.35
Second Quarter-2014       8,543	0.34	80.70
Sep-2010      12,845	0.52	81.21
Sep-2011      14,437	0.58	81.79
Sep-2012      16,984	0.68	82.48
Third Quarter-2010      95,109	3.82	86.30
Third Quarter-2011     106,799	4.29	90.59
Third Quarter-2012     213,651	8.59	99.18
Third Quarter-2013      11,448	0.46	99.64
Third Quarter-2014       8,945	0.36	100.00
		
Total   2,487,744	100.00

. tab TaxPeriod if _merge==3

The tax period for 
which the returns has 
been filed       Freq.	Percent	Cum.
		
First Quarter-2013     313,952	6.80	6.80
First Quarter-2014     615,341	13.33	20.13
Fourth Quarter-2012           3	0.00	20.13
Fourth Quarter-2013     599,150	12.98	33.11
Fourth Quarter-2014     650,049	14.08	47.20
Second Quarter-2012           1	0.00	47.20
Second Quarter-2013     566,316	12.27	59.47
Second Quarter-2014     626,559	13.57	73.04
Third Quarter-2013     603,939	13.08	86.12
Third Quarter-2014     640,522	13.88	100.00
		
Total   4,615,832	100.00


************************************************
if we use non unique returns to merge with commodity code
*************************************************
 merge m:1 id DealerTIN using "D:\data\form16_data_v4_0922.dta", keepusing(TaxPerio
> d PeriodBegin PeriodEnd TurnoverGross)

    Result                           # of obs.
    -----------------------------------------
    not matched                     4,247,417
        from master                 1,228,658  (_merge==1)
        from using                  3,018,759  (_merge==2)

    matched                         6,428,752  (_merge==3)
    -----------------------------------------

*/

log on
* On merging commodity codes with unique return files
tab _merge
* Now doing average commodities for a dealer in a specific quarter
* We use third quarter 2013
keep if TaxPeriod=="Third Quarter-2013"
tab _merge
keep if _merge==3

gsort DealerTIN CommodityCode
by DealerTIN CommodityCode: gen ReturnCount=_n
tab ReturnCount
keep if ReturnCount==1
drop ReturnCount

by DealerTIN: egen TotalCount=sum(dummy)
by DealerTIN: gen CommodityCount=_n
tab CommodityCount
keep if CommodityCount==1
tab TotalCount

/*

. tab TotalCount

 TotalCount |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    176,138       75.73       75.73
          2 |     42,486       18.27       94.00
          3 |     10,863        4.67       98.67
          4 |      2,059        0.89       99.55
          5 |        652        0.28       99.83
          6 |        224        0.10       99.93
          7 |         62        0.03       99.96
          8 |         36        0.02       99.97
          9 |         18        0.01       99.98
         10 |          5        0.00       99.98
         11 |          9        0.00       99.99
         12 |          8        0.00       99.99
         13 |          7        0.00       99.99
         14 |          3        0.00       99.99
         15 |          3        0.00      100.00
         16 |          2        0.00      100.00
         17 |          1        0.00      100.00
         18 |          3        0.00      100.00
         19 |          1        0.00      100.00
         20 |          1        0.00      100.00
         21 |          1        0.00      100.00
         24 |          1        0.00      100.00
         35 |          1        0.00      100.00
------------+-----------------------------------
      Total |    232,584      100.00
*/

//Q3 How many dealers with Zero Turnover?
use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
keep if TaxPeriod=="Third Quarter-2013"
gen ZeroTurnover=0
replace ZeroTurnover=1 if TurnoverGross==0

/*
. tab ZeroTurnover

ZeroTurnove |
          r |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    200,618       82.21       82.21
          1 |     43,414       17.79      100.00
------------+-----------------------------------
      Total |    244,032      100.00
*/
. sum TurnoverGross
/*
    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
TurnoverGr~s |    244032    1.07e+07    1.61e+08   -4165890   4.35e+10
*/

. codebook TurnoverGross
/*
------------------------------------------------------------------------------------
TurnoverGross                                                            (unlabeled)
------------------------------------------------------------------------------------

                  type:  numeric (double)

                 range:  [-4165890,4.352e+10]         units:  1
         unique values:  184022                   missing .:  0/244032

                  mean:   1.1e+07
              std. dev:   1.6e+08

           percentiles:        10%       25%       50%       75%       90%
                                 0   85355.5    676299   2.8e+06   1.1e+07

*/

 use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
(This file has unique returns for every tin, we saved only the latest id for a gi)

. keep if TaxPeriod=="First Quarter-2013"
(4130161 observations deleted)

. tab TaxPeriod
/*
    The tax period for |
 which the returns has |
            been filed |      Freq.     Percent        Cum.
-----------------------+-----------------------------------
    First Quarter-2013 |    239,989      100.00      100.00
-----------------------+-----------------------------------
                 Total |    239,989      100.00
*/
. gen ZeroTurnover=0

. replace ZeroTurnover=1 if TurnoverGross==0
(45806 real changes made)

. tab ZeroTurnover
/*
ZeroTurnove |
          r |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    194,183       80.91       80.91
          1 |     45,806       19.09      100.00
------------+-----------------------------------
      Total |    239,989      100.00
*/

. sum TurnoverGross
/*
    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
TurnoverGr~s |    239989    1.09e+07    2.18e+08   -1659600   4.84e+10

. codebook TurnoverGross

------------------------------------------------------------------------------------
TurnoverGross                                                            (unlabeled)
------------------------------------------------------------------------------------

                  type:  numeric (double)

                 range:  [-1659600,4.838e+10]         units:  1
         unique values:  178352                   missing .:  0/239989

                  mean:   1.1e+07
              std. dev:   2.2e+08

           percentiles:        10%       25%       50%       75%       90%
                                 0     64944    602580   2.5e+06   9.8e+06

*/

. keep if TaxPeriod=="First Quarter-2014"
(4126142 observations deleted)

. gen ZeroTurnover=0

. replace ZeroTurnover=1 if TurnoverGross==0
(44199 real changes made)

. tab ZeroTurnover

ZeroTurnove |
          r |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    199,809       81.89       81.89
          1 |     44,199       18.11      100.00
------------+-----------------------------------
      Total |    244,008      100.00

. sum TurnoverGross

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
TurnoverGr~s |    244008    1.10e+07    1.87e+08      -8145   4.23e+10

. codebook TurnoverGross

------------------------------------------------------------------------------------
TurnoverGross                                                            (unlabeled)
------------------------------------------------------------------------------------

                  type:  numeric (double)

                 range:  [-8145,4.231e+10]            units:  1
         unique values:  182422                   missing .:  0/244008

                  mean:   1.1e+07
              std. dev:   1.9e+08

           percentiles:        10%       25%       50%       75%       90%
                                 0     76000    641821   2.7e+06   1.1e+07

. 
//Q4 How many dealers with Zero Amount deposited?
 keep if TaxPeriod=="Third Quarter-2013"
(4126118 observations deleted)

. gen ZeroAmount=0

. replace ZeroAmount=1 if AmountDepositedByDealer==0
(166202 real changes made)

tab ZeroAmount
sum AmountDepositedByDealer
codebook AmountDepositedByDealer


/*
 ZeroAmount |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     77,830       31.89       31.89
          1 |    166,202       68.11      100.00
------------+-----------------------------------
      Total |    244,032      100.00

	  
	  
. sum AmountDepositedByDealer

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
AmountDepo~r |    244032    157090.9    1.14e+07          0   5.00e+09

. codebook AmountDepositedByDealer

------------------------------------------------------------------------------------
AmountDepositedByDealer                R7.8 Amount Deposited by the Dealer (attach
                                       proof of payment) T312067
------------------------------------------------------------------------------------

                  type:  numeric (double)

                 range:  [0,5.002e+09]                units:  1
         unique values:  43341                    missing .:  0/244032

                  mean:    157091
              std. dev:   1.1e+07

           percentiles:        10%       25%       50%       75%       90%
                                 0         0         0    3022.5     42122

*/

restore
preserve
keep if TaxPeriod=="First Quarter-2013"
gen ZeroAmount=0
replace ZeroAmount=1 if AmountDepositedByDealer==0
tab ZeroAmount
codebook AmountDepositedByDealer

/*
. replace ZeroAmount=1 if AmountDepositedByDealer==0
(161120 real changes made)

. 
. tab ZeroAmount

 ZeroAmount |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     78,869       32.86       32.86
          1 |    161,120       67.14      100.00
------------+-----------------------------------
      Total |    239,989      100.00

. 
. codebook AmountDepositedByDealer

------------------------------------------------------------------------------------
AmountDepositedByDealer                R7.8 Amount Deposited by the Dealer (attach
                                       proof of payment) T312067
------------------------------------------------------------------------------------

                  type:  numeric (double)

                 range:  [0,4.479e+09]                units:  1
         unique values:  43155                    missing .:  0/239989

                  mean:    150593
              std. dev:   1.0e+07

           percentiles:        10%       25%       50%       75%       90%
                                 0         0         0      3274     39847

. 
*/
 

keep if TaxPeriod=="First Quarter-2014"
gen ZeroAmount=0
replace ZeroAmount=1 if AmountDepositedByDealer==0
tab ZeroAmount
codebook AmountDepositedByDealer

/*
 keep if TaxPeriod=="First Quarter-2014"
(4126142 observations deleted)

. gen ZeroAmount=0

. 
. replace ZeroAmount=1 if AmountDepositedByDealer==0
(150345 real changes made)

. 
. tab ZeroAmount

 ZeroAmount |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     93,663       38.39       38.39
          1 |    150,345       61.61      100.00
------------+-----------------------------------
      Total |    244,008      100.00

. 
. codebook AmountDepositedByDealer

------------------------------------------------------------------------------------
AmountDepositedByDealer                R7.8 Amount Deposited by the Dealer (attach
                                       proof of payment) T312067
------------------------------------------------------------------------------------

                  type:  numeric (double)

                 range:  [0,5.065e+09]                units:  1
         unique values:  47115                    missing .:  0/244008

                  mean:    162067
              std. dev:   1.1e+07

           percentiles:        10%       25%       50%       75%       90%
                                 0         0         0    5830.5     48850

. 
*/

gen Negative=0
replace Negative=1 if NetTax<0
tab Negative
tab Negative ZeroAmount

/*
 replace Negative=1 if NetTax<0
(97662 real changes made)

. tab Negative

   Negative |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    146,346       59.98       59.98
          1 |     97,662       40.02      100.00
------------+-----------------------------------
      Total |    244,008      100.00

. tab Negative ZeroAmount

           |      ZeroAmount
  Negative |         0          1 |     Total
-----------+----------------------+----------
         0 |    84,978     61,368 |   146,346 
         1 |     8,685     88,977 |    97,662 
-----------+----------------------+----------
     Total |    93,663    150,345 |   244,008 
*/


//Q5 Top reasons for cancellation during the drive
use "D:\data\CancellationForm.dta" 

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
format %ty Year
format %td CancellationYear
tab year, missing
format %tm Month
tab Reasons if Cancellation==48


/*
. tab Reasons if CancellationMonth==48, sort

            Reasons T616006 varchar max |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                  Non filing of returns |     46,672       49.85       49.85
Whereas on the basis of information w.. |     45,760       48.88       98.73
                    Not filling return. |        267        0.29       99.02
         NOT FILING RETURNS SINCE 2005. |        164        0.18       99.19
You are not filed return & return def.. |         58        0.06       99.25
               NO RETURNS SINCE 2005-06 |         56        0.06       99.31
As per VATI report firm was found not.. |         55        0.06       99.37
THE DEALER IS RETURN DEFAULTER FOR TH.. |         52        0.06       99.43
             Filling return of Nil GTO. |         28        0.03       99.46
The prop./Director was not available .. |         26        0.03       99.48
       return defaulter 1st Qtr 2013-14 |         24        0.03       99.51
DEALER HAS NOT FILED RETURN SINCE 200.. |         21        0.02       99.53
                  NO RETURNS SINCE 2005 |         21        0.02       99.55
DEALER HAS NOT FILED SINCE 2005-06 TI.. |         19        0.02       99.57
You are not filed return & return def.. |         15        0.02       99.59
                  NO RETURN SINCE 2005. |         13        0.01       99.60
               NO RETURNS SINCE 2011-12 |         11        0.01       99.62
               NO RETURN SICEN 2005-06. |          9        0.01       99.63
The firm was not found functioning at.. |          9        0.01       99.64
AT THE TIME OF VISIT NO SUCH FIRM EXI.. |          8        0.01       99.64
                   NO RETURN SINCE 2005 |          7        0.01       99.65
       NOT FILING RETURNS SINCE 2006-07 |          7        0.01       99.66
       NOT FILING RETURNS SINCE 2011-12 |          7        0.01       99.67
You are not filed Return & Return def.. |          7        0.01       99.67
AS PER VATI REPORT THE FIRM WAS NOT F.. |          6        0.01       99.68
               NO RETURNS SINCE 2006-07 |          6        0.01       99.69
       NOT FILING RETURNS SINCE 2010-11 |          6        0.01       99.69
As per VATI report dealer not  starte.. |          5        0.01       99.70
FOR NOT FILING OF FIRST QUARTER RETUR.. |          5        0.01       99.70
THE DEALER HAS NOT FILED RETURN SINCE.. |          5        0.01       99.71
AS PER VATI REPORT FIRM NOT FUNCTIONI.. |          4        0.00       99.71
As per VATI report dealer not start h.. |          4        0.00       99.72
DEALER HAS NOT FILED SINCE 2010-11 TI.. |          4        0.00       99.72
               NO RETURNS SINCE 2010-11 |          4        0.00       99.73
PENALTY ORDER RETURN REMARKS WITH NO .. |          4        0.00       99.73
        Return not filed since 2005-06. |          4        0.00       99.74
THE DEALER HAS NOT FILED RETURN SINCE.. |          4        0.00       99.74
The book of accounts were not produce.. |          4        0.00       99.74
AS PER VATI REPORT FIRM WAS NOT FUNCT.. |          3        0.00       99.75
As per VATI report the firm was not f.. |          3        0.00       99.75
DEALER HAS NOT FILED SINCE 2011-12 TI.. |          3        0.00       99.75
                             NO RETURNS |          3        0.00       99.76
               NO RETURNS SINCE 2007-08 |          3        0.00       99.76
               NO RETURNS SINCE 2008-09 |          3        0.00       99.76
       NOT FILING RETURNS SINCE 2007-08 |          3        0.00       99.77
       NOT FILING RETURNS SINCE 2008-09 |          3        0.00       99.77
        No business activity was found. |          3        0.00       99.77
AS PER VATI REPORT FIRM WAS NOT FUNCT.. |          2        0.00       99.77
AT THE TIME OF VATI VISIT THE FIRM FO.. |          2        0.00       99.78
AT THE TIME OF VATI VISIT THE FIRM FO.. |          2        0.00       99.78
AT THE TIME OF VATI VISIT THE FIRM IS.. |          2        0.00       99.78
As per VATI report  firm was not trac.. |          2        0.00       99.78
As per VATI report dealer has not pri.. |          2        0.00       99.79
As per VATI report dealer not start h.. |          2        0.00       99.79
As per VATI report no such address fo.. |          2        0.00       99.79
At the time of visit, no such firm ex.. |          2        0.00       99.79
Dealer has not found functioning at g.. |          2        0.00       99.79
It is a fraudulent firm and No busine.. |          2        0.00       99.80
                              NO RETURN |          2        0.00       99.80
                NO RETURN SINCE 2011-12 |          2        0.00       99.80
                       NO RETURNS SINCE |          2        0.00       99.80
NO SUCH FIRM EXISTS AT THE GIVEN ADDR.. |          2        0.00       99.80
NO SUCH FIRM EXITS AT THE GIVEN ADDRE.. |          2        0.00       99.81
          NOT FILING RETURNS SINCE 2005 |          2        0.00       99.81
       NOT FILING RETURNS SINCE 2009-10 |          2        0.00       99.81
RETURN OF 1ST QUARTER OF 2013-14 NOT .. |          2        0.00       99.81
                      Return Defaulter. |          2        0.00       99.82
THE DEALER HAS FILED NIL RETURN SINCE.. |          2        0.00       99.82
You are not filed return & return def.. |          2        0.00       99.82
     the firm was not found functioning |          2        0.00       99.82
1. Non existant firm as per report of.. |          1        0.00       99.82
ADVERSE VATI REPORT.  NO SUCH FIRM CO.. |          1        0.00       99.82
                ALREADY BEEN CANCELLED. |          1        0.00       99.82
      AS PER AUDIT REPORT OF VAT AUDIT. |          1        0.00       99.83
AS PER VATI REPORT DATED ON 18/12/201.. |          1        0.00       99.83
AS PER VATI REPORT DEALER HAS NOT INT.. |          1        0.00       99.83
AS PER VATI REPORT FIRM WAS NOT FUNCT.. |          1        0.00       99.83
AS PER VATI REPORT FIRM WAS NOT FUNCT.. |          1        0.00       99.83
AS PER VATI REPORT NO SUCH OFFICE PRE.. |          1        0.00       99.83
AT THE TIME OF VATI VISIT THE FIRM  F.. |          1        0.00       99.83
AT THE TIME OF VATI VISIT THE FIRM IS.. |          1        0.00       99.83
AT THE TIME OF VISIT PROP. HAS NOT PR.. |          1        0.00       99.83
                  Address not traceble. |          1        0.00       99.84
All the partners want to close their .. |          1        0.00       99.84
As per VAT Inspector, construction wa.. |          1        0.00       99.84
As per VATI Report, the dealer has no.. |          1        0.00       99.84
As per VATI Report, undersigned visit.. |          1        0.00       99.84
As per VATI report dated 21-01-2013,N.. |          1        0.00       99.84
As per VATI report dealer is not inte.. |          1        0.00       99.84
As per VATI report dealer is not inte.. |          1        0.00       99.84
As per VATI report dealer is not inte.. |          1        0.00       99.84
As per VATI report dealer not start h.. |          1        0.00       99.85
As per VATI report it is found that s.. |          1        0.00       99.85
As per VATI report no sale bill print.. |          1        0.00       99.85
As per VATI report no such firm was f.. |          1        0.00       99.85
As per VATI report proof of residence.. |          1        0.00       99.85
As per VATI report said firm was not .. |          1        0.00       99.85
As per VATI report the firm was found.. |          1        0.00       99.85
As per VATI report, it is a resi of p.. |          1        0.00       99.85
As per VATI report, no record produce.. |          1        0.00       99.85
As per VATI report, no record produce.. |          1        0.00       99.85
As per VATI report, no record produce.. |          1        0.00       99.86
As per VATI report, no record produce.. |          1        0.00       99.86
As per VATI report, no record produce.. |          1        0.00       99.86
As per VATI report, no record produce.. |          1        0.00       99.86
As per VATI report, no record produce.. |          1        0.00       99.86
As per VATI report, no record produce.. |          1        0.00       99.86
As per VATI report, no record produce.. |          1        0.00       99.86
As per VATI visit report on dated 17-.. |          1        0.00       99.86
As per Vati report dated 17-10-2012,T.. |          1        0.00       99.86
As per vati report this was not funct.. |          1        0.00       99.87
At the time of visit, no such firm ex.. |          1        0.00       99.87
DEALER HAS NOT FILED RETURN FROM THE .. |          1        0.00       99.87
DEALER HAS NOT FILED RETURN FROM THE .. |          1        0.00       99.87
DEALER HAS NOT FILED RETURN SINCE 200.. |          1        0.00       99.87
DEALER HAS NOT FILED RETURN SINCE 200.. |          1        0.00       99.87
DEALER HAS NOT FILED RETURN SINCE 201.. |          1        0.00       99.87
DEALER HAS NOT FILED RETURN SINCE 201.. |          1        0.00       99.87
DEALER HAS NOT FILED RETURN SINCE THE.. |          1        0.00       99.87
DEALER HAS NOT FILED SINCE 2008-09 TI.. |          1        0.00       99.88
DEALER HAS NOT FILED SINCE THE DATE O.. |          1        0.00       99.88
         DEALER NIL  RETURN F.Y 2013-14 |          1        0.00       99.88
                DEALER NOT RETURN FILED |          1        0.00       99.88
                                DVAT 09 |          1        0.00       99.88
Dealer has not filed DVAT-16 of perio.. |          1        0.00       99.88
Dealer has not filed monthly return f.. |          1        0.00       99.88
Dvat-10 issued after VATI varificatio.. |          1        0.00       99.88
FOR NOT FILING OF FIRST QUARTER RETUR.. |          1        0.00       99.88
FOR NOT FILING OF II, III & IV QUARTE.. |          1        0.00       99.88
FOR NOT FILING OF RETURN OF FIRST QUA.. |          1        0.00       99.89
FOR NOT FILING OF RETURN OF II, III A.. |          1        0.00       99.89
Few wrong entries were made while iss.. |          1        0.00       99.89
                Filling Nil GTO return. |          1        0.00       99.89
For not filing of first quarter retur.. |          1        0.00       99.89
For not filing return for 2012-13 ( I.. |          1        0.00       99.89
It is a resedential address,The premi.. |          1        0.00       99.89
    LATE RETURNS FILERS DVAT-10 ISSUED. |          1        0.00       99.89
                                NIL GTO |          1        0.00       99.89
NIL GTO IN 2012-13.`FOR NOT FILING OF.. |          1        0.00       99.90
      NIL RETURNS FILED DVAT-10 ISSUED. |          1        0.00       99.90
NO BUSINESS ACTIVITIES WERE SEEN REPO.. |          1        0.00       99.90
                NO RETURN SICEN 2008-09 |          1        0.00       99.90
               NO RETURN SICEN 2010-11. |          1        0.00       99.90
               NO RETURN SICEN 2011-12. |          1        0.00       99.90
NO RETURN SINCE 19-11-2007 DATE OF RE.. |          1        0.00       99.90
               NO RETURN SINCE 2005-06. |          1        0.00       99.90
               NO RETURN SINCE 2011-12. |          1        0.00       99.90
NO RETURN SINCE 26-04-2012 (DATE OF R.. |          1        0.00       99.90
NO RETURN SINCE THE DATE OF REGISTRAI.. |          1        0.00       99.91
NO RETURN SINCE THE DATE OF REGISTRAT.. |          1        0.00       99.91
               NO RETURNS SINCE 2009-10 |          1        0.00       99.91
              NO RETURNS SINCE 2011-12. |          1        0.00       99.91
               NO RETURNS SINCE 2012-13 |          1        0.00       99.91
                   NON FILING OF RETURN |          1        0.00       99.91
NOT FILING OF FIRST QUARTER RETURN FO.. |          1        0.00       99.91
NOT FILING RETURN SINCE 2012-13 TILL .. |          1        0.00       99.91
       NOT FILING RETURNS SINCE 2005-06 |          1        0.00       99.91
          NOT FILING RETURNS SINCE 2006 |          1        0.00       99.92
      NOT FILING RETURNS SINCE 2006-07. |          1        0.00       99.92
           NOT FILNG RETURNS SINCE 2005 |          1        0.00       99.92
NOT FOUND FUNCTIONING . TEL;EPHINIC M.. |          1        0.00       99.92
         Nil tax paying dealer 3 years. |          1        0.00       99.92
No books of account were available an.. |          1        0.00       99.92
      No business activities was found. |          1        0.00       99.92
No business activities were noticed r.. |          1        0.00       99.92
No business activities were seen at t.. |          1        0.00       99.92
  No business activity could be traced. |          1        0.00       99.93
No business activity could be traced... |          1        0.00       99.93
No business activity could be traced... |          1        0.00       99.93
        No business activity was found, |          1        0.00       99.93
No business activity was found, NO bo.. |          1        0.00       99.93
 No such co. exist at the said address. |          1        0.00       99.93
No such firm exist on the given addre.. |          1        0.00       99.93
No such firm was found functioning at.. |          1        0.00       99.93
                     Non Filling Return |          1        0.00       99.93
                                     OK |          1        0.00       99.93
ON A VISIT BY VATI , NO SUCH FIRM FOU.. |          1        0.00       99.94
On both visits the premises were foun.. |          1        0.00       99.94
PENALTY ORDER RETURN REMARKS WITH NO .. |          1        0.00       99.94
Penalty order returned remarks with N.. |          1        0.00       99.94
          Premises could not be traced. |          1        0.00       99.94
             Premises was found locked. |          1        0.00       99.94
R.C Issued against Ref.R21192413 inst.. |          1        0.00       99.94
    RETURN DEFAULTER FOR 1st QTR2013-14 |          1        0.00       99.94
   RETURN DEFAULTER FOR IST QTR 2012-13 |          1        0.00       99.94
RETURN DEFAULTER IN 1ST QUARTER 2012-13 |          1        0.00       99.95
      RETURN DEFAULTER Ist Qtr 2013-14. |          1        0.00       99.95
                   RETURN IS NOT FILLED |          1        0.00       99.95
       Return Defaulter 1st Qtr 2013-14 |          1        0.00       99.95
Sign board was not displayed and not .. |          1        0.00       99.95
THE DEALER HAS FILED NILL RETURN SINC.. |          1        0.00       99.95
THE DEALER HAS NOT FILED RETURN FROM .. |          1        0.00       99.95
THE DEALER HAS NOT FILED RETURN SINCE.. |          1        0.00       99.95
THE DEALER HAS NOT FILED RETURN SINCE.. |          1        0.00       99.95
THE DEALER HAS NOT FILED RETURN SINCE.. |          1        0.00       99.96
THE DEALER HAS NOT FILED RETURN SINCE.. |          1        0.00       99.96
THE DEALER HAS NOT FILED RETURN SINCE.. |          1        0.00       99.96
THE DEALER HAS NOT FILED RETURN SINCE.. |          1        0.00       99.96
THE DEALER HAS NOT FILED RETURN SINCE.. |          1        0.00       99.96
THE DEALER HAS NOT FILED RETURN SINCE.. |          1        0.00       99.96
THE DEALER HAS NOT FILED RETURN SINCE.. |          1        0.00       99.96
THE DEALER HAS NOT FILED SINCE 01-04-.. |          1        0.00       99.96
THE DEALER HAS NOT FILED SINCE 2010-1.. |          1        0.00       99.96
THE DEALER HAS NOT PERTAIN OF THE JUR.. |          1        0.00       99.96
THE DEALER IS RETURN DEFAULTER FOR TH.. |          1        0.00       99.97
THE FIRM WAS NOT FUNCTIONING AT THE T.. |          1        0.00       99.97
                     TIN WRONGLY ISSUED |          1        0.00       99.97
   The Dealer has filed nil GTO 2012-13 |          1        0.00       99.97
The books of accounts were not produc.. |          1        0.00       99.97
The dealer is not filing return / Nil.. |          1        0.00       99.97
The dealer was not available at the l.. |          1        0.00       99.97
The firm is not functioning at the gi.. |          1        0.00       99.97
The firm is not functioning present a.. |          1        0.00       99.97
The firm was not found functioning at.. |          1        0.00       99.98
The firm was not found functioning at.. |          1        0.00       99.98
    The firm was not found functioning. |          1        0.00       99.98
The prop. was not available.No Busine.. |          1        0.00       99.98
The prop. were not available,No busin.. |          1        0.00       99.98
The prop. were not available.No busin.. |          1        0.00       99.98
                 VATI  ADVERSE  REPORT. |          1        0.00       99.98
VATI ENFORCEMENT -1 VIDE HIS REPORT D.. |          1        0.00       99.98
Vati (ENF- I branch ) visited the bus.. |          1        0.00       99.98
    WITNESS SIGNATURE ARE NOT AVAILABLE |          1        0.00       99.99
          business could not be started |          1        0.00       99.99
dealer is requested to submit the req.. |          1        0.00       99.99
     dealer return nil  filed till date |          1        0.00       99.99
       return defaulter 1st Qtr,2013-14 |          1        0.00       99.99
       return defaulter 1st qtr 2013-14 |          1        0.00       99.99
       return defaulter 1st qtr,2013-14 |          1        0.00       99.99
return defaulter 1st,2nd,3rd qtr 2011.. |          1        0.00       99.99
               return defaulter 2013-14 |          1        0.00       99.99
      return defaulter, 1st Qtr,2013-14 |          1        0.00       99.99
       return defaulter,1st Qtr 2013-14 |          1        0.00      100.00
        the delaer has not filed return |          1        0.00      100.00
the premises were found locked.the pr.. |          1        0.00      100.00
vati reported taht address is not cor.. |          1        0.00      100.00
                         wrongly issued |          1        0.00      100.00
----------------------------------------+-----------------------------------
                                  Total |     93,621      100.00

. 
*/
