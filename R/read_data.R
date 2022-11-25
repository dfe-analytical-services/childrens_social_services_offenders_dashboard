# Script where we provide functions to read in the data file(s).

# IMPORTANT: Data files pushed to GitHub repositories are immediately public. 
# You should not be pushing unpublished data to the repository prior to your 
# publication date. You should use dummy data or already-published data during
# development of your dashboard.

# In order to help prevent unpublished data being accidentally published, the 
# template will not let you make a commit if there are unidentified csv, xlsx, 
# tex or pdf files contained in your repository. To make a commit, you will need 
# to either add the file to .gitignore or add an entry for the file into 
# datafiles_log.csv.

read_revenue_data <- function(file='data/la_maintained_schools_revenue_reserve_final.csv'){
  # This reads in an example file. For the purposes of this demo, we're using the 
  # latest LA expenditure data downloaded from the EES release.
  dfRevenue <- read.csv(file)
  # The time period column name has some non-ascii characters so we're just going to rename it here.
  colnames(dfRevenue)[1] <- "time_period"
  dfRevenue <- dfRevenue %>% mutate(year = as.numeric(paste0("20",substr(format(time_period),5,6))),
                                    area_name=case_when(geographic_level=='National' ~ country_name,
                                           geographic_level=='Regional' ~ region_name,
                                           TRUE ~ la_name))
  return(dfRevenue)
}

read_cohort_data <- function(file='data/Cohort.csv'){
  # This reads in an data showing cohorts used in data share
  dfCohort <- read.csv(file)
  # Change col names
  colnames(dfCohort)[1:7] <- c("Academic Year",  "Cohort 6", "Cohort 5", "Cohort 4", "Cohort 5", "Cohort 2", "Cohort 1")
  return(dfCohort)
}


# function to read in tables/data needed for demographics tab
read_dash_data <- function(file="data/Demographics.xlsx"){
  sheetNames <- getSheetNames(file)
  no_sheets <- length(sheetNames)
  demo_data <- vector("list", no_sheets)
  for (i in 1:no_sheets){
    demo_data[[i]] <- read_excel(file, sheet = i)
  } 
  # Add sheet names to list of data - this will make it easier when added to environment  
  names(demo_data) <- sheetNames
  list2env(demo_data[1:no_sheets], envir = .GlobalEnv)
}
