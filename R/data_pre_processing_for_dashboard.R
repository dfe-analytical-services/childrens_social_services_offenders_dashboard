# This script contains the manipulation of data used in the dashboard

# Transform raw data from analysis output (after is has been suppressed)
# Make data long

# Make pre-processing a function so it won't run when running app 
pre_prop <- function(){
  
# Read in dummy data ----
# Create empty vector (same length as number of sheets) to store results

# Get sheet names to list of data - this will make it easier when
 sheetNames <- getSheetNames("data/Dummy_data.xlsx")
 no_sheets <- length(sheetNames)
 alldata <- vector("list", no_sheets)
 for (i in 1:no_sheets){
   alldata[[i]] <- read_excel("data/Dummy_data.xlsx", sheet = i)

 }
names(alldata) <- sheetNames

# Data needed for 'Demographics' tab -------------------------------------------

# LA info data table (Number and % of pupils/(sv)offenders, Home vs school diff, % sv with prior offence)
# Gender
# FSM (and FSM waffle)
# Ethnicity
# Age at first offence

# LA info data table -----------------------------------------------------------

# Tables needed for data table
table_list <- c("No_pupils_sclLA", "No_pupils_hmLA", "scl_with_dif_hm", "hm_with_dif_scl", "previous_offence_sclLA", "previous_offence_hmLA")

# Add tables currently needed to environment
list2env(alldata[table_list], envir = .GlobalEnv)

# Select variables wanted from each table and join them together
# Will have 2 rows per La (home and school)
No_pupils_sclLA <- No_pupils_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
No_pupils_hmLA <- No_pupils_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)

scl_with_dif_hm <- scl_with_dif_hm %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA) %>%
  select(LA, indicator, count_all_dif, count_any_dif, count_sv_dif, prop_count_all_dif, prop_count_any_dif, prop_count_sv_dif)
hm_with_dif_scl <- hm_with_dif_scl %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA) %>%
  select(LA, indicator, count_all_dif, count_any_dif, count_sv_dif, prop_count_all_dif, prop_count_any_dif, prop_count_sv_dif)

previous_offence_sclLA <- previous_offence_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA) %>% select(!sv)
previous_offence_hmLA <- previous_offence_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA) %>% select(!sv)

# Left join home tables together, then left just school tables together
tables_scl <- full_join(No_pupils_sclLA, scl_with_dif_hm, by=c("LA", "indicator")) %>% full_join(previous_offence_sclLA, by=c("LA", "indicator"))
tables_hm <- full_join(No_pupils_hmLA, hm_with_dif_scl, by=c("LA", "indicator")) %>% full_join(previous_offence_hmLA, by=c("LA", "indicator"))

# join above tables together
info_table <- bind_rows(tables_scl, tables_hm)
rm(tables_scl, tables_hm,No_pupils_sclLA, scl_with_dif_hm,previous_offence_sclLA, No_pupils_hmLA, hm_with_dif_scl,previous_offence_hmLA)
info_table <- info_table %>% select(LA, indicator, all, offenders, sv, prop_off, prop_sv, count_previous, prop_previous,
                                    count_all_dif, count_any_dif, count_sv_dif, prop_count_all_dif, prop_count_any_dif, prop_count_sv_dif)


# Gender -----------------------------------------------------------------------
# Add tables currently needed to environment
list2env(alldata[c("Gender_hmLA", "Gender_sclLA")], envir = .GlobalEnv)
# Make Gender 1 long dataframe (combine Gender_hmLA and Gender_sclLA)
# Create an indicator for home or school and change Home/school_LA to LA
Gender_hmLA <- Gender_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)
Gender_sclLA <- Gender_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
# Join above tables
Gender <- bind_rows(Gender_hmLA, Gender_sclLA)
rm(Gender_hmLA, Gender_sclLA)
# Make Gender table long
Gender_all <- Gender %>% select(LA, indicator, prop_count_M, prop_count_F) %>% mutate(group = "All Pupils") %>%
  pivot_longer(cols = c(prop_count_M, prop_count_F), names_to = "Gender", values_to = "perc") %>%
  mutate(Gender = ifelse(str_detect(Gender,"_M")==TRUE , "Male", "Female"))

Gender_any <- Gender %>% select(LA, indicator, prop_any_count_M, prop_any_count_F) %>% mutate(group = "Any Offence") %>%
  pivot_longer(cols = c(prop_any_count_M, prop_any_count_F), names_to = "Gender", values_to = "perc") %>%
  mutate(Gender = ifelse(str_detect(Gender,"_M")==TRUE , "Male", "Female"))

Gender_sv <- Gender %>% select(LA, indicator, prop_sv_count_M, prop_sv_count_F) %>% mutate(group = "Serious Violence Offence") %>%
  pivot_longer(cols = c(prop_sv_count_M, prop_sv_count_F), names_to = "Gender", values_to = "perc") %>%
  mutate(Gender = ifelse(str_detect(Gender,"_M")==TRUE , "Male", "Female"))

Gender <- bind_rows(Gender_all, Gender_any, Gender_sv)
rm(Gender_all, Gender_any, Gender_sv)


# Ethnicity --------------------------------------------------------------------
# Add tables currently needed to environment
list2env(alldata[c("Ethnicity_major_hmLA", "Ethnicity_major_sclLA")], envir = .GlobalEnv)
# Make Ethnicity 1 long data frame (combine hmLA and sclLA)
# Create an indicator for home or school and change Home/school_LA to LA
Ethnicity_major_hmLA <- Ethnicity_major_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)
Ethnicity_major_sclLA <- Ethnicity_major_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
# Join above tables
Ethnicity <- bind_rows(Ethnicity_major_hmLA, Ethnicity_major_sclLA)
rm(Ethnicity_major_hmLA, Ethnicity_major_sclLA)
# Make Ethnicity table long
Ethnicity_all <- Ethnicity %>% select(LA, indicator, EthnicGroupMajor, prop_all) %>% mutate(group = "All Pupils") %>%
  pivot_longer(cols = c(prop_all), values_to = "perc") %>%
  select(!name)

Ethnicity_any <- Ethnicity %>% select(LA, indicator, EthnicGroupMajor, prop_off) %>% mutate(group = "Any Offence") %>%
  pivot_longer(cols = c(prop_off), values_to = "perc") %>%
  select(!name)

Ethnicity_sv <- Ethnicity %>% select(LA, indicator, EthnicGroupMajor, prop_sv) %>% mutate(group = "Serious Violence Offence") %>%
  pivot_longer(cols = c(prop_sv), values_to = "perc") %>%
  select(!name)

Ethnicity <- bind_rows(Ethnicity_all, Ethnicity_any, Ethnicity_sv)
rm(Ethnicity_all, Ethnicity_any, Ethnicity_sv)


# FSM --------------------------------------------------------------------------
# Add tables currently needed to environment
list2env(alldata[c("Everflag_hmLA", "Everflag_sclLA")], envir = .GlobalEnv)
# Make Ethnicity 1 long data frame (combine hmLA and sclLA)
# Create an indicator for home or school and change Home/school_LA to LA
Everflag_hmLA <- Everflag_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)
Everflag_sclLA <- Everflag_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
# Join above tables
Everflag <- bind_rows(Everflag_hmLA, Everflag_sclLA)
rm(Everflag_hmLA, Everflag_sclLA)
# Select ever flag for FSM
FSM <- Everflag %>% select(., contains(c("LA", "indicator","FSM")))
# Make FSM table long
FSM_all <- FSM %>% select(LA, indicator, prop_count_FSM) %>% mutate(group = "All Pupils") %>%
  pivot_longer(cols = c(prop_count_FSM), values_to = "perc") %>%
  select(!name)

FSM_any <- FSM %>% select(LA, indicator, any_prop_count_FSM) %>% mutate(group = "Any Offence") %>%
  pivot_longer(cols = c(any_prop_count_FSM), values_to = "perc") %>%
  select(!name)

FSM_sv <- FSM %>% select(LA, indicator, sv_prop_count_FSM ) %>% mutate(group = "Serious Violence Offence") %>%
  pivot_longer(cols = c(sv_prop_count_FSM ), values_to = "perc") %>%
  select(!name)

FSM <- bind_rows(FSM_all, FSM_any, FSM_sv)
rm(FSM_all, FSM_any, FSM_sv)


# FSM waffle -------------------------------------------------------------------
FSM_LHS <- Everflag %>% select(LA, indicator, sv_prop_count_FSM) %>% mutate(prop_sv_not_FSM =100-sv_prop_count_FSM)
FSM_RHS <- Everflag %>% select(LA, indicator, also_sv_prop_count_FSM) %>% mutate(not_also_sv_prop_count_FSM = 100 - also_sv_prop_count_FSM)
FSM_waffle <- full_join(FSM_LHS, FSM_RHS, by = c("LA", "indicator"))
rm(FSM_LHS, FSM_RHS)


# Age at first offence ---------------------------------------------------------
# Add tables currently needed to environment
list2env(alldata[c("Age_first_offence_sclLA", "Age_first_offence_hmLA")], envir = .GlobalEnv)
# Make age first offence a long data frame (combine hmLA and sclLA)
# Create an indicator for home or school and change Home/school_LA to LA
Age_first_offence_hmLA <- Age_first_offence_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)
Age_first_offence_sclLA <- Age_first_offence_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
# Join above tables
age_offence <- bind_rows(Age_first_offence_hmLA, Age_first_offence_sclLA)
rm(Age_first_offence_hmLA, Age_first_offence_sclLA)
# Make age long table
age_offence_any <- age_offence %>% select(LA, indicator, OffenceStartAge, prop_off) %>% mutate(group = "Any Offence") %>%
  pivot_longer(cols = c(prop_off), values_to = "perc") %>%
  select(!name)

age_offence_sv <- age_offence %>% select(LA, indicator, OffenceStartAge, prop_sv) %>% mutate(group = "Serious Violence Offence") %>%
  pivot_longer(cols = c(prop_sv), values_to = "perc") %>%
  select(!name)

age_offence <- bind_rows(age_offence_any, age_offence_sv)
rm(age_offence_any, age_offence_sv)

# Join 'demographics' tables together and write.xlsx ---------------------------
write_xlsx(list(info_table = info_table, Gender = Gender, Ethnicity = Ethnicity,
               FSM = FSM, FSM_waffle = FSM_waffle, age_offence = age_offence),
          'C:/Users/msettle/OneDrive - Department for Education/Documents/Projects (R)/childrens_social_services_offenders_dashboard/data/Demographics.xlsx')

# Data needed for "School Experience" tab ------------------------------------

# Attainment -> KS2 attainment , KS4 attainment , KS4 attainment by suspension/exclusion/PA
# PA -> EverPA/PAUO (incl waffle) , Time missed due to PA , Timing of PA
# Sus -> Ever (incl waffle) , Time missed due to sus , Timing of closest/first sus
# Excl -> Ever (incl waffle) , Time missed due to Excl , Timing of closest/first Excl
# AP -> Ever (incl waffle) , Time missed due to AP , Timing of AP
# SEN/sup/EHCP -> Ever (incl waffle) , Timing of SEN/sup/EHCP , Timing of SEMH

# Attainment -------------------------------------------------------------------

# Add tables currently needed to environment
list2env(alldata[c("KS2_attain_sclLA", "KS2_attain_hmLA", "KS4_attain_sclLA", "KS4_attain_hmLA")], envir = .GlobalEnv)
# KS2
# Create an indicator for home or school and change Home/school_LA to LA
KS2_attain_sclLA <- KS2_attain_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
KS2_attain_hmLA <- KS2_attain_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)
# Join above tables
KS2_attain <- bind_rows(KS2_attain_sclLA, KS2_attain_hmLA)
rm(KS2_attain_sclLA, KS2_attain_hmLA)

KS2_attain <- KS2_attain %>% select(LA, indicator, propcount_EngL4orabove, propcount_MatL4orabove,
                                    propcount_EngL4orabove_offenders, propcount_MatL4orabove_offenders,
                                    propcount_EngL4orabove_SV_offenders, propcount_MatL4orabove_SV_offenders) %>%
  pivot_longer(cols = c(propcount_EngL4orabove, propcount_MatL4orabove,
                        propcount_EngL4orabove_offenders, propcount_MatL4orabove_offenders,
                        propcount_EngL4orabove_SV_offenders, propcount_MatL4orabove_SV_offenders),
               names_to = "tempSubject", values_to = "perc") %>%
  mutate(group = ifelse(str_detect(tempSubject,"_SV_")==TRUE , "Serious Violence Offence",
                        ifelse(str_detect(tempSubject,"e_offenders")==TRUE, "Any Offence", "All Pupils"))) %>%
  mutate(Subject = ifelse(str_detect(tempSubject,"Eng")==TRUE , "English", "Maths")) %>%
  select(!tempSubject)

# KS4
KS4_attain_sclLA <- KS4_attain_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
KS4_attain_hmLA <- KS4_attain_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)
# Join above tables
KS4_attain <- bind_rows(KS4_attain_sclLA, KS4_attain_hmLA)
rm(KS4_attain_sclLA, KS4_attain_hmLA)

KS4_attain <- KS4_attain %>% select(LA, indicator, propcount_anypass, propcount_5AG, propcount_5AC,
                                    propanycount_anypass, propanycount_5AG, propanycount_5AC,
                                    propsvcount_anypass, propsvcount_5AG, propsvcount_5AC) %>%
  pivot_longer(cols = c(propcount_anypass, propcount_5AG, propcount_5AC,
                        propanycount_anypass, propanycount_5AG, propanycount_5AC,
                        propsvcount_anypass, propsvcount_5AG, propsvcount_5AC),
               names_to = "tempSubject", values_to = "perc") %>%
  mutate(group = ifelse(str_detect(tempSubject,"propsv")==TRUE , "Serious Violence Offence",
                        ifelse(str_detect(tempSubject,"propany")==TRUE, "Any Offence", "All Pupils"))) %>%
  mutate(Subject = ifelse(str_detect(tempSubject,"anypass")==TRUE , "Achieved any pass at GCSE or equiv.",
                        ifelse(str_detect(tempSubject,"5AG")==TRUE, "Achieved 5 or more GCSE (or equiv.) passes A* - G incl. English and Maths",
                               "Achieved 5 or more GCSE (or equiv.) passes A* - C incl. English and Maths"))) %>%
  select(!tempSubject)


# Persistent Absence -----------------------------------------------------------
## PA -> EverPA/PAUO (incl waffle) , ((??Time missed due to PA/UO)) , Timing of PA/UO
# Add tables currently needed to environment
list2env(alldata[c("PAPAUO_timing_sclLA", "PAPAUO_timing_hmLA")], envir = .GlobalEnv)

EverPAPAUO <- Everflag %>% select(LA, indicator, prop_count_PA, any_prop_count_PA, sv_prop_count_PA,
                                  prop_count_PAUO, any_prop_count_PAUO, sv_prop_count_PAUO) %>%
  pivot_longer(cols = c(prop_count_PA, any_prop_count_PA, sv_prop_count_PA,
                        prop_count_PAUO, any_prop_count_PAUO, sv_prop_count_PAUO),
               names_to = "tempAbsence", values_to = "perc") %>%
  mutate(group = ifelse(str_detect(tempAbsence,"sv_pr")==TRUE , "Serious Violence Offence",
                        ifelse(str_detect(tempAbsence,"any_p")==TRUE, "Any Offence", "All Pupils"))) %>%
  mutate(Absence = ifelse(str_detect(tempAbsence,"PAUO")==TRUE , "Persistent absence (unauthorised other)",
                          "Persistent absence")) %>%
  select(!tempAbsence)

# PA waffle
PA_waffle <- Everflag %>% select(LA, indicator, sv_prop_count_PA, also_sv_prop_count_PA) %>%
  mutate(prop_sv_not_PA = 100 - sv_prop_count_PA,
         not_also_sv_prop_count_PA = 100 - also_sv_prop_count_PA)

# PA/uo Timing
PAPAUO_timing_sclLA <- PAPAUO_timing_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
PAPAUO_timing_hmLA <- PAPAUO_timing_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)
# Join above tables
PAPAUO_timing <- bind_rows(PAPAUO_timing_sclLA, PAPAUO_timing_hmLA)
rm(PAPAUO_timing_sclLA, PAPAUO_timing_hmLA)

PAPAUO_timing <- PAPAUO_timing %>% select(LA, indicator, prop_PA_Before_SV, prop_PASame_Term, prop_PA_After_SV,
                                          prop_PAUO_Before_SV, prop_PAUOSame_Term, prop_PAUO_After_SV) %>%
  pivot_longer(cols = c(prop_PA_Before_SV, prop_PASame_Term, prop_PA_After_SV,
                        prop_PAUO_Before_SV, prop_PAUOSame_Term, prop_PAUO_After_SV),
               names_to = "tempAbsence", values_to = "perc") %>%
  mutate(Timing = ifelse(str_detect(tempAbsence,"Before")==TRUE , "Before the first serious violence offence",
                        ifelse(str_detect(tempAbsence,"Same")==TRUE, "In the same term as the first serious violence offence",
                               "After the first serious violence offence"))) %>%
  mutate(Absence = ifelse(str_detect(tempAbsence,"PAUO")==TRUE , "Persistent absence (unauthorised other)",
                          "Persistent absence")) %>%
  select(!tempAbsence)


# Suspension & Exclusion -------------------------------------------------------
# Sus -> Ever (incl waffle) , ((?Time missed due to sus) , Timing of closest/first sus
# Excl -> Ever (incl waffle) , ((?Time missed due to Excl) , Timing of closest/first Excl
# Add tables currently needed to environment
list2env(alldata[c("First_sus_timing_sclLA", "First_sus_timing_hmLA", "First_excl_timing_sclLA", "First_excl_timing_hmLA",
                   "Closest_sus_timing_sclLA", "Closest_sus_timing_hmLA", "Closest_excl_timing_sclLA", "Closest_excl_timing_hmLA")], envir = .GlobalEnv)

# Ever sus / excl
EverSusExcl <- Everflag %>% select(LA, indicator, prop_count_Sus, any_prop_count_Sus, sv_prop_count_Sus,
                                   prop_count_Excl, any_prop_count_Excl, sv_prop_count_Excl) %>%
  pivot_longer(cols = c(prop_count_Sus, any_prop_count_Sus, sv_prop_count_Sus,
                        prop_count_Excl, any_prop_count_Excl, sv_prop_count_Excl),
               names_to = "tempAbsence", values_to = "perc") %>%
  mutate(group = ifelse(str_detect(tempAbsence,"sv_")==TRUE , "Serious Violence Offence",
                        ifelse(str_detect(tempAbsence,"any_")==TRUE, "Any Offence", "All Pupils"))) %>%
  mutate(Absence = ifelse(str_detect(tempAbsence,"Sus")==TRUE , "Suspended",
                          "Permanently excluded")) %>%
  select(!tempAbsence)

# sus / excl waffle
SusExcl_waffle <- Everflag %>% select(LA, indicator, sv_prop_count_Excl, also_sv_prop_count_Excl,
                                      sv_prop_count_Sus, also_sv_prop_count_Sus) %>%
  mutate(prop_sv_not_Excl = 100 - sv_prop_count_Excl,
         not_also_sv_prop_count_Excl = 100 - also_sv_prop_count_Excl,
         prop_sv_not_Sus = 100 - sv_prop_count_Sus,
         not_also_sv_prop_count_Sus = 100 - also_sv_prop_count_Sus)

# Closest / First sus / excl
First_sus_timing_sclLA <- First_sus_timing_sclLA %>%
  mutate(indicator = "School", SusExcl = "Suspended", Time = "First") %>% rename(LA = SCHOOL_LA, prop_absencefirst_all= prop_susfirst_all) %>%
  select(!contains(c("count")) & !c(prop_svfirst, prop_susfirst))
First_sus_timing_hmLA <- First_sus_timing_hmLA %>%
  mutate(indicator = "Home", SusExcl = "Suspended", Time = "First") %>% rename(LA = HOME_LA, prop_absencefirst_all= prop_susfirst_all)%>%
  select(!contains(c("count")) & !c(prop_svfirst, prop_susfirst))
First_excl_timing_sclLA <- First_excl_timing_sclLA %>%
  mutate(indicator = "School", SusExcl = "Permanently excluded", Time = "First") %>% rename(LA = SCHOOL_LA, prop_absencefirst_all = prop_exclfirst_all)%>%
  select(!contains(c("count")) & !c(prop_svfirst, prop_exclfirst))
First_excl_timing_hmLA <-  First_excl_timing_hmLA %>%
  mutate(indicator = "Home", SusExcl = "Permanently excluded", Time = "First") %>% rename(LA = HOME_LA, prop_absencefirst_all = prop_exclfirst_all)%>%
  select(!contains(c("count")) & !c(prop_svfirst, prop_exclfirst))
Closest_sus_timing_sclLA <- Closest_sus_timing_sclLA %>%
  mutate(indicator = "School", SusExcl = "Suspended", Time = "Closest") %>% rename(LA = SCHOOL_LA, prop_absencefirst_all= prop_susfirst_all)%>%
  select(!contains(c("count")) & !c(prop_svfirst, prop_susfirst))
Closest_sus_timing_hmLA <- Closest_sus_timing_hmLA %>%
  mutate(indicator = "Home", SusExcl = "Suspended", Time = "Closest") %>% rename(LA = HOME_LA, prop_absencefirst_all= prop_susfirst_all)%>%
  select(!contains(c("count")) & !c(prop_svfirst, prop_susfirst))
Closest_excl_timing_sclLA <- Closest_excl_timing_sclLA %>%
  mutate(indicator = "School", SusExcl = "Permanently excluded", Time = "Closest") %>% rename(LA = SCHOOL_LA, prop_absencefirst_all = prop_exclfirst_all)%>%
  select(!contains(c("count")) & !c(prop_svfirst, prop_exclfirst))
Closest_excl_timing_hmLA <- Closest_excl_timing_hmLA %>%
  mutate(indicator = "Home", SusExcl = "Permanently excluded", Time = "Closest") %>% rename(LA = HOME_LA, prop_absencefirst_all = prop_exclfirst_all)%>%
  select(!contains(c("count")) & !c(prop_svfirst, prop_exclfirst))

fst.clst_SusExcl <- bind_rows(First_sus_timing_sclLA, First_sus_timing_hmLA, First_excl_timing_sclLA, First_excl_timing_hmLA,
                              Closest_sus_timing_sclLA, Closest_sus_timing_hmLA, Closest_excl_timing_sclLA, Closest_excl_timing_hmLA)

rm(First_sus_timing_sclLA, First_sus_timing_hmLA, First_excl_timing_sclLA, First_excl_timing_hmLA,
             Closest_sus_timing_sclLA, Closest_sus_timing_hmLA, Closest_excl_timing_sclLA, Closest_excl_timing_hmLA)

fst.clst_SusExcl <- fst.clst_SusExcl %>% pivot_longer(cols = c(prop_svfirst_all, prop_absencefirst_all),
                                          names_to = "key",
                                          values_to = "Perc") %>%
  mutate(time_group = ifelse(str_detect(key,"svfirst")==TRUE, "Absense after offence", "Absense before offence")) %>%
  filter(!(key =='prop_absencefirst_all' & grouped_overall =='On same day')) %>%
  mutate(time_group = ifelse(grouped_overall =='On same day', "Absense on same day as offence", time_group)) %>%
  select(!key)


# Alternative provision --------------------------------------------------------
# AP -> Ever (incl waffle) , ((??Time missed due to AP)) , Timing of AP
# Add tables currently needed to environment
list2env(alldata[c("AP_timing_sclLA", "AP_timing_hmLA")], envir = .GlobalEnv)
# Ever AP
EverAP <- Everflag %>% select(LA, indicator, prop_count_AP, any_prop_count_AP, sv_prop_count_AP) %>%
  pivot_longer(cols = c(prop_count_AP, any_prop_count_AP, sv_prop_count_AP),
               names_to = "tempAP", values_to = "perc") %>%
  mutate(group = ifelse(str_detect(tempAP,"sv_")==TRUE , "Serious Violence Offence",
                        ifelse(str_detect(tempAP,"any_")==TRUE, "Any Offence", "All Pupils"))) %>%
  select(!tempAP)

# AP waffle
AP_waffle <- Everflag %>% select(LA, indicator, sv_prop_count_AP, also_sv_prop_count_AP) %>%
  mutate(prop_sv_not_AP = 100 - sv_prop_count_AP,
         not_also_sv_prop_count_AP = 100 - also_sv_prop_count_AP)

# AP Timing
AP_timing_sclLA <- AP_timing_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
AP_timing_hmLA <- AP_timing_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)
# Join above tables
AP_timing <- bind_rows(AP_timing_sclLA, AP_timing_hmLA)
rm(AP_timing_sclLA, AP_timing_hmLA)

AP_timing <- AP_timing %>% select(LA, indicator, prop_AP_Before_SV, prop_APSame_Term, prop_AP_After_SV) %>%
  pivot_longer(cols = c(prop_AP_Before_SV, prop_APSame_Term, prop_AP_After_SV),
               names_to = "tempAP", values_to = "perc") %>%
  mutate(Timing = ifelse(str_detect(tempAP,"Before")==TRUE , "Before the first serious violence offence",
                         ifelse(str_detect(tempAP,"Same")==TRUE, "In the same term as the first serious violence offence",
                                "After the first serious violence offence"))) %>%
  select(!tempAP)


# SEN (no_SEN/SEN_sup/EHCP) ----------------------------------------------------
# noSEN/SEN_sup/EHCP -> Ever (incl waffle) , Timing of SEN/sup/EHCP , Timing of SEMH
# Add tables currently needed to environment
list2env(alldata[c("SEN_sclLA", "SEN_hmLA","SEN_timing_sclLA","SEN_timing_hmLA","SEMH_timing_sclLA","SEMH_timing_hmLA",
                   "EHCP_timing_sclLA","EHCP_timing_hmLA")], envir = .GlobalEnv)
# Ever noSEN/SEN_sup/EHCP
SEN_sclLA <- SEN_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)

SEN_hmLA <- SEN_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)

EverSEN_all <- bind_rows(SEN_sclLA, SEN_hmLA)
rm(SEN_sclLA, SEN_hmLA)

EverSEN <- EverSEN_all %>%
  select(LA, indicator, prop_EHCP_all, prop_EHCP_any, prop_EHCP_SV,
         prop_SEN_support_all, prop_SEN_support_any, prop_SEN_support_SV) %>%
  mutate(prop_NoSEN_all = 100 - prop_EHCP_all - prop_SEN_support_all,
         prop_NoSEN_any = 100 - prop_EHCP_any - prop_SEN_support_any,
         prop_NoSEN_SV = 100 - prop_EHCP_SV - prop_SEN_support_SV) %>%
  pivot_longer(cols = c(prop_EHCP_all, prop_EHCP_any, prop_EHCP_SV,
                        prop_SEN_support_all, prop_SEN_support_any, prop_SEN_support_SV,
                        prop_NoSEN_all, prop_NoSEN_any, prop_NoSEN_SV),
               names_to = "tempSEN", values_to = "perc") %>%
  mutate(SEN_type = ifelse(str_detect(tempSEN,"EHCP")==TRUE , "EHCP",
                           ifelse(str_detect(tempSEN,"SEN_sup")==TRUE, "SEN support", "No identified SEN")),
         group = ifelse(str_detect(tempSEN,"_SV")==TRUE , "Serious Violence Offence",
                        ifelse(str_detect(tempSEN,"_any")==TRUE, "Any Offence", "All Pupils"))) %>%
  select(!tempSEN)


# SEN waffle
SEN_waffle <- EverSEN_all %>%
  select(LA, indicator, prop_SEN_support_SV, prop_also_SEN_support_SV) %>%
  mutate(prop_not_SEN_support_SV = 100 - prop_SEN_support_SV,
         not_also_SEN_support_SV = 100 - prop_also_SEN_support_SV)

# EHCP waffle
EHCP_waffle <- EverSEN_all %>%
  select(LA, indicator, prop_EHCP_SV, prop_also_EHCP_SV) %>%
  mutate(prop_not_EHCP_SV = 100 - prop_EHCP_SV,
         not_prop_also_EHCP_SV = 100 - prop_also_EHCP_SV)


# Timing of SEN
SEN_timing_sclLA <- SEN_timing_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
SEN_timing_hmLA <- SEN_timing_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)
SEN_timing <- bind_rows(SEN_timing_sclLA, SEN_timing_hmLA)
rm(SEN_timing_sclLA, SEN_timing_hmLA)
SEN_timing <- SEN_timing %>% select(LA, indicator, prop_SEN_Before_SV, prop_SENSame_Term, prop_SEN_After_SV) %>%
  pivot_longer(cols = c(prop_SEN_Before_SV, prop_SENSame_Term, prop_SEN_After_SV),
               names_to = "Temp", values_to = "perc") %>%
  mutate(Timing = ifelse(str_detect(Temp,"Before")==TRUE , "Before the first serious violence offence",
                         ifelse(str_detect(Temp,"Same")==TRUE, "In the same term as the first serious violence offence",
                                "After the first serious violence offence"))) %>%
  select(!Temp)

# Timing of EHCP
EHCP_timing_sclLA <- EHCP_timing_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
EHCP_timing_hmLA <-  EHCP_timing_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)
EHCP_timing <- bind_rows(EHCP_timing_sclLA, EHCP_timing_hmLA)
rm(EHCP_timing_sclLA, EHCP_timing_hmLA)

EHCP_timing <- EHCP_timing %>% select(LA, indicator, prop_EHCP_Before_SV, prop_EHCPSame_Term, prop_EHCP_After_SV) %>%
  pivot_longer(cols = c(prop_EHCP_Before_SV, prop_EHCPSame_Term, prop_EHCP_After_SV),
               names_to = "Temp", values_to = "perc") %>%
  mutate(Timing = ifelse(str_detect(Temp,"Before")==TRUE , "Before the first serious violence offence",
                         ifelse(str_detect(Temp,"Same")==TRUE, "In the same term as the first serious violence offence",
                                "After the first serious violence offence"))) %>%
  select(!Temp)


# Timing of SEMH
SEMH_timing_sclLA <- SEMH_timing_sclLA %>% mutate(indicator = "School") %>% rename(LA = SCHOOL_LA)
SEMH_timing_hmLA <-  SEMH_timing_hmLA %>% mutate(indicator = "Home") %>% rename(LA = HOME_LA)
SEMH_timing <- bind_rows(SEMH_timing_sclLA, SEMH_timing_hmLA)
rm(SEMH_timing_sclLA, SEMH_timing_hmLA)

SEMH_timing <- SEMH_timing %>% select(LA, indicator, prop_SEMH_Before_SV, prop_SEMHSame_Term, prop_SEMH_After_SV) %>%
  pivot_longer(cols = c(prop_SEMH_Before_SV, prop_SEMHSame_Term, prop_SEMH_After_SV),
               names_to = "Temp", values_to = "perc") %>%
  mutate(Timing = ifelse(str_detect(Temp,"Before")==TRUE , "Before the first serious violence offence",
                         ifelse(str_detect(Temp,"Same")==TRUE, "In the same term as the first serious violence offence",
                                "After the first serious violence offence"))) %>%
  select(!Temp)


# Write excel file for all data in school experience tab -----------------------
# Join 'School Experience' tables together and write.xlsx 
write_xlsx(list(KS2_attain = KS2_attain, KS4_attain = KS4_attain, EverPAPAUO = EverPAPAUO,
                PA_waffle = PA_waffle, PAPAUO_timing = PAPAUO_timing, EverSusExcl = EverSusExcl, SusExcl_waffle = SusExcl_waffle,
                fst.clst_SusExcl = fst.clst_SusExcl, EverAP = EverAP, AP_waffle = AP_waffle, AP_timing = AP_timing, EverSEN = EverSEN,
                SEN_waffle = SEN_waffle, EHCP_waffle = EHCP_waffle, SEN_timing = SEN_timing, EHCP_timing = EHCP_timing, SEMH_timing = SEMH_timing),
           'C:/Users/msettle/OneDrive - Department for Education/Documents/Projects (R)/childrens_social_services_offenders_dashboard/data/SchoolExp.xlsx')



}
