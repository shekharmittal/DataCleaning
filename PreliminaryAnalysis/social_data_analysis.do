search nwcommands
net install nwcommands-ado.pkg
net get nwcommands-ado.pkg
net install nwcommands-ext.pkg
net install nwcommands-hlp.pkg
net install nwcommands-dlg.pkg

cd "D:\data\"


set maxvar 32767
use "annexure_2A2B_quarterly_2014.dta", clear
keep if SourceFile=="t9854114"
keep if SaleOrPurchase=="AE"
gsort DealerTIN SellerBuyerTIN

by DealerTIN: gen DealerCount=_n


//Doing this just to try if nwfromedge command works or not.
by DealerTIN: gen DealerCount=_n
keep if DealerCount==1

drop DealerCount
gen DealerCount=_n



nwfromedge DealerTIN SellerBuyerTIN, name(traders)
nwplot traders
