clear
cd "C:\Users\xpy\Desktop\PBCTJ"


use "IBRN_Prudential_Database_Aug2021_final.dta" ,clear
keep if country=="China"
gen BTI=cum_ltv_cap
gen FITI=cum_PruC - cum_ltv_cap
collapse (mean) BTI FITI cum_PruC ltv_cap PruC, by(year) 

drop if year<2007
tsset year
merge 1:1 year using "宏观EDB.dta", nogen
merge 1:1 year using "宏观lev.dta", nogen
merge 1:m year using "bankdata.dta", nogen
drop if year>2021

// 定义面板数据
sort Bankcd year
xtset Bankcd year
gen SRGDP = SR/GDP

gen BFITI = BTI*FITI

// 表1
sum Zscore Nplra cum_PruC BTI FITI IS DS lev lnasset GDP levH levF levB 

rename cum_PruC MPI
rename lnasset LNASSET
rename lev LEV
rename levH LEVH
rename levF LEVF
rename levB LEVB

// 表2
quietly reghdfe Zscore MPI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A11
quietly reghdfe Zscore BTI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A12
quietly reghdfe Zscore FITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A13
quietly reghdfe Zscore BTI FITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A14
quietly reghdfe Zscore BTI FITI BFITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A15
esttab A11 A12 A13 A14 A15, order(MPI BTI FITI BFITI) r2 ar2 se scalar(rmse) stats(N, labels("Observations")) star(* 0.1 ** 0.05 *** 0.01)


// 表4
quietly reghdfe Nplra MPI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A11
quietly reghdfe Nplra BTI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A12
quietly reghdfe Nplra FITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A13
quietly reghdfe Nplra BTI FITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A14
quietly reghdfe Nplra BTI FITI BFITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A15
esttab A11 A12 A13 A14 A15, order(MPI BTI FITI BFITI) r2 ar2 se scalar(rmse) stats(N, labels("Observations")) star(* 0.1 ** 0.05 *** 0.01)


// 表5(1)(2) 
quietly reghdfe Zscore l.Zscore BTI FITI BFITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A11
quietly reghdfe Nplra l.Nplra BTI FITI BFITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A12
esttab A11 A12, order(MPI BTI FITI BFITI) r2 ar2 se scalar(rmse) stats(N, labels("Observations")) star(* 0.1 ** 0.05 *** 0.01)



*****************************替换宏观审慎政策指数***************
use "iMaPP.dta" ,clear
// drop bti fiti
// rename bti BTI 
// rename fiti FITI
// gen cum_PruC = BTI + FITI
drop BTI SUM_17
rename BTI_cum BTI
rename cum_PruC MPI
rename FITI_cum FITI

drop if year<2007
tsset year


// tsline BTI || tsline FITI
merge 1:1 year using "宏观EDB.dta", nogen
merge 1:1 year using "宏观lev.dta", nogen
merge 1:m year using "bankdata.dta", nogen
drop if year>2021

// 定义面板数据
sort Bankcd year
xtset Bankcd year
gen SRGDP = SR/GDP
gen BFITI = BTI*FITI

rename lnasset LNASSET
rename lev LEV
rename levH LEVH
rename levF LEVF
rename levB LEVB


// 表3
quietly reghdfe Zscore MPI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A11
quietly reghdfe Zscore BTI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A12
quietly reghdfe Zscore FITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A13
quietly reghdfe Zscore BTI FITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A14
quietly reghdfe Zscore BTI FITI BFITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)
eststo A15
esttab A11 A12 A13 A14 A15, order(MPI BTI FITI BFITI) r2 ar2 se scalar(rmse) stats(N, labels("Observations")) star(* 0.1 ** 0.05 *** 0.01)
outreg2[A11 A12 A13 A14 A15] using "C:\Code_world\PBCTJ\Table1.doc", replace           ///
        tstat bdec(3) tdec(2) ctitle(y)  ///
        keep(MPI BTI FITI BFITI IS DS LEV LNASSET GDP LEVH LEVF LEVB $Xs)             ///
        addtext(Bankcd FE, YES)

// 表5(3)
reghdfe Zscore l.Zscore BTI FITI BFITI IS DS LEV LNASSET GDP LEVH LEVF LEVB, absorb(Bankcd) vce(cluster Bankcd)







