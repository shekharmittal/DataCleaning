cd "D:\data"

use "form16_data.dta", clear

//First we clean up TaxPeriod Variable and make sure it is uniform
tab TaxPeriod

/*    The tax period for |
 which the returns has |
            been filed |      Freq.     Percent        Cum.
-----------------------+-----------------------------------
               99-2012 |          4        0.00        0.00
           Annual-2010 |     27,338        0.49        0.49
           Annual-2011 |     26,806        0.48        0.97
           Annual-2012 |        407        0.01        0.98
          Anually-2010 |          1        0.00        0.98
              Apr-2010 |     15,661        0.28        1.26
              Apr-2011 |     17,131        0.31        1.56
              Apr-2012 |     26,821        0.48        2.04
              Apr-2013 |      1,197        0.02        2.06
              Aug-2010 |     15,107        0.27        2.33
              Aug-2011 |     16,692        0.30        2.63
              Aug-2012 |     24,972        0.45        3.08
              Dec-2010 |     14,775        0.26        3.34
              Dec-2011 |     16,604        0.30        3.64
              Dec-2012 |     25,033        0.45        4.08
              Feb-2010 |          1        0.00        4.09
              Feb-2011 |     14,657        0.26        4.35
              Feb-2012 |     16,371        0.29        4.64
              Feb-2013 |     24,696        0.44        5.08
 First Halfyearly-2011 |          1        0.00        5.08
   First Quarter -2011 |          1        0.00        5.08
    First Quarter-2010 |    100,081        1.79        6.87
    First Quarter-2011 |    111,076        1.99        8.86
    First Quarter-2012 |    241,627        4.32       13.17
    First Quarter-2013 |    355,244        6.35       19.52
    First Quarter-2014 |    310,204        5.54       25.07
     First Quater-2010 |          2        0.00       25.07
     First Quater-2011 |          5        0.00       25.07
 First halfyearly-2010 |     55,092        0.98       26.05
 First halfyearly-2011 |     54,989        0.98       27.04
 First halfyearly-2012 |         85        0.00       27.04
  First halfyerly-2010 |          1        0.00       27.04
   First quaterly-2012 |          1        0.00       27.04
    Forth Quarter-2008 |          1        0.00       27.04
    Forth Quarter-2012 |          1        0.00       27.04
     Forth Quater-2011 |          1        0.00       27.04
  Fourth Quarter -2011 |          2        0.00       27.04
   Fourth Quarter-2007 |          1        0.00       27.04
   Fourth Quarter-2010 |    110,654        1.98       29.01
   Fourth Quarter-2011 |    124,043        2.22       31.23
   Fourth Quarter-2012 |    290,257        5.19       36.42
   Fourth Quarter-2013 |    326,205        5.83       42.25
   Fourth Quarter-2014 |    294,438        5.26       47.51
    Fourth Quater-2010 |          1        0.00       47.51
    Fourth Quater-2011 |          2        0.00       47.51
              Jan-2011 |     14,675        0.26       47.78
              Jan-2012 |     16,362        0.29       48.07
              Jan-2013 |     24,767        0.44       48.51
              Jul-2010 |     15,124        0.27       48.78
              Jul-2011 |     16,624        0.30       49.08
              Jul-2012 |     25,605        0.46       49.54
             July-2011 |          1        0.00       49.54
              Jun-2010 |     15,435        0.28       49.81
              Jun-2011 |     17,028        0.30       50.12
              Jun-2012 |     26,272        0.47       50.59
              Mar-2011 |     15,268        0.27       50.86
              Mar-2012 |     17,055        0.30       51.16
              Mar-2013 |     25,802        0.46       51.62
              May-2010 |     15,259        0.27       51.90
              May-2011 |     17,101        0.31       52.20
              May-2012 |     27,039        0.48       52.69
              May-2013 |          8        0.00       52.69
              Nov-2010 |     14,806        0.26       52.95
              Nov-2011 |     16,572        0.30       53.25
              Nov-2012 |     24,649        0.44       53.69
              Oct-2010 |     15,001        0.27       53.96
              Oct-2011 |     16,654        0.30       54.25
              Oct-2012 |     25,368        0.45       54.71
 Second Halfyealy-2010 |          1        0.00       54.71
Second Halfyearly-2010 |          2        0.00       54.71
Second Halfyearly-2011 |          3        0.00       54.71
  Second Quarter -2011 |          1        0.00       54.71
   Second Quarter-2008 |          1        0.00       54.71
   Second Quarter-2009 |          2        0.00       54.71
   Second Quarter-2010 |    103,930        1.86       56.56
   Second Quarter-2011 |    115,266        2.06       58.62
   Second Quarter-2012 |    253,504        4.53       63.16
   Second Quarter-2013 |    432,337        7.73       70.88
   Second Quarter-2014 |    311,551        5.57       76.45
    Second Quater-2010 |          1        0.00       76.45
    Second Quater-2011 |          5        0.00       76.45
Second halfyearly-2010 |     54,360        0.97       77.42
Second halfyearly-2011 |     53,931        0.96       78.39
Second halfyearly-2012 |          6        0.00       78.39
  Second quaterly-2012 |          1        0.00       78.39
              Sep-2010 |     15,357        0.27       78.66
              Sep-2011 |     17,011        0.30       78.97
              Sep-2012 |     24,958        0.45       79.41
   Third Quarter -2011 |          2        0.00       79.41
    Third Quarter-2008 |          1        0.00       79.41
    Third Quarter-2009 |          1        0.00       79.41
    Third Quarter-2010 |    106,005        1.89       81.31
    Third Quarter-2011 |    119,383        2.13       83.44
    Third Quarter-2012 |    275,426        4.92       88.36
    Third Quarter-2013 |    342,175        6.12       94.48
    Third Quarter-2014 |    308,850        5.52      100.00
     Third Quater-2010 |          2        0.00      100.00
     Third Quater-2011 |          5        0.00      100.00
   Third quaterly-2012 |          1        0.00      100.00
     Thrid Quater-2010 |          1        0.00      100.00
     Thrid Quater-2012 |          1        0.00      100.00
-----------------------+-----------------------------------
                 Total |  5,594,845      100.00

. 
*/

replace TaxPeriod="Third Quarter-2012" if TaxPeriod=="Thrid Quater-2012"
replace TaxPeriod="Third Quarter-2012" if TaxPeriod=="Third quaterly-2012"
replace TaxPeriod="Third Quarter-2010" if TaxPeriod=="Thrid Quater-2010"
replace TaxPeriod="Third Quarter-2010" if TaxPeriod=="Third Quater-2010"
replace TaxPeriod="Third Quarter-2011" if TaxPeriod=="Third Quater-2011"
replace TaxPeriod="Third Quarter-2011" if TaxPeriod=="Third Quarter -2011"
replace TaxPeriod="Second Quarter-2012" if TaxPeriod=="Second quaterly-2012"
replace TaxPeriod="Second Quarter-2011" if TaxPeriod=="Second Quater-2011"
replace TaxPeriod="Second Quarter-2010" if TaxPeriod=="Second Quater-2010"
replace TaxPeriod="Second Quarter-2010" if TaxPeriod=="Second Quarter -2011"


replace TaxPeriod="Second Halfyear-2012" if TaxPeriod=="Second halfyearly-2012"
replace TaxPeriod="Second Halfyear-2011" if TaxPeriod=="Second halfyearly-2011"
replace TaxPeriod="Second Halfyear-2010" if TaxPeriod=="Second halfyearly-2010"

replace TaxPeriod="Second Halfyear-2011" if TaxPeriod=="Second Halfyearly-2011"
replace TaxPeriod="Second Halfyear-2010" if TaxPeriod=="Second Halfyearly-2010"
replace TaxPeriod="Second Halfyear-2010" if TaxPeriod=="Second Halfyealy-2010"

replace TaxPeriod="Jul-2011" if TaxPeriod=="July-2011"

replace TaxPeriod="Fourth Quarter-2011" if TaxPeriod=="Fourth Quater-2011"
replace TaxPeriod="Fourth Quarter-2010" if TaxPeriod=="Fourth Quater-2010"
replace TaxPeriod="Fourth Quarter-2011" if TaxPeriod=="Fourth Quarter -2011"
replace TaxPeriod="Fourth Quarter-2011" if TaxPeriod=="Forth Quater-2011"

replace TaxPeriod="Fourth Quarter-2012" if TaxPeriod=="Forth Quarter-2012"

replace TaxPeriod="Fourth Quarter-2008" if TaxPeriod=="Forth Quarter-2008"
replace TaxPeriod="First Quarter-2012" if TaxPeriod=="First quaterly-2012"

replace TaxPeriod="First Halfyear-2010" if TaxPeriod=="First halfyerly-2010"
replace TaxPeriod="First Halfyear-2010" if TaxPeriod=="First halfyearly-2010"
replace TaxPeriod="First Halfyear-2011" if TaxPeriod=="First halfyearly-2011"
replace TaxPeriod="First Halfyear-2012" if TaxPeriod=="First halfyearly-2012"

replace TaxPeriod="First Quarter-2011" if TaxPeriod=="First Quater-2011"
replace TaxPeriod="First Quarter-2010" if TaxPeriod=="First Quater-2010"

replace TaxPeriod="Annual-2010" if TaxPeriod=="Anually-2010"

replace TaxPeriod="First Halfyear-2011" if TaxPeriod=="First Halfyearly-2011"
replace TaxPeriod="First Quarter-2011" if TaxPeriod=="First Quarter -2011"
replace TaxPeriod="Feb-2012" if TaxPeriod=="99-2012"

gen Time= PeriodEnd- PeriodBegin
tab Time
format Time %tc
tab Time
gen Days=dofc(Time)
tab Days

//Dropping all useless entries
drop if TaxPeriod=="Annual-2012"&DealerTIN=="07999999999"
drop if TaxPeriod=="Annual-2011"&DealerTIN=="07999999999"
drop if TaxPeriod=="Feb-2010"
drop if TaxPeriod=="Fourth Quarter-2007"
drop if TaxPeriod=="Fourth Quarter-2008"
drop if TaxPeriod=="Second Halfyear-2011"&id=="100582210" //The other 2 observations in Second Halfyear 2011 look okay to me.
drop if TaxPeriod=="Second Quarter-2008"
drop if TaxPeriod=="Second Quarter-2009"
drop  if TaxPeriod=="Third Quarter-2008"
drop  if TaxPeriod=="Third Quarter-2009"
//Changing entries if they are in the incorrect section
replace TaxPeriod="Fourth Quarter-2010" if id=="101295557"&TaxPeriod=="First Quarter-2010"
replace TaxPeriod="Second Quarter-2011" if id=="100852182"&TaxPeriod=="First Quarter-2011"
replace TaxPeriod="Fourth Quarter-2011" if (id=="200221206"|id=="200196173")&TaxPeriod=="Fourth Quarter-2012"

replace TaxPeriod="First Quarter-2013" if (id=="100944147"|id=="200166729"|id=="200091347"|id=="100973346"|id=="101048209"|id=="200167043"|id=="101029556")&TaxPeriod=="Fourth Quarter-2012"
replace TaxPeriod="First Quarter-2013" if (id=="101047663"|id=="200167129"|id=="200166872"|id=="101090406")&TaxPeriod=="Fourth Quarter-2012"

replace TaxPeriod="Jan-2013" if id=="100880573"&TaxPeriod=="Jan-2012"
replace TaxPeriod="Apr-2012" if id=="100224305"&TaxPeriod=="Jun-2012"
replace TaxPeriod="May-2011" if id=="100310097"&TaxPeriod=="May-2012"
replace TaxPeriod="Second Quarter-2011" if id=="101436339"&TaxPeriod=="Second Quarter-2010"
replace TaxPeriod="Third Quarter-2012" if id=="100782984"&TaxPeriod=="Second Quarter-2012"
replace TaxPeriod="First Quarter-2013" if id=="100772912"&TaxPeriod=="Second Quarter-2013"
replace TaxPeriod="Third Quarter-2012" if id=="100588159"&TaxPeriod=="Third Quarter-2011"
replace TaxPeriod="Fourth Quarter-2012" if id=="24028898"&TaxPeriod=="Third Quarter-2011"

/*
 tab TaxPeriod

    The tax period for |
 which the returns has |
            been filed |      Freq.     Percent        Cum.
-----------------------+-----------------------------------
           Annual-2010 |     27,339        0.49        0.49
           Annual-2011 |     26,805        0.48        0.97
           Annual-2012 |        406        0.01        0.98
              Apr-2010 |     15,661        0.28        1.25
              Apr-2011 |     17,131        0.31        1.56
              Apr-2012 |     26,821        0.48        2.04
              Apr-2013 |      1,197        0.02        2.06
              Aug-2010 |     15,107        0.27        2.33
              Aug-2011 |     16,692        0.30        2.63
              Aug-2012 |     24,972        0.45        3.08
              Dec-2010 |     14,775        0.26        3.34
              Dec-2011 |     16,604        0.30        3.64
              Dec-2012 |     25,033        0.45        4.08
              Feb-2010 |          1        0.00        4.08
              Feb-2011 |     14,657        0.26        4.35
              Feb-2012 |     16,375        0.29        4.64
              Feb-2013 |     24,696        0.44        5.08
   First Halfyear-2010 |     55,093        0.98        6.07
   First Halfyear-2011 |     54,990        0.98        7.05
   First Halfyear-2012 |         85        0.00        7.05
    First Quarter-2010 |    100,083        1.79        8.84
    First Quarter-2011 |    111,082        1.99       10.82
    First Quarter-2012 |    241,628        4.32       15.14
    First Quarter-2013 |    355,244        6.35       21.49
    First Quarter-2014 |    310,204        5.54       27.04
  
  Done till First Quarter 2014
  Fourth Quarter-2007 |          1        0.00       27.04
   Fourth Quarter-2008 |          1        0.00       27.04
   Fourth Quarter-2010 |    110,655        1.98       29.01
   Fourth Quarter-2011 |    124,048        2.22       31.23
   Fourth Quarter-2012 |    290,258        5.19       36.42
   Fourth Quarter-2013 |    326,205        5.83       42.25
   Fourth Quarter-2014 |    294,438        5.26       47.51
              Jan-2011 |     14,675        0.26       47.78
              Jan-2012 |     16,362        0.29       48.07
              Jan-2013 |     24,767        0.44       48.51
              Jul-2010 |     15,124        0.27       48.78
              Jul-2011 |     16,625        0.30       49.08
              Jul-2012 |     25,605        0.46       49.54
              Jun-2010 |     15,435        0.28       49.81
              Jun-2011 |     17,028        0.30       50.12
              Jun-2012 |     26,272        0.47       50.59
              Mar-2011 |     15,268        0.27       50.86
              Mar-2012 |     17,055        0.30       51.16
              Mar-2013 |     25,802        0.46       51.62
              May-2010 |     15,259        0.27       51.90
              May-2011 |     17,101        0.31       52.20
              May-2012 |     27,039        0.48       52.69
              May-2013 |          8        0.00       52.69
              Nov-2010 |     14,806        0.26       52.95
              Nov-2011 |     16,572        0.30       53.25
              Nov-2012 |     24,649        0.44       53.69
              Oct-2010 |     15,001        0.27       53.96
              Oct-2011 |     16,654        0.30       54.25
              Oct-2012 |     25,368        0.45       54.71
  Second Halfyear-2010 |     54,363        0.97       55.68
  Second Halfyear-2011 |     53,934        0.96       56.64
  Second Halfyear-2012 |          6        0.00       56.64
   Second Quarter-2008 |          1        0.00       56.64
   Second Quarter-2009 |          2        0.00       56.64
   Second Quarter-2010 |    103,932        1.86       58.50
   Second Quarter-2011 |    115,271        2.06       60.56
   Second Quarter-2012 |    253,505        4.53       65.09
   Second Quarter-2013 |    432,337        7.73       72.82
   Second Quarter-2014 |    311,551        5.57       78.39
   
              Sep-2010 |     15,357        0.27       78.66
              Sep-2011 |     17,011        0.30       78.97
              Sep-2012 |     24,958        0.45       79.41
    Third Quarter-2008 |          1        0.00       79.41
    Third Quarter-2009 |          1        0.00       79.41
    Third Quarter-2010 |    106,008        1.89       81.31
    Third Quarter-2011 |    119,390        2.13       83.44
    Third Quarter-2012 |    275,428        4.92       88.36
    Third Quarter-2013 |    342,175        6.12       94.48
    Third Quarter-2014 |    308,850        5.52      100.00
-----------------------+-----------------------------------
                 Total |  5,594,843      100.00


*/

save "form16_data_v3_0901.dta", replace







