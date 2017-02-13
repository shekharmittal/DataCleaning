cd "D:\data\"

use  "form37_data_auditnotice.dta", clear

gsort DealerTIN DateActualNotice
by DealerTIN: gen NoticeCount=_n
br DealerTIN DateActualNotice
keep if NoticeCount==1

// First we import the date from the registration date
gen NoticeDate=dofc(DateActualNotice)
format %td NoticeDate //change it into date format
gen NoticeYear=yofd(NoticeDate)
gen NoticeMonth=mofd(NoticeDate)
format %tm NoticeMonth
format %ty NoticeYear //Changing the format to appropriate year form
