/* Code cleaning and Verfication exercise
Step 1: Merge 2A-2B with returns
Step 2: Merge returns with commodity codes
Step 3: Merge returns with DP-1
*******************************************************************
Step 4: Merge commodity codes with DP-1
*******************************************************************
Step 5: What are the number of returns per Tin
Step 6: Try and see what are the unique id combinations in each file. Keep the log.
Step 7: Calculate unique tins in each file and compare with each other
Step 8: Check how many unique tin numbers are matching up with each other
Step 9 : Merge cancelled Dealers with returns data and dealer profiles
*/

*******************************************************************
********************STEP 4*****************************************
*******************************************************************
cd "D:\data\"

use "DealerProfile.dta", clear
gsort DealerTIN -idDP
br
drop if DealerTIN==""
isid idDP DealerTIN

save "DataVerification\step4\DealerProfile_uniquetinandid.dta"

use "TableCommodityCodeforDealerProfile.dta", clear

gsort DealerTIN -idDP CommodityCode

merge m:1 idDP DealerTIN using "DataVerification\step4\DealerProfile_uniquetinandid.dta", keepusing(RegistrationDate Boolean)

/*
. merge m:1 idDP DealerTIN using "D:\data\step4\DealerProfile_uniquetinandid.dta", keepus
> ing(RegistrationDate)
(note: variable idDP was str8, now str19 to accommodate using data's values)
(note: variable DealerTIN was str19, now str25 to accommodate using data's values)

    Result                           # of obs.
    -----------------------------------------
    not matched                       402,041
        from master                    40,947  (_merge==1)
        from using                    361,094  (_merge==2)

    matched                           990,508  (_merge==3)
    -----------------------------------------
*/

/* Now I check for how many unique dealertins in the using file
In the 361094 observations, 263071 Tin numbers are unique
I got this number by running the following commands 

keep if _merge==2
gsort DealerTIN idDP
by DealerTIN: gen TotalCount=_n
tab TotalCount
drop if TotalCount!=1
isid DealerTIN

In the 40947 observations, 5971 Tin numbers are unique
I got this number by running the following commands 

keep if _merge==1
gsort DealerTIN idDP
by DealerTIN: gen TotalCount=_n
tab TotalCount
drop if TotalCount!=1
isid DealerTIN
*/

* We have already created a file for latest unique dealer profiles in step 3. will use that. 
* Now we use commodity codes
use "TableCommodityCodeforDealerProfile.dta", clear

gsort DealerTIN -idDP CommodityCode
br
merge m:1 idDP DealerTIN using "DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(RegistrationDate)

/*
 merge m:1 idDP DealerTIN using "D:\data\step3\DealerProfile_uniqueTin.dta", keepusing(R
> egistrationDate)
(note: variable idDP was str8, now str19 to accommodate using data's values)
(note: variable DealerTIN was str19, now str25 to accommodate using data's values)

    Result                           # of obs.
    -----------------------------------------
    not matched                       327,752
        from master                   118,854  (_merge==1)
        from using                    208,898  (_merge==2)

    matched                           912,601  (_merge==3)
    -----------------------------------------
*/
