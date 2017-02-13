cd "D:\data"

odbc load, table("dbo.r438") clear noquote

rename R438001 idDP
rename R438002 CommodityDescription
rename R438003 CommodityCode
rename R438004 DealerTIN

save "TableCommodityCodeforDealerProfile.dta"
