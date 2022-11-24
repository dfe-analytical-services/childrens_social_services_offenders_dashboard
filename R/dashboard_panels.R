homepage_panel <- function() {
  tabPanel(
    "Homepage",
    gov_main_layout(
      gov_row(
        column(
          12,
          h1("DfE Analytical Services R-Shiny data dashboard template (h1)"),
          br(),
          h4("This is some overview text about the dashboard etc etc .... "),
          br()
        ),
        
        ## Left panel -------------------------------------------------------
        
        column(
          6,
          div(
            div(
              class = "panel panel-info",
              div(
                class = "panel-heading",
                style = "color: white;font-size: 18px;font-style: bold; background-color: #1d70b8;",
                h2("Contents (h2)")
              ),
              div(
                class = "panel-body",
                tags$div(
                  title = "This section is useful if you want to understand how well different industries retain graduates.",
                  h3("Introduction (h3)"),
                  p("This app demonstrates the DfE Analytical Services R-Shiny data dashboard template."),
                  p("You might want to add some brief introductory text here alongside some links to different tabs within your dashboard. Here's an example of a link working:"),
                  p(actionLink("link_to_app_content_tab", "Dashboard panel")),
                  p("You need to add an observeEvent() function to the server.R script for any link that navigates within your App.")
                ),
                br()
              )
            )
          ),
        ),
        
        ## Right panel ------------------------------------------------------
        
        column(
          6,
          div(
            div(
              class = "panel panel-info",
              div(
                class = "panel-heading",
                style = "color: white;font-size: 18px;font-style: bold; background-color: #1d70b8;",
                h2("Background Info (h2)")
              ),
              div(
                class = "panel-body",
                h3("Context and purpose (h3)"),
                p("This app is the DfE Analytical Service's R-Shiny template demonstration app and is being developed to provide a coherent styling for DfE dashboards alongside some useful example componenets that teams can adapt for their own uses."),
                p("DfE teams using this template should avoid changing the styling and layout, keeping the header, footer and side navigation list formats."),
                                p("You might want to add some relevant background information for your users here. For example some useful links to your EES publication, data sources and other relevant resources."),
                h3("Guidance sources (h3)"),
                p("For example, here we'll add some of the key resources we draw on to guide styling and vizualisation...")
              )
            )
          )
        ),
        
        ## Bottom panel ------------------------------------------------------
        
        column(
          12,
          div(
            div(
              class = "panel panel-info",
              div(
                class = "panel-heading",
                style = "color: white;font-size: 18px;font-style: bold; background-color: #1d70b8;",
                h2("A wider column")
              ),
              div(
                class = "panel-body",
                tags$div(
                  title = "This section is useful for .......",
                  h3("Introduction..."),
                  p("This is a paragraph text ..."),
                  br(),
                  tabBox(width = 12, title = NULL, id="overview_tabs",
                         tabPanel("Overview 1", 
                                  h3("Overview 1 text"), 
                                  br()
                                  ),
                         tabPanel("Overview 2", 
                                  h3("Overview 2 text"), 
                                  br()
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


dashboard_panel <- function() {
  tabPanel(
    value = "dashboard",
    "Dashboard",
    
    # Define UI for application that draws a histogram
    
    # Sidebar with a slider input for number of bins
    gov_main_layout(
      gov_row(
        column(
          width=12,
        h1("Overall content title for this dashboard page (h1)"),
        ),
        column(
          width=12,
          div(
            class = "well",
            style = "min-height: 100%; height: 100%; overflow-y: visible",
            gov_row(
            column(
              width = 6,
              selectizeInput("selectPhase",
                    "Select a school phase",
                    choices = choicesPhase
                    )),
            column(
              width = 6,
          selectizeInput(
            inputId = "selectArea",
            label = "Choose an area:",
            choices = choicesAreas$area_name
        )
        ), 
        column(
          width = 12,
          paste("Download the underlying data for this dashboard:"), br(),
          downloadButton(
            outputId = "download_data",
            label= "Download data",
            icon = shiny::icon("download"),
            class = "downloadButton"
          )
        ))
          )
        ),
        
        column(
          width=12,
               tabsetPanel(id = "tabsetpanels",
                 tabPanel(
                   "Example panel 1",
                   fluidRow(
                     column(
                       width=12,
          h2("Outputs 1 (h2)"),
          valueBoxOutput("boxavgRevBal", width = 6),
          valueBoxOutput("boxpcRevBal", width = 6),
          box(
            width=12,
          plotlyOutput("lineRevBal")))
        )
        ),
        tabPanel(
          "Example panel 2",
          fluidRow(
            column(
              width=12,
          h2("Outputs 2 (h2)"),
          p("This is the standard paragraph style for adding guiding info around data content."),
          column(
            width=6,
            box(
              width=12,
              plotlyOutput("colBenchmark")
            )
          ),
          column(
            width=6,
            div(
              class = "well",
              style = "min-height: 100%; height: 100%; overflow-y: visible",
              fluidRow(
                column(
                  width=12,
                  selectizeInput("selectBenchLAs",
                                 "Select benchamrk LAs",
                                 choices = choicesLAs$area_name,
                                 multiple=TRUE,
                                 options = list(maxItems = 3)
                  )
                )
                  )
              ),
                dataTableOutput("tabBenchmark")
          ))
        ))
              )
        )
        # add box to show user input
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
                               "LA", 
                               choices = choicesLA
                )),
              column(
                width = 6,
                selectizeInput("demLAchoice2", 
                               "LA (choice 2)",
                               choices = choicesLA,
                               select = "xSgZ6" # Will need to change this to England with real data
                )
              ), 
              column(
                width = 6,
                radioButtons("demindichoice", 
                             "Indicator", 
                             choices = choiceIndicator$Indicator,
                             selected = "School"
                             )
                ),
              column(
                width = 6,
                checkboxGroupInput("demgroupchoice", 
                                   "Pupil group", 
                                   choices = choiceGroup$group, 
                                   selected = choiceGroup$group
                )
              ),
              bsPopover(id = "demindichoice", title="", content = "Select <b>Home</b> to view children who <b>live</b> in given local authority. Select <b>School</b> to view children who <b>go to school</b> in given local authority", 
                        trigger="hover", placement="bottom", options = list(container = "body"))
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
                            h5("The table below contains demographic information about the selected local authorities and/or England"),
                            br(),
                            box(
                              width = 12,
                              dataTableOutput("demotable")
                            ),
                            strong("Footnotes"),
                            br(),
                            paste("1. Percentages are rounded to the nearest 1%."),
                            br(),
                            paste("2. Gaps in the table indicate where data has been supressed due to small numbers."),
                            br(),
                            paste("3. In order to better understand offending trajectories for children who had been cautioned
                            or sentenced for a serious violence offence, this analysis looks at the volume of offending which 
                                  preceded a first serious violence offence."),
                            br()
                          )
                          )
                        
                      ),
                      tabPanel(
                        "Gender",
                        fluidRow(
                          column(
                            width=12,
                            h3("The gender breakdown of offending and pupil group, for all pupils matched to KS4 academic years XXXX/XX - XXXX/XX"),
                            br(),
                            h5("Gender information has been taken from the DfE school census, and from 2011, could only be completed by the child or their parents. 
                               Where a pupil's gender changes over time, the most recent gender has been taken. The gender recorded in the DfE school census may not be the
                               same as to which a child identifies."),
                            br(),
                            box(
                              width=12,
                              plotOutput("GenderPlot1"),
                              br(),
                              plotOutput("GenderPlot2"))
                          ),
                          strong("Footnotes"),
                          br(),
                          paste("1. Percentages are rounded to the nearest 1%."),
                          br(),
                          paste("2. Gaps in the chart indicate where data has been supressed due to small numbers."),
                          br(),
                        )
                      ),
                      tabPanel(
                        "Age at first offence",
                        fluidRow(
                          column(
                            width=12,
                            h3("The proportion of children relative to their age at first offence\nby offending group, for pupils matched 
                               to KS4 academic years XXXX/XX - XXXX/XX"),
                            br(),
                            box(
                              width = 12,
                              plotOutput("ageofplot1"),
                              br(),
                              plotOutput("ageofplot2")
                            ),
                            strong("Footnotes"),
                            br(),
                            paste("1. Percentages are rounded to the nearest 1%."),
                            br(),
                            paste("2. Gaps in the chart indicate where data has been supressed due to small numbers."),
                            br(),
                            paste("3. The date used to calculate age at first offence is the date the offence took place rather
                            than when it was processed through the courts."),
                            br(),
                            paste("4. All offences were included in the analysis of age at first offence for children who had been 
                            cautioned or sentenced for an offence irrespective of whether they were also serious violence offences. 
                            Serious violence offences only were included in the analysis for children who had been cautioned or 
                            sentenced for a serious violence offence"),
                            br(),
                          )
                        )
                      ),
                      tabPanel(
                        "Ethnicity",
                        fluidRow(
                          column(
                            width=12,
                            h3("The proportion of all pupils split by ethnic group major, offending and pupil group, for pupils matched to KS4 academic years
                               XXXX/XX - XXXX/XX"),
                            br(),
                            h5("Ethnicity [3*] has two different categorisations in the school census - ethnic group major
                            and ethnic group minor. Ethnic group major contains wider categories (Asian, Black,
                            Chinese, White, Mixed, Unclassified, Any Other Ethnic Group) whereas ethnic group minor is more detailed [4*]"),
                            br(), 
                            box(
                              width = 12,
                              plotOutput("EthPlot1"),
                              br(),
                              plotOutput("EthPlot2")
                            ),
                            strong("Footnotes"),
                            br(),
                            paste("1. Percentages are rounded to the nearest 1%."),
                            br(),
                            paste("2. Gaps in the chart indicate where data has been supressed due to small numbers."),
                            br(),
                            paste("3. Where a pupil’s ethnicity changes over time, the most recent ethnicity has been taken. 
                            Ethnicity information has been taken from the DfE school census, and from 2011, could only be 
                            completed by the child or their parents"),
                            br(),
                            paste("4. Ethnic group minor categories include Bangladeshi, Indian, Any Other Pakistani Background, Pakistani,
                            Black African, Black Caribbean, Any Other Black Background, Chinese, Any Other Mixed Background,
                            White and Asian, White and Black African, White and Black Caribbean, Information Not Yet Obtained, Any 
                            Other Ethnic Group, Refused, White British, White Irish, Traveller of Irish Heritage, Any Other White Background, 
                            Gypsy/Roma. For a more detailed breakdown of ethnic group minor, see accompanying tables"),
                            br(),
                            )
                        )
                      ),
                      tabPanel(
                        "Free school meals",
                        fluidRow(
                          column(
                            width=12,
                            tabBox(width = 12, title = NULL, id="FSMsubtabs",
                                   tabPanel("Charts", h3("The Proportion of all pupils eligible for free school meals (FSM) by offending and pupil group, 
                                                         for pupils matched to KS4 academic years XXXX/XX - XXXX/XX"), 
                                            plotOutput("fsmPlot1"), br(), plotOutput("fsmPlot2")),
                                   tabPanel("Waffle", h3("The proportion of children who had been cautioned or sentenced for a serious violence offence and 
                                   had ever been eligible for free school meals (FSM), and all pupils who had ever been eligible for FSM, for pupils matched 
                                   to KS4 academic years XXXX/XX - XXXX/XX"), plotOutput("waffle_FSM1"), br(), textOutput("WaffleTextFSM1"), br(), 
                                            plotOutput("waffle_FSM2"), br(), textOutput("WaffleTextFSM2"), br()))
                            ),
                          strong("Footnotes"),
                          br(),
                          paste("1. Percentages are rounded to the nearest 1%."),
                          br(),
                          paste("2. Gaps in the chart indicate where data has been supressed due to small numbers."),
                          br(),
                          paste("3. The metric for free school meals (FSM) used in this analysis is FSM eligibility. Children are FSM eligible
                          if a claim has been made by them, or on their behalf, and eligibility has been confirmed."),
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
                               "LA", 
                               choices = choicesLA
                )),
              column(
                width = 6,
                selectizeInput("sclLAchoice2", 
                               "LA (choice 2)", 
                               choices = choicesLA,
                               select = "xSgZ6" # Will need to change this to England with real data
                )
              ), 
              column(
                width = 6,
                radioButtons("sclindichoice", 
                             "Indicator", 
                             choices = choiceIndicator$Indicator,
                             selected = "School"
                )
              ),
              column(
                width = 6,
                checkboxGroupInput("sclgroupchoice", 
                                   "Pupil group", 
                                   choices = choiceGroup$group, 
                                   selected = choiceGroup$group
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
                                   tabPanel("KS2 attainment", br(), 
                                            p("This analysis looks at the percentage of pupils meeting the expected standard in English and Maths at KS2.
                                              At the end of KS2 children are expected to be working to at least level 4 in English and Maths."),
                                            h3("The proportion of all pupils who achieved level 4 or above in English and Maths at key stage 2 (KS2) 
                                            by offending and pupil group, for pupils matched to KS4 academic years XXXX/XX - XXXX/XX"),
                                            plotOutput("ks2attainplot1"), br(), plotOutput("ks2attainplot2"),
                                            strong("Footnotes"),
                                            br(),
                                            paste("1. Percentages are rounded to the nearest 1%."),
                                            br(),
                                            paste("2. Gaps in the chart indicate where data has been supressed due to small numbers."),
                                            br(),
                                            paste("3. Possible attainment levels at KS2 range from Level 1 to Level 6"),
                                            br(),
                                            paste("4. DPEPENDING ON FINAL COHORT ... some changes in assessments over time etc (eg Birmingham footnote 13)")),
                                   tabPanel("KS4 attainment", br(), 
                                            p("This analysis looks at the percentage of pupils meeting various KS4 benchmarks."),
                                            h3("The proportion of all pupils who achieved various key stage 4 (KS4) benchmarks by offending and 
                                            pupil group, for pupils matched to KS4 academic years XXXX/XX - XXXX/XX"),
                                            plotOutput("ks4attainplot1"), br(), plotOutput("ks4attainplot2"),
                                            strong("Footnotes"),
                                            br(),
                                            paste("1. Percentages are rounded to the nearest 1%."),
                                            br(),
                                            paste("2. Gaps in the chart indicate where data has been supressed due to small numbers."),
                                            br(),
                                            paste("3. DPEPENDING ON FINAL COHORT ... some changes in assessments over time etc (eg Birmingham footnote 14")))
                          )
                        )
                      ),
                      tabPanel(
                        "Persistent Absence",
                        fluidRow(
                          column(
                            width=12,
                            details(
                              inputId = "PA_def",
                              label = "What is persistent absence?",
                              help_text = tags$p("A child is said to be persistently absent (PA) if they miss 10% or more of the sessions 
                              they could possibly have attended in an academic year or term. Most sessions represent a half-day. 
                              For context, this would amount to between 6 and 7 days of a 13-week term or around 19 days for a school 
                              year", tags$sup("[3]"), ". This includes both authorised and unauthorised absences", tags$sup("[4]"), ".", tags$br(), tags$br(),
                              
                              "It is worth noting that persistent absence can include various reasons for absence, including absence due to 
                              being suspended or permanently excluded", tags$sup("[5]"), ".")
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
                            tabBox(width = 12, title = NULL, id="pa_subtabs",
                                   tabPanel("Ever PA/PAUO",
                                            br(),
                                            h4("For the following analysis, a pupil was marked as having ever been persistently absent if they had missed 
                                               10% or more of their possible sessions over the course of a school year, not a term."), 
                                            br(),
                                            tabBox(width = 12, title = NULL, id="pa_subtabs2",
                                            tabPanel("Chart", h3("The proportion of all pupils who had ever been persistently absent or 
                                            persistently absent (unauthorised other) by offending and pupil group, for pupils matched to 
                                                                 KS4 academic years XXXX/XX - XXXX/XX"), plotOutput("PAPlot1"), br(), plotOutput("PAPlot2")),
                                            tabPanel("Waffle", h3("The proportion of children who had been cautioned or sentenced for a 
                                            serious violence offence and had been persistently absent, and all pupils who had ever been 
                                                                  persistently absent, for pupils matched to KS4 academic years XXXX/XX - XXXX/XX"),
                                                     plotOutput("waffle_PA1"), br(), textOutput("waffleText_PA1"), br(),
                                                     plotOutput("waffle_PA2"), textOutput("waffleText_PA2"), br()))),
                                   tabPanel("Timing of PA/PAUO", h4("For the following analysis termly absence data has been used. 
                                             Throughout the rest of the publication, annual absence data has been used."),
                                            h3("Timing of first record of persistent absence or persistent absence (unauthorised other) relative to the timing 
                                            of children’s first serious violence offence, for all pupils matched to KS4 academic years XXXX/XX - XXXX/XX", tags$sup("[7]")),
                                            br(),
                                            plotOutput("timing_PA1"), br(), plotOutput("timing_PA2"))),
                            strong("Footnotes"),
                            br(),
                            paste("1. Percentages are rounded to the nearest 1%."),
                            br(),
                            paste("2. Gaps in the chart indicate where data has been supressed due to small numbers."),
                            br(),
                            paste("3. "),
                            a(href = "https://www.legislation.gov.uk/uksi/1999/3181/regulation/3/made", "The School Day and Year"),
                            br(),
                            paste("4. For more information on the definition of pupil absences see"),
                            a(href = "https://explore-education-statistics.service.gov.uk/methodology/pupil-absence-in-schools-in-england", 
                              "Pupil absence statistics: methodology"),
                            paste(". This was changed from 15% to 10% in September 2015."),
                            br(),
                            paste("5. The definition of persistent absence includes all possible reasons for absence, including children whose 
                            absence was unauthorised, but the school was still provided with a reason for that absence (for example, an unagreed 
                            family holiday). The analysis has included this additional metric of absence (PAUO), as a way of differentiating those 
                            whose absence was not authorised and were unable to provide a reason for that absence, from those not attending school 
                                  for any reason."),
                            br(),
                            paste("6. The date used to calculate any findings relating to timing of first offence use the date the offence took place rather than 
                           when it was processed through the courts."),
                            br(),
                            paste("7. For children who were cautioned or sentenced for a serious violence offence, and had been persistently 
                            absent, the analysis compares whether the first school term they were fagged as persistently absent in, or 
                                  PAUO, preceded the school term in which the serious violence offence took place.")
                          )
                        )
                      ),
                      tabPanel(
                        "Suspension & Exclusions",
                        fluidRow(
                          column(
                            width=12,
                            details(
                              inputId = "sus_def",
                              label = "What is a suspension?",
                              help_text = tags$p("A suspension is where a pupil has been temporarily removed from the school", 
                                                 tags$sup("[3]"), ".")
                            ),
                            details(
                              inputId = "excl_def",
                              label = "What is a permanent exclusion?",
                              help_text = tags$p("A permanent exclusion is when a pupil is no longer allowed to attend a school", tags$sup("[4]"), ".")
                            ),
                            tabBox(width = 12, title = NULL, id="SusExcl_subtabs",
                                   tabPanel("Ever suspended/excluded",
                                            tabBox(width=12, title = NULL, id="SusExcl_subtabs2", 
                                            tabPanel("Chart", h3("The proportion of all pupils who had a record of being suspended or 
                                            permanently excluded by offending and pupil group, for all pupils matched to KS4 academic years XXX/XX - XXXX/XX"), 
                                                     br(), plotOutput("SusExclPlot1"), br(), plotOutput("SusExclPlot2")),
                                            tabPanel("Suspension Waffle", h3("The proportion of children who had been cautioned or sentenced for a serious violence 
                                            offence and had ever been suspended, and all pupils who had ever been suspended, for pupils matched to KS4 academic years 
                                                                            XXXX/XX - XXXX/XX"), br(), plotOutput("waffle_Sus1"), br(),
                                                     textOutput("waffleText_sus1"), br(), plotOutput("waffle_Sus2"), br(), textOutput("waffleText_sus2")),
                                            tabPanel("Exclusion Waffle", h3("The proportion of children who had been cautioned or sentenced for a serious violence 
                                            offence and had ever been permanently excluded, and all pupils who had ever been permanently excluded, for pupils matched 
                                            to KS4 academic years XXXX/XX - XXXX/XX"), br(), plotOutput("waffle_Excl1"), br(), textOutput("waffleText_excl1"), br(),
                                                    plotOutput("waffle_Excl2"), br(), textOutput("waffleText_excl2")))),
                                   tabPanel("Timing of first/closest suspension/exclusion", 
                                            h4("The following analysis first investigates the sequencing of suspensions and permanent exclusions with serious violence 
                                            offences. It looks at both the child’s first suspension or permanent exclusion and, in the case of multiple events, their 
                                            closest suspension or permanent exclusion relative to their first serious violence offence."), br(),
                                            details(
                                              inputId = "sus_timeHelp",
                                              label = "What do these charts tell us?",
                                              help_text = tags$p("Did first suspensions / permanent exclusions commonly precede or follow first serious violence offences?", tags$br(),
                                                                 tags$br(), "Did the closest suspensions", tags$sup("[5]"), "/ permanent exclusions commonly precede or follow first serious violence offences?")
                                            ),
                                            tabBox(width = 12, title = NULL, id="SusExcl_subtabs3",
                                                   tabPanel("First suspension", h3("Timing of children’s first suspension relative to their first serious violence offence, 
                                                                                   for all pupils matched to KS4 academic year XXXX/XX - XXXX/XX"), br(),
                                                            plotOutput("FstSusTime1"), br(), plotOutput("FstSusTime2")),
                                                   tabPanel("Closest suspension", h3("Timing of children’s closest suspension relative to their first serious violence offence, 
                                                                                   for all pupils matched to KS4 academic year XXXX/XX - XXXX/XX"), br(),
                                                            plotOutput("clstSusTime1"), br(), plotOutput("clstSusTime2")),
                                                   tabPanel("First exclusion", h3("Timing of children’s first permanent exlusion relative to their first serious violence offence, 
                                                                                   for all pupils matched to KS4 academic year XXXX/XX - XXXX/XX"), br(),
                                                            plotOutput("FstExclTime1"), br(), plotOutput("FstExclTime2")),
                                                   tabPanel("Closest exclusion", h3("Timing of children’s closest permanent exlusion relative to their first serious violence offence, 
                                                                                   for all pupils matched to KS4 academic year XXXX/XX - XXXX/XX"), br(),
                                                            plotOutput("clstExclTime1"), br(), plotOutput("clstExclTime2"))))),
                            strong("Footnotes"),
                            br(),
                            paste("1. Percentages are rounded to the nearest 1%."),
                            br(),
                            paste("2. Gaps in the chart indicate where data has been supressed due to small numbers."),
                            br(),
                            paste("3. Prior to 2019/20, suspensions were referred to as fixed term exclusions."),
                          br(),
                          paste("4. Note, suspensions data can include lunchtime suspensions, but suspensions during lunchtime have not 
                                been included in this analysis. Please see full definition here: "),
                          a(href = "https://explore-education-statistics.service.gov.uk/methodology/pupil-exclusion-statistics-methodology", 
                            "Pupil exclusion statistics: methodology"),
                          br(),
                          paste("5. Where children who had been cautioned or sentenced for an offence had received multiple suspensions/permanent exclusions, 
                          the analysis defined closest as the shortest amount of time between the start of the suspensions/permanent exclusions and the first 
                                serious violence offence date"),
                          br(),
                          paste("6.The date used to calculate any findings relating to timing of first offence use the date the offence took place rather than 
                           when it was processed through the courts."),
                          br()
                          )
                        )
                      ),
                      tabPanel(
                        "AP",
                        fluidRow(
                          column(
                            width=12,
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
                                                 which do not meet the Department for Education’s (DfE) statutory definition of AP.", tags$sup("[3]"))
                            ),
                            tabBox(width = 12, title = NULL, id="AP_subtabs",
                                   tabPanel("Ever AP",
                                            tabBox(width=12, title = NULL, id="AP_subtabs2",
                                                   tabPanel("Chart", h3("The proportion of all pupils who had ever attended alternative provision by offending 
                                                                        and pupil group, for pupils matched to KS4 academic years XXXX/XX - XXXX/XX"), br(),
                                                            plotOutput("APchart1"), br(), plotOutput("APchart2")),
                                                   tabPanel("Waffle", h3("The proportion of children who had been cautioned or sentenced for a serious violence 
                                                   offence and had ever attended alternative provision, and all pupils who had ever attended alternative provision, 
                                                   for pupils matched to KS4 academic years XXXX/XX - XXXX/XX"), br(),
                                                            plotOutput("waffle_AP1"), br(), textOutput("waffleText_AP1"), br(), 
                                                            plotOutput("waffle_AP2"), br(), textOutput("waffleText_AP2"), br()))),
                                   tabPanel("Timing of AP", h3("The first term children attended alternative provision (AP) relative to the timing of their first 
                                                               offence, for all pupils matched to KS4 academic years XXXX/XX - XXXX/XX"), 
                                            h4("Did the first term a child attended alternative provision (AP) commonly precede the first serious violence offence?"), br(), 
                                            plotOutput("timing_AP1"), br(), plotOutput("timing_AP2"))),
                            strong("Footnotes"),
                            br(),
                            paste("1. Percentages are rounded to the nearest 1%."),
                            br(),
                            paste("2. Gaps in the chart indicate where data has been supressed due to small numbers."),
                            br(),
                            paste("3. Please see here for more information on AP statutory guidance:"),
                            a(href = "https://www.gov.uk/government/publications/alternative-provision", "Alternative Provision Statutory Guidance"),
                            br(),
                            paste("4. The date used to calculate any findings relating to timing of first offence use the date the offence took place rather than 
                           when it was processed through the courts."),
                            br()
                            )
                        )
                      ),
                      tabPanel(
                        "SEN",
                        fluidRow(
                          column(
                            width=12,
                            h3("Special Educational Needs"),
                            h4("This analysis looks at the proportion of children who had been cautioned or sentenced for an offence who were ever recorded as 
                               having Special Educational Needs (SEN) [3]."), br(),
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
                              the local authority (‘SEN Support’)", tags$sup("[4]"), "whilst others may undergo a formal assessment resulting in an Education, Health and Care 
                              plan (EHC plan)", tags$sup("[5]"), "if they are assessed as having a complex need that requires additional provision. It is important to note that 
                              this analysis only covers children who have identified SEN, and some children will have unidentified needs and therefore relevant 
                              support will not have been put in place.")
                            ),
                            tabBox(width = 12, title = NULL, id="sen_subtabs",
                                   tabPanel("Ever SEN",
                                            tabBox(width=12, title = NULL, id="sen_subtab2",
                                                   tabPanel("Ever Chart", h3("Special Educational Needs (SEN) of all pupils by offending and pupil group, for those that 
                                                                             were ever recorded with SEN, for pupils matched to KS4 academic years XXXX/XX - XXXX/XX"), br(),
                                                            plotOutput("SENchart1"), br(), plotOutput("SENchart2")),
                                                   tabPanel("SEN support Waffle", h3("The proportion of children who had been cautioned or sentenced for a serious 
                                                   violence offence and had ever had SEN Support, and all pupils who had ever had SEN Support, for pupils matched 
                                                                                     to KS4 academic years XXXX/XX - XXXX/XX"), br(), 
                                                            plotOutput("waffle_SEN1"), br(), textOutput("waffleText_SEN1"), br(),
                                                            plotOutput("waffle_SEN2"), br(), textOutput("waffleText_SEN2"), br()),
                                                   tabPanel("EHCP waffle", h3("The proportion of children who had been cautioned or sentenced for a serious violence 
                                                   offence and had ever had an EHC plan, and all pupils who had ever had an EHC plan, for pupils matched to 
                                                                              KS4 academic years XXXX/XX - XXXX/XX"), br(), 
                                                            plotOutput("waffle_EHCP1"), br(), textOutput("waffleText_EHCP1"), br(),
                                                            plotOutput("waffle_EHCP2"), br(), textOutput("waffleText_EHCP2"), br()))),
                                   tabPanel("Timing of SEN",
                                            h4("Did a child being identified as SEN commonly precede the first serious violence offence?[8*]"), br(), 
                                            tabBox(width=12, title = NULL, id="sen_subtab3",
                                                   tabPanel("SEN timing", h3("The first term children had been recorded with SEN, relative to the timing of their first 
                                                                             serious violence offence, for pupils matched to KS4 academic years XXXX/XX - XXXX/XX"), br(),
                                                            plotOutput("timing_SEN1"), br(), plotOutput("timing_SEN2")),
                                                   tabPanel("EHCP timing", h3("The first term children had an EHC plan, relative to the timing of their first serious violence
                                                                              offence, for pupils matched to KS4 academic years XXXX/XX - XXXX/XX"), br(), 
                                                            plotOutput("timing_EHCP1"), br(), plotOutput("timing_EHCP2")))),
                                   tabPanel("Timing of SEMH", h4("Did a child being identified as SEMH commonly precede the first serious violence offence?"), br(),
                                            details(
                                              inputId = "SENTypes_def",
                                              label = "What types of SEN are used in the analysis?",
                                              help_text = tags$p("For this analysis, both primary and secondary SEN type have been considered when exploring types of SEN.", 
                                                                 tags$br(), tags$br(), "The most prevalent type of recorded SEN amongst children who had been cautioned or sentenced for 
                                                                 an offence was Social, Emotional and Mental Health needs (SEMH)", tags$sup("[9][10]", "."))), 
                                     h3("The first term children had SEMH, relative to the timing of their first serious violence offence, for pupils matched to KS4 academic years XXXX/XX - XXXX/XX"),
                                     br(), plotOutput("timing_SEMH1"), br(), plotOutput("timing_SEMH2"))),
                            br(),
                            strong("Footnotes"),
                            br(),
                            paste("1. Percentages are rounded to the nearest 1%."),
                            br(),
                            paste("2. Gaps in the chart indicate where data has been supressed due to small numbers."),
                            br(),
                            paste("3. The Children and Families Act 2014 and the SEND Code of Practice (2015) covers children and young 
                            people with Special Educational Needs and Disabilities (SEND). A child or young person has SEN if they 
                            have a learning difficulty or disability which calls for special educational provision to be made for them. 
                            Children and young people have a disability if they have a physical or mental impairment which has a 
                            long-term and substantial adverse effect on their ability to carry out normal day-to-day activities. Children 
                            and young people with a disability do not necessarily have SEN, or vice-versa, but there is a significant 
                            overlap between disabled children and young people and those with SEN. Data collected and published by 
                                  Department for Education only records children and young people identified with SEN."),
                            br(),
                            paste("4. Prior to 2014, this category was School Action or School Action Plus. The term ‘SEN Support’ describes 
                            the actions taken to support children in mainstream settings who have been identifed as having Special 
                            Educational Needs (SEN), but who do not have an Education, Health and Care plan (EHC plan). These 
                            children receive support and provision from resources already available within the school (which could 
                            include advice or support from outside specialists). Should a child require additional resources that the 
                            existing school’s SEN Support system does not include, then they can apply for a more detailed EHC plan, 
                            which outlines the educational, health and social needs of the individual and the specific provisions in place 
                                  to support them."),
                            br(),
                            paste("5. From 2014 Education, Health and Care plans were introduced. Under previous legislation pupils could 
                            be eligible for Statements of SEN. The period for local authorities to transfer children and young people 
                            with Statements of SEN to EHC plans started in September 2014 and ended on 31 March 2018. For the 
                            purposes of this analysis, ‘EHC plan’ will be used to describe both Statements of SEN and EHC plans 
                                  unless stated otherwise in the particular context."),
                            br(),
                            paste("6. The analysis throughout this publication refers to children with SEN Support as children that had ever 
                                  been identified as having SEN, but never with an EHC plan"),
                            br(),
                            paste("7. The date used to calculate any findings relating to timing of first offence use the date the offence took place rather than 
                           when it was processed through the courts."),
                            br(),
                            paste("8. This analysis aims to differentiate between children who had been cautioned or sentenced for an offence, or a serious 
                            violence offence, that have received different levels of support. As such, the analysis distinguishes between those that have had SEN 
                            Support, but have never had an EHC plan, and those that have had an EHC plan, and when they were first recorded as receiving that support. 
                            It is important to note that this does not necessarily equate to when the child was first identified as having SEN."),
                            br(),
                            paste("9. There were changes to the classification of type of need in 2015 when the previous code of ‘Behaviour, emotional and social 
                            difficulties (BESD)’ was removed, and a new code ‘Social, emotional and mental health (SEMH)’ was introduced. However, those with a primary 
                            need of BESD in 2014 were not all expected to move to SEMH in 2015. The analysis combined results for the two SEN types, whilst understanding 
                            that SEMH was not intended to be a direct replacement for BESD. Results for types of SEN prior to 2015 will include BESD rather than SEMH."),
                            br(),
                            paste("10. As SEMH is consistently the most common recorded SEN type amongst children who had been cautioned or sentenced for an 
                                  offence, further analysis has been carried out on the timing of the identification of SEMH. ... Could reference  our previous 
                                  publication where SEMH was the most prevalent???"),
                            br()
                            )
                        )
                      )
          )
        ),  
        bsPopover(id = "sclindichoice", title="", content = "Select <b>Home</b> to view children who <b>live</b> in given local authority. Select <b>School</b> to view children who <b>go to school</b> in given local authority.", 
                      trigger="hover", placement="bottom", options = list(container = "body"))
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
          h4("This tab contains analysis that relates to children's experiences whilst in care")
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
                               "LA", 
                               choices = choicesLA
                )),
              column(
                width = 6,
                selectizeInput("cscLAchoice2", 
                               "LA (choice 2)", 
                               choices = choicesLA,
                               select = "xSgZ6" # Will need to change this to England with real data
                               )
              ),
              column(
                width = 6,
                radioButtons("cscindichoice", 
                             "Indicator",
                             choices = choiceIndicator$Indicator,
                             selected = "School"
                )
              ),
              column(
                width = 6,
                checkboxGroupInput("cscgroupchoice", 
                                   "Pupil group", 
                                   choices = choiceGroup$group, 
                                   selected = choiceGroup$group
                )
              ))
          )
        ),
        bsPopover(id = "cscindichoice", title="", content = "Select <b>Home</b> to view children who <b>live</b> in given local authority. Select <b>School</b> to view children who <b>go to school</b> in given local authority", 
                  trigger="hover", placement="bottom", options = list(container = "body")),
        column(
          width=12,
          h3("Children with a Social Worker"),
          p("The next set of findings look at the proportion of children who had been cautioned or sentenced for an offence that were recorded 
                        as being children in need (CIN) or children who are looked after (CLA) on 31st March in any given year, as defined by the Children Act 1989,
                        between 2011/12 – 2017/18 for CIN, and 2005/06 - 2017/18 for CLA", tags$sup("[1][2]"), ". CIN here refers to children who are designated under a number of
                        different social care classifications: children on a child in need plan; children on a child protection plan", tags$sup("[3]"), "; and children who are looked 
                        after", tags$sup("[4]"), ". As such, CLA figures are included in the figures for CIN. Since the CIN and CLA data cover different time periods, and CIN 
                        includes CLA for some of the same period, comparisons of CIN to CLA should be made with caution. To maximise coverage of the CIN data 
                        and avoid skewed results, the analysis in this section is based on children matched to KS4 academic year 2014/15 only."), br(),
          p("When reading the findings related to children looked after (CLA), it is important to note that the introduction of the Legal Aid, 
                        Sentencing and Punishment of Offenders Act 2012 (LASPOA) meant that, from 3rd December 2012, children up to the age of 18 who are 
                        remanded to youth detention accommodation as a result of being charged with or convicted of an offence will be ‘looked after’ by the 
                        designated local authority",tags$sup("[5]"), ". Therefore, caution should be taken when considering the findings related to CLA and offending, as the child 
                        may have become CLA due to the offending."), br(),
          tabsetPanel(id = "tabsetpanels3",
                      tabPanel(
                        "Ever CIN/CLA",
                        fluidRow(
                          column(
                            width=12,
                            tabBox(width = 12, title = NULL, id="csc_subtabs",
                                   tabPanel("Chart", h3("The proportion of children who had been recorded as being CIN/CLA on 31st March in any 
                                   given year, by offending and pupil group, for pupils matched to KS4 academic years XXXX/XX - XXXX/XX"), 
                                            br(), plotOutput("CSCPlot1"), br(), plotOutput("CSCPlot2")),
                                   tabPanel("Waffle", h3("The proportion of children who had been cautioned or sentenced for a serious violence offence and had ever been CIN on 31st 
                                                         March in any given year, and all pupils who had ever been CIN on 31st March in any given year, for pupils matched to KS4 a
                                                         cademic years XXXX/XX - XXXX/XX"), br(), 
                                            plotOutput("waffle_CIN1"), br(), textOutput("waffleText_CIN1"), br(),
                                            plotOutput("waffle_CIN2"), br(), textOutput("waffleText_CIN2"), br()))
                          )
                        )
                      ),
                      tabPanel(
                        "Timing of CSC",
                        h4("Did the first record of a child being known to children’s social care commonly precede the first serious violence offence?"), br(),
                        p("The focus of this analysis is to understand the sequencing of a child’s journey between different social care groups relative to the 
                        interaction(s) with the criminal justice system they may have had. It looks at children who had been cautioned or sentenced for a 
                        serious violence offence and whether their first record of being a child in need, a child on a child protection plan, and/or a child being 
                        looked after occurred before, after or during the same school term as their first serious violence offence (for those recorded as CIN, 
                        including CLA, as defined by the Children Act 1989, at any point in a given school term between 2011/12 – 2017/18 for CIN, and 
                          2004/05 - 2017/18 for CLA)."), br(),
                        p("The analysis presented here utilises a different dataset", tags$sup("[8]"), "to that used in the previous section of this 
                        publication, enabling more granular examination of those recorded in the children’s social care system at any point during the year, 
                        not just on 31st March, and to look at changes in their social care group throughout the year."), br(),
                        p("Children who had been cautioned or sentenced for a serious violence offence have been classifed here as being CIN, CPP or CLA 
                        in an academic term, if at any point in that term they have been recorded as CIN, CPP or CLA", tags$sup("[9]"), "."),
                        fluidRow(
                          column(
                            width=12,
                            tabBox(width = 12, title = NULL, id="csc_subtabsTime",
                                   tabPanel("Timing CSC", h3("The first record of children being a child in need, having a child protection plan or 
                                   being a child who was looked after, relative to the timing of their first offence, for all pupils matched to KS4 
                                                             academic year XXXX/XX - XXXX/XX"), br(), plotOutput("timing_CSC1"), br(), plotOutput("timing_CSC2")))
                          )
                        )
                      )
          ),
          br(),
          strong("Footnotes"),
          br(),
          paste("1. It is important to note on using this measure, the analysis takes no account of how long the children 
          were in need, or in care, and does not count those who were in need, or looked after, during the period 
          specified but were not in need, or looked after specifically on 31st March. As such, the figures stated will 
                be an under-estimate of the true proportion of children in need and children who are looked after."),
          br(),
          paste("2. This diverges from the definition of Ever CIN used in the CIN Review, which looks at whether the child 
          was recorded as so in the previous 6 years. Please see here for further details:"),
          a(href = "https://www.gov.uk/government/publications/children-in-need-of-help-and-protection-data-and-analysis", 
            "Children in need of help and protection: data and analysis"),
          br(),
          paste("3. Child Protection Plan (CPP) - support for a child where there is reasonable suspicion that child is 
                suffering, or likely to suffer, significant harm."),
          br(),
          paste("4. Children who are looked after (CLA) – a child who is looked after by a local authority if they fall into one 
          of the following: is provided with accommodation, for a continuous period of more than 24 hours (Children Act 1989, 
          Section 20 and 21); is subject to a care order (Children Act 1989, Part IV), or is subject to a placement order. 
          The analysis has not analysed children on a child in need plan (CINP) separately, but rather have looked at all 
                children in need, and the two categories of highest intervention."),
          br(),
          paste("5. Please see here for more information:"),
          a(href = "https://www.gov.uk/government/publications/children-in-need-of-help-and-protection-data-and-analysis", 
            "Children looked after return 2020 to 2021"),
          br(),
          paste("6. Full CIN data is available from 2011/12, term 3. Children are included in this CIN analysis if they had 
          been recorded as a child in need on the 31st March in any period between the ages of 12 - 16. Those matched to earlier 
          years in the KS4 attainment data will as a result have less coverage than those matched to later years. For example: 
                those with KS4 academic year 2012/13 have coverage from age 14 and above."),
          br(),
          paste("7. Children are included in this CLA analysis if they had been recorded as a child being looked after on the 31st March 
          in any period between the ages of 6 - 16. Those matched to earlier years in the KS4 attainment data will as a result have less 
          coverage than those matched to later years. For example: those with KS4 academic year 2012/13 have coverage from age 8 and above."),
          br(),
          paste("8. Termly CIN and CLA datasets were provided internally to enable us to complete this analysis. This data is not currently 
                available within the MoJ-DfE data share."),
          br(),
          paste("9. A child can move between various stages of the social care system within and between terms, including into and out of need. 
          Each child was assigned a termly activity label based on the following hierarchy: CLA – if a child has been looked after for at least 
          one day in that term; CPP – if a child is not labelled as CLA and has been on a child protection plan for at least one day in that term; 
          CIN – a child that falls into any of the two previous categories, or if they are CINP - if a child is not labelled as CLA or CPP and has 
          been in need for at least one day in the term (child in need plan). The legal definition of children in need includes all disabled children. 
          Unlike other children who must be assessed as in need, disabled children are classed as Children in Need by virtue of having a disability. 
          Please see here for more information:"), 
          a(href = "https://www.gov.uk/government/publications/children-in-need-of-help-and-protection-data-and-analysis", 
            "Children in need of help and protection: data and analysis"),
          br(),
          paste("10. Percentages are rounded to the nearest 1%."),
          br(),
          paste("11. Gaps in the chart indicate where data has been supressed due to small numbers."),
          br(),
          paste("12. The date used to calculate any findings relating to timing of first offence use the date the offence took place 
                rather than when it was processed through the courts."),
          br()
        )
      )
    )
  )
}
