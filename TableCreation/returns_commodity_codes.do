
cd "D:\data\"
* First we create the data file for commodity codes
odbc load, table("dbo.T771") noquote clear
rename T771001 id
rename T771002 DealerTIN
rename T771003 CommodityCode
rename T771004 CommodityDescription
rename T771005 CommodityPercentageContribution
rename T771009 CommodityActualContribution
rename T771008 CommodityTaxRate
rename T771006 CommodityType


label variable id "This is the return id"



save "TableCommodityCode.dta", replace
