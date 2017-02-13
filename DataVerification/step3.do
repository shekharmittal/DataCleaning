/* Code cleaning and Verfication exercise
*******************************************************************
Step 1: Merge 2A-2B with returns
Step 2: Merge returns with commodity codes
*******************************************************************
Step 3: Merge returns with DP-1
*******************************************************************
Step 4: Merge commodity codes with DP-1
Step 5: What are the number of returns per Tin
Step 6: Try and see what are the unique id combinations in each file. Keep the log.
Step 7: Calculate unique tins in each file and compare with each other
Step 8: Check how many unique tin numbers are matching up with each other
Step 9 : Merge cancelled Dealers with returns data and dealer profiles
********************************************************************/
/* Here I assume that if Dealers edit their profiles then new Ids get created for their TIN
Hence I sort on tin and keep the latest entry */
* A question that we need to ask is why are there 69983 ids that have no tins.
cd "D:\data\"

use "DealerProfile.dta", clear
gsort DealerTIN -idDP
br
drop if DealerTIN==""
isid idDP DealerTIN

by DealerTIN: gen ReturnCount = _n
keep if ReturnCount==1
save "DataVerification\step3\DealerProfile_uniqueTin.dta"



/* THen I simply merge all the tins in the returns data with the unique dealer profiles */
use "form16_data.dta", clear
merge m:1 DealerTIN using "DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(idDP RegistrationDate)

/*

. merge m:1 DealerTIN using "D:\data\DealerProfile_uniqueTin.dta", keepusing(idDP Registr
> ationDate)
(note: variable DealerTIN was str11, now str25 to accommodate using data's values)

    Result                           # of obs.
    -----------------------------------------
    not matched                       569,042
        from master                   531,592  (_merge==1)
        from using                     37,450  (_merge==2)

    matched                         5,063,257  (_merge==3)

	*/

* To verify in another way, I use the unique tins returns file and redo the merge
************ Now I use the uniquetin data from the forms table
use "DataVerification\step1\form16_uniquetin_all.dta", clear
merge m:1 DealerTIN using "DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(idDP RegistrationDate)

/*
 merge m:1 DealerTIN using "D:\data\DealerProfile_uniqueTin.dta", keepusing(idDP Registr
> ationDate)
(note: variable DealerTIN was str11, now str25 to accommodate using data's values)

    Result                           # of obs.
    -----------------------------------------
    not matched                        97,684
        from master                    60,234  (_merge==1)
        from using                     37,450  (_merge==2)

    matched                           276,071  (_merge==3)
    -----------------------------------------

*/
