/* Code cleaning and Verfication exercise
*******************************************************************
Step 1: Merge 2A-2B with returns
*******************************************************************
Step 2: Merge returns with commodity codes
Step 3: Merge returns with DP-1
Step 4: Merge commodity codes with DP-1
Step 5: What are the number of returns per Tin
Step 6: Try and see what are the unique id combinations in each file. Keep the log.
Step 7: Calculate unique tins in each file and compare with each other
Step 8: Check how many unique tin numbers are matching up with each other
Step 9 : Merge cancelled Dealers with returns data and dealer profiles
*/
*******************************************************************
********************STEP 1*****************************************
*******************************************************************
* Merge 2A-2B with returns
* Trying this exercise for quarter 1 of year 2014

* First we get returns for Q1 of 2014
cd "D:\data"

use "form16_data.dta", clear
keep if TaxPeriod=="First Quarter-2014"

gsort DealerTIN -id
//drop tin
/* Calculating number of times a dealer files returns per quarter*/
by DealerTIN: gen ReturnCount = _n
keep if ReturnCount==1
save "form16_uniquedata_q1_2014.dta"

// Now using 2A-2B data
use "annexure_2A2B_quarterly_2014.dta", clear

keep if SourceFile=="t9854114" //keeping only first quarter 2014 entries

gsort DealerTIN
/* Calculating number of times a dealer files returns per quarter*/
by DealerTIN: gen ReturnCount = _n
keep if ReturnCount==1

merge 1:1 DealerTIN using "DataVerification\step1\form16_uniquedata_q1_2014.dta", keepusing(id)

/*
Result                           # of obs.
-----------------------------------------
not matched                        45,919
from master                     7,578	(_merge==1)
from using                     38,341	(_merge==2)

matched                           205,667	(_merge==3)
-----------------------------------------

I did not delete duplicate TIN numbers in the annexure
. merge m:1 DealerTIN using "D:\data\form16_uniquedata_q1_2014.dta", keepusing(id)

    Result                           # of obs.
    -----------------------------------------
    not matched                       128,135
        from master                    89,794  (_merge==1)
        from using                     38,341  (_merge==2)

    matched                         5,923,474  (_merge==3)
    -----------------------------------------



*/
*******************************************************************
********************STEP 1.2*****************************************
*******************************************************************
/* Now if I convert the id to numeric and repeat the process, the results may change substantially*/
use "form16_data.dta", clear
keep if TaxPeriod=="First Quarter-2014"

destring id, replace
gsort DealerTIN -id
drop Tin
/* Calculating number of times a dealer files returns per quarter*/
by DealerTIN: gen ReturnCount = _n
keep if ReturnCount==1
save "DataVerification\step1\form16_uniquedata_q1_2014_v2_numericid.dta"

// Now using 2A-2B data
use "annexure_2A2B_quarterly_2014.dta", clear

keep if SourceFile=="t9854114" //keeping only first quarter 2014 entries

gsort DealerTIN
/* Calculating number of times a dealer files returns per quarter*/
by DealerTIN: gen ReturnCount = _n
keep if ReturnCount==1

merge 1:1 DealerTIN using "DataVerification\step1\form16_uniquedata_q1_2014_v2_numericid.dta", keepusing(id)

/* The results did not change at all!

    Result                           # of obs.
    -----------------------------------------
    not matched                        45,919
        from master                     7,578  (_merge==1)
        from using                     38,341  (_merge==2)

    matched                           205,667  (_merge==3)
    -----------------------------------------

.	merge m:1 DealerTIN using "D:\data\form16_uniquedata_q1_2014_v2_numericid.dta",	keepusing(id)

	Result                           # of obs.
	-----------------------------------------
	not matched                       128,135
	from master                    89,794  (_merge==1)
	from using                     38,341  (_merge==2)

	matched                         5,923,474  (_merge==3)
*/


*******************************************************************
********************STEP 1.3*****************************************
*******************************************************************
/* Now if I convert the id and Tin to numeric, do the results change?*/
use "form16_data.dta", clear
keep if TaxPeriod=="First Quarter-2014"

destring id, replace
destring DealerTIN, replace
gsort DealerTIN -id

/* Calculating number of times a dealer files returns per quarter*/
by DealerTIN: gen ReturnCount = _n
keep if ReturnCount==1
save "DataVerification\step1\form16_uniquedata_q1_2014_v2_numericidandtin.dta"

// Now using 2A-2B data
use "annexure_2A2B_quarterly_2014.dta", clear

keep if SourceFile=="t9854114" //keeping only first quarter 2014 entries
destring DealerTIN, replace

bys DealerTIN: gen ReturnCount = _n
keep if ReturnCount==1

merge 1:1 DealerTIN using "DataVerification\step1\form16_uniquedata_q1_2014_v2_numericidandtin.dta", keepusing(id)

/* The results got progressively worse
Result                           # of obs.
-----------------------------------------
not matched                       136,580
from master                     6,760	(_merge==1)
from using                    129,820	(_merge==2)

matched                           206,485	(_merge==3)
-----------------------------------------


.	merge m:1 DealerTIN using "D:\data\form16_uniquedata_q1_2014_v2_numericidandtin.dta",	keepusing(id)

	Result                           # of obs.
	-----------------------------------------
	not matched                       210,283
	from master                    80,463  (_merge==1)
	from using                    129,820  (_merge==2)

	matched                         5,932,805  (_merge==3)
*/


*******************************************************************
********************STEP 1.4*****************************************
*******************************************************************
* Now I try to use the entire return file to see which Tin numbers are missing
* Merge 2A-2B with returns
* Trying this exercise for quarter 1 of year 2014

* First we get returns for all years
use "form16_data.dta", clear

gsort DealerTIN -id
drop tin
/* Calculating number of times a dealer files returns*/
by DealerTIN: gen ReturnCount = _n
keep if ReturnCount==1
save "DataVerification\step1\form16_uniquetin_all.dta"

// Now using 2A-2B data
use "annexure_2A2B_quarterly_2014.dta", clear

keep if SourceFile=="t9854114" //keeping only first quarter 2014 entries

gsort DealerTIN
/* Calculating number of times a dealer files returns per quarter*/
by DealerTIN: gen ReturnCount = _n
keep if ReturnCount==1

merge 1:1 DealerTIN using "form16_uniquetin_all.dta", keepusing(id)

/*

.	do "C:\Users\ADMINI~1\AppData\Local\Temp\2\STD01000000.tmp"

.	merge 1:1 DealerTIN using "D:\data\form16_uniquetin_all.dta",	keepusing(id)

	Result                           # of obs.
	-----------------------------------------
	not matched                       136,580
	from master                     6,760  (_merge==1)
	from using                    129,820  (_merge==2)

	matched                           206,485  (_merge==3)


I did not delete duplicate TIN numbers in the annexure
.

. merge m:1 DealerTIN using "D:\data\form16_uniquetin_all.dta", keepusing(id)

    Result                           # of obs.
    -----------------------------------------
    not matched                       210,283
        from master                    80,463  (_merge==1)
        from using                    129,820  (_merge==2)

    matched                         5,932,805  (_merge==3)

*/
