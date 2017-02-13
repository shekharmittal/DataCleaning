/* Code cleaning and Verfication exercise
Step 1: Merge 2A-2B with returns
Step 2: Merge returns with commodity codes
Step 3: Merge returns with DP-1
Step 4: Merge commodity codes with DP-1
Step 5: What are the number of returns per Tin
Step 6: Try and see what are the unique id combinations in each file. Keep the log.
Step 7: Calculate unique tins in each file and compare with each other
Step 8: Check how many unique tin numbers are matching up with each other
*******************************************************************
Step 9 : Merge cancelled Dealers with returns data and dealer profiles
*******************************************************************
*/
cd "D:\data"

use "CancellationForm.dta", clear

. isid T616001 //ids are unique

. codebook T616001 T616002

-----------------------------------------------------------------------------------------
T616001                                                                       (unlabeled)
-----------------------------------------------------------------------------------------

                  type:  string (str19), but longest is str11

         unique values:  278986                   missing "":  0/278986

              examples:  "54576121011"
                         "58550138979"
                         "58550194776"
                         "58550250573"

-----------------------------------------------------------------------------------------
T616002                                                                       (unlabeled)
-----------------------------------------------------------------------------------------

                  type:  string (str11)

         unique values:  169044                   missing "":  58/278986

              examples:  "196215"
                         "294415"
                         "392209"
                         "489530"

. drop if T616002==""
(58 observations deleted)

. isid T616002
variable T616002 does not uniquely identify the observations
r(459);

. gsort T616002 T616001


. by T616002: egen TotalCount=sum(dummy)
. by T616002: gen RunningCount=_n

. tab RunningCount

RunningCoun |
          t |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |    169,044       60.60       60.60
          2 |     81,054       29.06       89.66
          3 |     24,332        8.72       98.39
          4 |      3,521        1.26       99.65
          5 |        734        0.26       99.91
          6 |        168        0.06       99.97
          7 |         42        0.02       99.99
          8 |         21        0.01      100.00
          9 |          7        0.00      100.00
         10 |          3        0.00      100.00
         11 |          1        0.00      100.00
         12 |          1        0.00      100.00
------------+-----------------------------------
      Total |    278,928      100.00

. drop if RunningCount!=1
(109884 observations deleted)

. tab TotalCount

 TotalCount |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |     87,990       52.05       52.05
          2 |     56,722       33.55       85.61
          3 |     20,811       12.31       97.92
          4 |      2,787        1.65       99.57
          5 |        566        0.33       99.90
          6 |        126        0.07       99.98
          7 |         21        0.01       99.99
          8 |         14        0.01      100.00
          9 |          4        0.00      100.00
         10 |          2        0.00      100.00
         12 |          1        0.00      100.00
------------+-----------------------------------
      Total |    169,044      100.00

rename T616002 DealerTIN

merge 1:1 DealerTIN using "DataVerification\step1\form16_uniquetin_all.dta", keepusing(SourceFile)

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                       312,735
        from master                    72,737  (_merge==1)
        from using                    239,998  (_merge==2)

    matched                            96,307  (_merge==3)
    -----------------------------------------

. tab SourceFile

 SourceFile |      Freq.     Percent        Cum.
------------+-----------------------------------
F16T3121011 |     14,906        4.43        4.43
F16T3121112 |    168,995       50.25       54.68
F16T3121213 |     34,141       10.15       64.83
F16T3121314 |     12,617        3.75       68.59
F16T3121415 |    105,646       31.41      100.00
------------+-----------------------------------
      Total |    336,305      100.00

. drop if _merge==2
(239998 observations deleted)

. tab SourceFile

 SourceFile |      Freq.     Percent        Cum.
------------+-----------------------------------
F16T3121011 |      8,914        9.26        9.26
F16T3121112 |     52,308       54.31       63.57
F16T3121213 |     13,359       13.87       77.44
F16T3121314 |      9,022        9.37       86.81
F16T3121415 |     12,704       13.19      100.00
------------+-----------------------------------
      Total |     96,307      100.00

*/	  
. drop _merge

. merge 1:1 DealerTIN using "DataVerification\step3\DealerProfile_uniqueTin.dta", keepusing(RegistrationDate)
(note: variable DealerTIN was str11, now str25 to accommodate using data's values)

    Result                           # of obs.
    -----------------------------------------
    not matched                       364,065
        from master                   109,794  (_merge==1)
        from using                    254,271  (_merge==2)

    matched                            59,250  (_merge==3)
    -----------------------------------------

. 
