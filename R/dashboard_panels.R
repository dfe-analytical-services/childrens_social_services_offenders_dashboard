homepage_panel <- function() {
  tabPanel(
    "Homepage",
    gov_main_layout(
      gov_row(
        column(
          12,
          h1("DfE Analytical Services R-Shiny data dashboard template (h1)"),
          br(),
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
        )
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
              ))
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
                            h2("Outputs 0 (h2)"),
                            box(
                              width = 12,
                              dataTableOutput("demotable")
                            )
                            
                            
                          )
                        )
                      ),
                      tabPanel(
                        "Gender",
                        fluidRow(
                          column(
                            width=12,
                            h2("Outputs 1 (h2)"),
                            box(
                              width=12,
                              plotlyOutput("GenderPlot1"),
                              plotlyOutput("GenderPlot2"))
                            )
                        )
                      ),
                      tabPanel(
                        "Ethnicity",
                        fluidRow(
                          column(
                            width=12,
                            h2("Outputs 2 (h2)"),
                            box(
                              width = 12,
                              plotlyOutput("EthPlot1"),
                              plotlyOutput("EthPlot2")
                            )
                            )
                        )
                      ),
                      tabPanel(
                        "Free school meals",
                        fluidRow(
                          column(
                            width=12,
                            h2("Outputs 3 (h2)"),
                            tabBox(width = 12, title = NULL, id="FSMsubtabs",
                                   tabPanel("Charts", plotlyOutput("fsmPlot1"), plotlyOutput("fsmPlot2")),
                                   tabPanel("Waffle", plotOutput("waffle_FSM1"), plotOutput("waffle_FSM2")))
                            ),
                            
                        )
                      ),
                      tabPanel(
                        "Age at first offence",
                        fluidRow(
                          column(
                            width=12,
                            h2("Outputs 4 (h2)"),
                            box(
                              width = 12,
                              plotlyOutput("ageofplot1"),
                              plotlyOutput("ageofplot2")
                            )
                            )
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
                            h2("Outputs 0 (h2)"),
                            tabBox(width = 12, title = NULL, id="atn_subtabs",
                                   tabPanel("KS2 attainment", plotlyOutput("ks2attainplot1"), plotlyOutput("ks2attainplot2")),
                                   tabPanel("KS4 attainment", plotlyOutput("ks4attainplot1"), plotlyOutput("ks4attainplot2")))
                          )
                        )
                      ),
                      tabPanel(
                        "PA",
                        fluidRow(
                          column(
                            width=12,
                            h2("Outputs 1 (h2)"),
                            tabBox(width = 12, title = NULL, id="pa_subtabs",
                                   tabPanel("Ever PA/PAUO",
                                            tabBox(width = 12, title = NULL, id="pa_subtabs2",
                                            tabPanel("Chart", plotlyOutput("PAPlot1"), plotlyOutput("PAPlot2")),
                                            tabPanel("Waffle", plotOutput("waffle_PA1"), plotOutput("waffle_PA2")))),
                                   tabPanel("Timing of PA/PAUO", plotlyOutput("timing_PA1"), plotlyOutput("timing_PA2")))
                          )
                        )
                      ),
                      tabPanel(
                        "Suspension & Exclusions",
                        fluidRow(
                          column(
                            width=12,
                            h2("Outputs 2 (h2)"),
                            tabBox(width = 12, title = NULL, id="SusExcl_subtabs",
                                   tabPanel("Ever suspended/excluded",
                                            tabBox(width=12, title = NULL, id="SusExcl_subtabs2",
                                            tabPanel("Chart", plotlyOutput("SusExclPlot1"), plotlyOutput("SusExclPlot2")),
                                            tabPanel("Suspension Waffle", plotOutput("waffle_Sus1"), plotOutput("waffle_Sus2")),
                                            tabPanel("Exclusion Waffle",plotOutput("waffle_Excl1"), plotOutput("waffle_Excl2")))),
                                   tabPanel("Timing of closest/first suspension",
                                            tabBox(width = 12, title = NULL, id="SusExcl_subtabs3",
                                                   tabPanel("First suspension", plotlyOutput("FstSusTime1"), plotlyOutput("FstSusTime2")),
                                                   tabPanel("Closest suspension", plotlyOutput("clstSusTime1"),plotlyOutput("clstSusTime2")),
                                                   tabPanel("First exclusion", plotlyOutput("FstExclTime1"), plotlyOutput("FstExclTime2")),
                                                   tabPanel("Closest exclusion", plotlyOutput("clstExclTime1"),plotlyOutput("clstExclTime2")))))
                          )
                        )
                      ),
                      tabPanel(
                        "AP",
                        fluidRow(
                          column(
                            width=12,
                            h2("Outputs 4 (h2)"),
                            tabBox(width = 12, title = NULL, id="AP_subtabs",
                                   tabPanel("Ever AP",
                                            tabBox(width=12, title = NULL, id="AP_subtabs2",
                                                   tabPanel("Chart", plotlyOutput("APchart1"), plotlyOutput("APchart2")),
                                                   tabPanel("Waffle", plotOutput("waffle_AP1"), plotOutput("waffle_AP2")))),
                                   tabPanel("Timing of AP", plotlyOutput("timing_AP1"), plotlyOutput("timing_AP2")))
                          )
                        )
                      ),
                      tabPanel(
                        "SEN",
                        fluidRow(
                          column(
                            width=12,
                            h2("Outputs 5 (h2)"),
                            tabBox(width = 12, title = NULL, id="sen_subtabs",
                                   tabPanel("Ever SEN",
                                            tabBox(width=12, title = NULL, id="sen_subtab2",
                                                   tabPanel("Ever Chart", plotlyOutput("SENchart1"), plotlyOutput("SENchart2")),
                                                   tabPanel("SEN support Waffle", plotOutput("waffle_SEN1"), plotOutput("waffle_SEN2")),
                                                   tabPanel("EHCP waffle", plotOutput("waffle_EHCP1"), plotOutput("waffle_EHCP2")))),
                                   tabPanel("Timing",
                                            tabBox(width=12, title = NULL, id="sen_subtab3",
                                                   tabPanel("SEN timing", plotlyOutput("timing_SEN1"), plotlyOutput("timing_SEN2")),
                                                   tabPanel("EHCP timing", plotlyOutput("timing_EHCP1"), plotlyOutput("timing_EHCP2")))),
                                   tabPanel("Timing of SEMH", plotlyOutput("timing_SEMH1"), plotlyOutput("timing_SEMH2")))
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
    "Children's social care Experience",
    
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
        
        column(
          width=12,
          tabsetPanel(id = "tabsetpanels3",
                      tabPanel(
                        "Ever CIN/CLA",
                        fluidRow(
                          column(
                            width=12,
                            h2("Outputs 0 (h2)"),
                            tabBox(width = 12, title = NULL, id="csc_subtabs",
                                   tabPanel("Chart", plotlyOutput("CSCPlot1"), plotlyOutput("CSCPlot2")),
                                   tabPanel("Waffle", plotOutput("waffle_CIN1"), plotOutput("waffle_CIN2")))
                          )
                        )
                      ),
                      tabPanel(
                        "Timing of CSC",
                        fluidRow(
                          column(
                            width=12,
                            h2("Outputs 1 (h2)"),
                            tabBox(width = 12, title = NULL, id="csc_subtabs",
                                   tabPanel("Timing CSC", plotlyOutput("timing_CSC1"), plotlyOutput("timing_CSC2")))
                          )
                        )
                      )
          )
        )
      )
    )
  )
}
