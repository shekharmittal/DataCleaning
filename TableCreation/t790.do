//Do not know what this table is for
cd "D:\data\"
odbc load, table("dbo.t790") clear noquote

rename T790001 id
rename T790002 DealerTIN
rename T790003 CommodityCode
rename T790004 CommodityDescription

gsort DealerTIN -idDP CommodityCode

merge m:1 idDP DealerTIN using "DataVerification\step4\DealerProfile_uniquetinandid.dta", keepusing(RegistrationDate)

/*
So this is something else!
(note: variable idDP was str8, now str19 to accommodate using data's values)
(note: variable DealerTIN was str8, now str25 to accommodate using data's values)

    Result                           # of obs.
    -----------------------------------------
    not matched                     1,853,403
        from master                 1,379,125  (_merge==1)
        from using                    474,278  (_merge==2)

    matched                                 0  (_merge==3)
    -----------------------------------------

. 
end of do-file
*/

