/* Code cleaning and Verfication exercise
Step 1: Merge 2A-2B with returns
Step 2: Merge returns with commodity codes
Step 3: Merge returns with DP-1
Step 4: Merge commodity codes with DP-1
Step 5: What are the number of returns per Tin
*******************************************************************
Step 6: Try and see what are the unique id combinations in each file. Keep the log.
*******************************************************************
Step 7: Calculate unique tins in each file and compare with each other
Step 8: Check how many unique tin numbers are matching up with each other
Step 9 : Merge cancelled Dealers with returns data and dealer profiles
*/

*******************************************************************
********************STEP 6*****************************************
*******************************************************************

* Check for unique entries

/* Check for unique tin numbers in each file. Files to check are 
1. Dealer Commodity codes file for the returns
2. Returns file for the dealers
3. Dealer Profile Data
4. Commodity code data for dealer profiles
5. 2A 2B annexure
6. Audit Notice Data
7. Registration cancellation data
*/
**********************************************************************
*1. Dealer Commodity codes file for the returns
**********************************************************************
cd "D:\data"
use "TableCommodityCode.dta", clear

. isid id
/*
variable id should never be missing
r(459);
*/
. drop if id==""
(5521 observations deleted)


. isid id
//variable id does not uniquely identify the observations
//r(459);

. isid id DealerTIN
//variables id DealerTIN do not uniquely identify the observations
//r(459);

. isid id DealerTIN CommodityCode
//variables id DealerTIN CommodityCode should never be missing
//r(459);

. drop if CommodityCode==""
//(19 observations deleted)

. isid id DealerTIN CommodityCode
//variables id DealerTIN CommodityCode do not uniquely identify the observations
r(459);


**********************************************************************
* 2. Returns file for the dealers
**********************************************************************
. use "form16_data.dta", clear
. drop if id=="0"
/* 
. tab SourceFile

 SourceFile |      Freq.     Percent        Cum.
------------+-----------------------------------
F16T3121011 |    738,651       13.20       13.20
F16T3121112 |    806,676       14.42       27.62
F16T3121213 |  1,367,313       24.44       52.06
F16T3121314 |  1,457,166       26.04       78.10
F16T3121415 |  1,225,043       21.90      100.00
------------+-----------------------------------
      Total |  5,594,849      100.00

. isid id
variable id does not uniquely identify the observations
r(459);

. keep if SourceFile=="F16T3121415"
(4369802 observations deleted)

. isid id

. 
*/

preserve
keep if SourceFile=="F16T3121314"
drop if id=="0"
isid id
//Output says that it is unique

restore
drop if id=="0"

preserve
keep if SourceFile=="F16T3121213"
isid id
//Output says that it is unique
restore

preserve
keep if SourceFile=="F16T3121112"
isid id
//Output says that it is unique
restore

keep if SourceFile=="F16T3121011"
isid id
//Output says that it is unique

**********************************************************************************
*3. Dealer Profile Data
**********************************************************************
use "DealerProfile.dta", clear

. isid idDP


/*

. codebook idDP DealerTIN

-----------------------------------------------------------------------------------------
idDP                                                                    ID T501001 Bigint
-----------------------------------------------------------------------------------------

                  type:  string (str19), but longest is str8

         unique values:  544261                   missing "":  0/544261

              examples:  "21096246"
                         "21253381"
                         "21370920"
                         "21486175"

-----------------------------------------------------------------------------------------
DealerTIN                                               TIN No        T501005 Varchar 100
-----------------------------------------------------------------------------------------

                  type:  string (str25), but longest is str19

         unique values:  313521                   missing "":  69983/544261

              examples:  "140174"
                         "252750"
                         "364060"
                         "476050"

. 
*/
**********************************************************************************
*4. Commodity code data for dealer profiles
**********************************************************************************
use "TableCommodityCodeforDealerProfile.dta", clear


. codebook idDP DealerTIN

-----------------------------------------------------------------------------------------
idDP                                                                          (unlabeled)
-----------------------------------------------------------------------------------------

                  type:  string (str8)

         unique values:  119306                   missing "":  0/1031455

              examples:  "21391666"
                         "21427805"
                         "21491803"
                         "21536777"

-----------------------------------------------------------------------------------------
DealerTIN                                                                     (unlabeled)
-----------------------------------------------------------------------------------------

                  type:  string (str19)

         unique values:  110938                   missing "":  0/1031455

              examples:  "195887"
                         "291978"
                         "38711"
                         "485466"

. isid idDP DealerTIN
variables idDP DealerTIN do not uniquely identify the observations
r(459);

. isid idDP DealerTIN Commodity
Commodity ambiguous abbreviation
r(111);

. isid idDP DealerTIN CommodityCode
variables idDP DealerTIN CommodityCode should never be missing
r(459);

. drop if CommodityCode==""
(2 observations deleted)

. isid idDP DealerTIN CommodityCode
variables idDP DealerTIN CommodityCode do not uniquely identify the observations
r(459);

. gsort idDP DealerTIN CommodityCode

. by idDP DealerTIN CommodityCode: gen ReturnCount=_n

. drop ReturnCount

. by idDP DealerTIN: gen ReturnCount=_n

. keep if ReturnCount==1
(912078 observations deleted)

. isid idDP DealerTIN CommodityCode

. 
*/
**********************************************************************************
*6. Audit Notice Data
**********************************************************************************
 use "form37_data_auditnotice.dta", clear

. codebook DealerTIN

-----------------------------------------------------------------------------------------
DealerTIN                                                           TIN   T678001 varchar
-----------------------------------------------------------------------------------------

                  type:  string (str11)

         unique values:  12978                    missing "":  17/17327

              examples:  "195620"
                         "29265"
                         "389400"
                         "481916"

               warning:  variable has leading and trailing blanks

. codebook DateAudit

-----------------------------------------------------------------------------------------
DateAudit                                  Date_of_auditing with time    T678009 datetime
-----------------------------------------------------------------------------------------

                  type:  numeric (double)

                 range:  [6.139e+11,1.972e+12]        units:  10000
         unique values:  5081                     missing .:  163/17327

                  mean:   1.7e+12
              std. dev:   3.0e+10

           percentiles:        10%       25%       50%       75%       90%
                           1.7e+12   1.7e+12   1.7e+12   1.7e+12   1.7e+12

. gsort DealerTIN DateActualNotice

. br DealerTIN DateActualNotice DateOfAssignment DateAudit

.
**********************************************************************************
*7. Registration cancellation data
**********************************************************************************
. use "CancellationForm.dta", clear

. isid T616001

. 
