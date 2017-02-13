*******************************************************************
/* Code cleaning and Verfication exercise
Step 1: Merge 2A-2B with returns
Step 2: Merge returns with commodity codes
Step 3: Merge returns with DP-1
Step 4: Merge commodity codes with DP-1
*******************************************************************
Step 5: What are the number of returns per Tin
*******************************************************************
Step 6: Try and see what are the unique id combinations in each file. Keep the log.
Step 7: Calculate unique tins in each file and compare with each other
Step 8: Check how many unique tin numbers are matching up with each other
Step 9 : Merge cancelled Dealers with returns data and dealer profiles
*/
*******************************************************************
cd "D:\data"

use "form16_data.dta", clear

gsort  DealerTIN TaxPeriod -id
by DealerTIN TaxPeriod: gen ReturnCount = _n
drop if ReturnCount!=1

by DealerTIN: gen TotalReturns=_n

/* 
. tab TotalReturns

TotalReturn 
s       Freq.	Percent	Cum.
		
1     336,305	7.70	7.70
2     318,690	7.29	14.99
3     302,386	6.92	21.91
4     288,371	6.60	28.51
5     271,929	6.22	34.73
6     259,517	5.94	40.67
7     248,058	5.68	46.34
8     237,908	5.44	51.79
9     226,074	5.17	56.96
10     212,602	4.86	61.82
11     198,398	4.54	66.36
12     182,830	4.18	70.55
13     171,989	3.94	74.48
14     165,039	3.78	78.26
15     145,917	3.34	81.60
16     136,218	3.12	84.72
17      93,779	2.15	86.86
18      88,924	2.03	88.90
19      80,993	1.85	90.75
20      77,267	1.77	92.52
21      18,290	0.42	92.94
22      18,005	0.41	93.35
23      17,769	0.41	93.75
24      17,489	0.40	94.15
25      17,028	0.39	94.54
26      16,725	0.38	94.93
27      16,462	0.38	95.30
28      16,213	0.37	95.67
29      13,821	0.32	95.99
30      13,549	0.31	96.30
31      13,473	0.31	96.61
32      13,377	0.31	96.92
33      13,290	0.30	97.22
34      13,191	0.30	97.52
35      13,087	0.30	97.82
36      12,914	0.30	98.12
37      10,790	0.25	98.36
38      10,486	0.24	98.60
39      10,383	0.24	98.84
40      10,252	0.23	99.08
41      10,078	0.23	99.31
42       9,991	0.23	99.53
43       9,888	0.23	99.76
44       9,651	0.22	99.98
45         787	0.02	100.00
46          11	0.00	100.00
47           3	0.00	100.00
48           1	0.00	100.00
49           1	0.00	100.00
		
Total   4,370,199	100.00
*/
