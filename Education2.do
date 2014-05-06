*17.871: Individual Project
*Spring 2011

clear
clear matrix
set mem 200m

*Do-file No. 2

use "/afs/athena.mit.edu/user/j/u/jumanji/Documents/Political Science Lab/Individual Project/PAA_2003_labeled.dta"

*normalize all scores from 0 to 1
gen normptpn = (ptpn/95.466)
label var normptpn "Normalizacion de puntaje transformado del promedio de notas"
gen normptrv = (ptrv /96.688)
label var normptrv "Normalizacion de puntaje transformado del razonamiento verbal"
gen normpthn = (pthn/135.162)
label var normpthn "Normalizacion de puntaje transformado de Habilidad Numerica"

*combined achievement score
gen comba = (normpthn+normptrv)/2
*comba not inclusive of grades
gen combb = (normpthn + normptrv + normptpn) / 3
*combb inclusive of grades

*dropping 14, 15, and 16 -- no information given, total of 1678, 150 and 66 resp.
drop if (rem == 14)
drop if (rem == 15)
drop if (rem == 16)

*indeterminate categories, temporary
drop if (rem == 1)
drop if (rem == 13)
drop if (rem == 99)
drop if (rem == 5)
drop if (rem == 7)
drop if (rem == 10)

*still 47 observations left with cat_edu = 0, temporarily dropping
drop if (cat_edu == 0)

*scatter comba cat_edu ||lfit comba cat_edu

*graph box comba, over(cat_edu)
regress comba cat_edu

*Normalizing control variables:
gen nsexo = sexo
replace nsexo = . if nsexo==9
replace nsexo = (nsexo-1)

gen nedo_civ = edo_civ
replace nedo_civ = . if nedo_civ==9
replace nedo_civ = (nedo_civ-1)

gen nsw_trab = sw_trab
replace nsw_trab = . if nsw_trab == 9
replace nsw_trab = (nsw_trab-1)

* Go back to efr
gen nefr = efr
replace nefr = . if nefr == 99

* Go back to efp
gen nefp = efp
replace nefp = . if nefp == 99

gen ndepen = depen
replace ndepen = . if ndepen == 9
replace ndepen = (ndepen - 1)

gen nsistema = sistema
replace nsistema = . if nsistema == 9
replace nsistema = (nsistema - 1)/2

gen nturno = turno
replace nturno = . if nturno == 9
replace nturno = (nturno - 1)

* Go back to aa_gr
gen naa_gr = aa_gr
replace naa_gr = . if naa_gr < 1900

* Ignore rem, rama de educacion media

gen npjf = pjf
replace npjf = . if npjf == 9
replace npjf = (npjf -1)/4

gen nnim = nim
replace nnim = . if nnim == 9
replace nnim = (nnim - 1)/4

gen nnip = nip
replace nnip = . if nnip == 9
replace nnip = (nnip -1)/4

gen nfif = fif
replace nfif = . if nfif == 9
replace nfif = (nfif - 1)/4

gen nca = ca
replace nca = . if nca == 9
replace nca = (nca - 1)/4

gen nin_fa = in_fa
replace nin_fa = . if nin_fa == 9
replace nin_fa = (nin_fa - 1)/4

gen ncos = cos
replace ncos = . if ncos == 9
replace ncos = (ncos - 1)/4

/*
* Go back to this later please

gen ntrans = trans
replace ntrans = . if ntrans == 9
replace ntrans = (ntrans - 1)/4
*/

gen nnseok = nseok
replace nnseok = . if nnseok == 9
replace nnseok = (nnseok - 1)/4

* Ask whether can code by schools

*regress comba cat_edu
*regress comba cat_edu nedo_civ nturno naa_gr npjf nnim ///
*nnip nfif nca nin_fa ncos nnseok


*Recode cat_edu from 0 to 1, 0 is estudios humanisticos, 1 is estudios cientificos
replace cat_edu = 0 if (cat_edu == 1)
replace cat_edu = 1 if (cat_edu == 2)
label define cat_edu2 0 "estudios humanisticos" 1 "estudios cientificos"
label values cat_edu cat_edu2


*summarize comba cat_edu nedo_civ nturno naa_gr npjf nnim ///
*nnip nfif nca nin_fa ncos nnseok

*scatter nnim cat_edu || lfit nnim cat_edu

*Get rid of nnseok

summarize comba cat_edu nedo_civ nturno naa_gr npjf nnim ///
nnip nfif nca nin_fa ncos

*Translate to english variables:
gen verbal_reasoning = normptrv
gen mathematical_reasoning = normpthn
gen combined_scores = comba
gen educational_specialization = cat_edu
gen marital_status = nedo_civ
gen school_shift = nturno
gen graduation_year = naa_gr
gen breadwinner_professional_level = npjf
gen mother_education = nnim
gen father_education = nnip
gen income_source = nfif
gen lodging_conditions = nca
gen family_income = nin_fa
gen tuition_source = ncos

summarize combined_scores educational_specialization marital_status ///
school_shift graduation_year breadwinner_professional_level mother_education ///
father_education income_source lodging_conditions family_income tuition_source

*Outreg command
*outreg2 using table, se auto(2) e(rmse) replace word

*box plot
*graph box combined_scores educational_specialization, over(educational_specialization)

regress combined_scores educational_specialization marital_status ///
school_shift graduation_year breadwinner_professional_level mother_education ///
father_education income_source lodging_conditions family_income tuition_source


*second model regression

gen school_state_development = efp
replace school_state_development = . if school_state == 99
*19524 missing
replace school_state_development = 1 if school_state == 11
replace school_state_development = 1 if school_state == 12
replace school_state_development = 1 if school_state == 13
replace school_state_development = 1 if school_state == 21
replace school_state_development = 1 if school_state == 22
replace school_state_development = 0 if school_state == 23
replace school_state_development = 0 if school_state == 31
replace school_state_development = 0 if school_state == 32
replace school_state_development = 1 if school_state == 41
replace school_state_development = 1 if school_state == 42
replace school_state_development = 0 if school_state == 43
replace school_state_development = 0 if school_state == 44
replace school_state_development = 1 if school_state == 51
replace school_state_development = 0 if school_state == 61
replace school_state_development = 0 if school_state == 62
replace school_state_development = 1 if school_state == 63
replace school_state_development = 0 if school_state == 64
replace school_state_development = 1 if school_state == 71
replace school_state_development = 1 if school_state == 72
replace school_state_development = 1 if school_state == 73
replace school_state_development = 0 if school_state == 74
replace school_state_development = 1 if school_state == 81
replace school_state_development = 0 if school_state == 82
replace school_state_development = 0 if school_state == 83
replace school_state_development = . if school_state == 90


regress combined_scores educational_specialization marital_status ///
school_shift graduation_year breadwinner_professional_level mother_education ///
father_education income_source lodging_conditions family_income tuition_source ///
school_state_development

*Outreg command
*outreg2 using table, se auto(2) e(rmse) replace word

*Introduce indicator variables
xi: regress combined_scores educational_specialization i.marital_status ///
i.school_shift i.graduation_year i.breadwinner_professional_level i.mother_education ///
i.father_education i.income_source i.lodging_conditions i.family_income i.tuition_source 

xi: regress combined_scores educational_specialization i.marital_status ///
i.school_shift i.graduation_year i.breadwinner_professional_level i.mother_education ///
i.father_education i.income_source i.lodging_conditions i.family_income i.tuition_source ///
i.school_state_development

*Finding difference of means
sum if educational_specialization == 0
*mean combined scores is .4298071
sum if educational_specialization == 1
*mean combined scores is .4179076

gen mean_diff = 0
replace mean_diff =(.4298071-combined_scores) if educational_specialization == 0
replace mean_diff = (.4179076-combined_scores) if educational_specialization == 1

*scatter mean_diff educational_specialization || lfit mean_diff educational_specialization
