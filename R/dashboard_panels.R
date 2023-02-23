homepage_panel <- function() {
  tabPanel(
    "Homepage",
    gov_main_layout(
      gov_row(
        
        ## Bottom panel ------------------------------------------------------
        
        column(
          12,
          div(
            h1(tags$b("Education, children's social care and offending:"), tags$br(), tags$b("Descriptive statistics"),
               tags$br(), tags$h2("National and local authority level data")),
            br(),
            div(
              class = "panel panel-info",
              div(
                class = "panel-heading",
                style = "color: white;font-size: 18px;font-style: bold; background-color: #1d70b8;",
                h6("")
              ),
              div(
                class = "panel-body",
                tags$div(
                  h3(tags$b("Aims")),
                  p("This dashboard was created to complement the previously published", 
                     tags$a(href = "https://www.gov.uk/government/publications/education-childrens-social-care-and-offending", 
                            "Education, children’s social care and offending", style = "font-size:16px"),
                     "descriptive analysis with the aim of providing local authority specific breakdowns, for each local authority in England, where possible.",
                    style = "font-size:16px"),
                  br(),
                  tabBox(width = 12, title = NULL, id="overview_tabs",
                         tabPanel(h4(tags$u("Dashboard overview")), 
                                  h3(tags$b("Contents")),
                                  p("To navigate through the dashboard, please click on the tabs on the left (Demographics, School Experience or Children's Social Care 
                                  Experience). Within each tab, you will be given several options to select:" ,
                                   tags$br(),  
                                   tags$br(), 
                                   tags$b("1."),
                                   "Two different local authorities (LA) to compare, with the option to compare with 10 nearest statistical neighbours and England. 
                                   Please see", 
                                   actionLink("link_to_sup_tab", "Support and feedback"),
                                   "for more information on statistical neighbours used in the dashboard.",  
                                   tags$br(), 
                                   tags$b("2."),
                                   "Either home or school LA – this selects whether the analysis focuses on the LA in which a child resides, or the LA in which a 
                                    child attends school (please see the Data Overview tab for more information).", 
                                   tags$br(),
                                   tags$br(),
                                   "There is also the option to select sub-tabs within these tabs, to look at more specific variables within each page, with 
                                    explanatory text included where necessary.",
                                   tags$br(),  tags$br(), 
                                   "The dashboard includes information on the following:",
                                   tags$br(), 
                                   "•	Previous offending", 
                                   tags$br(), 
                                   "•	Gender",
                                   tags$br(), 
                                   "•	Age",
                                   tags$br(), 
                                   "•	Ethnicity",
                                   tags$br(), 
                                   "•	Free School Meals eligibility",
                                   tags$br(), 
                                   "•	Attainment",
                                   tags$br(), 
                                   "•	Persistent Absence",
                                   tags$br(), 
                                   "•	Permanent exclusions and suspensions",
                                   tags$br(), 
                                   "•	Alternative Provision",
                                   tags$br(), 
                                   "•	Special Educational Needs",
                                   tags$br(), 
                                   "•	Children with a Social Worker",
                                   tags$br(),"", style = "font-size:16px"),
                                  h3(tags$b("Previous publications")),
                                  p("This dashboard follows a previous national level", 
                                  tags$a(href="https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1059556/Education_children_s_social_care_and_offending_descriptive_stats_FINAL.pdf", "publication"),
                                  "that looked at the education and 
                                    social care background of children in England that had been cautioned or sentenced for an offence across 
                                    England, and 10 LA level publications focussing on the ten SAFE (Support, Attend, Fulfil, Exceed) 
                                    Taskforce areas (for more information see", 
                                    tags$a(href = "https://www.gov.uk/government/news/support-for-vulnerable-young-people-in-serious-violence-hotspots", 
                                           "Support for vulnerable young people in serious violence hotspots"), ").", style = "font-size:16px")
                                  ),
                         tabPanel(h4(tags$u("Data Overview")),  
                                  br(),
                                  details(
                                    inputId = "datashare_def",
                                    label = "The DfE-MoJ data-share",
                                    help_text = tags$p("This section sets out details of the data share between the Ministry of Justice (MoJ) and Department for 
                                    Education (DfE), and the matching process between the MoJ and National Pupil Database data. Data
                                    from several large datasets were brought together in this data share, as permitted by the Ministry of Justice’s 
                                    common law powers and various prescribed legislative data sharing powers available to DfE. A brief description of
                                    the two main datasets is included below:", tags$br(), tags$br(),
                                  tags$b("National Pupil Database (NPD)"), "– DfE. A wide range of information about pupils and students which provides evidence on 
                                    educational performance and context. The data includes detailed information about pupils’ test and exam results, prior attainment, 
                                    and progression between each key stage for all state schools in England. It also includes information about the characteristics of pupils
                                    in the state sector and non-maintained special schools, such as their gender, ethnicity, first language, eligibility for Free School 
                                    Meals, awarding of bursary funding for 16-19-year-olds, information about Special Educational Needs, and detailed information about any
                                    absences and exclusions.", tags$br(), tags$br(),
                                  tags$b("Police National Computer (PNC)"), "– MoJ. This dataset includes recordable offences committed, with separate entries for each offence committed by a person, 
                                    although only some information (e.g. personal characteristics) will be available through the linked data. The data analysed in this report is a subset of
                                    the total number of individuals. All individuals who commit an offence are recorded on the Police National Computer (PNC), this report is based on offenders
                                    from the PNC that were successfully matched to the NPD, covering the period 2000 - 2020.", tags$br(), tags$br(),
                                  "The first iteration of the share was carried out in 2019 and covered offending data up to the end of 2017 and education data up to
                                  the end of the 17/18 academic year. The second iteration of the share was completed in 2022 and includes offending data up to the end of 2020 and education data
                                  up to the end of the 2019/20 academic year. The share is intended to be updated on an annual basis going forward.", tags$br(), tags$br(), 
                                  "Applications to access the data share can be made by ONS accredited researchers, by submitting the", 
                                  tags$a(href="https://www.gov.uk/government/publications/moj-data-first-application-form-for-secure-access-to-data", "application form"), "to MoJ and DfE. 
                                  Successful applicants will access the data through the ONS Secure Research Service (SRS).", tags$br(), tags$br(),
                                  "For more information please see the previously published", 
                                  tags$a(href = "https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1059557/Education_children_s_social_care_and_offending_descriptive_stats_Technical_Note_FINAL.pdf", 
                                         "technical note"), ".")),
                                  details(
                                    inputId = "cohort_def",
                                    label = "Cohorts",
                                    help_text = tags$p(tags$i("The below text describes the cohorts we will be using in the final dashboard, so does not directly apply to the data currently included"), 
                                    tags$br(), tags$br(),
                                    "The cohorts of children within this analysis include all pupils who finished key stage 2 (KS2) in 2007/08, 2008/09, 2009/10, 2010/11, 2011/12 
                                    or 2012/13, and were aged 10 at the start of these academic years. Therefore, this cohort has a key stage 4 
                                    (KS4) academic year of 2012/13, 2013/14, 2013/14, 2014/15, 2015/16 or 2017/18, amounting to approximately [Number to be added] children.", tags$br(), tags$br(), 
                                    "For these children, all their records from Year 1 to Year 13 (or equivalent) are included. Pupils who do not have a KS4 record are not included. 
                                    Pupils who attended an independent primary or secondary school have been excluded from the data as their characteristics are not recorded, except for those 
                                    registered in independent Alternative Provision (AP) settings.", tags$br(), tags$br(),
                                    "The cohorts were selected in this way to maximise data coverage and balance data availability 
                                    across each of the datasets provided in the share. Children that appear on a school census at the end of KS2 and the end of KS4 have been included
                                    in this analysis, with allowances for those that have moved ahead or been kept behind by one or more school years. Independent schools that provide 
                                    alternative provision have been included, however those with KS4 results at mainstream independent schools have been removed.", tags$br(), tags$br(), 
                                    "This publication will present statistics relating to the local authority (LA) of a child’s school during the school year they entered when they were 
                                    aged 15. We selected age 15 as this is the most common age at which children who had been cautioned or sentenced for a serious violence offence commit their
                                    first serious violence offence. Where this isn’t possible, the closest previous year has been used. We have also conducted analysis using the 
                                    records of the LA of the child’s home address when they were aged 15.",
                                    tags$table(border = 1, style = "font-size:16px",
                                               tags$tbody(
                                                 tags$tr(
                                                   tags$td(align = "center", strong("Academic Year")),
                                                   tags$td(align = "center", strong("Cohort 6")),
                                                   tags$td(align = "center", strong("Cohort 5")),
                                                   tags$td(align = "center", strong("Cohort 4")),
                                                   tags$td(align = "center", strong("Cohort 3")),
                                                   tags$td(align = "center", strong("Cohort 2")),
                                                   tags$td(align = "center", strong("Cohort 1"))
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2019/20"),
                                                   tags$td(align = "center", "Year 13"),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", "")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2018/19"),
                                                   tags$td(align = "center", "Year 12"),
                                                   tags$td(align = "center", "Year 13"),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", "")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2017/18"),
                                                   tags$td(align = "center", "Year 11"),
                                                   tags$td(align = "center", "Year 12"),
                                                   tags$td(align = "center", "Year 13"),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", "")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2016/17"),
                                                   tags$td(align = "center", "Year 10"),
                                                   tags$td(align = "center", "Year 11"),
                                                   tags$td(align = "center", "Year 12"),
                                                   tags$td(align = "center", "Year 13"),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", "")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2015/16"),
                                                   tags$td(align = "center", "Year 9"),
                                                   tags$td(align = "center", "Year 10"),
                                                   tags$td(align = "center", "Year 11"),
                                                   tags$td(align = "center", "Year 12"),
                                                   tags$td(align = "center", "Year 13"),
                                                   tags$td(align = "center", "")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2014/15"),
                                                   tags$td(align = "center", "Year 8"),
                                                   tags$td(align = "center", "Year 9"),
                                                   tags$td(align = "center", "Year 10"),
                                                   tags$td(align = "center", "Year 11"),
                                                   tags$td(align = "center", "Year 12"),
                                                   tags$td(align = "center", "Year 13")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2013/14"),
                                                   tags$td(align = "center", "Year 7"),
                                                   tags$td(align = "center", "Year 8"),
                                                   tags$td(align = "center", "Year 9"),
                                                   tags$td(align = "center", "Year 10"),
                                                   tags$td(align = "center", "Year 11"),
                                                   tags$td(align = "center", "Year 12")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2012/13"),
                                                   tags$td(align = "center", "Year 6"),
                                                   tags$td(align = "center", "Year 7"),
                                                   tags$td(align = "center", "Year 8"),
                                                   tags$td(align = "center", "Year 9"),
                                                   tags$td(align = "center", "Year 10"),
                                                   tags$td(align = "center", "Year 11")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2011/12"),
                                                   tags$td(align = "center", "Year 5"),
                                                   tags$td(align = "center", "Year 6"),
                                                   tags$td(align = "center", "Year 7"),
                                                   tags$td(align = "center", "Year 8"),
                                                   tags$td(align = "center", "Year 9"),
                                                   tags$td(align = "center", "Year 10")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2010/11"),
                                                   tags$td(align = "center", "Year 4"),
                                                   tags$td(align = "center", "Year 5"),
                                                   tags$td(align = "center", "Year 6"),
                                                   tags$td(align = "center", "Year 7"),
                                                   tags$td(align = "center", "Year 8"),
                                                   tags$td(align = "center", "Year 9")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2009/10"),
                                                   tags$td(align = "center", "Year 3"),
                                                   tags$td(align = "center", "Year 4"),
                                                   tags$td(align = "center", "Year 5"),
                                                   tags$td(align = "center", "Year 6"),
                                                   tags$td(align = "center", "Year 7"),
                                                   tags$td(align = "center", "Year 8")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2008/09"),
                                                   tags$td(align = "center", "Year 2"),
                                                   tags$td(align = "center", "Year 3"),
                                                   tags$td(align = "center", "Year 4"),
                                                   tags$td(align = "center", "Year 5"),
                                                   tags$td(align = "center", "Year 6"),
                                                   tags$td(align = "center", "Year 7")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2007/08"),
                                                   tags$td(align = "center", "Year 1"),
                                                   tags$td(align = "center", "Year 2"),
                                                   tags$td(align = "center", "Year 3"),
                                                   tags$td(align = "center", "Year 4"),
                                                   tags$td(align = "center", "Year 5"),
                                                   tags$td(align = "center", "Year 6")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2006/07"),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", "Year 1"),
                                                   tags$td(align = "center", "Year 2"),
                                                   tags$td(align = "center", "Year 3"),
                                                   tags$td(align = "center", "Year 4"),
                                                   tags$td(align = "center", "Year 5")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2005/06"),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", "Year 1"),
                                                   tags$td(align = "center", "Year 2"),
                                                   tags$td(align = "center", "Year 3"),
                                                   tags$td(align = "center", "Year 4")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2004/05"),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", "Year 1"),
                                                   tags$td(align = "center", "Year 2"),
                                                   tags$td(align = "center", "Year 3")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2003/04"),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", "Year 1"),
                                                   tags$td(align = "center", "Year 2")
                                                 ),
                                                 tags$tr(
                                                   tags$td(align = "center", "2002/03"),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", ""),
                                                   tags$td(align = "center", "Year 1")
                                                 )
                                               )
                                    )
                                    )),
                                  details(
                                    inputId = "off_def",
                                    label = "Defining the offending groups",
                                    help_text = tags$p(tags$b("'Children who had been cautioned or sentenced for an offence'"), "relates to all children and young people
                                                       in the linked data who were in the academic years described above, and who had been cautioned or sentenced for
                                                       any offence recorded on the Police National Computer over the defined coverage period.", tags$br(), tags$br(),
                                                       "All cohorts in this analysis are limited to ages 10-17. This means that for each cohort, the last year of 
                                                       offending data would be during Year 13 (or equivalent). This is to ensure that each child had the same amount 
                                                       of time to offend - if the data was not limited by age, then children born in earlier years would have more 
                                                       years of data available to record offences, thereby skewing the results.", tags$br(), tags$br(),
                                                       "As well as 'children who had been cautioned or sentenced for an offence',", tags$b("‘children who had been
                                                       cautioned or sentenced for a serious violence offence’"), "have also been included in this analysis.", tags$br(), tags$br(), 
                                                       "The definition of serious violence offences is based broadly on the following categories of offence groups 
                                                       and offence types: indictable only", tags$b("‘violence against the person’"), "offences, indictable only",
                                                       tags$b("‘robbery offences’"), ", and triable either way or indictable only", tags$b("‘possession of weapons offences’"), ". A full
                                                       list of offences included in the serious violence definition can be found in Annex B of the previous national level ", 
                                                       tags$a(href="https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/1059556/Education_children_s_social_care_and_offending_descriptive_stats_FINAL.pdf", 
                                                              "publication"), ".")
                                  ),
                                  details(
                                    inputId = "ever_def",
                                    label = "Defining 'ever'",
                                    help_text = tags$p("It is important to note that this analysis will not be directly comparable with other published government statistics. 
                                                       Unless otherwise specified, when referencing whether a child has ‘ever’ had a certain characteristic, the analysis considers 
                                                       all periods up to the end of KS4.", tags$br(), tags$br(), 
                                                       "This methodology may differ from that of other published statistics where, for example, only
                                                       the previous six years are considered. For this reason, figures discussed here may appear higher than those available in other 
                                                       publications.", tags$br(), tags$br(),
                                                       "It is also important to note that when referencing whether a child has ‘ever’ had a certain characteristic they could have had this 
                                                       characterstic before and after an offence took place, unless otherwise specified.")
                                  ),
                                  details(
                                    inputId = "small_def",
                                    label = "Reporting on small numbers of children",
                                    help_text = tags$p("In order to prevent the disclosure of sensitive data, any numbers in this publication that relate to less than 6 pupils have been replaced
                                                       by ‘ * ’ in data tables or a gap in charts. Where there are further risks of identification (for example where a suppressed number can
                                                       be calculated using other numbers), numbers have been further suppressed. Due to the size variation across the local authority areas,
                                                       this happens more for some LAs than others.", tags$br(), tags$br(), "Due to low numbers among the offending groups, LA level analysis
                                                       has not been conducted for City of London, Isle of Scilly and XXX. Once more data becomes available, they may be included in future 
                                                       updates/iterations of the dashboard. However, these LAs are included in the national level analysis as a result of this LA counts may
                                                       not sum to England counts.")
                                  )
                                  )
                         )
                  ),
                br()
              )
            )
          ),
        ),
      )
    )
  )
  
}

Demographics <- function() {
  tabPanel(
    value = "tab_demo",
    "Demographics",
    
    gov_main_layout(
      gov_row(
        column(
          width=12,
          h1("Demographics"),
          h4("This tab contains a high-level analysis of demographic factors")
        ),
        column(
          width=12,
          div(
            class = "well",
            style = "min-height: 100%; height: 100%; overflow-y: visible",
            gov_row(
              column(
                width = 6,
                selectizeInput("demLAchoice", 
                               "Local Authority 1", 
                               choices = choicesLA
                )),
              column(
                width = 6,
                uiOutput('demLAchoice2_')
              ), 
              column(
                width = 6,
                radioButtons("demindichoice", 
                             p("Indicator 1", 
                               tags$div(class = "dropdown", 
                                        dropdownButton(h5("Select", tags$b("Home"), "to view children who", tags$b("live"), "in given local authority.", 
                                                          tags$br(), tags$br(), 
                                                          "Select", tags$b("School"), "to view children who", tags$b("go to school"), "in given local authority",
                                                          style = "color:black"), 
                                                       status = 'info', icon = icon('info'), size = "xs")
                               )
                             ),
                             choices = choiceIndicator$Indicator,
                             selected = "School"
                             )
                ),
              column(
                width = 6,
                radioButtons("demindichoice2", 
                             p("Indicator 2", 
                               tags$div(class = "dropdown", 
                                        dropdownButton(h5("Select", tags$b("Home"), "to view children who", tags$b("live"), "in given local authority.", 
                                                          tags$br(), tags$br(), 
                                                          "Select", tags$b("School"), "to view children who", tags$b("go to school"), "in given local authority",
                                                          style = "color:black"), 
                                                       status = 'info', icon = icon('info'), size = "xs")
                               )
                             ),
                             choices = choiceIndicator$Indicator,
                             selected = "School"
                )
              )
              )
          )
        ),
        column(
          width=12,
          tabsetPanel(id = "tabsetpanels2",
                      tabPanel(
                        "LA info",
                        fluidRow(
                          column(
                            width=12,
                            br(),
                            h5("The table below contains information about the selected local authorities and/or England"),
                            br(),
                            box(
                              width = 12,
                              div(dataTableOutput("demotable"), 
                                  style = "font-size:16px")
                            ),
                            br(),
                            strong("Footnotes"),
                            br(),
                            paste("1. Percentages are rounded to the nearest 1%."),
                            br(),
                            paste("2. '*' in the table indicate where data has been suppressed due to small numbers."),
                            br(),
                            paste("3. In order to better understand offending trajectories for children who had been cautioned
                            or sentenced for a serious violence offence, this analysis looks at the volume of offending which 
                                  preceded a first serious violence offence."),
                            br()
                          ),
                          )
                      ),
                      tabPanel(
                        "Gender",
                        fluidRow(
                          h3("The gender breakdown of offending and pupil group, for all pupils matched to KS4 academic years 2012/13 - 2017/18"),
                          h5("Gender information has been taken from the DfE school census.
                               Where a pupil's gender has changed over time, the most recent record has been used. The gender recorded in the DfE school census may not be the
                               same as to which a child identifies."),
                          column(h3(textOutput("DemTitle1")),
                            width=6,
                            box(
                              width=12,
                              plotOutput("GenderPlot1"),
                              br()
                              )
                          ),
                          column(h3(textOutput("DemTitle2")),
                            width=6,
                            box(
                              width=12,
                              plotOutput("GenderPlot2"),
                              br()
                              )
                          ),
                          strong("Footnotes"),
                          br(),
                          paste("1. Percentages are rounded to the nearest 1%."),
                          br(),
                        )
                      ),
                      tabPanel(
                        "Age at first offence",
                        fluidRow(h3("The proportion of children relative to their age at first offence\nby offending group, for pupils matched 
                               to KS4 academic years 2012/13 - 2017/18"),
                          column(h3(textOutput("DemTitle1_age")),
                            width=6,
                            box(
                              width = 12,
                              plotOutput("ageofplot1"),
                              br()
                            )
                          ),
                          column(h3(textOutput("DemTitle2_age")),
                            width=6,
                            box(
                              width = 12,
                              plotOutput("ageofplot2"),
                              br()
                            )
                          ),
                          strong("Footnotes"),
                          br(),
                          paste("1. Percentages are rounded to the nearest 1%."),
                          br(),
                          paste("2. The analysis uses the date the offence took place rather than the date it was processed through the courts."),
                          br(),
                          paste("3. All offences were included in the analysis of age at first offence for children who had been 
                            cautioned or sentenced for an offence irrespective of whether they were also serious violence offences. 
                            Serious violence offences only were included in the analysis for children who had been cautioned or 
                            sentenced for a serious violence offence."),
                          br(),
                        )
                      ),
                      tabPanel(
                        "Ethnicity",
                        fluidRow(
                        h3("The proportion of all pupils split by ethnic group major, offending and pupil group, for pupils matched to KS4 academic years
                               2012/13 - 2017/18"),
                               h5("Ethnicity", tags$sup("[1]"), "has two different categorisations in the school census - ethnic group major
                            and ethnic group minor. Ethnic group major contains wider categories (Asian, Black,
                            Chinese, White, Mixed, Unclassified, Any Other Ethnic Group) whereas ethnic group minor is more detailed", tags$sup("[2]"),"."),
                          column(h3(textOutput("DemTitle1_eth")),
                            width=6,
                            box(
                              width = 12,
                              plotOutput("EthPlot1")
                            ),
                            ),
                        column(h3(textOutput("DemTitle2_eth")),
                          width=6,
                          box(
                            width = 12,
                            plotOutput("EthPlot2")
                          ),
                        ),
                          strong("Footnotes"),
                            br(),
                            paste("1. Where a pupil’s ethnicity changes over time, the most recent ethnicity has been taken. 
                            Ethnicity information has been taken from the DfE school census, and from 2011, could only be 
                            completed by the child or their parents."),
                            br(),
                            paste("2. Ethnic group minor categories include Bangladeshi, Indian, Any Other Pakistani Background, Pakistani,
                            Black African, Black Caribbean, Any Other Black Background, Chinese, Any Other Mixed Background,
                            White and Asian, White and Black African, White and Black Caribbean, Information Not Yet Obtained, Any 
                            Other Ethnic Group, Refused, White British, White Irish, Traveller of Irish Heritage, Any Other White Background, 
                            Gypsy/Roma. For a more detailed breakdown of ethnic group minor, see accompanying tables."),
                            br(),
                        paste("3. Percentages are rounded to the nearest 1%."),
                        br()
                        )
                      ),
                      tabPanel(
                        "Free school meals",
                        fluidRow(
                          column(
                            width=12, h5(tags$b("Choose plot type")),
                            tabBox(width = 12, title = NULL, id="FSMsubtabs",
                                   tabPanel(
                                   p(tags$u("Bar chart (All pupil groups)")), 
                                   h3("The proportion of all pupils eligible for free school meals (FSM) by offending and pupil group, 
                                                         for pupils matched to KS4 academic years 2012/13 - 2017/18"), 
                                            column(width=6, h3(textOutput("DemTitle1_FSM1")), 
                                                   box(width = 12, plotOutput("fsmPlot1"))),
                                            column(width=6, h3(textOutput("DemTitle1_FSM2")), 
                                                   box(width = 12, plotOutput("fsmPlot2")))),
                                   tabPanel(
                                   p(tags$u("Waffle plot")), 
                                   
                                   column(12,	
                                          radioGroupButtons(                  
                                            inputId="fsm_plot_switch_waf", 
                                            label="Choose pupil group",
                                            choiceNames=c("All pupils : Any Offence", "All pupils : Serious Violence Offence"),
                                            choiceValues=c("Any_off", "sv_off"),
                                          )
                                   ),
                                   
                                   uiOutput("dem_plot_waf_fsm"),
                                   
                                   
                                   )
                                   )
                            ),
                          strong("Footnotes"),
                          br(),
                          paste("1. The metric for free school meals (FSM) used in this analysis is FSM eligibility. Children are FSM eligible
                          if a claim has been made by them, or on their behalf, and eligibility has been confirmed."),
                          br(),
                          paste("2. Percentages are rounded to the nearest 1%."),
                          br(),
                        )
                      )
          )
        )
        
      )
    )
  )
}

SchoolExp <- function() {
  tabPanel(
    value = "tab_scl",
    "School Experience",
    
    gov_main_layout(
      gov_row(
        column(
          width=12,
          h1("School Experience"),
          h4("This tab contains analysis that relates to children's experiences whilst in school")
        ),
        column(
          width=12,
          div(
            class = "well",
            style = "min-height: 100%; height: 100%; overflow-y: visible",
            gov_row(
              column(
                width = 6,
                selectizeInput("sclLAchoice", 
                               "Local Authority 1", 
                               choices = choicesLA
                )),
              column(
                width = 6,
                uiOutput('sclLAchoice2_')
              ), 
              column(
                width = 6,
                radioButtons("sclindichoice", 
                             p("Indicator 1", 
                               tags$div(class = "dropdown", 
                                        dropdownButton(h5("Select", tags$b("Home"), "to view children who", tags$b("live"), "in given local authority.", 
                                                          tags$br(), tags$br(), 
                                                          "Select", tags$b("School"), "to view children who", tags$b("go to school"), "in given local authority",
                                                          style = "color:black"), 
                                                       status = 'info', icon = icon('info'), size = "xs")
                               )
                             ), 
                             choices = choiceIndicator$Indicator,
                             selected = "School"
                )
              ),
              column(
                width = 6,
                radioButtons("sclindichoice2", 
                             p("Indicator 2", 
                               tags$div(class = "dropdown", 
                                        dropdownButton(h5("Select", tags$b("Home"), "to view children who", tags$b("live"), "in given local authority.", 
                                                          tags$br(), tags$br(), 
                                                          "Select", tags$b("School"), "to view children who", tags$b("go to school"), "in given local authority",
                                                          style = "color:black"), 
                                                       status = 'info', icon = icon('info'), size = "xs")
                               )
                             ),
                             choices = choiceIndicator$Indicator,
                             selected = "School"
                )
              ))
          )
        ),
        
        column(
          width=12,
          tabsetPanel(id = "tabsetpanels3",
                      tabPanel(
                        "Attainment",
                        fluidRow(
                          column(
                            width=12,
                            tabBox(width = 12, title = NULL, id="atn_subtabs",
                                   tabPanel(
                                     p(tags$u("KS2 attainment")), 
                                     h3("The proportion of all pupils who achieved level 4 or above in English and Maths at key stage 2 (KS2) 
                                            by offending and pupil group, for pupils matched to KS4 academic years 2012/13 - 2017/18"),
                                     p("This analysis looks at the percentage of pupils meeting the expected standard in English and Maths at KS2.
                                              At the end of KS2 children are expected to be working to at least level 4 in English and Maths."),
                                     column(h3(textOutput("sclTitle1_ks2")),
                                            width=6,
                                            box(width = 12,
                                              plotOutput("ks2attainplot1"))), 
                                     column(h3(textOutput("sclTitle2_ks2")),
                                           width=6,
                                           box(width = 12,
                                             plotOutput("ks2attainplot2"))),
                                     br(),
                                            strong("Footnotes"),
                                            br(),
                                            paste("1. Percentages are rounded to the nearest 1%."),
                                            br(),
                                            paste("2. Possible attainment levels at KS2 range from Level 1 to Level 6."),
                                            br(),
                                     paste(
                                       "3. The figures discussed here are the combined results of all cohorts, of whom reached the end of
                                            KS2 in 2007/08 - 2012/13. Based on the metrics used in this analysis, only a very small number
                                            of results for the 2009/10 cohort were withheld, in light of the boycott of the delivery of end of KS2 National
                                            Curriculum tests. It was determined that a sufficient volume of results were available for this cohort, and
                                            that the results of all three cohorts could be combined. Please see here for more information regarding the
                                            2009/10 KS2 National Curriculum tests results:"
                                     ),
                                     a(href = "https://www.gov.uk/government/statistics/national-curriculum-assessments-at-key-stage-2-and-3-in-england-academic-year-2009-to-2010-provisional",
                                       "National curriculum assessments: KS2 and KS3, 2010"), "."), 
                                   tabPanel(
                                     p(tags$u("KS4 attainment")),
                                     h3("The proportion of all pupils who achieved various key stage 4 (KS4) benchmarks by offending and 
                                            pupil group, for pupils matched to KS4 academic year 2014/15 - 2017/18"),
                                     p("This analysis looks at the percentage of pupils meeting various KS4 benchmarks."),
                                     column(h3(textOutput("sclTitle1_ks4")),
                                            width=6,
                                            box(width = 12,
                                            plotOutput("ks4attainplot1"))), 
                                     column(h3(textOutput("sclTitle2_ks4")),
                                            width=6,
                                            box(width = 12,plotOutput("ks4attainplot2"))),
                                     br(),
                                            strong("Footnotes"),
                                            br(),
                                            paste("1. Percentages are rounded to the nearest 1%."),
                                            br(),
                                            paste("2. The implementation of two major reforms in 2013/14 that affect the calculation of KS4 performance
                                                  measures data mean that findings for KS4 attainment cannot be combined over all year groups, and
                                                  the analysis will refer to the results of those with KS4 academic year 2014/15 - 2017/18.
                                                  ")))
                          )
                        )
                      ),
                      tabPanel(
                        "Persistent Absence",
                        fluidRow(
                          column(
                            width=12,
                            br(),
                            details(
                              inputId = "PA_def",
                              label = "What is persistent absence?",
                              help_text = tags$p("A child is said to be persistently absent (PA) if they miss 10% or more of the sessions 
                              they could possibly have attended in an academic year or term. Most sessions represent a half-day. 
                              For context, this would amount to between 6 and 7 days of a 13-week term or around 19 days for a school 
                              year", tags$sup("[1]"), ". This includes both authorised and unauthorised absences", tags$sup("[2]"), ".", tags$br(), tags$br(),
                              "It is worth noting that persistent absence can include various reasons for absence, including absence due to 
                              being suspended or permanently excluded.")
                            ),
                            details(
                              inputId = "PAUO_def",
                              label = "What is persistent absence for 'unauthorised other' reasons (PAUO)?",
                              help_text = tags$p("The absence reason ‘persistent absence for “unauthorised other” reasons’ (PAUO) is used as a closest 
                              available proxy for persistent truancy.", tags$br(), tags$br(), "The definition of persistent absence includes all possible reasons for absence, 
                              including children whose absence was unauthorised, but the school was still provided with a reason for that absence 
                              (for example, an unagreed family holiday). The analysis has included this additional metric of absence (PAUO), as a way 
                              of differentiating those whose absence was not authorised and were unable to provide a reason for that absence, from those
                              not attending school for any reason.")
                            ),
                            tabBox(
                              width = 12, title = NULL, id="pa_subtabs",
                                   tabPanel(
                                     p(tags$u("Ever PA/PAUO")),
                                            br(),
                                            p("For the following analysis, a pupil was marked as having ever been persistently absent if they had missed 
                                               10% or more of their possible sessions over the course of a school year, not a term."), 
                                            br(),
                                            h5(tags$b("Choose plot type")),
                                            tabBox(
                                              width = 12, title = NULL, id="pa_subtabs2",
                                            tabPanel( 
                                            p(tags$u("Bar chart (All pupil groups)")), 
                                            h3("The proportion of all pupils who had ever been persistently absent or 
                                            persistently absent (unauthorised other) by offending and pupil group, for pupils matched to 
                                                                 KS4 academic years 2012/13 - 2017/18"), 
                                            column(h3(textOutput("sclTitle1_PA")),
                                                   width=6,
                                                   box(width = 12,
                                                       plotOutput("PAPlot1"))), 
                                            column(h3(textOutput("sclTitle2_PA")),
                                                   width=6,
                                                   box(width = 12, 
                                                       plotOutput("PAPlot2")))),
                                            tabPanel(
                                            p(tags$u("Waffle plot")), 
                                            column(12,	
                                                   radioGroupButtons(                  
                                                     inputId="pa_plot_switch_waf", 
                                                     label="Choose pupil group",
                                                     choiceNames=c("All pupils : Any Offence", "All pupils : Serious Violence Offence"),
                                                     choiceValues=c("Any_off", "sv_off"),
                                                   )
                                            ),
                                            
                                            uiOutput("scl_plot_waf_pa")
                                            
                                            )),
                                     br(),
                                     strong("Footnotes"),
                                     br(),
                                     paste("1. "),
                                     a(href = "https://www.legislation.gov.uk/uksi/1999/3181/regulation/3/made", "The School Day and Year"),
                                     br(),
                                     paste("2. For more information on the definition of pupil absences see"),
                                     a(href = "https://explore-education-statistics.service.gov.uk/methodology/pupil-absence-in-schools-in-england", 
                                       "Pupil absence statistics: methodology"),
                                     paste(". This was changed from 15% to 10% in September 2015."),
                                     br(), 
                                     paste("3. The definition of persistent absence includes all possible reasons for absence, including children whose 
                            absence was unauthorised, but the school was still provided with a reason for that absence (for example, an unagreed 
                            family holiday). The analysis has included this additional metric of absence (PAUO), as a way of differentiating those 
                            whose absence was not authorised and were unable to provide a reason for that absence, from those not attending school 
                                  for any reason. From 2013/14, absence for extended family holiday was discontinued due to a change in regulation"),
                                     br(),
                                     paste("4. Breakdown of rates of persistent absence by reason code are included in the accompanying publication tables."),
                                     br(),
                                     paste("5. Percentages are rounded to the nearest 1%."),
                                     br()),
                              tabPanel(
                                p(tags$u("Timing of PA/PAUO")), 
                                p("For the following analysis termly absence data has been used", tags$sup("[4]"), 
                                  "Throughout the rest of the publication, annual absence data has been used."),
                                  h3("Timing of first record of persistent absence or persistent absence (unauthorised other) relative to the timing 
                                    of children’s first serious violence offence, for all pupils matched to KS4 academic years 2012/13 - 2017/18", tags$sup("[5]")),
                                column(h3(textOutput("sclTitle1_PAtime")),
                                       width=6,
                                       box(width = 12, plotOutput("timing_PA1"))), 
                                column(h3(textOutput("sclTitle2_PAtime")),
                                       width=6,
                                       box(width = 12, plotOutput("timing_PA2"))),
                                br(),
                                strong("Footnotes"),
                                br(),
                                paste("1. "),
                                a(href = "https://www.legislation.gov.uk/uksi/1999/3181/regulation/3/made", "The School Day and Year"),
                                br(),
                                paste("2. For more information on the definition of pupil absences see"),
                                a(href = "https://explore-education-statistics.service.gov.uk/methodology/pupil-absence-in-schools-in-england", 
                                  "Pupil absence statistics: methodology"),
                                paste(". This was changed from 15% to 10% in September 2015."),
                                br(),
                                paste("3. The definition of persistent absence includes all possible reasons for absence, including children whose 
                            absence was unauthorised, but the school was still provided with a reason for that absence (for example, an unagreed 
                            family holiday). The analysis has included this additional metric of absence (PAUO), as a way of differentiating those 
                            whose absence was not authorised and were unable to provide a reason for that absence, from those not attending school 
                                  for any reason. From 2013/14 absence for extended family holiday was discontinued, due to a change in regulation"),
                                br(), 
                                paste("4. Prior to the 2016/17 academic year absence information from special schools was collected on an annual basis only, 
                                      this was be collected each year via the autumn school census. Termly absence data for special schools was collected by 
                                      the Department for the first time in the autumn 2016 school census. Termly counts are likely to be underestimate as a result."),
                                br(),
                                paste("5. For children who were cautioned or sentenced for a serious violence offence, and had been persistently 
                            absent, the analysis compares whether the first school term they were fagged as persistently absent in, or 
                                  PAUO, preceded the school term in which the serious violence offence took place."),
                                br(),
                                paste("6. The analysis uses the date the offence took place rather than the date it was processed through the courts."),
                                br(),
                               paste("7. Percentages are rounded to the nearest 1%."),
                                br()
                                )),
                          )
                        )
                      ),
                      tabPanel(
                        "Suspension & Exclusions",
                        fluidRow(
                          column(
                            width=12,
                            br(),
                            details(
                              inputId = "sus_def",
                              label = "What is a suspension?",
                              help_text = tags$p("A suspension is where a pupil has been temporarily removed from the school", 
                                                 tags$sup("[1] [2]"), ".")
                            ),
                            details(
                              inputId = "excl_def",
                              label = "What is a permanent exclusion?",
                              help_text = tags$p("A permanent exclusion is when a pupil is no longer allowed to attend the school where they are currently on roll.")
                            ),
                            tabBox(width = 12, title = NULL, id="SusExcl_subtabs",
                                   tabPanel(
                                     p(tags$u("Ever suspended/excluded")),
                                     h5(tags$b("Choose plot type")),
                                            tabBox(width=12, title = NULL, id="SusExcl_subtabs2", 
                                            tabPanel(
                                            p(tags$u("Bar chart (All pupil groups)")), 
                                            h3("The proportion of all pupils who had a record of being suspended or 
                                            permanently excluded by offending and pupil group, for all pupils matched to KS4 academic years 2012/13 - 2017/18"), 
                                                     column(h3(textOutput("sclTitle1_sus")),
                                                            width=6,
                                                            box(width = 12, plotOutput("SusExclPlot1"))),  
                                                     column(h3(textOutput("sclTitle2_sus")),
                                                            width=6,
                                                            box(width = 12, plotOutput("SusExclPlot2")))
                                                     ),
                                            tabPanel(
                                            p(tags$u("Suspension Waffle plot")), 
                                            column(12,	
                                                   radioGroupButtons(                  
                                                     inputId="sus_plot_switch_waf", 
                                                     label="Choose pupil group",
                                                     choiceNames=c("All pupils : Any Offence", "All pupils : Serious Violence Offence"),
                                                     choiceValues=c("Any_off", "sv_off"),
                                                   )
                                            ),
                                            uiOutput("scl_plot_waf_sus"),
                                            
                                            ),
                                            tabPanel(
                                            p(tags$u("Exclusion Waffle plot")), 
                                            column(12,	
                                                   radioGroupButtons(                  
                                                     inputId="excl_plot_switch_waf", 
                                                     label="Choose pupil group",
                                                     choiceNames=c("All pupils : Any Offence", "All pupils : Serious Violence Offence"),
                                                     choiceValues=c("Any_off", "sv_off"),
                                                   )
                                            ),
                                            uiOutput("scl_plot_waf_excl"),
                                            )
                                            ),
                                     strong("Footnotes"),
                                     br(),
                                     paste("1. Prior to 2019/20, suspensions were referred to as fixed term exclusions."),
                                     br(),
                                     paste("2. Note, suspensions data can include lunchtime suspensions, but suspensions during lunchtime have not 
                                been included in this analysis. Please see full definition here: "),
                                     a(href = "https://explore-education-statistics.service.gov.uk/methodology/pupil-exclusion-statistics-methodology", 
                                       "Pupil exclusion statistics: methodology"),
                                     br(),
                                     paste("3. Year-on-year comparisons of local authority (LA) data may be affected by schools converting to academies."),
                                     br(),
                                     paste("4. Percentages are rounded to the nearest 1%."),
                                     br(),
                                     paste("5. Caution is advised when comparing across Local Authorities, due to differences in local policies."),
                                     br()
                                     ),
                                   tabPanel(
                                     p(tags$u("Timing of first/closest suspension/exclusion")), 
                                     p("The following analysis investigates the sequencing of suspensions and permanent exclusions with serious violence 
                                        offences. It looks at both the child’s first suspension or permanent exclusion and, in the case of multiple events, their 
                                            closest suspension or permanent exclusion relative to their first serious violence offence."), br(),
                                     details(
                                       inputId = "sus_timeHelp",
                                       label = "What do these charts tell us?",
                                       help_text = tags$p("Did first suspensions / permanent exclusions commonly precede or follow first serious violence offences?", 
                                                          tags$br(), tags$br(), 
                                                          "Did the closest suspensions", tags$sup("[4]"), 
                                                          "/ permanent exclusions commonly precede or follow first serious violence offences?")
                                            ),
                                            tabBox(width = 12, title = NULL, id="SusExcl_subtabs3",
                                                   tabPanel
                                                   (p(tags$u("First suspension")), 
                                                   h3("Timing of children’s first suspension relative to their first serious violence offence,
                                                      for all pupils matched to KS4 academic years 2012/13 - 2017/18"),
                                                     column(h3(textOutput("sclTitle1_fstsus")),
                                                            width=6,
                                                            box(width = 12,
                                                            plotOutput("FstSusTime1"))),  
                                                     column(h3(textOutput("sclTitle2_fstsus")),
                                                            width=6,
                                                            box(width = 12,
                                                                plotOutput("FstSusTime2")))
                                                     ),
                                                   tabPanel(
                                                   p(tags$u("Closest suspension")), 
                                                   h3("Timing of children’s closest suspension relative to their first serious violence offence, 
                                                      for all pupils matched to KS4 academic years 2012/13 - 2017/18"),
                                                   column(h3(textOutput("sclTitle1_clssus")),
                                                          width=6,
                                                          box(width = 12,
                                                            plotOutput("clstSusTime1"))), 
                                                   column(h3(textOutput("sclTitle2_clssus")),
                                                          width=6,
                                                          box(width = 12,
                                                              plotOutput("clstSusTime2")))
                                                   ),
                                                   tabPanel(
                                                   p(tags$u("First exclusion")), 
                                                   h3("Timing of children’s first permanent exclusion relative to their first serious violence offence, 
                                                      for all pupils matched to KS4 academic years 2012/13 - 2017/18"),
                                                   column(h3(textOutput("sclTitle1_fstexcl")),
                                                          width=6,
                                                          box(width = 12,
                                                              plotOutput("FstExclTime1"))), 
                                                   column(h3(textOutput("sclTitle2_fstexcl")),
                                                          width=6,
                                                          box(width = 12,plotOutput("FstExclTime2")))
                                                   ),
                                                   tabPanel(
                                                   p(tags$u("Closest exclusion")), 
                                                   h3("Timing of children’s closest permanent exclusion relative to their first serious violence offence, 
                                                      for all pupils matched to KS4 academic years 2012/13 - 2017/18"), 
                                                   column(h3(textOutput("sclTitle1_clsexcl")),
                                                          width=6,
                                                          box(width = 12,
                                                            plotOutput("clstExclTime1"))), 
                                                   column(h3(textOutput("sclTitle2_clsexcl")),
                                                          width=6,
                                                          box(width = 12, 
                                                              plotOutput("clstExclTime2"))))),
                                     strong("Footnotes"),
                                     br(),
                                     paste("1. Prior to 2019/20, suspensions were referred to as fixed term exclusions."),
                                     br(),
                                     paste("2. Note, suspensions data can include lunchtime suspensions, but suspensions during lunchtime have not 
                                been included in this analysis. Please see full definition here: "),
                                     a(href = "https://explore-education-statistics.service.gov.uk/methodology/pupil-exclusion-statistics-methodology", 
                                       "Pupil exclusion statistics: methodology"),
                                     br(),
                                     paste("3. Year-on-year comparisons of local authority (LA) data may be affected by schools converting to academies."),
                                     br(), 
                                     paste("4. Where children who had been cautioned or sentenced for a serious violence offence had received multiple suspensions/permanent exclusions, 
                          the analysis defined closest as the shortest amount of time between the start of the suspensions/permanent exclusions and the first 
                                serious violence offence date"),
                                     br(),
                                     paste("5.The analysis uses the date the offence took place rather than the date it was processed through the courts."),
                                     br(),
                                     paste("6. Percentages are rounded to the nearest 1%."),
                                     br(),
                                     paste("7. Caution is advised when comparing across Local Authorities, due to differences in local policies."),
                                     br()
                                     )),
                          )
                        )
                      ),
                      tabPanel(
                        "Alternative Provision",
                        fluidRow(
                          column(
                            width=12, 
                            br(),
                            details(
                              inputId = "AP_def",
                              label = "What is alternative provision?",
                              help_text = tags$p("Alternative Provision (AP) is full or part-time education arranged by:", tags$br(), tags$br(), 
                                                 "a) local authorities, either directly or working with schools, for pupils who, because of permanent exclusion, 
                                                 illness or other reasons, would not otherwise receive suitable education.", tags$br(), tags$br(),
                                                 "b) schools for pupils to improve their behaviour off-site, or during a suspension", tags$br(), tags$br(),
                                                 "The education often takes place at a pupil referral unit (PRU), AP academy or free school, known collectively 
                                                 as the ‘state place-funded AP’ sector.", tags$br(), tags$br(), "However, alternative provision placements can 
                                                 also be arranged in independent schools, Further Education colleges or unregistered education settings, known as the 
                                                 'independent AP’ sector. Some of the pupils identified in the data as attending independent and unregistered AP 
                                                 settings were registered in independent special schools named on their Education, Health and Care plans, some of 
                                                 which do not meet the Department for Education’s (DfE) statutory definition of AP.", tags$sup("[1]"))
                              
                              ),
                            tabBox(width = 12, title = NULL, id="AP_subtabs",
                                   tabPanel( 
                                     p(tags$u("Ever AP")),
                                     h5(tags$b("Choose plot type")),
                                     tabBox(width=12, title = NULL, id="AP_subtabs2",
                                            tabPanel(
                                              p(tags$u("Bar chart (All pupil groups)")), 
                                            h3("The proportion of all pupils who had ever attended alternative provision by offending 
                                                and pupil group, for pupils matched to KS4 academic years 2012/13 - 2017/18"), 
                                            column(h3(textOutput("sclTitle1_AP")),
                                                   width=6, 
                                                   box(width = 12,
                                                   plotOutput("APchart1"))),
                                            column(h3(textOutput("sclTitle2_AP")),
                                                   width=6,
                                                   box(width = 12,
                                                   plotOutput("APchart2")))),
                                            tabPanel(
                                              p(tags$u("Waffle plot")), 
                                              column(12,	
                                                     radioGroupButtons(                  
                                                       inputId="ap_plot_switch_waf", 
                                                       label="Choose pupil group",
                                                       choiceNames=c("All pupils : Any Offence", "All pupils : Serious Violence Offence"),
                                                       choiceValues=c("Any_off", "sv_off"),
                                                     )
                                              ),
                                              uiOutput("scl_plot_waf_ap"),
                                              )),
                                     strong("Footnotes"),
                                     br(),
                                     paste("1. Please see here for more information on AP statutory guidance:"),
                                     a(href = "https://www.gov.uk/government/publications/alternative-provision", "Alternative Provision Statutory Guidance"),
                                     br(),
                                     paste("2. Percentages are rounded to the nearest 1%."),
                                     br()),
                                   tabPanel( 
                                   p(tags$u("Timing of AP")), 
                                   h3("The first term children attended alternative provision (AP) relative to the timing of their first 
                                      offence, for all pupils matched to KS4 academic years 2012/13 - 2017/18"), 
                                   p("Did the first term a child attended alternative provision (AP) commonly precede the first serious violence offence?"),  
                                   column(h3(textOutput("sclTitle1_APtime")),
                                          width=6, 
                                          box(width = 12,
                                              plotOutput("timing_AP1"))), 
                                   column(h3(textOutput("sclTitle2_APtime")),
                                          width=6, 
                                          box(width = 12,
                                              plotOutput("timing_AP2"))),
                                   strong("Footnotes"),
                                   br(),
                                   paste("1. Please see here for more information on AP statutory guidance:"),
                                   a(href = "https://www.gov.uk/government/publications/alternative-provision", "Alternative Provision Statutory Guidance"),
                                   br(),
                                   paste("2. The analysis uses the date the offence took place rather than the date it was processed through the courts."),
                                   br(),
                                   paste("3. Percentages are rounded to the nearest 1%."),
                                   br())),
                            )
                        )
                      ),
                      tabPanel(
                        "SEN",
                        fluidRow(
                          column(
                            width=12,
                            h3("Special Educational Needs"),
                          p("This analysis looks at the proportion of children who had been cautioned or sentenced for an offence who were ever recorded as 
                               having Special Educational Needs (SEN)", tags$sup("[1]"), "."), br(),
                            details(
                              inputId = "SEN_def",
                              label = "When is a child or young person classified as having SEN?",
                              help_text = tags$p("A child or young person is classified as having SEN if they have a learning difficulty or disability which 
                                                 calls for special educational provision to be made for them.")
                            ),
                            details(
                              inputId = "SENSup_def",
                              label = "What is SEN Support and an Education, Health and Care plan (EHC plan)?",
                              help_text = tags$p("Most children with SEN will have their needs met by their education setting with no additional funding from 
                              the local authority (‘SEN Support’)", tags$sup("[2]"), "whilst others may undergo a formal assessment resulting in an Education, Health and Care 
                              plan (EHC plan)", tags$sup("[3]"), "if they are assessed as having a complex need that requires additional provision. It is important to note that 
                              this analysis only covers children who have identified SEN, and some children will have unidentified needs and therefore relevant 
                              support will not have been put in place.")
                            ),
                            tabBox(width = 12, title = NULL, id="sen_subtabs",
                                   tabPanel(
                                     p(tags$u("Ever SEN")),
                                     h5(tags$b("Choose plot type")),
                                     tabBox(width=12, title = NULL, id="sen_subtab2",
                                            tabPanel(
                                              p(tags$u("Bar chart (All pupil groups)")), 
                                              h3("Special Educational Needs (SEN) of all pupils by offending and pupil group, for those that 
                                                   were ever recorded with SEN, for pupils matched to KS4 academic years 2012/13 - 2017/18"), 
                                              column(h3(textOutput("sclTitle1_SEN")),
                                                     width=6, 
                                                     box(width = 12,
                                                         plotOutput("SENchart1"))),  
                                              column(h3(textOutput("sclTitle2_SEN")),
                                                     width=6, 
                                                     box(width = 12, 
                                                         plotOutput("SENchart2")))
                                                         ),
                                            tabPanel(
                                              p(tags$u("SEN Support Waffle plot")), 
                                              column(12,	
                                                     radioGroupButtons(                  
                                                       inputId="sen_plot_switch_waf", 
                                                       label="Choose pupil group",
                                                       choiceNames=c("All pupils : Any Offence", "All pupils : Serious Violence Offence"),
                                                       choiceValues=c("Any_off", "sv_off"),
                                                     )
                                              ),
                                              uiOutput("scl_plot_waf_sen"),
                                              ),
                                            tabPanel(
                                              p(tags$u("EHC plan waffle plot")), 
                                              column(12,	
                                                     radioGroupButtons(                  
                                                       inputId="ehcp_plot_switch_waf", 
                                                       label="Choose pupil group",
                                                       choiceNames=c("All pupils : Any Offence", "All pupils : Serious Violence Offence"),
                                                       choiceValues=c("Any_off", "sv_off"),
                                                     )
                                              ),
                                              uiOutput("scl_plot_waf_ehcp"),
                                                         )),
                                     strong("Footnotes"),
                                     br(),
                                     paste("1. The Children and Families Act 2014 and the SEND Code of Practice (2015) covers children and young 
                            people with Special Educational Needs and Disabilities (SEND). A child or young person has SEN if they 
                            have a learning difficulty or disability which calls for special educational provision to be made for them. 
                            Children and young people have a disability if they have a physical or mental impairment which has a 
                            long-term and substantial adverse effect on their ability to carry out normal day-to-day activities. Children 
                            and young people with a disability do not necessarily have SEN, or vice-versa, but there is a significant 
                            overlap between disabled children and young people and those with SEN. Data collected and published by 
                                  Department for Education only records children and young people identified with SEN."),
                                     br(),
                                     paste("2. Prior to 2014, this category was School Action or School Action Plus. The term ‘SEN Support’ describes 
                            the actions taken to support children in mainstream settings who have been identifed as having Special 
                            Educational Needs (SEN), but who do not have an Education, Health and Care plan (EHC plan). These 
                            children receive support and provision from resources already available within the school (which could 
                            include advice or support from outside specialists). Should a child require additional resources that the 
                            existing school’s SEN Support system does not include, then they can apply for a more detailed EHC plan, 
                            which outlines the educational, health and social needs of the individual and the specific provisions in place 
                                  to support them."),
                                     br(),
                                     paste("3. From 2014 Education, Health and Care plans were introduced. Under previous legislation pupils could 
                            be eligible for Statements of SEN. The period for local authorities to transfer children and young people 
                            with Statements of SEN to EHC plans started in September 2014 and ended on 31 March 2018. For the 
                            purposes of this analysis, ‘EHC plan’ will be used to describe both Statements of SEN and EHC plans 
                                  unless stated otherwise in the particular context."),
                                     br(),
                                     paste("4. The analysis throughout this publication refers to children with SEN Support as children that had ever 
                                  been identified as having SEN, but never with an EHC plan."),
                                     br(),
                                     paste("5. Percentages are rounded to the nearest 1%."),
                                     br(),
                                     paste("6. Caution is advised when comparing across Local Authorities, due to differences in local policies."),
                                     br(),
                                     ),
                                   tabPanel(
                                     p(tags$u("Timing of SEN")),
                                     p("Did a child being identified as SEN commonly precede the first serious violence offence?", tags$sup("[4]"),"."),  
                                     tabBox(width=12, title = NULL, id="sen_subtab3",
                                            tabPanel(
                                              p(tags$u("SEN timing")), 
                                              h3("The first term children had been recorded with SEN, relative to the timing of their first 
                                         serious violence offence, for pupils matched to KS4 academic years 2012/13 - 2017/18"),
                                              column(h3(textOutput("sclTitle1_SENtime")),
                                                     width=6, 
                                                     box(width = 12,
                                                         plotOutput("timing_SEN1"))),
                                              column(h3(textOutput("sclTitle2_SENtime")), 
                                                     width=6, 
                                                     box(width = 12,
                                                         plotOutput("timing_SEN2")))
                                              ),
                                              tabPanel(
                                              p(tags$u("EHC plan timing")), 
                                              h3("The first term children had an EHC plan, relative to the timing of their first serious violence
                                                  offence, for pupils matched to KS4 academic years 2012/13 - 2017/18"),
                                              column(h3(textOutput("sclTitle1_EHCPtime")),
                                                     width=6, 
                                                     box(width = 12,
                                                         plotOutput("timing_EHCP1"))), 
                                              column(h3(textOutput("sclTitle2_EHCPtime")),
                                                     width=6, 
                                                     box(width = 12,
                                                         plotOutput("timing_EHCP2")))
                                                         )),
                                     strong("Footnotes"),
                                     br(),
                                     paste("1. The Children and Families Act 2014 and the SEND Code of Practice (2015) covers children and young 
                                            people with Special Educational Needs and Disabilities (SEND). A child or young person has SEN if they 
                                            have a learning difficulty or disability which calls for special educational provision to be made for them. 
                                            Children and young people have a disability if they have a physical or mental impairment which has a 
                                            long-term and substantial adverse effect on their ability to carry out normal day-to-day activities. Children 
                                            and young people with a disability do not necessarily have SEN, or vice-versa, but there is a significant 
                                            overlap between disabled children and young people and those with SEN. Data collected and published by 
                                            Department for Education only records children and young people identified with SEN."),
                                     br(),
                                     paste("2. Prior to 2014, this category was School Action or School Action Plus. The term ‘SEN Support’ describes
                                     the actions taken to support children in mainstream settings who have been identifed as having Special 
                                      Educational Needs (SEN), but who do not have an Education, Health and Care plan (EHC plan). These 
                                      children receive support and provision from resources already available within the school (which could 
                                      include advice or support from outside specialists). Should a child require additional resources that the 
                                      existing school’s SEN Support system does not include, then they can apply for a more detailed EHC plan, 
                                      which outlines the educational, health and social needs of the individual and the specific provisions in place 
                                      to support them."),
                                     br(),
                                     paste("3. From 2014 Education, Health and Care plans were introduced. Under previous legislation pupils could 
                                      be eligible for Statements of SEN. The period for local authorities to transfer children and young people 
                                      with Statements of SEN to EHC plans started in September 2014 and ended on 31 March 2018. For the 
                                      purposes of this analysis, ‘EHC plan’ will be used to describe both Statements of SEN and EHC plans 
                                            unless stated otherwise in the particular context."),
                                     br(),
                                     paste("4. This analysis aims to differentiate between children who had been cautioned or sentenced for an offence, or a serious 
                                      violence offence, that have received different levels of support. As such, the analysis distinguishes between those that have had SEN 
                                      Support, but have never had an EHC plan, and those that have had an EHC plan, and when they were first recorded as receiving that support. 
                                      It is important to note that this does not necessarily equate to when the child was first identified as having SEN."),
                                     br(), 
                                     paste("5. The analysis throughout this publication refers to children with SEN Support as children that had ever 
                                      been identified as having SEN, but never with an EHC plan."),
                                     br(),
                                     paste("6. The analysis uses the date the offence took place rather than the date it was processed through the courts."),
                                     br(),
                                     paste("7. Percentages are rounded to the nearest 1%."),
                                     br(),
                                     paste("8. Caution is advised when comparing across Local Authorities, due to differences in local policies."), 
                                     br()),
                                   tabPanel(
                                     p(tags$u("Timing of SEMH")), 
                                     p("Did a child being identified as SEMH commonly precede the first serious violence offence?"),
                                     br(),
                                     details(
                                       inputId = "SENTypes_def",
                                       label = "What types of SEN are used in the analysis?",
                                       help_text = tags$p("For this analysis, both primary and secondary SEN type have been considered when exploring types of SEN",
                                                          tags$sup("[4]", "."), 
                                                   tags$br(), tags$br(), "The most prevalent type of recorded SEN amongst children who had been cautioned or sentenced for 
                                                    a serious violence offence was Social, Emotional and Mental Health needs (SEMH)", tags$sup("[5][6]", "."))), 
                                     h3("The first term children had SEMH, relative to the timing of their first serious violence offence, for pupils matched to KS4 academic years 2012/13 - 2017/18"),
                                     column(h3(textOutput("sclTitle1_SEMHtime")),
                                            width=6, 
                                            box(width = 12,
                                                plotOutput("timing_SEMH1"))),
                                     column(h3(textOutput("sclTitle2_SEMHtime")),
                                            width=6, 
                                            box(width = 12,
                                                plotOutput("timing_SEMH2"))),
                                     strong("Footnotes"),
                                     br(),
                                     paste("1. The Children and Families Act 2014 and the SEND Code of Practice (2015) covers children and young 
                            people with Special Educational Needs and Disabilities (SEND). A child or young person has SEN if they 
                            have a learning difficulty or disability which calls for special educational provision to be made for them. 
                            Children and young people have a disability if they have a physical or mental impairment which has a 
                            long-term and substantial adverse effect on their ability to carry out normal day-to-day activities. Children 
                            and young people with a disability do not necessarily have SEN, or vice-versa, but there is a significant 
                            overlap between disabled children and young people and those with SEN. Data collected and published by 
                                  Department for Education only records children and young people identified with SEN."),
                                     br(),
                                     paste("2. Prior to 2014, this category was School Action or School Action Plus. The term ‘SEN Support’ describes 
                            the actions taken to support children in mainstream settings who have been identifed as having Special 
                            Educational Needs (SEN), but who do not have an Education, Health and Care plan (EHC plan). These 
                            children receive support and provision from resources already available within the school (which could 
                            include advice or support from outside specialists). Should a child require additional resources that the 
                            existing school’s SEN Support system does not include, then they can apply for a more detailed EHC plan, 
                            which outlines the educational, health and social needs of the individual and the specific provisions in place 
                                  to support them."),
                                     br(),
                                     paste("3. From 2014 Education, Health and Care plans were introduced. Under previous legislation pupils could 
                            be eligible for Statements of SEN. The period for local authorities to transfer children and young people 
                            with Statements of SEN to EHC plans started in September 2014 and ended on 31 March 2018. For the 
                            purposes of this analysis, ‘EHC plan’ will be used to describe both Statements of SEN and EHC plans 
                                  unless stated otherwise in the particular context."),
                                     br(),
                                     paste("4. Primary and secondary SEN type was added to the AP census in 2017/18"),
                                     br(),
                                     paste("5. There were changes to the classification of type of need in 2015 when the previous code of ‘Behaviour, emotional and social 
                            difficulties (BESD)’ was removed, and a new code ‘Social, emotional and mental health (SEMH)’ was introduced. However, those with a primary 
                            need of BESD in 2014 were not all expected to move to SEMH in 2015. The analysis combined results for the two SEN types, whilst understanding 
                            that SEMH was not intended to be a direct replacement for BESD. Results for types of SEN prior to 2015 will include BESD rather than SEMH."),
                                     br(),
                                     paste("6. As SEMH is consistently the most common recorded SEN type amongst children who had been cautioned or sentenced for a serious violence 
                                  offence in England (See"), 
                                     a(href = "https://www.gov.uk/government/publications/education-childrens-social-care-and-offending", 
                                                   "previous publication"), 
                                     "for more detail on recorded SEN types), further analysis has been carried out on the timing of the identification of SEMH",
                                     br(),
                                     paste("7. The analysis uses the date the offence took place rather than the date it was processed through the courts."),
                                     br(),
                                     paste("8. Percentages are rounded to the nearest 1%."),
                                     br(),
                                     paste("9. Caution is advised when comparing across Local Authorities, due to differences in local policies."),
                                     br()
                                     )),
                            )
                        )
                      )
          )
        )
      )
    )
  )
}

CSCExp <- function() {
  tabPanel(
    value = "tab_csc",
    "Children's Social Care Experience",
    
    gov_main_layout(
      gov_row(
        column(
          width=12,
          h1("Children's Social Care Experience"),
          h4("This tab contains analysis that relates to children's experiences with children's social care")
        ),
        column(
          width=12,
          div(
            class = "well",
            style = "min-height: 100%; height: 100%; overflow-y: visible",
            gov_row(
              column(
                width = 6,
                selectizeInput("cscLAchoice", 
                               "Local Authority 1", 
                               choices = choicesLA
                               )
                ),
              column(
                width = 6,
                uiOutput('cscLAchoice2_')
                ),
              column(
                width = 6,
                radioButtons("cscindichoice", 
                             p("Indicator 1", 
                               tags$div(class = "dropdown", 
                                        dropdownButton(h5("Select", tags$b("Home"), "to view children who", tags$b("live"), "in given local authority.", 
                                                          tags$br(), tags$br(), 
                                                          "Select", tags$b("School"), "to view children who", tags$b("go to school"), "in given local authority",
                                                          style = "color:black"), 
                                                       status = 'info', icon = icon('info'), size = "xs")
                               )
                             ),
                             choices = choiceIndicator$Indicator,
                             selected = "School"
                             )
              ), 
              column(
                width = 6,
                radioButtons("cscindichoice2", 
                            p("Indicator 2", 
                              tags$div(class = "dropdown", 
                                        dropdownButton(h5("Select", tags$b("Home"), "to view children who", tags$b("live"), "in given local authority.", 
                                                         tags$br(), tags$br(), 
                                                         "Select", tags$b("School"), "to view children who", tags$b("go to school"), "in given local authority",
                                                         style = "color:black"), 
                                                       status = 'info', icon = icon('info'), size = "xs")
                                        )
                            ),
                             choices = choiceIndicator$Indicator,
                             selected = "School"
                )
                )
              )
            )
          ),
        column(width=12, 
        h3("Children known to children's social care"),
        p("The next set of findings look at the proportion of children who had been cautioned or sentenced for an offence that were recorded 
                        as being children in need (CIN) or children who are looked after (CLA), as defined by the Children Act 1989,
                        between 2011/12 – 2017/18 for CIN, and 2005/06 - 2017/18 for CLA", tags$sup("[1]"), ". CIN here refers to children who are designated under a number of
                        different social care classifications: children on a child in need plan; children on a child protection plan", tags$sup("[2]"), "; and children who are looked 
                        after", tags$sup("[3]"), ". As such, CLA figures are included in the figures for CIN. Since the CIN and CLA data cover different time periods, and CIN 
                        includes CLA for some of the same period, comparisons of CIN to CLA should be made with caution. To maximise coverage of the CIN data 
                        and avoid skewed results, the analysis in this section is based on children matched to KS4 academic year 2012/13 - 2017/18 only."), br(),
        p("When reading the findings related to children looked after (CLA), it is important to note that the introduction of the Legal Aid, 
                        Sentencing and Punishment of Offenders Act 2012 (LASPOA) meant that, from 3rd December 2012, children up to the age of 18 who are 
                        remanded to youth detention accommodation as a result of being charged with or convicted of an offence will be ‘looked after’ by the 
                        designated local authority",tags$sup("[4]"), ". Therefore, caution should be taken when considering the findings related to CLA and offending, as the child 
                        may have become CLA due to the offending."), br(), 
        tabsetPanel(id = "tabsetpanels3",
                    tabPanel(
                      "Ever CIN/CLA",
                      fluidRow(
                        column(
                          width=12,
                          br(),
                          h5(tags$b("Choose plot type")),
                          tabBox(width = 12, title = NULL, id="csc_subtabs",
                                 tabPanel(
                                   p(tags$u("Bar chart (All pupil groups)")), 
                                   h3("The proportion of children who had been recorded as being CIN/CLA, by offending and pupil group, for pupils matched to KS4 academic year 2012/13 - 2017/18"), 
                                 column(h3(textOutput("CSCTitle1")),
                                        width=6, 
                                        box(width = 12,
                                 plotOutput("CSCPlot1"))), 
                                 column(h3(textOutput("CSCTitle2")),
                                        width=6, 
                                        box(width = 12,br(), plotOutput("CSCPlot2")))),
                                 
                                 tabPanel(
                                   p(tags$u("Waffle plot")), 
                                   
                                   # added
                                   column(12,	
                                          radioGroupButtons(                  
                                            inputId="csc_plot_switch_waf", 
                                            label="Choose pupil group",
                                            choiceNames=c("All pupils : Any Offence", "All pupils : Serious Violence Offence"),
                                            choiceValues=c("Any_off", "sv_off"),
                                          )
                                   ),
                                   uiOutput("csc_plot_la_waf")
                                   )
                                 )
                          )
                        ),
                      strong("Footnotes"),
                      br(),
                      paste("1. This diverges from the definition of Ever CIN used in the CIN Review, which looks at whether the child 
          was recorded as so in the previous 6 years. Please see here for further details:"),
                      a(href = "https://www.gov.uk/government/publications/children-in-need-of-help-and-protection-data-and-analysis", 
                        "Children in need of help and protection: data and analysis"),
                      br(),
                      paste("2. Child Protection Plan (CPP) - support for a child where there is reasonable suspicion that child is 
                suffering, or likely to suffer, significant harm."),
                      br(),
                      paste("3. Children who are looked after (CLA) – a child who is looked after by a local authority if they fall into one 
          of the following: is provided with accommodation, for a continuous period of more than 24 hours (Children Act 1989, 
          Section 20 and 21); is subject to a care order (Children Act 1989, Part IV), or is subject to a placement order. 
          The analysis has not analysed children on a child in need plan (CINP) separately, but rather have looked at all 
                children in need, and the two categories of highest intervention."),
                      br(),
                      paste("4. Please see here for more information:"),
                      a(href = "https://www.gov.uk/government/publications/children-in-need-of-help-and-protection-data-and-analysis", 
                        "Children looked after return 2020 to 2021"),
                      br(),
                      paste("5. Full CIN data is available from 2011/12, term 3. Children are included in this CIN analysis if they had 
          been recorded as a child in need in any period between the ages of 12 - 16. Those matched to earlier 
          years in the KS4 attainment data will as a result have less coverage than those matched to later years. For example: 
                those with KS4 academic year 2012/13 have coverage from age 14 and above."),
                      br(),
                      paste("6. Children are included in this CLA analysis if they had been recorded as a child being looked after 
                      in any period between the ages of 6 - 16. Those matched to earlier years in the KS4 attainment data will as a result have less 
          coverage than those matched to later years. For example: those with KS4 academic year 2012/13 have coverage from age 8 and above."),
                      br(),
                      paste("7. Percentages are rounded to the nearest 1%."),
                      br(),
                      paste("8. Caution is advised when comparing across Local Authorities, due to differences in local policies."),
                      br()),
                    tabPanel(
                      "Timing of CSC",
                      h4("Did the first record of a child being known to children’s social care commonly precede the first serious violence offence?"), br(),
                      p("The focus of this analysis is to understand the sequencing of a child’s journey between different social care groups relative to the 
                        interaction(s) with the criminal justice system they may have had. It looks at children who had been cautioned or sentenced for a 
                        serious violence offence and whether their first record of being a child in need, a child on a child protection plan, and/or a child being 
                        looked after occurred before, after or during the same school term as their first serious violence offence (for those recorded as CIN, 
                        including CLA, as defined by the Children Act 1989, at any point in a given school term between 2011/12 – 2017/18 for CIN, and 
                          2004/05 - 2017/18 for CLA)."), br(),
                      p("The analysis presented here utilises a different dataset", tags$sup("[5]"), "to that used in the previous tab (Ever CIN/CLA), enabling more granular examination of those recorded in the children’s social care system at any point during the year,
                        and to look at changes in their social care group throughout the year."), br(),
                      p("Children who had been cautioned or sentenced for a serious violence offence have been classifed here as being CIN, CPP or CLA 
                        in an academic term, if at any point in that term they have been recorded as CIN, CPP or CLA", tags$sup("[6]"), "."),
                        h3("The first record of children being a child in need, having a child protection plan or 
                            being a child who was looked after, relative to the timing of their first offence, for all pupils matched to KS4 
                             academic year 2012/13 - 2017/18"), 
                      column(h3(textOutput("CSCTitle1_time")),
                             width=6, 
                             box(width = 12,
                                 plotOutput("timing_CSC1"))
                             ), 
                      column(h3(textOutput("CSCTitle2_time")),
                             width=6, 
                             box(width = 12, 
                                 plotOutput("timing_CSC2"))
                             )
                      ,
                      strong("Footnotes"),
                      br(),
                      paste("1. This diverges from the definition of Ever CIN used in the CIN Review, which looks at whether the child 
          was recorded as so in the previous 6 years. Please see here for further details:"),
                      a(href = "https://www.gov.uk/government/publications/children-in-need-of-help-and-protection-data-and-analysis", 
                        "Children in need of help and protection: data and analysis"),
                      br(),
                      paste("2. Child Protection Plan (CPP) - support for a child where there is reasonable suspicion that child is 
                suffering, or likely to suffer, significant harm."),
                      br(),
                      paste("3. Children who are looked after (CLA) – a child who is looked after by a local authority if they fall into one 
          of the following: is provided with accommodation, for a continuous period of more than 24 hours (Children Act 1989, 
          Section 20 and 21); is subject to a care order (Children Act 1989, Part IV), or is subject to a placement order. 
          The analysis has not analysed children on a child in need plan (CINP) separately, but rather have looked at all 
                children in need, and the two categories of highest intervention."),
                      br(),
                      paste("4. Please see here for more information:"),
                      a(href = "https://www.gov.uk/government/publications/children-in-need-of-help-and-protection-data-and-analysis", 
                        "Children looked after return 2020 to 2021"),
                      br(),
                      paste("5. Termly CIN and CLA datasets were provided internally to enable us to complete this analysis. This data is not currently 
                available within the MoJ-DfE data share."),
                      br(),
                      paste("6. A child can move between various stages of the social care system within and between terms, including into and out of need. 
          Each child was assigned a termly activity label based on the following hierarchy: CLA – if a child has been looked after for at least 
          one day in that term; CPP – if a child is not labelled as CLA and has been on a child protection plan for at least one day in that term; 
          CIN – a child that falls into any of the two previous categories, or if they are CINP - if a child is not labelled as CLA or CPP and has 
          been in need for at least one day in the term (child in need plan). The legal definition of children in need includes all disabled children. 
          Unlike other children who must be assessed as in need, disabled children are classed as Children in Need by virtue of having a disability. 
          Please see here for more information:"), 
                      a(href = "https://www.gov.uk/government/publications/children-in-need-of-help-and-protection-data-and-analysis", 
                        "Children in need of help and protection: data and analysis"),
                      br(),
                      paste("7. The analysis uses the date the offence took place rather than the date it was processed through the courts."),
                      br(),
                      paste("8. Percentages are rounded to the nearest 1%."),
                      br(),
                      paste("9. Caution is advised when comparing across Local Authorities, due to differences in local policies."),
                      br())
        ),
        )
      )
    )
  )
}