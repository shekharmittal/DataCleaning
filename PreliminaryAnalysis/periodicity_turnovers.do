cd "D:\data"
use "PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear

histogram TurnoverGross if TaxPeriod=="Annual-2010"&TurnoverGross<1500000&TurnoverGross>0, bin(500) fraction

histogram AmountDepositedByDealer if TaxPeriod=="Annual-2010"&TurnoverGross<1500000&TurnoverGross>0, bin(500) fraction

histogram TurnoverGross if TaxPeriod=="Annual-2011"&TurnoverGross<1500000&TurnoverGross>0, bin(500) fraction

/*
The right numbers to look at!

 sum  AmountDepositedByDealer  TurnoverGross AggregateAmountPaid  if TaxPeriod=="Annual-2010"&TurnoverGross>1000000&TurnoverGross<1100000, detail

     R7.8  Amount Deposited by the Dealer (attach proof
                    of payment)  T312067
-------------------------------------------------------------
      Percentiles      Smallest
 1%            0              0
 5%            0              0
10%            0              0       Obs                  10
25%            0              0       Sum of Wgt.          10

50%         5284                      Mean            14385.3
                        Largest       Std. Dev.      21435.78
75%        17591          11034
90%        52330          17591       Variance       4.59e+08
95%        63300          41360       Skewness       1.465413
99%        63300          63300       Kurtosis       3.765433

                        TurnoverGross
-------------------------------------------------------------
      Percentiles      Smallest
 1%      1000720        1000226
 5%      1004494        1000285
10%      1009794        1000378       Obs                 456
25%      1021671        1000637       Sum of Wgt.         456

50%      1047161                      Mean            1047192
                        Largest       Std. Dev.      29196.84
75%      1070828        1099757
90%      1091100        1099799       Variance       8.52e+08
95%      1095534        1099825       Skewness       .1762699
99%      1098834        1099876       Kurtosis       1.845179

         Aggregate Amount Paid(Sum total of Challan)
                           T312068
-------------------------------------------------------------
      Percentiles      Smallest
 1%            0              0
 5%            0              0
10%            0              0       Obs                 456
25%            0              0       Sum of Wgt.         456

50%         1604                      Mean           13981.88
                        Largest       Std. Dev.      25034.44
75%        18032         131469
90%        48496         131671       Variance       6.27e+08
95%        65520         133769       Skewness       2.573234
99%       126705         136968       Kurtosis       10.15559

. sum  AmountDepositedByDealer  TurnoverGross AggregateAmountPaid  if TaxPeriod=="Annual-2010"&TurnoverGross<1000000&TurnoverGross>900000, detail

     R7.8  Amount Deposited by the Dealer (attach proof
                    of payment)  T312067
-------------------------------------------------------------
      Percentiles      Smallest
 1%            0              0
 5%            0              0
10%            0              0       Obs                  49
25%            0              0       Sum of Wgt.          49

50%            0                      Mean           9670.122
                        Largest       Std. Dev.      21182.69
75%         5100          47311
90%        45900          56272       Variance       4.49e+08
95%        56272          64692       Skewness       2.489938
99%        98793          98793       Kurtosis       8.828486

                        TurnoverGross
-------------------------------------------------------------
      Percentiles      Smallest
 1%       901461         900030
 5%       906482         900205
10%       912760         900216       Obs                1390
25%       928175         900219       Sum of Wgt.        1390

50%     955322.5                      Mean           954874.2
                        Largest       Std. Dev.      30072.83
75%       982863         999870
90%       993785         999888       Variance       9.04e+08
95%       997464         999914       Skewness      -.1471901
99%       999401         999915       Kurtosis       1.711175

         Aggregate Amount Paid(Sum total of Challan)
                           T312068
-------------------------------------------------------------
      Percentiles      Smallest
 1%            0              0
 5%            0              0
10%            0              0       Obs                1390
25%            0              0       Sum of Wgt.        1390

50%          107                      Mean           9417.122
                        Largest       Std. Dev.      18659.52
75%        10156         112304
90%        29533         113881       Variance       3.48e+08
95%        48095         119407       Skewness       2.990954
99%        96456         121817       Kurtosis       12.97007

. 
*/




//HalfYearly
  
use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
keep if TaxPeriod=="Second Halfyear-2011"|TaxPeriod=="First Halfyear-2011"
gsort DealerTIN
drop ReturnCount
by DealerTIN: gen ReturnCount=_n
tab ReturnCount
by DealerTIN: egen AnnualTurnover=sum(TurnoverGross)
keep if ReturnCount==2
histogram AnnualTurnover if AnnualTurnover>4000000&AnnualTurnover<6000000, bin(1000) fraction

use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
keep if TaxPeriod=="Second Halfyear-2010"|TaxPeriod=="First Halfyear-2010"
gsort DealerTIN
drop ReturnCount
by DealerTIN: gen ReturnCount=_n
tab ReturnCount
by DealerTIN: egen AnnualTurnover=sum(TurnoverGross)
keep if ReturnCount==2
histogram AnnualTurnover if AnnualTurnover>4000000&AnnualTurnover<6000000, bin(1000) fraction

restore

use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
keep if TaxPeriod=="Third Quarter-2010"|TaxPeriod=="First Quarter-2010"|TaxPeriod=="Second Quarter-2010"|TaxPeriod=="Fourth Quarter-2010"
gsort DealerTIN
drop ReturnCount
by DealerTIN: gen ReturnCount=_n
tab ReturnCount
by DealerTIN: egen AnnualTurnover=sum(TurnoverGross)
keep if ReturnCount==4
histogram AnnualTurnover if AnnualTurnover>40000000&AnnualTurnover<60000000, bin(1000) fraction

use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
keep if TaxPeriod=="Third Quarter-2011"|TaxPeriod=="First Quarter-2011"|TaxPeriod=="Second Quarter-2011"|TaxPeriod=="Fourth Quarter-2011"
gsort DealerTIN
drop ReturnCount
by DealerTIN: gen ReturnCount=_n
tab ReturnCount
by DealerTIN: egen AnnualTurnover=sum(TurnoverGross)
keep if ReturnCount==4
histogram AnnualTurnover if AnnualTurnover>40000000&AnnualTurnover<60000000, bin(1000) fraction

use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
keep if TaxPeriod=="Third Quarter-2012"|TaxPeriod=="First Quarter-2012"|TaxPeriod=="Second Quarter-2012"|TaxPeriod=="Fourth Quarter-2012"
gsort DealerTIN
drop ReturnCount
by DealerTIN: gen ReturnCount=_n
tab ReturnCount
by DealerTIN: egen AnnualTurnover=sum(TurnoverGross)
keep if ReturnCount==4
histogram AnnualTurnover if AnnualTurnover>40000000&AnnualTurnover<60000000, bin(1000) fraction
histogram AnnualTurnover if AnnualTurnover>4000000&AnnualTurnover<6000000, bin(1000) fraction
histogram AnnualTurnover if AnnualTurnover>0&AnnualTurnover<1500000, bin(1000) fraction




use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
keep if TaxPeriod=="Third Quarter-2013"|TaxPeriod=="First Quarter-2013"|TaxPeriod=="Second Quarter-2013"|TaxPeriod=="Fourth Quarter-2013"
gsort DealerTIN
drop ReturnCount
by DealerTIN: gen ReturnCount=_n
tab ReturnCount
by DealerTIN: egen AnnualTurnover=sum(TurnoverGross)
keep if ReturnCount==4
histogram AnnualTurnover if AnnualTurnover>40000000&AnnualTurnover<60000000, bin(1000) fraction
histogram AnnualTurnover if AnnualTurnover>4000000&AnnualTurnover<6000000, bin(1000) fraction
histogram AnnualTurnover if AnnualTurnover>0&AnnualTurnover<1500000, bin(1000) fraction


use "D:\data\PreliminaryAnalysis\returns\form16_data_v3_0901.dta", clear
keep if TaxPeriod=="Third Quarter-2014"|TaxPeriod=="First Quarter-2014"|TaxPeriod=="Second Quarter-2014"|TaxPeriod=="Fourth Quarter-2014"
gsort DealerTIN
drop ReturnCount
by DealerTIN: gen ReturnCount=_n
tab ReturnCount
by DealerTIN: egen AnnualTurnover=sum(TurnoverGross)
keep if ReturnCount==4
histogram AnnualTurnover if AnnualTurnover>40000000&AnnualTurnover<60000000, bin(1000) fraction
histogram AnnualTurnover if AnnualTurnover>4000000&AnnualTurnover<6000000, bin(1000) fraction
histogram AnnualTurnover if AnnualTurnover>0&AnnualTurnover<1500000, bin(1000) fraction




