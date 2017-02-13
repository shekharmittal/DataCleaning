/* This files extracts and renames the returns data*/
// ODBC was crashing while importing this file from the sqlserver.
// However, it worked on my personal laptop and then I had to upload this file using dropbox
//
cd "D:\data\"
use "CancellationForm.dta", clear


rename T616001 idCancellation
rename T616002 DealerTIN
rename T616003 Ward
rename T616004 DateEffective
rename T616005 DateAppearance
rename T616006 Reasons
rename T616009 NotInUse1
rename T616010 NotInUse2
rename T616011 DealerReply
rename T616012 ReplySatisfactory
rename T616014 DateReply
rename T616015 VatoReply 
rename T616016 CancellationDate
rename T616018 Status
rename T616019 CancelledBy
rename T616020 DateOfIssue
rename T616021 DidDealerReply
rename T616022 FlagCancelled

label variable idCancellation "Reference ID	T616001	bigint	8"
label variable DealerTIN "TIN	T616002	varchar	11"
label variable Ward "ward	T616003	varchar	10"
label variable DateEffective "WEF date	T616004	smalldatetime	4"
label variable DateAppearance "Appearing Date	T616005	smalldatetime	4"
label variable Reasons "Reasons	T616006	varchar	max"
label variable NotInUse1 "not in use	T616009	bigint	8"
label variable NotInUse2 "not in use	T616010	smalldatetime	4"
label variable DealerReply "Reply of Dealer	T616011	varchar	500"
label variable ReplySatisfactory "Yes/No whether satisfy or not	T616012	tinyint	1"
label variable DateReply "Date of Reply	T616014	smalldatetime	4"
label variable VatoReply "Vato Reply	T616015	varchar	500"
label variable CancellationDate "Cancellation Date /Issue dvat11 date --- in case of dvat10	T616016	smalldatetime"
label variable Status "status	T616018	int	4"
label variable CancelledBy "Cancelled By	T616019	bigint	8"
label variable DateOfIssue "Date of Issue of Notice	T616020	smalldatetime"
label variable DidDealerReply "Wheather Dealer Reply	T616021	smallint"
label variable FlagCancelled "flag for cancelled	T616022	tinyint	1"
label variable T616007 "Not in USE"
label variable T616008 "Not in USE"
label variable T616017 "Not in USE"
label variable T616013 "Not in USE"


save "CancellationForm.dta", replace
