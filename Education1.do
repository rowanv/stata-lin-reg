*17.871: Individual Project
*Spring 2011

*Do-file No. 1

clear
set mem 100m

use "/afs/athena.mit.edu/user/j/u/jumanji/Documents/Political Science Lab/Individual Project/PAA_2003.dta"

*Label variables according to codebook
label var nac "Nacionalidad"
label var sexo "Sexo"
label var edo_civ "Estado Civil"
label var edad "Edad"
label var sw_trab "Condicion de Trabajo"
label var efr "Entidad Federal de Residencia"
label var efp "Entidad Federal del Plantel"
label var depen "Dependencia del Plantel"
label var sistema "Sistema de Estudio"
label var turno "Turno"
label var aa_gr "Ano de graduacion"
label var rem "Rama de Educacion Media"
label var pjf "Profesion del Jefe de la Familia"
label var nim "Nivel de Instruccion de la Madre"
label var nip "Nivel de Instruccion del Padre" //not in code file but seems reasonable
label var fif "Fuente del Ingreso Familiar"
label var ca "Condicion de Alojamiento"
label var in_fa "Ingreso Familiar"
label var grp "Grupo Familiar"
label var cos "Costeo de Estudios"
label var trans "Transporte"
label var nse "Nivel Socio-Economico"
label var nseok "Nivel Socio-Economico Codificado"
label var p_n "Promedio de Notas"
label var r_v "Puntaje Bruto de Razonamiento Verbal"
label var h_n "Puntaje Bruto de Habilidad Numerica"
label var ptpn "Puntaje Transformado del Promedio de Notas"
label var ptrv "Puntaje Transformado de Razonamiento Verbal"
label var pthn "Puntaje Transformado de Habilidad Numerica"
label var ia "Indice Academico"
label var indice "Indice Academico Codificado"
label var codpfpla "Codigo del Plantel de Educacion Media"
label var proceso "Ano de Proceso"
label var codpf "Copia de codpfpla"

*Create pnok
gen pnok = 0
label var pnok "Promedio de Notas Codificado"
replace pnok = 1 if (p_n <= 10)
replace pnok = 2 if (p_n <=11) & (p_n > 10)
replace pnok = 3 if (p_n <=12) & (p_n > 11)
replace pnok = 4 if (p_n <=13) & (p_n > 12)
replace pnok = 5 if (p_n <=14) & (p_n > 13)
replace pnok = 6 if (p_n <=15) & (p_n > 14)
replace pnok = 7 if (p_n <=16) & (p_n > 15)
replace pnok = 8 if (p_n <=17) & (p_n > 16)
replace pnok = 9 if (p_n <=18) & (p_n > 17)
replace pnok = 10 if (p_n <=19) & (p_n > 18)
replace pnok = 11 if (p_n <=20) & (p_n > 19)

*Label variable specifics
destring nac, replace
label define nac1 1 "Venezolano" 2 "Extranjero" 9 "Sin informacion"
label values nac nac1

destring sexo, replace
label define sexo1 1 "masculino" 2 "femenino" 9 "sin informacion"
label values sexo sexo1

destring edo_civ, replace
label define edo_civ1 1 "casado" 2 "soltero" 3 "viudo" 4 "otro" 9 "sin informacion"
label values edo_civ edo_civ1

destring sw_trab, replace
label define sw_trab1 1 "trabaja" 2 "no trabaja" 9 "sin informacion"
label values sw_trab sw_trab1

destring efr, replace
label define efr1 11 "area metropolitana" 12 "miranda" 13 "vargas" 21 "aragua" ///
		22 "carabobo" 23 "cojedes" 31 "apure" 32 "guarico" 41 "falcon" ///
		42 "lara" 43 "portuguesa" 44 "yaracuy" 51 "zulia" 61 "barinas" ///
		62 "merida" 63 "tachira" 64 "trujillo" 71 "anzoategui" 72 "monagas" ///
		73 "nva.esparta" 74 "sucre" 81 "bolivar" 82 "amazonas" 83 "delta amacuro" ///
		90 "extranjeros" 99 "sin informacion"
label values efr efr1

destring efp, replace
label define efp1 11 "area metropolitana" 12 "miranda" 13 "vargas" 21 "aragua" ///
		22 "carabobo" 23 "cojedes" 31 "apure" 32 "guarico" 41 "falcon" ///
		42 "lara" 43 "portuguesa" 44 "yaracuy" 51 "zulia" 61 "barinas" ///
		62 "merida" 63 "tachira" 64 "trujillo" 71 "anzoategui" 72 "monagas" ///
		73 "nva.esparta" 74 "sucre" 81 "bolivar" 82 "amazonas" 83 "delta amacuro" ///
		90 "extranjeros" 99 "sin informacion"
label values efp efp1

*have to replace PRIVADA and PUBLICO as numeric values
drop if (depen=="PUBLICO")
drop if (depen=="PRIVADA")
destring depen, replace
label define depen1 1 "publico" 2 "privado" 9 "sin informacion"
label values depen depen1

destring sistema, replace
label define sistema1 1 "regular" 2 "educ. adul." 3 "otro" 9 "sin informacion"
label values sistema sistema1

destring turno, replace
label define turno1 1 "diurno" 2 "nocturno" 9 "sin informacion"
label values turno turno1

destring rem, replace
label define rem1 1 "administracion" 2 "aeronautica" 3 "agropecuaria" 4 "artes" 5 "asistencial" ///
		6 "ciencias" 7 "comercio" 8 "comunicacion" 9 "industrial" 10 "docente" ///
		11 "humanidades" 12 "ccs. humd" 13 "otra" 99 "sin informacion"
*humanidades = 4, 8, 11, 12 ciencias = 2, 3, 6, 9 n/a = 1, 13, 99, 5, 7, 10
label values rem rem1

destring pjf, replace
label define pjf1 1 "universitario o ejecutivo" 2 "tecnico" 3 "empleado" 4 "obrero especializado" ///
		5 "obrero no especializado" 9 "sin informacion"
label values pjf pjf1

destring nim, replace
label define nim1 1 "universitaria" 2 "secundaria completa" 3 "secundaria incompleta" 4 "primaria" ///
		5 "analfabeta" 9 "sin informacion"
label values nim nim1

destring nip, replace
label define nip1 1 "universitaria" 2 "secundaria completa" 3 "secundaria incompleta" 4 "primaria" ///
		5 "analfabeta" 9 "sin informacion"
label values nip nip1

destring fif, replace
label define fif1 1 "herencia/inversion en empresas" 2 "honorarios profesionales" 3 "sueldos" ///
		4 "salarios" 5 "ingreso ocacional" 9 "sin informacion"
label values fif fif1

destring ca, replace
label define ca1 1 "lujoso" 2 "espacioso" 3 "reducido/condiciones sanitarias normales" ///
		4 "reducido/condiciones sanitarias deficientes" 5 "muy deficiente" 9 "sin informacion"
label values ca ca1

destring in_fa, replace
label define in_fa1 1 "rango 1" 2 "rango 2" 3 "rango 3" 4 "rango 4" 5 "rango 5" 9 "sin informacion"
label values in_fa in_fa1

destring grp, replace
label define grp1 1 "3 personas o menos" 2 "4 personas" 3 "5 personas" 4 "6 personas" 5 "7 personas" ///
		9 "sin informacion"
label values grp grp1

*Issues with trans
*destring trans, replace
*label define trans1 1 "vehiculo propio" 2 "vehiculo de sus padres" 3 "de sus amigos" 4 "transporte///
*		de la institucion" 5 "transporte publico" 9 "sin informacion"
*label values trans trans1

destring cos, replace
label define cos1 1 "aporte de sus padres" 2 "contribucion de familiar" 3 "becado por la institucion" ///
		4 "credito educativo" 5 "trabajo del estudiante" 9 "sin informacion"
label values cos cos1

destring nseok, replace
label define nseok1 1 "alta" 2 "media-alta" 3 "media-baja" 4 "obrera" 5 "marginal" 9 "sin informacion"
label values nseok nseok1

destring indice, replace
label define indice1 1 "ia < 45" 2 "45 =< ia < 60" 3 "ia >= 60" 9 "sin informacion"

destring codpfpla, replace
*parroquia is a string
*municipio is a string
*nombre_est is a string
destring cod_mun, replace

generate cat_edu = 0
label define cat_edu1 1 "estudios humanisticos" 2 "estudios cientificos" 3 "ninguno"
label values cat_edu cat_edu1
replace cat_edu = 1 if (rem == 4) 
replace cat_edu = 1 if (rem == 8) 
replace cat_edu = 1 if (rem == 11)
replace cat_edu = 1 if (rem == 12)
replace cat_edu = 2 if (rem == 2) 
replace cat_edu = 2 if (rem == 3) 
replace cat_edu = 2 if (rem == 6) 
replace cat_edu = 2 if (rem == 9)
replace cat_edu = 3 if (rem == 1) 
replace cat_edu = 3 if (rem == 13) 
replace cat_edu = 3 if (rem == 99) 
replace cat_edu = 3 if (rem == 5) 
replace cat_edu = 3 if (rem == 7) 
replace cat_edu = 3 if (rem == 10)
*humanidades = 4, 8, 11, 12 ciencias = 2, 3, 6, 9 n/a = 1, 13, 99, 5, 7, 10
*14, 15 y 16 de rem???

*Preliminary bivariate regressions
*scatter ptpn ptrv, by(cat_edu)|| lfit ptpn ptrv
*scatter ptpn pthn, by(cat_edu)|| lfit ptpn pthn
 
