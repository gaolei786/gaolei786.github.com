clear 
set more off
cd "C:\Users\xpy\Desktop\PBCTJ"

use "MPICISSdata.dta", clear

* Define panel data
xtset iso2num datem

*Define global control vector 
global rhs l(0/4).CISS

*Pick impulse variables 
local impulse MPI BTI FITI

*Pick projection variables 
local response CISS 

*Define controls
local rhs $rhs

*Define horizon
local H 16


// duplicates drop Country, force



foreach x of local impulse  {
foreach y of local response {
	
	* Generate first difference of lp variable 
	sort iso2num datem
	gen `y'`x'_gr = `y'
	
	
	foreach y of local response {
		* Generate local projection variable with horizon H
		forvalues h = 0/`H' {
			sort iso2num datem
			gen d`y'`x'`h' = f`h'.`y' 
		}
	}

	
	* Generate "empty" variables in which to store IRF, SE and CI
	foreach y of local response {
		gen IRF`y'`x' = 0 if _n<=`H'+1 
		gen SE`y'`x' = 0 if _n<=`H'+1 

		gen CI_UP`y'`x' = 0 if _n<=`H'+1 
		gen CI_LO`y'`x' = 0 if _n<=`H'+1 

		gen CI_UP1`y'`x' = 0 if _n<=`H'+1 
		gen CI_LO1`y'`x' = 0 if _n<=`H'+1
	}

	
	* Estimate coefficients and standard errors
	sort iso2num datem
	foreach y of local response {
		forvalues h = 0/`H' { // loop over horizons 
			**LP
			qui xtreg d`y'`x'`h' `x' l(1/4).`y'`x'_gr `rhs' i.datem, fe vce(cluster iso2num)
			eststo IRF`y'`x'`h'

			* store IRF and SE
			lincom `x' 	// get coefficient for contemporary shock
			replace IRF`y'`x' = r(estimate) if _n==`h'+1 // store coefficient
			replace SE`y'`x' = r(se) if _n==`h'+1 // store standard error

			* confidence intervals, +/- 1 se and +/- 1.96 se	
			replace CI_UP`y'`x' = IRF`y'`x' + 1*SE`y'`x' if _n <= `H'+1 
			replace CI_LO`y'`x' = IRF`y'`x' - 1*SE`y'`x' if _n <= `H'+1
			
			replace CI_UP1`y'`x' = IRF`y'`x' + 1.96*SE`y'`x' if _n <= `H'+1 
			replace CI_LO1`y'`x' = IRF`y'`x' - 1.96*SE`y'`x' if _n <= `H'+1
		*_____________________________ PLOT RESULT ______________________
		}
	}

	
	* generate plot prerequisites
	foreach y of local response {
		gen quarters`y'`x' = _n-1 if(_n<=`H'+1) // quarter variable
		gen nil`y'`x' = 0 if(_n<=`H'+1) // 0 reference line

		* rescale (percent y-axis)
		replace CI_LO`y'`x' = CI_LO`y'`x'
		replace CI_UP`y'`x' = CI_UP`y'`x' 
		replace CI_LO1`y'`x' = CI_LO1`y'`x' 
		replace CI_UP1`y'`x' = CI_UP1`y'`x' 
		replace IRF`y'`x' = IRF`y'`x'

		* plot cumulative IRFs
		twoway (rarea CI_LO1`y'`x' CI_UP1`y'`x' quarters`y'`x' if quarters`y'`x' <= `H', fcolor(gs15) lcolor(gs15) lw(none) lpattern(solid)) /// confidence band
		(rarea CI_LO`y'`x' CI_UP`y'`x' quarters`y'`x' if quarters`y'`x' <= `H', fcolor(gs12) lcolor(gs12) lw(none) lpattern(solid)) /// confidence band
		(line IRF`y'`x' quarters`y'`x' if quarters`y'`x' <= `H', lcolor(blue) lwidth(thick)) /// impulse response
		(line nil`y'`x' quarters`y'`x' if quarters`y'`x' <= `H', lcolor(black) ), /// 0 reference line
		title("`y'`x'", color(black) size(medsmall)) /// title
		ytitle("Percent") /// y-axis label
		xtitle("Quarter") /// x-axis label
		graphregion(color(white)) plotregion(color(white)) ///
		legend(off) /// legend
		name(`y'`x',replace)
	}


	eststo clear
	
}
}

* set balanced panel
bysort iso2num: egen min_datem = min(datem)
egen maxmin_datem = max(min_datem)
drop if datem < maxmin_datem
drop min_datem maxmin_datem

* transform shock to BTI and interact with FITIcum;
gen BFITI = FITI*BTI

* time variable
bysort iso2num: gen t = _n
gen h = t - 1 

* Generate first difference of lp variable 
sort iso2num datem
gen CISS_gr = CISS


******* INITIALISE RESULT VECTORS *********** ;  
foreach depvar in CISS {
foreach shock in BTI BFITI{

  quietly gen b`depvar'`shock' = .
  quietly gen u90`depvar'`shock' = .
  quietly gen l90`depvar'`shock' = .
 
foreach eval in avg p20 p80 {

  quietly gen b`eval'`depvar'`shock' = .
  quietly gen u90`eval'`depvar'`shock' = .
  quietly gen l90`eval'`depvar'`shock' = .

}
}
}


scalar avg_FITI = 0
scalar p20_FITI = -1
scalar p80_FITI = 1


di "均值：" avg_FITI
di "20%分位数：" p20_FITI
di "80%分位数：" p80_FITI

forvalues i = 0/16 {
foreach y of local response {
	qui xtreg f`i'.CISS BTI BFITI l(1/4).CISS_gr `rhs' i.datem, fe vce(cluster iso2num)
	est store `y'`i'
	
	gen b`y'BTIh`i' = _b[BTI]
	gen se`y'BTIh`i' = _se[BTI]
	gen b`y'BFITIh`i' = _b[BFITI]
	gen se`y'BFITIh`i' = _se[BFITI]
	
	quietly replace b`y'BTI  = b`y'BTIh`i' if h==`i'
	quietly replace u90`y'BTI  = b`y'BTIh`i' + 1.65*se`y'BTIh`i' if h==`i'
	quietly replace l90`y'BTI  = b`y'BTIh`i' - 1.65*se`y'BTIh`i' if h==`i'
	
	quietly replace b`y'BFITI  = b`y'BFITIh`i' if h==`i'
	quietly replace u90`y'BFITI  = b`y'BFITIh`i' + 1.65*se`y'BFITIh`i' if h==`i'
	quietly replace l90`y'BFITI  = b`y'BFITIh`i' - 1.65*se`y'BFITIh`i' if h==`i'
	
	foreach eval in avg p20 p80 {

		quietly lincom _b[BTI] + _b[BFITI]*`eval'_FITI

		gen b`y'BTIh`i'`eval' = r(estimate)
		gen se`y'BTIh`i'`eval' = r(se)

		quietly replace b`eval'`y'BTI  = b`y'BTIh`i'`eval' if h==`i'
		quietly replace u90`eval'`y'BTI  = b`y'BTIh`i'`eval' + 1.65*se`y'BTIh`i'`eval' if h==`i'
		quietly replace l90`eval'`y'BTI  = b`y'BTIh`i'`eval' - 1.65*se`y'BTIh`i'`eval' if h==`i'
	}
	drop b`y'BTIh`i'* se`y'BTIh`i'*
}
}

* plot cumulative IRFs
twoway (rarea l90p20CISSBTI u90p20CISSBTI h if h <= 16, fcolor(gs15) lcolor(gs15) lw(none) lpattern(solid)) /// confidence band 
(rarea l90p80CISSBTI u90p80CISSBTI h if h <= 16, fcolor(gs12) lcolor(gs12) lw(none) lpattern(solid))  /// confidence band
(line bp20CISSBTI h if h <= 16 & iso2=="AT", lcolor(blue) lwidth(thick)) /// impulse response
(line bp80CISSBTI h if h <= 16 & iso2=="AT", lcolor(black) lwidth(thick)), /// 0 reference line
title("CISS", color(black) size(medsmall)) /// title
ytitle("Percent") /// y-axis label
xtitle("Quarter") /// x-axis label
graphregion(color(white)) plotregion(color(white)) ///
legend(off) /// legend
name(CISS,replace)






