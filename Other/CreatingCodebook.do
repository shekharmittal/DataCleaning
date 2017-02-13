cd "D:\data"

log using "Other\codebook for all tables.smcl", replace

/********Annexure 2A 2B******/
use "annexure_2A2B_quarterly_2013.dta", clear
codebook

/********Dealer Profiles******/
use "DealerProfile.dta", clear
codebook


/********Form 16 returns******/
use "form16_data.dta", clear
codebook


/********Audit Notice******/
use "form37_data_auditnotice.dta", clear
codebook

/********Commodity Codes for the returns******/
use "TableCommodityCode.dta", clear
codebook


/********Commodity Codes for DealerProfiles******/
use "TableCommodityCodeforDealerProfile.dta", clear
codebook

/********Cancellation Forms******/
use "CancellationForm.dta", clear
codebook


log close
