/* Code cleaning and Verfication exercise
Step 1: Merge 2A-2B with returns
Step 2: Merge returns with commodity codes
Step 3: Merge returns with DP-1
Step 4: Merge commodity codes with DP-1
Step 5: What are the number of returns per Tin
Step 6: Try and see what are the unique id combinations in each file. Keep the log.
*******************************************************************
Step 7: Calculate unique tins in each file and compare with each other
*******************************************************************
Step 8: Check how many unique tin numbers are matching up with each other
Step 9 : Merge cancelled Dealers with returns data and dealer profiles
*/

*******************************************************************
********************STEP 7*****************************************
*******************************************************************
/* Check for unique tin numbers in each file. Files to check are 
1. Dealer Commodity codes file for the returns
2. Returns file for the dealers
3. Dealer Profile Data
4. Commodity code data for dealer profiles
5. 2A 2B annexure
6. Audit Notice Data
7. Registration cancellation data
*/

cd "D:\data"

/* 1. Dealer Commodity codes file for the returns */ 
use "TableCommodityCode.dta", clear

gsort DealerTIN id
by DealerTIN: gen ReturnCount=_n
keep if ReturnCount==1

/*
codebook DealerTIN

					
DealerTIN					(unlabeled)
					

type:	string (str11)

unique values:	313154	missing	"":	0/313154

examples:	"198335"
	"296467"
	"394008"
	"492674"

*/

// 2. Returns file for the dealers
use "form16_data.dta", clear
gsort DealerTIN id
by DealerTIN: gen ReturnCount=_n
keep if ReturnCount==1

/*. codebook DealerTIN

-----------------------------------------------------------------------------------------
DealerTIN                                                                     (unlabeled)
-----------------------------------------------------------------------------------------

                  type:  string (str11)

         unique values:  336305                   missing "":  0/336305

              examples:  "194689"
                         "289930"
                         "383384"
                         "47888"

*/

//3. Dealer Profile Data

use "DealerProfile.dta", clear

gsort DealerTIN idDP
by DealerTIN: gen ReturnCount=_n
keep if ReturnCount==1


. drop if DealerTIN==""
//(69983 observations deleted)

. keep if ReturnCount==1
//(160757 observations deleted)

/*
. codebook DealerTIN
				
DealerTIN		TIN No	T501005	Varchar	100
					

type:  string (str25),	but	longest is str19

unique values:  313521		missing "":	0/313521

examples:  "198711"
"296725"
"393937"
"49243"

*/

//4. Commodity code data for dealer profiles
use "TableCommodityCodeforDealerProfile.dta", clear

gsort DealerTIN idDP
by DealerTIN: gen ReturnCount=_n
keep if ReturnCount==1

codebook DealerTIN

/* codebook DealerTIN

-----------------------------------------------------------------------------------------
DealerTIN                                                                     (unlabeled)
-----------------------------------------------------------------------------------------

                  type:  string (str19)

         unique values:  110938                   missing "":  0/110938

              examples:  "198118"
                         "295841"
                         "392625"
                         "490649"
*/
//5. 2A 2B annexure
// FILE 1

use "annexure_2A2B_monthly_201213.dta", clear

bys DealerTIN SourceFile: gen AnnexureCount=_n
keep if AnnexureCount==1

gen dummy=1
by DealerTIN:egen TotalCount=sum(dummy)
by DealerTIN: gen AnnexureCount=_n
keep if AnnexureCount==1

/*. codebook DealerTIN

				
DealerTIN		Tin number of the	current	dealer
				

type:	string (str11)

unique values:	223306	missing "":  0/223306

examples:	"197718"
	"294698"
	"390799"
	"486559"

tab TotalCount

TotalCount	Freq.	Percent	Cum.
			
1	9,506	4.26	4.26
2	7,957	3.56	7.82
3	15,393	6.89	14.71
4	6,688	2.99	17.71
5	6,306	2.82	20.53
6	9,718	4.35	24.88
7	6,782	3.04	27.92
8	7,206	3.23	31.15
9	11,397	5.10	36.25
10	10,468	4.69	40.94
11	17,880	8.01	48.95
12	114,005	51.05	100.00
			
Total	223,306	100.00

*/


// FILE 2
use "annexure_2A2B_quarterly_2013.dta", clear
bys DealerTIN SourceFile: gen AnnexureCount=_n
keep if AnnexureCount==1

gen dummy=1
drop AnnexureCount
by DealerTIN:egen TotalCount=sum(dummy)
by DealerTIN: gen AnnexureCount=_n
keep if AnnexureCount==1

/*tab TotalCount

TotalCount       Freq.	Percent	Cum.
		
1      19,952	8.25	8.25
2      17,570	7.27	15.52
3      20,943	8.66	24.19
4     183,267	75.81	100.00
		
Total     241,732	100.00

. codebook DealerTIN

					
DealerTIN			Tin number of the	current	dealer
					

type:	string (str11)

unique values:	241732		missing "":  0/241732

examples:	"198416"
	"296285"
	"393413"
	"491676"

. 
*/

//File 3

use "annexure_2A2B_quarterly_2014.dta", clear
bys DealerTIN SourceFile: gen AnnexureCount=_n
keep if AnnexureCount==1

gen dummy=1
drop AnnexureCount
by DealerTIN:egen TotalCount=sum(dummy)
by DealerTIN: gen AnnexureCount=_n
keep if AnnexureCount==1

/*
tab TotalCount

TotalCount       Freq.	Percent	Cum.
		
1      21,519	8.70	8.70
2      18,724	7.57	16.27
3      21,493	8.69	24.96
4     185,559	75.04	100.00
		
Total     247,295	100.00

. codebook DealerTIN

					
DealerTIN			Tin number of the	current	dealer
					

type:	string (str11)

unique values:	247294		missing "":  1/247295

examples:	"198702"
	"296552"
	"393655"
	"49156"

. 
*/

/*6. Audit Notice Data*/
use "form37_data_auditnotice.dta", clear
/*
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

. gsort DealerTIN

. gosrt DealerTIN DateActualNotice
unrecognized command:  gosrt
r(199);

. gsort DealerTIN DateActualNotice

. by DealerTIN: gen ReturnCount=_n

. tab ReturnCount

ReturnCount |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |     12,979       74.91       74.91
          2 |      2,904       16.76       91.67
          3 |      1,013        5.85       97.51
          4 |        218        1.26       98.77
          5 |         73        0.42       99.19
          6 |         36        0.21       99.40
          7 |         23        0.13       99.53
          8 |         13        0.08       99.61
          9 |         12        0.07       99.68
         10 |         10        0.06       99.73
         11 |         10        0.06       99.79
         12 |          9        0.05       99.84
         13 |          8        0.05       99.89
         14 |          7        0.04       99.93
         15 |          5        0.03       99.96
         16 |          3        0.02       99.98
         17 |          3        0.02       99.99
         18 |          1        0.01      100.00
------------+-----------------------------------
      Total |     17,327      100.00

. br DealerTIN ReturnCount DateActualNotice

*/

//7. Registration cancellation data

use "CancellationForm.dta", clear

/*
codebook T616002

-----------------------------------------------------------------------------------------
T616002                                                                       (unlabeled)
-----------------------------------------------------------------------------------------

                  type:  string (str11)

         unique values:  169044                   missing "":  58/278986

              examples:  "196215"
                         "294415"
                         "392209"
                         "489530"

*/
