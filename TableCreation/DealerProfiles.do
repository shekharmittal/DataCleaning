//ODBC command was not working on Stata for this table
//So I loaded the file on my desktop and then uploaded it on the server.
cd "D:\data"
odbc load, table("dbo.T501") noquote clear
// Loading the stata file
use "DealerProfile.dta", clear


rename T501001 idDP
rename T501002 Email
rename T501003 Mobile
rename T501004 Password
rename T501005 DealerTIN
rename T501006 IECCode
rename T501007 Name
rename T501008 Nature 
rename T501009 Constitution
rename T501010 OtherConstitution
rename T501011 OptConstitution
rename T501012 RegistrationType
rename T501013 AnnualTurnoverCategory
rename T501014 TurnoverPreviousYear
rename T501015 ExpectedTurnover
rename T501016 RegistrationDate
rename T501017 PAN
rename T501018 CEANumber
rename T501019 PPBBuildingName
rename T501020 PPBArea
rename T501021 PPBLocality
rename T501022 PinCode
rename T501023 PPBEmail
rename T501024 PPBPhone
rename T501025 PPBFax
rename T501026 ASNBuildingName
rename T501027 ASNArea
rename T501028 ASNLocality
rename T501029 ASNPinCode
rename T501030 ASNEmail
rename T501031 ASNPhone
rename T501032 ASNFax
rename T501033 BankName
rename T501034 BankAddress
rename T501035 MICR
rename T501036 BankAccount
rename T501037 OwnCapital
rename T501038 BankLoan
rename T501039 OtherLoan
rename T501040 PlantAndMachinery
rename T501041 LandAndBuilding
rename T501042 OtherAssets
rename T501043 ItemDescription
rename T501044 AccountingBasis
rename T501045 TotalSecurity
rename T501046 TypeOfSecurity
rename T501047 ExpiryBankSecurity
rename T501048 ManagerName
rename T501049 Status
rename T501050 ApprovalDate
rename T501051 SubmissionDate
rename T501052 StringManager
rename T501053 PanCardName
rename T501054 DP1Floor
rename T501055 StatusDealer
rename T501056 DocsSecurityReduction
rename T501057 DealerSecurity
rename T501058 ReceptionCounterDetails
rename T501059 IdentityProof
rename T501060 AddressProof
rename T501061 BusinessPremises
rename T501062 VatoApprovalDetails
rename T501063 VatoIdentityProof
rename T501064 SuretyTin
rename T501065 VatoAddressProof
rename T501066 VatoBusinessPremises
rename T501067 IssueTinDetails
rename T501068 NameInPAN
rename T501069 DateFilingRequest //This is an interesting variable 
rename T501070 PPBCity
rename T501071 PPBDistrict
rename T501072 PPBState
rename T501073 PPBContactCode
rename T501074 PPBFaxCode
rename T501075 ASNCity
rename T501076 ASNDistrict
rename T501077 ASNState
rename T501078 ASNContactCode
rename T501079 ASNFaxCode
rename T501080 SignatoryDesignation
rename T501081 RegularDealerType
rename T501082 PanApprovalID
rename T501083 PanApprovalDate
rename T501084 PanVerifiedStatus
rename T501085 NewStatus
rename T501086 PANReason
rename T501087 Ward
rename T501088 TINSurity
rename T501089 StatusByDealer
rename T501090 SecurityApprovalDate
rename T501091 TINIssueDate
rename T501092 TaxRateComposition
rename T501093 StatusManualRegistration
rename T501094 BooleanInterState
rename T501095 Boolean201011 //Need to verify
rename T501096 Boolean201112 //Need to Verify
rename T501097 Boolean201213 //Need to verify
rename T501098 ServiceTaxNumber
rename T501099 Floor
rename T501100 OpenArea
rename T501101 CoveredArea
rename T501102 BooleanCounsel 
rename T501103 CounselEmail
rename T501104 ProprietorName
rename T501105 BooleanThirdPartyStorage
rename T501106 BooleanSurveyFilled //Need to verify thi
rename T501107 ThirdPartyAddress
rename T501108 GTONil201213
rename T501109 PhysicalWard
rename T501110 CounselName
rename T501111 CounselMobile
rename T501112 ProprietorPAN
rename T501113 VatoActionDate
rename T501114 BooleanRegisteredIEC
rename T501115 BooleanRegisteredCE
rename T501116 BooleanServiceTax
rename T501117 ServiceNoticeOpenArea
rename T501118 ServiceNoticeCoveredArea
rename T501119 ServiceNoticeOtherFloor
//rename T501120 Floor need to verify this variable
rename T501121 PANBusinessName



label variable idDP "ID	T501001	Bigint"
label variable Email "Registered Email	T501002	varchar	200"
label variable Mobile "Registered Mobile No	T501003	varchar	10"
label variable Password "Password	T501004	varchar	20"
label variable DealerTIN "TIN No	T501005	Varchar	100"
label variable IECCode "IEC Code	T501006	Varchar	200"
label variable Name "Name of Business	T501007	Varchar	200"
label variable Nature "Nature of Business	T501008	varchar	255"
label variable Constitution "Constitution of Business	T501009	varchar	200"
label variable OtherConstitution "Other Constitution of Business	T501010	varchar	100"
label variable OptConstitution "Opting for Composition	T501011	Tinyint"
label variable RegistrationType "Type of Registration	T501012	Tinyint"
label variable AnnualTurnoverCategory "Annual Turnover Category	T501013	Tinyint"
label variable TurnoverPreviousYear "Turnover in Preceding Year	T501014	Decimal	(18,2)"
label variable ExpectedTurnover "Expected Turnover	T501015	Decimal	(18,2)"
label variable RegistrationDate "Date from Which laible(registration date)	T501016	Smalldatetime	"
label variable PAN "PAN	T501017	Varchar	10"
label variable CEANumber "CEA Registration Number	T501018	Varchar	50"
label variable PPBBuildingName "PPB Building Name/Number	T501019	Varchar	100"
label variable PPBArea "PPB Area/Road	T501020	Varchar	100"
label variable PPBLocality "PPB Locality/Market	T501021	Varchar	100"
label variable PinCode "PPB Pincode	T501022	Number	6"
label variable PPBEmail "PPB Email	T501023	Varchar	200"
label variable PPBPhone "PPB Telephone	T501024	Varchar	50"
label variable PPBFax "PPB Fax	T501025	Varchar	50"
label variable ASNBuildingName "ASN Building Name/Number	T501026	Varchar	100"
label variable ASNArea "ASN Area/Road	T501027	Varchar	100"
label variable ASNLocality "ASN Locality/Market	T501028	Varchar	100"
label variable ASNPinCode "ASN Pincode	T501029	Number	6"
label variable ASNEmail "ASN Email	T501030	Varchar	200"
label variable ASNPhone "ASN Telephone	T501031	Varchar	50"
label variable ASNFax "ASN Fax	T501032	Varchar	50"
label variable BankName "Name of Bank	T501033	Varchar	100"
label variable BankAddress "Address of Bank	T501034	Varchar	500"
label variable MICR "MICR Number	T501035	Varchar	20"
label variable BankAccount "Account Number	T501036	Varchar	20"
label variable OwnCapital "Own Capital	T501037	Decimal	(18,2)"
label variable BankLoan "Loans from Banks	T501038	Decimal	(18,2)"
label variable OtherLoan "Other Loans	T501039	Decimal	(18,2)"
label variable PlantAndMachinery "Plant and Machinery	T501040	Decimal	(18,2)"
label variable LandAndBuilding "Land and Building	T501041	Decimal	(18,2)"
label variable OtherAssets "Other Assets	T501042	Decimal	(18,2)"
label variable ItemDescription "ItemDescription	T501043	Varchar"
label variable AccountingBasis "Accounting Basis	T501044	Tinyint"
label variable TotalSecurity "Total Amount of security	T501045	Decimal	(18,2)"
label variable TypeOfSecurity "Type of security	T501046	Tinyint"
label variable ExpiryBankSecurity "Date of Expiry in case of bank Guarentee	T501047	Smalldatetime"
label variable ManagerName "Manager Name	T501048	Varchar	1000"
label variable Status "Status (Amendment approved by VATO or not)	T501049	Tinyint"
label variable ApprovalDate "Approval Date (Self Approved) (Ammendment/DP1)	T501050	Smalldatetime"
label variable SubmissionDate "Submission Date of Part A	T501051	smalldatetime"
label variable StringManager "Part B String             string of manager in DP1	T501052	varchar	max"
label variable PanCardName "Part C String             Name on Pan Card DP1	T501053	varchar	max"
label variable DP1Floor "Part D String             floor DP1 part A	T501054	varchar	max"
label variable StatusDealer "Status Dealer approve himself	T501055	BIT	"
label variable DocsSecurityReduction "Documents for reduction in security	T501056	varchar	max"
label variable DealerSecurity "DealerSecurity/ BANK GUARANTEE/ FIXED DEPOSIT/ Other all surety in string format	T501057	varchar	max"
label variable ReceptionCounterDetails "Reception Counter Details	T501058	varchar	max"
label variable IdentityProof "Identity Proof	T501059	varchar	max"
label variable AddressProof "Address Proof	T501060	varchar	max"
label variable BusinessPremises "Business Premises	T501061	varchar	max"
label variable VatoApprovalDetails "VATO Approval Details	T501062	varchar	max"
label variable VatoIdentityProof "VATO Identity Proof	T501063	varchar	max"
label variable SuretyTin "Surety Tin with Approved/.Disapproved	T501064	varchar	max"
label variable VatoAddressProof "VATO Address Proof	T501065	varchar	max"
label variable VatoBusinessPremises "VATO Business Premises	T501066	varchar	max"
label variable IssueTinDetails "Issue TIN Details	T501067	varchar	max"
label variable NameInPAN "Name in PAN record	T501068	varchar	200"
label variable DateFilingRequest "Date of Filing Request for the very first time	T501069	Smalldatetime"
label variable PPBCity "PPB City	T501070	varchar	200"
label variable PPBDistrict "PPB District	T501071	varchar	200"
label variable PPBState "PPB State	T501072	varchar	200"
label variable PPBContactCode "PPB Contact Code	T501073	varchar	200"
label variable PPBFaxCode "PPB Fax Code	T501074	varchar	200"
label variable ASNCity "ASN City	T501075	varchar	200"
label variable ASNDistrict "ASN District	T501076	varchar	200"
label variable ASNState "ASN State	T501077	varchar	200"
label variable ASNContactCode "ASN Contact Code	T501078	varchar	200"
label variable ASNFaxCode "ASN Fax Code	T501079	varchar	200"
label variable SignatoryDesignation "Authorized Signatory~Designation	T501080	varchar	200"
label variable RegularDealerType "Type of regular dealer (Apply for)	T501081	varchar	200"
label variable PanApprovalID "Pan Approval login ID	T501082	varchar	20"
label variable PanApprovalDate "Pan Approval Date	T501083	Smalldatetime"
label variable PanVerifiedStatus "Status (PAN verified by VATO) 1 for approved	T501084	Tinyint"
label variable NewStatus "Status(New/Amendment)	T501085	Varchar"
label variable PANReason "Reason of PAN Approval/Rejection	T501086	Varchar	500"
label variable Ward "Ward	T501087	Varchar	20"
label variable TINSurity "TIN of surity	T501088	varchar	11"
label variable StatusByDealer "status(Approved/disapproved) by dealer for security	T501089	Tinyint"
label variable SecurityApprovalDate "Date of approval of security	T501090	Smalldatetime"
label variable TINIssueDate "Date of Issue TIN	T501091	Smalldatetime"
label variable TaxRateComposition "Rate of TAX under Composition Scheme	T501092	varchar	100"
label variable StatusManualRegistration "Status Manual Registration by vato to fill DVAT forms	T501093	tinyint	1"
label variable BooleanInterState "Would you deal with interstate Transaction	T501094	tinyint	1"
label variable Boolean201011 "2010-11	T501095	tinyint	1"
label variable Boolean201112 "2011-12	T501096	tinyint	1"
label variable Boolean201213 "2012-13	T501097	tinyint	1"
label variable ServiceTaxNumber "Service TAX No.	T501098	varchar	11"
label variable Floor "Floor	T501099	varchar	15"
label variable OpenArea "Area Open	T501100	decimal	9"
label variable CoveredArea "Area Covered	T501101	decimal	9"
label variable BooleanCounsel "Whether Counsel is	T501102	tinyint	1"
label variable CounselEmail "Counsel EmailID	T501103	varchar	100"
label variable ProprietorName "Proprietor Name	T501104	varchar	100"
label variable BooleanThirdPartyStorage "whether using Third Party storage	T501105	tinyint	1"
label variable BooleanSurveyFilled "whether filled surety	T501106	tinyint	1"
label variable ThirdPartyAddress "Address of Third Party	T501107	varchar	500"
label variable GTONil201213 "was the GTO nil in 2012-13	T501108	bigint	8"
label variable PhysicalWard "ward as per physical location	T501109	bigint	8"
label variable CounselName "Counsel Name	T501110	varchar	100"
label variable CounselMobile "Counsel mobile No.	T501111	varchar	11"
label variable ProprietorPAN "Proprietor PAN	T501112	varchar	10"
label variable VatoActionDate "Date of vato action for manual registration to fill form	T501113	smalldatetime	4"
label variable BooleanRegisteredIEC "Whether registered in IEC	T501114	tinyint	1"
label variable BooleanRegisteredCE "Whether registered in Central Excise	T501115	tinyint	1"
label variable BooleanServiceTax "Whether registered in Service TAX	T501116	tinyint	1"
label variable ServiceNoticeOpenArea "Area Open (Service Notice)	T501117	decimal	9"
label variable ServiceNoticeCoveredArea "Area Covered (Service Notice)	T501118	decimal	9"
label variable ServiceNoticeOtherFloor "floor if other (Service Notice)	T501119	varchar	max"
//Floor	T501120	varchar	15
label variable PANBusinessName "Name of Business (PAN of applicant dealer)	T501121	Varchar	200"

save "DealerProfile.dta", replace
