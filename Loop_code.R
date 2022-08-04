setwd('C:/Users/JMCNALLY/Department for Education/SBAEA - SAFE Taskforces/Local cuts of the data/Analysis/Code')
library(readxl)
library(tidyverse)
library(reshape2)
library(dplyr)
library(dbplyr)
library(ggplot2)
library(waffle)
library(knitr)
library(kableExtra)
library(rmarkdown)

# List of SAFE areas
safe_LA <- c('TlDJE','ExbVO', 'zfPKp',
             'uBH5D', 'EG67z', '9Hfya',
             'lqSj6', 'antN5', 'aoCSR',
             'aA5QM')

for(la_name in safe_LA){
  rmarkdown::render("Loop.Rmd",
         output_file=paste0(la_name, ".pdf"),
         params=list(input_la_choice=la_name)
  )
}