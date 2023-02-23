# ---------------------------------------------------------
# This is the server file.
# Use it to create interactive elements like tables, charts and text for your app.
#
# Anything you create in the server file won't appear in your app until you call it in the UI file.
# This server script gives an example of a plot and value box that updates on slider input.
# There are many other elements you can add in too, and you can play around with their reactivity.
# The "outputs" section of the shiny cheatsheet has a few examples of render calls you can use:
# https://shiny.rstudio.com/images/shiny-cheatsheet.pdf
#
#
# This is the server logic of a Shiny web application. You can run th
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# ---------------------------------------------------------


server <- function(input, output, session) {
  # Loading screen ---------------------------------------------------------------------------
  # Call initial loading screen

  hide(id = "loading-content", anim = TRUE, animType = "fade")
  show("app-content")

  # Nav link to Support and feedback tab
  observeEvent(input$link_to_sup_tab, {
    updateTabsetPanel(session, "navlistPanel", selected = "Support and feedback")
  })
  
  # Code to sync inputs across tabs: LA choice
  observeEvent(input$demLAchoice, {
    if (input$navlistPanel == "tab_demo") {
      updateSelectInput(session, "sclLAchoice", selected = input$demLAchoice)
      updateSelectInput(session, "cscLAchoice", selected = input$demLAchoice)
    }
  })

  observeEvent(input$demLAchoice2, {
    if (input$navlistPanel == "tab_demo") {
      updateSelectInput(session, "sclLAchoice2", selected = input$demLAchoice2)
      updateSelectInput(session, "cscLAchoice2", selected = input$demLAchoice2)
    }
  })

  observeEvent(input$sclLAchoice, {
    if (input$navlistPanel == "tab_scl") {
      updateSelectInput(session, "demLAchoice", selected = input$sclLAchoice)
      updateSelectInput(session, "cscLAchoice", selected = input$sclLAchoice)
    }
  })

  observeEvent(input$sclLAchoice2, {
    if (input$navlistPanel == "tab_scl") {
      updateSelectInput(session, "demLAchoice2", selected = input$sclLAchoice2)
      updateSelectInput(session, "cscLAchoice2", selected = input$sclLAchoice2)
    }
  })

  observeEvent(input$cscLAchoice, {
    if (input$navlistPanel == "tab_csc") {
      updateSelectInput(session, "demLAchoice", selected = input$cscLAchoice)
      updateSelectInput(session, "sclLAchoice", selected = input$cscLAchoice)
    }
  })

  observeEvent(input$cscLAchoice2, {
    if (input$navlistPanel == "tab_csc") {
      updateSelectInput(session, "demLAchoice2", selected = input$cscLAchoice2)
      updateSelectInput(session, "sclLAchoice2", selected = input$cscLAchoice2)
    }
  })

  # Code to sync inputs across tabs: indichoice (Home or School) for LA 1
  observeEvent(input$demindichoice, {
    if (input$navlistPanel == "tab_demo") {
      updateSelectInput(session, "sclindichoice", selected = input$demindichoice)
      updateSelectInput(session, "cscindichoice", selected = input$demindichoice)
    }
  })

  observeEvent(input$sclindichoice, {
    if (input$navlistPanel == "tab_scl") {
      updateSelectInput(session, "demindichoice", selected = input$sclindichoice)
      updateSelectInput(session, "cscindichoice", selected = input$sclindichoice)
    }
  })

  observeEvent(input$cscindichoice, {
    if (input$navlistPanel == "tab_csc") {
      updateSelectInput(session, "demindichoice", selected = input$cscindichoice)
      updateSelectInput(session, "sclindichoice", selected = input$cscindichoice)
    }
  })
  
  # Code to sync inputs across tabs: indichoice (Home or School) for LA 2
  observeEvent(input$demindichoice2, {
    if (input$navlistPanel == "tab_demo") {
      updateSelectInput(session, "sclindichoice2", selected = input$demindichoice2)
      updateSelectInput(session, "cscindichoice2", selected = input$demindichoice2)
    }
  })
  
  observeEvent(input$sclindichoice2, {
    if (input$navlistPanel == "tab_scl") {
      updateSelectInput(session, "demindichoice2", selected = input$sclindichoice2)
      updateSelectInput(session, "cscindichoice2", selected = input$sclindichoice2)
    }
  })
  
  observeEvent(input$cscindichoice2, {
    if (input$navlistPanel == "tab_csc") {
      updateSelectInput(session, "demindichoice2", selected = input$cscindichoice2)
      updateSelectInput(session, "sclindichoice2", selected = input$cscindichoice2)
    }
  })

  # Adding interactivity for LA 2 stat neighbour (dem tab)
  output$demLAchoice2_ = renderUI({
    choicesLA_SN2 <- choicesLA_SN2 %>% filter(LA == input$demLAchoice)
    
    choicesLA_not_stat <- choicesLA %>% filter(!LA %in% c(input$demLAchoice, choicesLA_SN2$StatN_1, choicesLA_SN2$StatN_2))
    choicesLA_stat <- choicesLA %>% filter(LA %in% c(choicesLA_SN2$StatN_1, choicesLA_SN2$StatN_2))
    
    selectizeInput('demLAchoice2', 'Local Authority 2', choices = c('Statistical neighbour' = choicesLA_stat, "All other" = choicesLA_not_stat),
                   multiple = TRUE, selected=character(0),
                   options = list(placeholder = 'Select a comparison', maxItems =  1))
    
    # Will need to Add England in another group
  })
  
  # Adding interactivity for LA 2 stat neighbour (scl tab)
  output$sclLAchoice2_= renderUI({
    choicesLA_SN2 <- choicesLA_SN2 %>% filter(LA == input$sclLAchoice)
    
    choicesLA_not_stat <- choicesLA %>% filter(!LA %in% c(input$sclLAchoice, choicesLA_SN2$StatN_1, choicesLA_SN2$StatN_2))
    choicesLA_stat <- choicesLA %>% filter(LA %in% c(choicesLA_SN2$StatN_1, choicesLA_SN2$StatN_2))
    
    selectizeInput('sclLAchoice2', 'Local Authority 2', choices = c('Statistical neighbour' = choicesLA_stat, "All other" = choicesLA_not_stat),
                   multiple = TRUE, selected=character(0),
                   options = list(placeholder = 'Select a comparison', maxItems =  1))
    
    # Will need to Add England in another group
  })
  
# Adding interactivity for LA 2 stat neighbour (CSC tab)
  output$cscLAchoice2_= renderUI({
    choicesLA_SN2 <- choicesLA_SN2 %>% filter(LA == input$cscLAchoice)
    
    choicesLA_not_stat <- choicesLA %>% filter(!LA %in% c(input$cscLAchoice, choicesLA_SN2$StatN_1, choicesLA_SN2$StatN_2))
    choicesLA_stat <- choicesLA %>% filter(LA %in% c(choicesLA_SN2$StatN_1, choicesLA_SN2$StatN_2))
    
    selectizeInput('cscLAchoice2', 'Local Authority 2', choices = c('Statistical neighbour' = choicesLA_stat, "All other" = choicesLA_not_stat),
                   multiple = TRUE, selected=character(0),
                   options = list(placeholder = 'Select a comparison', maxItems =  1))
    
    # Will need to Add England in another group
  })
  
  
  # Simple server stuff goes here ------------------------------------------------------------
  reactiveRevBal <- reactive({
    dfRevBal %>% filter(
      area_name == input$selectArea | area_name == "England",
      school_phase == input$selectPhase
    )
  })

  # Define server logic required to draw a histogram
  output$lineRevBal <- renderPlotly({
    ggplotly(createAvgRevTimeSeries(reactiveRevBal(), input$selectArea)) %>%
      config(displayModeBar = F) %>%
      layout(legend = list(orientation = "h", x = 0, y = -0.2))
  })

  reactiveBenchmark <- reactive({
    dfRevBal %>%
      filter(
        area_name %in% c(input$selectArea, input$selectBenchLAs),
        school_phase == input$selectPhase,
        year == max(year)
      )
  })

  output$colBenchmark <- renderPlotly({
    ggplotly(
      plotAvgRevBenchmark(reactiveBenchmark()) %>%
        config(displayModeBar = F),
      height = 420
    )
  })

  output$tabBenchmark <- renderDataTable({
    datatable(
      reactiveBenchmark() %>%
        select(
          Area = area_name,
          `Average Revenue Balance (£)` = average_revenue_balance,
          `Total Revenue Balance (£m)` = total_revenue_balance_million
        ),
      options = list(
        scrollX = TRUE,
        paging = FALSE
      )
    )
  })

  # Define server logic to create a box

  output$boxavgRevBal <- renderValueBox({
    # Put value into box to plug into app
    valueBox(
      # take input number
      paste0("£", format(
        (reactiveRevBal() %>% filter(
          year == max(year),
          area_name == input$selectArea,
          school_phase == input$selectPhase
        ))$average_revenue_balance,
        big.mark = ","
      )),
      # add subtitle to explain what it's hsowing
      paste0("This is the latest value for the selected inputs"),
      color = "blue"
    )
  })
  output$boxpcRevBal <- renderValueBox({
    latest <- (reactiveRevBal() %>% filter(
      year == max(year),
      area_name == input$selectArea,
      school_phase == input$selectPhase
    ))$average_revenue_balance
    penult <- (reactiveRevBal() %>% filter(
      year == max(year) - 1,
      area_name == input$selectArea,
      school_phase == input$selectPhase
    ))$average_revenue_balance

    # Put value into box to plug into app
    valueBox(
      # take input number
      paste0("£", format(latest - penult,
        big.mark = ","
      )),
      # add subtitle to explain what it's hsowing
      paste0("Change on previous year"),
      color = "blue"
    )
  })

  observeEvent(input$link_to_app_content_tab, {
    updateTabsetPanel(session, "navlistPanel", selected = "dashboard")
  })

  # Download the underlying data button
  output$download_data <- downloadHandler(
    filename = "shiny_template_underlying_data.csv",
    content = function(file) {
      write.csv(dfRevBal, file)
    }
  )

  # Output - Cohort table (Homepage)
  output$CohortTable <- renderTable(dfCohort, na = "")

  # LA 1  table in Demographics tab
  output$demotable <- renderDataTable(datatable(
    {
      info_table_la1 <- info_table %>%
        filter(indicator == input$demindichoice, LA == input$demLAchoice) %>%
        rename(
          "Local authority" = LA,
          "Indicator" = indicator,
          "Number of pupils" = all,
          "Number of children cautioned or sentenced\nfor an offence (%)" = offenders_perc,
          "Number of children cautioned or sentenced for a serious violence offence (%)" = sv_perc,
          "Number of children cautioned or sentenced for a serious violence offence with a prior offence (%)" = prev_perc,
          "Number of children who live or go to school in different LA (%)" = all_dif_perc,
          "Number of children cautioned or sentenced for an offence who live or go to school in different LA (%)" = off_dif_perc,
          "Number of children cautioned or sentenced for a serious violence offence who live or go to school in different LA (%)" = sv_dif_perc) %>%
        t() %>%
        as.data.frame() %>%
        rename("Local Authority 1" = V1)
      
      info_table_la2 <- info_table %>%
        filter(indicator == input$demindichoice2, LA == input$demLAchoice2) %>%
        rename(
          "Local authority" = LA,
          "Indicator" = indicator,
          "Number of pupils" = all,
          "Number of children cautioned or sentenced\nfor an offence (%)" = offenders_perc,
          "Number of children cautioned or sentences for a serious violence offence (%)" = sv_perc,
          "Number of children cautioned or sentenced for a serious violence offence with a prior offence (%)" = prev_perc,
          "Number of children who live or go to school in different LA (%)" = all_dif_perc,
          "Number of children cautioned or sentenced for an offence who live or go to school in different LA (%)" = off_dif_perc,
          "Number of children cautioned or sentenced for a serious violence offence who live or go to school in different LA (%)" = sv_dif_perc) %>%
        t() %>%
        as.data.frame() %>%
        rename("Local Authority 2" = V1)
      
      info_table_la <- bind_cols(info_table_la1, info_table_la2)
      
    },
    rownames = TRUE,
    options = list(searchable = FALSE, dom = "t", ordering = F),
    filter = c("none"),
    selection = c("none")
  ))

  # Output - Gender column 1 LA title
  output$DemTitle1 <- renderText({
    (Gender %>% filter(indicator == input$demindichoice, LA == input$demLAchoice) %>% slice_head())$LA
  })

  # Output - Gender column 2 LA title
  output$DemTitle2 <- renderText({
    (Gender %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2) %>% slice_head())$LA
  })

  # Gender plot 1
  output$GenderPlot1 <- renderPlot({
    Genderplot <- Gender %>% filter(indicator == input$demindichoice, LA == input$demLAchoice)
    createGenderPlot(Genderplot, input$demLAchoice)
  })

  # Gender plot 2
  output$GenderPlot2 <- renderPlot({
    Genderplot <- Gender %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2)
    createGenderPlot(Genderplot, input$demLAchoice2)
  })

  # Output - Ethnicity column 1 LA title
  output$DemTitle1_eth <- renderText({
    (Ethnicity %>% filter(indicator == input$demindichoice, LA == input$demLAchoice) %>% slice_head())$LA
  })

  # Output - Ethnicity column 2 LA title
  output$DemTitle2_eth <- renderText({
    (Ethnicity %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2) %>% slice_head())$LA
  })

  # Ethnicity plot 1
  output$EthPlot1 <- renderPlot({
    ethplot <- Ethnicity %>% filter(indicator == input$demindichoice, LA == input$demLAchoice)
    createEthPlot(ethplot, input$demLAchoice)
  })

  # Ethnicity plot 2
  output$EthPlot2 <- renderPlot({
    ethplot <- Ethnicity %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2)
    createEthPlot(ethplot, input$demLAchoice2)
  })

  # Output - FSM chart column 1 LA title
  output$DemTitle1_FSM1 <- renderText({
    (FSM %>% filter(indicator == input$demindichoice, LA == input$demLAchoice) %>% slice_head())$LA
  })

  # Output - FSM chart column 2 LA title
  output$DemTitle1_FSM2 <- renderText({
    (FSM %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2) %>% slice_head())$LA
  })

  # Output - FSM waffle column 1 LA title
  output$DemTitle2_FSM1_sv <- renderText({
    (FSM %>% filter(indicator == input$demindichoice, LA == input$demLAchoice) %>% slice_head())$LA
  })

  # Output - FSM waffle column 2 LA title
  output$DemTitle2_FSM2_sv <- renderText({
    (FSM %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2) %>% slice_head())$LA
  })

  # Output - FSM chart 1
  output$fsmPlot1 <- renderPlot({
    fsmplot <- FSM %>% filter(indicator == input$demindichoice, LA == input$demLAchoice)
    createFSMPlot(fsmplot, input$demLAchoice)
  })

  # Output - FSM chart 2
  output$fsmPlot2 <- renderPlot({
    fsmplot <- FSM %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2)
    createFSMPlot(fsmplot, input$demLAchoice2)
  })

  # Output - FSM waffle 1 - sv
  output$waffle_FSM1_sv <- renderPlot({
    FSM_waffle_sv <- FSM_waffle_sv %>% filter(indicator == input$demindichoice, LA == input$demLAchoice)
    createWaffle_FSM_sv(FSM_waffle_sv, input$demLAchoice)
  })

  # Output - FSM waffle 2 - sv
  output$waffle_FSM2_sv <- renderPlot({
    FSM_waffle_sv <- FSM_waffle_sv %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2)
    createWaffle_FSM_sv(FSM_waffle_sv, input$demLAchoice2)
  })
  
  # Output - FSM waffle Text 1 - sv
  output$WaffleTextFSM1_sv <- renderText({
    WaffleText <- FSM_waffle_sv %>% filter(indicator == input$demindichoice, LA == input$demLAchoice)
    paste0(WaffleText$sv_prop_count_FSM, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been eligible for FSM. However, ", WaffleText$also_sv_prop_count_FSM, "% of those who had ever been eligible
    for FSM were children who were cautioned or sentenced for a serious violence offence.")
  })

  # Output - FSM waffle Text 2 - sv
  output$WaffleTextFSM2_sv <- renderText({
    WaffleText <- FSM_waffle_sv %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2)
    paste0(WaffleText$sv_prop_count_FSM, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been eligible for FSM. However, ", WaffleText$also_sv_prop_count_FSM, "% of those who had ever been eligible
    for FSM were children who were cautioned or sentenced for a serious violence offence.")
  })
  
  # Output - FSM waffle Text 1 - offenders
  output$WaffleTextFSM1_any <- renderText({
    WaffleText <- FSM_waffle_any %>% filter(indicator == input$demindichoice, LA == input$demLAchoice)
    paste0(WaffleText$any_prop_count_FSM, "% of children who were cautioned or sentenced for an offence
    had ever been eligible for FSM. However, ", WaffleText$also_any_prop_count_FSM, "% of those who had ever been eligible
    for FSM were children who were cautioned or sentenced for an offence.")
  })
  
  # Output - FSM waffle Text 2 - offenders
  output$WaffleTextFSM2_any <- renderText({
    WaffleText <- FSM_waffle_any %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2)
    paste0(WaffleText$any_prop_count_FSM, "% of children who were cautioned or sentenced for an offence
    had ever been eligible for FSM. However, ", WaffleText$also_any_prop_count_FSM, "% of those who had ever been eligible
    for FSM were children who were cautioned or sentenced for an offence.")
  })
  
  # Output - FSM waffle 1 - offenders
  output$waffle_FSM1_any <- renderPlot({
    FSM_waffle_any <- FSM_waffle_any %>% filter(indicator == input$demindichoice, LA == input$demLAchoice)
    createWaffle_FSM_any(FSM_waffle_any, input$demLAchoice)
  })
  
  # Output - FSM waffle 2 - offenders
  output$waffle_FSM2_any <- renderPlot({
    FSM_waffle_any <- FSM_waffle_any %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2)
    createWaffle_FSM_any(FSM_waffle_any, input$demLAchoice2)
  })
  
  # Output - FSM plot switch between waffle (offenders / sv) 
  output$dem_plot_waf_fsm <- renderUI(
    if (input$fsm_plot_switch_waf == "sv_off") {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for a serious violence offence and 
                                   had ever been eligible for free school meals (FSM), and all pupils who had ever been eligible for FSM, for pupils matched 
                                   to KS4 academic years 2012/13 - 2017/18"), 
        column(width=6, 
               h3(textOutput("DemTitle2_FSM1_sv")), 
               box(width = 12, 
                   br(), 
                   textOutput("WaffleTextFSM1_sv"), 
                   br(), 
                   plotOutput("waffle_FSM1_sv"), 
                   br())),
        column(width=6, 
               h3(textOutput("DemTitle2_FSM2_sv")), 
               box(width = 12, 
                   br(), 
                   textOutput("WaffleTextFSM2_sv"), 
                   br(), 
                   plotOutput("waffle_FSM2_sv"), 
                   br()))
      )
    } else {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for an offence and 
            had ever been eligible for free school meals (FSM), and all pupils who had ever been eligible for FSM, for pupils matched 
            to KS4 academic years 2012/13 - 2017/18"), 
        column(width=6, 
               h3(textOutput("DemTitle2_FSM1_sv")), 
               box(width = 12, 
                   br(), 
                   textOutput("WaffleTextFSM1_any"), 
                   br(), 
                   plotOutput("waffle_FSM1_any"), 
                   br())),
        column(width=6, 
               h3(textOutput("DemTitle2_FSM2_sv")), 
               box(width = 12, 
                   br(), 
                   textOutput("WaffleTextFSM2_any"), 
                   br(), 
                   plotOutput("waffle_FSM2_any"), 
                   br()))
        
      )
    }
  )
  
  # Output - age_offence column 1 LA title
  output$DemTitle1_age <- renderText({
    (age_offence %>% filter(indicator == input$demindichoice, LA == input$demLAchoice) %>% slice_head())$LA
  })

  # Output - age_offence column 2 LA title
  output$DemTitle2_age <- renderText({
    (age_offence %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2) %>% slice_head())$LA
  })

  # Output - age first offence chart 1
  output$ageofplot1 <- renderPlot({
    age_plot <- age_offence %>% filter(indicator == input$demindichoice, LA == input$demLAchoice)
    createAgeOffence(age_plot, input$demLAchoice)
  })

  # Output - age first offence chart 2
  output$ageofplot2 <- renderPlot({
    age_plot <- age_offence %>% filter(indicator == input$demindichoice2, LA == input$demLAchoice2)
    createAgeOffence(age_plot, input$demLAchoice2)
  })

  # Output - KS2 attainment column 1 LA title
  output$sclTitle1_ks2 <- renderText({
    (KS2_attain %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - KS2 attainment column 2 LA title
  output$sclTitle2_ks2 <- renderText({
    (KS2_attain %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - KS2 attainment chart 1
  output$ks2attainplot1 <- renderPlot({
    KS2_attain <- KS2_attain %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createKS2plot(KS2_attain, input$sclLAchoice)
  })

  # Output - KS2 attainment chart 2
  output$ks2attainplot2 <- renderPlot({
    KS2_attain <- KS2_attain %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createKS2plot(KS2_attain, input$sclLAchoice2)
  })

  # Output - KS4 attainment column 1 LA title
  output$sclTitle1_ks4 <- renderText({
    (KS4_attain %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - KS4 attainment column 2 LA title
  output$sclTitle2_ks4 <- renderText({
    (KS4_attain %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - KS4 attainment chart 1
  output$ks4attainplot1 <- renderPlot({
    KS4_attain <- KS4_attain %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createKS4plot(KS4_attain, input$sclLAchoice)
  })

  # Output - KS4 attainment chart 2
  output$ks4attainplot2 <- renderPlot({
    KS4_attain <- KS4_attain %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createKS4plot(KS4_attain, input$sclLAchoice2)
  })

  # Output - PA column 1 LA title
  output$sclTitle1_PA <- renderText({
    (EverPAPAUO %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - PA column 2 LA title
  output$sclTitle2_PA <- renderText({
    (EverPAPAUO %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - PA/PAUO chart 1
  output$PAPlot1 <- renderPlot({
    EverPAPAUO <- EverPAPAUO %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createPAPlot(EverPAPAUO, input$sclLAchoice)
  })

  # Output - PA/PAUO chart 2
  output$PAPlot2 <- renderPlot({
    EverPAPAUO <- EverPAPAUO %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createPAPlot(EverPAPAUO, input$sclLAchoice2)
  })

  # Output - PA waffle column 1 LA title
  output$sclTitle1_PAwaf <- renderText({
    (PA_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - PA waffle column 2 LA title
  output$sclTitle2_PAwaf <- renderText({
    (PA_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - PA waffle 1 - sv
  output$waffle_PA1_sv <- renderPlot({
    PA_waffle_sv <- PA_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_PA_sv(PA_waffle_sv, input$sclLAchoice)
  })

  # Output - PA waffle 2 - sv
  output$waffle_PA2_sv <- renderPlot({
    PA_waffle_sv <- PA_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_PA_sv(PA_waffle_sv, input$sclLAchoice2)
  })

  # Output - PA waffle text 1 - sv
  output$waffleText_PA1_sv <- renderText({
    WaffleText <- PA_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$sv_prop_count_PA, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been persistently absent. However, ", WaffleText$also_sv_prop_count_PA, "% of those who had ever been persistently absent
             were children who were cautioned or sentenced for a serious violence offence.")
  })

  # Output - PA waffle text 2 - sv
  output$waffleText_PA2_sv <- renderText({
    WaffleText <- PA_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$sv_prop_count_PA, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been persistently absent. However, ", WaffleText$also_sv_prop_count_PA, "% of those who had ever been persistently absent
    for FSM were children who were cautioned or sentenced for a serious violence offence.")
  })

  # Output - PA waffle 1 - offender
  output$waffle_PA1_any <- renderPlot({
    PA_waffle_any <- PA_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_PA_any(PA_waffle_any, input$sclLAchoice)
  })
  
  # Output - PA waffle 2 - offender
  output$waffle_PA2_any <- renderPlot({
    PA_waffle_any <- PA_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_PA_any(PA_waffle_any, input$sclLAchoice2)
  })
  
  # Output - PA waffle text 1 - offender
  output$waffleText_PA1_any <- renderText({
    WaffleText <- PA_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$any_prop_count_PA, "% of children who were cautioned or sentenced for an offence
    had ever been persistently absent. However, ", WaffleText$also_any_prop_count_PA, "% of those who had ever been persistently absent
             were children who were cautioned or sentenced for an offence.")
  })
  
  # Output - PA waffle text 2 - offender
  output$waffleText_PA2_any <- renderText({
    WaffleText <- PA_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$any_prop_count_PA, "% of children who were cautioned or sentenced for an offence
    had ever been persistently absent. However, ", WaffleText$also_any_prop_count_PA, "% of those who had ever been persistently absent
    for FSM were children who were cautioned or sentenced for an offence.")
  })
  
  # output - PA waffle switch 
  output$scl_plot_waf_pa <- renderUI(
    if (input$pa_plot_switch_waf == "sv_off") {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for a 
            serious violence offence and had been persistently absent, and all pupils who had ever been 
            persistently absent, for pupils matched to KS4 academic years 2012/13 - 2017/18"),
        column(h3(textOutput("sclTitle1_PAwaf")),
               width=6,
               box(width = 12,
                   br(),
                   textOutput("waffleText_PA1_sv"), 
                   br(),
                   plotOutput("waffle_PA1_sv"),
                   br())), 
        column(h3(textOutput("sclTitle2_PAwaf")),
               width=6,
               box(width = 12, 
                   br(),
                   textOutput("waffleText_PA2_sv"),
                   br(),
                   plotOutput("waffle_PA2_sv"),
                   br()))
        )
    } else {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for an 
            offence and had been persistently absent, and all pupils who had ever been 
            persistently absent, for pupils matched to KS4 academic years 2012/13 - 2017/18"),
        
        column(h3(textOutput("sclTitle1_PAwaf")),
               width=6,
               box(width = 12,
                   br(),
                   textOutput("waffleText_PA1_any"), 
                   br(),
                   plotOutput("waffle_PA1_any"),
                   br())), 
        column(h3(textOutput("sclTitle2_PAwaf")),
               width=6,
               box(width = 12, 
                   br(),
                   textOutput("waffleText_PA2_any"),
                   br(),
                   plotOutput("waffle_PA2_any"),
                   br()))
      )
    }
  )
  
  # Output - PA timing column 1 LA title
  output$sclTitle1_PAtime <- renderText({
    (PAPAUO_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - PA timing column 2 LA title
  output$sclTitle2_PAtime <- renderText({
    (PAPAUO_timing %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - PA timing 1
  output$timing_PA1 <- renderPlot({
    PAPAUO_timing <- PAPAUO_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createPATimingPlot(PAPAUO_timing, input$sclLAchoice)
  })

  # Output - PA timing 2
  output$timing_PA2 <- renderPlot({
    PAPAUO_timing <- PAPAUO_timing %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createPATimingPlot(PAPAUO_timing, input$sclLAchoice2)
  })

  # Output - Sus column 1 LA title
  output$sclTitle1_sus <- renderText({
    (EverSusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - Sus column 2 LA title
  output$sclTitle2_sus <- renderText({
    (EverSusExcl %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - Sus/Excl 1
  output$SusExclPlot1 <- renderPlot({
    EverSusExcl <- EverSusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createSusExclPlot(EverSusExcl, input$sclLAchoice)
  })

  # Output - Sus/Excl 2
  output$SusExclPlot2 <- renderPlot({
    EverSusExcl <- EverSusExcl %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createSusExclPlot(EverSusExcl, input$sclLAchoice2)
  })

  # Output - Sus waffle column 1 LA title
  output$sclTitle1_suswaf <- renderText({
    (SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - Sus waffle column 2 LA title
  output$sclTitle2_suswaf <- renderText({
    (SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - Suspension waffle 1 - sv
  output$waffle_Sus1_sv <- renderPlot({
    SusExcl_waffle_sv <- SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_Sus_sv(SusExcl_waffle_sv, input$sclLAchoice)
  })

  # Output - Suspension waffle 2 - sv
  output$waffle_Sus2_sv <- renderPlot({
    SusExcl_waffle_sv <- SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_Sus_sv(SusExcl_waffle_sv, input$sclLAchoice2)
  })
  
  # Output - sus waffle text 1 - sv
  output$waffleText_sus1_sv <- renderText({
    WaffleText <- SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$sv_prop_count_Sus, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been suspended. However, ", WaffleText$also_sv_prop_count_Sus, "% of those who had ever been suspended
           were children who were cautioned or sentenced for a serious violence offence.")
  })
  
  # Output - sus waffle text 2 - sv
  output$waffleText_sus2_sv <- renderText({
    WaffleText <- SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$sv_prop_count_Sus, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been suspended. However, ", WaffleText$also_sv_prop_count_Sus, "% of those who had ever been suspended
           were children who were cautioned or sentenced for a serious violence offence.")
  })
  
  # Output - Suspension waffle 1 - offenders
  output$waffle_Sus1_any <- renderPlot({
    SusExcl_waffle_any <- SusExcl_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_Sus_any(SusExcl_waffle_any, input$sclLAchoice)
  })
  
  # Output - Suspension waffle 2 - offenders
  output$waffle_Sus2_any <- renderPlot({
    SusExcl_waffle_any <- SusExcl_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_Sus_any(SusExcl_waffle_any, input$sclLAchoice2)
  })
  
  # Output - sus waffle text 1 - offenders
  output$waffleText_sus1_any <- renderText({
    WaffleText <- SusExcl_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$any_prop_count_Sus, "% of children who were cautioned or sentenced for an offence
    had ever been suspended. However, ", WaffleText$also_any_prop_count_Sus, "% of those who had ever been suspended
           were children who were cautioned or sentenced for an offence.")
  })
  
  # Output - sus waffle text 2 - offenders
  output$waffleText_sus2_any <- renderText({
    WaffleText <- SusExcl_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$any_prop_count_Sus, "% of children who were cautioned or sentenced for an offence
    had ever been suspended. However, ", WaffleText$also_any_prop_count_Sus, "% of those who had ever been suspended
           were children who were cautioned or sentenced for an offence.")
  })

  # output - suspension waffle switch 
  output$scl_plot_waf_sus <- renderUI(
    if (input$sus_plot_switch_waf == "sv_off") {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for a serious violence 
            offence and had ever been suspended, and all pupils who had ever been suspended, for pupils matched to KS4 academic years 
            2012/13 - 2017/18"), 
        column(h3(textOutput("sclTitle1_suswaf")),
               width=6,
               box(width = 12,
                   br(),
                   textOutput("waffleText_sus1_sv"),
                   br(),
                   plotOutput("waffle_Sus1_sv"), 
                   br())),
        column(h3(textOutput("sclTitle2_suswaf")),
               width=6,
               box(width = 12,
                   br(), 
                   textOutput("waffleText_sus2_sv"),
                   br(),
                   plotOutput("waffle_Sus2_sv"), 
                   br()))
      )
    } else {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for an
            offence and had ever been suspended, and all pupils who had ever been suspended, for pupils matched to KS4 academic years 
            2012/13 - 2017/18"), 
        column(h3(textOutput("sclTitle1_suswaf")),
               width=6,
               box(width = 12,
                   br(),
                   textOutput("waffleText_sus1_any"),
                   br(),
                   plotOutput("waffle_Sus1_any"), 
                   br())),
        column(h3(textOutput("sclTitle2_suswaf")),
               width=6,
               box(width = 12,
                   br(), 
                   textOutput("waffleText_sus2_any"),
                   br(),
                   plotOutput("waffle_Sus2_any"), 
                   br()))
      )
    }
  )
  
  # Output - Excl waffle column 1 LA title
  output$sclTitle1_exclwaf <- renderText({
    (SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - Excl waffle column 2 LA title
  output$sclTitle2_exclwaf <- renderText({
    (SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - Exclusion waffle 1 - sv
  output$waffle_Excl1_sv <- renderPlot({
    SusExcl_waffle_sv <- SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_Excl_sv(SusExcl_waffle_sv, input$sclLAchoice)
  })

  # Output - Exclusion waffle 2 - sv
  output$waffle_Excl2_sv <- renderPlot({
    SusExcl_waffle_sv <- SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_Excl_sv(SusExcl_waffle_sv, input$sclLAchoice2)
  })

  # Output - Excl waffle text 1 - sv
  output$waffleText_excl1_sv <- renderText({
    WaffleText <- SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$sv_prop_count_Excl, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been permanently excluded. However, ", WaffleText$also_sv_prop_count_Excl, "% of those who had ever been permanently
    excluded were children who were cautioned or sentenced for a serious violence offence.")
  })

  # Output - Excl waffle text 2 - sv
  output$waffleText_excl2_sv <- renderText({
    WaffleText <- SusExcl_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$sv_prop_count_Excl, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been permanently excluded. However, ", WaffleText$also_sv_prop_count_Excl, "% of those who had ever been permanently
    excluded were children who were cautioned or sentenced for a serious violence offence.")
  })
  
  # Output - Exclusion waffle 1 - offenders
  output$waffle_Excl1_any <- renderPlot({
    SusExcl_waffle_any <- SusExcl_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_Excl_any(SusExcl_waffle_any, input$sclLAchoice)
  })
  
  # Output - Exclusion waffle 2 - offenders
  output$waffle_Excl2_any <- renderPlot({
    SusExcl_waffle_any <- SusExcl_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_Excl_any(SusExcl_waffle_any, input$sclLAchoice2)
  })
  
  # Output - Excl waffle text 1 - offenders
  output$waffleText_excl1_any <- renderText({
    WaffleText <- SusExcl_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$any_prop_count_Excl, "% of children who were cautioned or sentenced for an offence
    had ever been permanently excluded. However, ", WaffleText$also_any_prop_count_Excl, "% of those who had ever been permanently
    excluded were children who were cautioned or sentenced for an offence.")
  })
  
  # Output - Excl waffle text 2 - offenders
  output$waffleText_excl2_any <- renderText({
    WaffleText <- SusExcl_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$any_prop_count_Excl, "% of children who were cautioned or sentenced for an offence
    had ever been permanently excluded. However, ", WaffleText$also_any_prop_count_Excl, "% of those who had ever been permanently
    excluded were children who were cautioned or sentenced for an offence.")
  })

  # output - exclusion waffle switch 
  output$scl_plot_waf_excl <- renderUI(
    if (input$excl_plot_switch_waf == "sv_off") {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for a serious violence 
            offence and had ever been permanently excluded, and all pupils who had ever been permanently excluded, for pupils matched 
            to KS4 academic years 2012/13 - 2017/18"),  
        column(h3(textOutput("sclTitle1_exclwaf")),
               width=6,
               box(width = 12,
                   br(),
                   textOutput("waffleText_excl1_sv"),
                   br(),
                   plotOutput("waffle_Excl1_sv"),
                   br())),
        column(h3(textOutput("sclTitle2_exclwaf")),
               width=6,
               box(width = 12,
                   br(),
                   textOutput("waffleText_excl2_sv"),
                   br(),
                   plotOutput("waffle_Excl2_sv"), 
                   br()))
      )
    } else {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for an
            offence and had ever been permanently excluded, and all pupils who had ever been permanently excluded, for pupils matched 
            to KS4 academic years 2012/13 - 2017/18"),  
        column(h3(textOutput("sclTitle1_exclwaf")),
               width=6,
               box(width = 12,
                   br(),
                   textOutput("waffleText_excl1_any"),
                   br(),
                   plotOutput("waffle_Excl1_any"),
                   br())),
        column(h3(textOutput("sclTitle2_exclwaf")),
               width=6,
               box(width = 12,
                   br(),
                   textOutput("waffleText_excl2_any"),
                   br(),
                   plotOutput("waffle_Excl2_any"), 
                   br()))
      )
    }
  )
  
  # Output - first sus column 1 LA title
  output$sclTitle1_fstsus <- renderText({
    (fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - first sus column 2 LA title
  output$sclTitle2_fstsus <- renderText({
    (fst.clst_SusExcl %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - close sus column 1 LA title
  output$sclTitle1_clssus <- renderText({
    (fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - close sus column 2 LA title
  output$sclTitle2_clssus <- renderText({
    (fst.clst_SusExcl %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - first excl column 1 LA title
  output$sclTitle1_fstexcl <- renderText({
    (fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - first excl column 2 LA title
  output$sclTitle2_fstexcl <- renderText({
    (fst.clst_SusExcl %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - close excl column 1 LA title
  output$sclTitle1_clsexcl <- renderText({
    (fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - close excl column 2 LA title
  output$sclTitle2_clsexcl <- renderText({
    (fst.clst_SusExcl %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - first suspension timing 1
  output$FstSusTime1 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createSusTimePlot(fst.clst_SusExcl, input$sclLAchoice, "First")
  })

  # Output - first suspension timing 2
  output$FstSusTime2 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createSusTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "First")
  })

  # Output - closest suspension timing 1
  output$clstSusTime1 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createSusTimePlot(fst.clst_SusExcl, input$sclLAchoice, "Closest")
  })

  # Output - closest suspension timing 2
  output$clstSusTime2 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createSusTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "Closest")
  })

  # Output - first Exclusion timing 1
  output$FstExclTime1 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice, "First")
  })

  # Output - first Exclusion timing 2
  output$FstExclTime2 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "First")
  })

  # Output - closest Exclusion timing 1
  output$clstExclTime1 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice, "Closest")
  })

  # Output - closest Exclusion timing 2
  output$clstExclTime2 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "Closest")
  })

  # Output - AP column 1 LA title
  output$sclTitle1_AP <- renderText({
    (EverAP %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - AP column 2 LA title
  output$sclTitle2_AP <- renderText({
    (EverAP %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - AP chart 1
  output$APchart1 <- renderPlot({
    EverAP <- EverAP %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createAPPlot(EverAP, input$sclLAchoice)
  })

  # Output - AP chart 2
  output$APchart2 <- renderPlot({
    EverAP <- EverAP %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createAPPlot(EverAP, input$sclLAchoice2)
  })

  # Output - AP waffle column 1 LA title
  output$sclTitle1_APwaf <- renderText({
    (AP_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - AP waffle column 2 LA title
  output$sclTitle2_APwaf <- renderText({
    (AP_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - AP waffle 1 - sv
  output$waffle_AP1_sv <- renderPlot({
    AP_waffle_sv <- AP_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_AP_sv(AP_waffle_sv, input$sclLAchoice)
  })

  # Output - AP waffle 2 - sv
  output$waffle_AP2_sv <- renderPlot({
    AP_waffle_sv <- AP_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_AP_sv(AP_waffle_sv, input$sclLAchoice2)
  })

  # Output - AP waffle text 1 - sv
  output$waffleText_AP1_sv <- renderText({
    WaffleText <- AP_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$sv_prop_count_AP, "% of children who were cautioned or sentenced for a serious violence offence
    had ever attended alternative provision. However, ", WaffleText$also_sv_prop_count_AP, "% of those who had ever attended alternative
    provision were children who were cautioned or sentenced for a serious violence offence.")
  })

  # Output - AP waffle text 2 - sv
  output$waffleText_AP2_sv <- renderText({
    WaffleText <- AP_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$sv_prop_count_AP, "% of children who were cautioned or sentenced for a serious violence offence
    had ever attended alternative provision. However, ", WaffleText$also_sv_prop_count_AP, "% of those who had ever attended alternative
    provision were children who were cautioned or sentenced for a serious violence offence.")
  })

  # Output - AP waffle 1 - offenders
  output$waffle_AP1_any <- renderPlot({
    AP_waffle_any <- AP_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_AP_any(AP_waffle_any, input$sclLAchoice)
  })
  
  # Output - AP waffle 2 - offenders
  output$waffle_AP2_any <- renderPlot({
    AP_waffle_any <- AP_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_AP_any(AP_waffle_any, input$sclLAchoice2)
  })
  
  # Output - AP waffle text 1 - offenders
  output$waffleText_AP1_any <- renderText({
    WaffleText <- AP_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$any_prop_count_AP, "% of children who were cautioned or sentenced for an offence
    had ever attended alternative provision. However, ", WaffleText$also_any_prop_count_AP, "% of those who had ever attended alternative
    provision were children who were cautioned or sentenced for an offence.")
  })
  
  # Output - AP waffle text 2 - offenders
  output$waffleText_AP2_any <- renderText({
    WaffleText <- AP_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$any_prop_count_AP, "% of children who were cautioned or sentenced for an offence
    had ever attended alternative provision. However, ", WaffleText$also_any_prop_count_AP, "% of those who had ever attended alternative
    provision were children who were cautioned or sentenced for an offence.")
  })
  
  # output - AP waffle switch 
  output$scl_plot_waf_ap <- renderUI(
    if (input$ap_plot_switch_waf == "sv_off") {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for a serious violence 
            offence and had ever attended alternative provision, and all pupils who had ever attended alternative provision, 
            for pupils matched to KS4 academic years 2012/13 - 2017/18"), 
        column(h3(textOutput("sclTitle1_APwaf")),
               width=6, 
               box(width = 12,
                   br(),
                   textOutput("waffleText_AP1_sv"),
                   br(),
                   plotOutput("waffle_AP1_sv"), 
                   br())),
        column(h3(textOutput("sclTitle2_APwaf")),
               width=6,
               box(width = 12,
                   br(),
                   textOutput("waffleText_AP2_sv"), 
                   br(),
                   plotOutput("waffle_AP2_sv"), 
                   br()))
      )
    } else {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for an 
            offence and had ever attended alternative provision, and all pupils who had ever attended alternative provision, 
            for pupils matched to KS4 academic years 2012/13 - 2017/18"), 
        column(h3(textOutput("sclTitle1_APwaf")),
               width=6, 
               box(width = 12,
                   br(),
                   textOutput("waffleText_AP1_any"),
                   br(),
                   plotOutput("waffle_AP1_any"), 
                   br())),
        column(h3(textOutput("sclTitle2_APwaf")),
               width=6,
               box(width = 12,
                   br(),
                   textOutput("waffleText_AP2_any"), 
                   br(),
                   plotOutput("waffle_AP2_any"), 
                   br()))
      )
    }
  )

  # Output - AP timing column 1 LA title
  output$sclTitle1_APtime <- renderText({
    (AP_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - AP timing column 2 LA title
  output$sclTitle2_APtime <- renderText({
    (AP_timing %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - AP timing 1
  output$timing_AP1 <- renderPlot({
    AP_timing <- AP_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createAPTimingPlot(AP_timing, input$sclLAchoice)
  })

  # Output - AP timing 2
  output$timing_AP2 <- renderPlot({
    AP_timing <- AP_timing %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createAPTimingPlot(AP_timing, input$sclLAchoice2)
  })

  # Output - SEN column 1 LA title
  output$sclTitle1_SEN <- renderText({
    (EverSEN %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - SEN column 2 LA title
  output$sclTitle2_SEN <- renderText({
    (EverSEN %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - SEN chart 1
  output$SENchart1 <- renderPlot({
    EverSEN <- EverSEN %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createSENPlot(EverSEN, input$sclLAchoice)
  })

  # Output - SEN chart 2
  output$SENchart2 <- renderPlot({
    EverSEN <- EverSEN %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createSENPlot(EverSEN, input$sclLAchoice2)
  })

  # Output - SEN waffle column 1 LA title
  output$sclTitle1_SENwaf <- renderText({
    (SEN_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - SEN waffle column 2 LA title
  output$sclTitle2_SENwaf <- renderText({
    (SEN_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - SEN waffle 1 - sv
  output$waffle_SEN1_sv <- renderPlot({
    SEN_waffle_sv <- SEN_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_SEN_sv(SEN_waffle_sv, input$sclLAchoice)
  })

  # Output - SEN waffle 2 - sv
  output$waffle_SEN2_sv <- renderPlot({
    SEN_waffle_sv <- SEN_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_SEN_sv(SEN_waffle_sv, input$sclLAchoice2)
  })

  # Output - SEN waffle text 1 - sv
  output$waffleText_SEN1_sv <- renderText({
    WaffleText <- SEN_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$prop_SEN_support_SV, "% of children who were cautioned or sentenced for a serious violence offence
    had ever had SEN Support. However, ", WaffleText$prop_also_SEN_support_SV, "% of those who had ever had SEN Support
    were children who were cautioned or sentenced for a serious violence offence.")
  })
  
  # Output - SEN waffle text 2 - sv
  output$waffleText_SEN2_sv <- renderText({
    WaffleText <- SEN_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$prop_SEN_support_SV, "% of children who were cautioned or sentenced for a serious violence offence
    had ever had SEN Support. However, ", WaffleText$prop_also_SEN_support_SV, "% of those who had ever had SEN Support
    were children who were cautioned or sentenced for a serious violence offence.")
  })
  
  # Output - SEN waffle 1 - offenders
  output$waffle_SEN1_any <- renderPlot({
    SEN_waffle_any <- SEN_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_SEN_any(SEN_waffle_any, input$sclLAchoice)
  })
  
  # Output - SEN waffle 2 - offenders
  output$waffle_SEN2_any <- renderPlot({
    SEN_waffle_any <- SEN_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_SEN_any(SEN_waffle_any, input$sclLAchoice2)
  })
  
  # Output - SEN waffle text 1 - offenders
  output$waffleText_SEN1_any <- renderText({
    WaffleText <- SEN_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$prop_SEN_support_any, "% of children who were cautioned or sentenced for an offence
    had ever had SEN Support. However, ", WaffleText$prop_also_SEN_support_any, "% of those who had ever had SEN Support
    were children who were cautioned or sentenced for an offence.")
  })
  
  # Output - SEN waffle text 2 - offenders
  output$waffleText_SEN2_any <- renderText({
    WaffleText <- SEN_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$prop_SEN_support_any, "% of children who were cautioned or sentenced for an offence
    had ever had SEN Support. However, ", WaffleText$prop_also_SEN_support_any, "% of those who had ever had SEN Support
    were children who were cautioned or sentenced for an offence.")
  })
  
  # output - SEN waffle switch 
  output$scl_plot_waf_sen <- renderUI(
    if (input$sen_plot_switch_waf == "sv_off") {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for a serious 
                                                  violence offence and had ever had SEN Support, and all pupils who had ever had SEN Support, for pupils matched 
                                                  to KS4 academic years 2012/13 - 2017/18"), 
        column(h3(textOutput("sclTitle1_SENwaf")),
               width=6, 
               box(width = 12,
                   br(),
                   textOutput("waffleText_SEN1_sv"),
                   br(),
                   plotOutput("waffle_SEN1_sv"), 
                   br())),
        column(h3(textOutput("sclTitle2_SENwaf")),
               width=6, 
               box(width = 12, 
                   br(),
                   textOutput("waffleText_SEN2_sv"),
                   br(),
                   plotOutput("waffle_SEN2_sv"), 
                   br()))
      )
    } else {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for an
            offence and had ever had SEN Support, and all pupils who had ever had SEN Support, for pupils matched 
            to KS4 academic years 2012/13 - 2017/18"), 
        column(h3(textOutput("sclTitle1_SENwaf")),
               width=6, 
               box(width = 12,
                   br(),
                   textOutput("waffleText_SEN1_any"),
                   br(),
                   plotOutput("waffle_SEN1_any"), 
                   br())),
        column(h3(textOutput("sclTitle2_SENwaf")),
               width=6, 
               box(width = 12, 
                   br(),
                   textOutput("waffleText_SEN2_any"),
                   br(),
                   plotOutput("waffle_SEN2_any"), 
                   br()))
      )
    }
  )
  
  # Output - EHCP column 1 LA title
  output$sclTitle1_EHCPwaf <- renderText({
    (EHCP_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - EHCP column 2 LA title
  output$sclTitle2_EHCPwaf <- renderText({
    (EHCP_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - EHCP waffle 1 - sv
  output$waffle_EHCP1_sv <- renderPlot({
    EHCP_waffle_sv <- EHCP_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_EHCP_sv(EHCP_waffle_sv, input$sclLAchoice)
  })

  # Output - EHCP waffle 2 - sv
  output$waffle_EHCP2_sv <- renderPlot({
    EHCP_waffle_sv <- EHCP_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_EHCP_sv(EHCP_waffle_sv, input$sclLAchoice2)
  })

  # Output - EHCP waffle text 1 - sv
  output$waffleText_EHCP1_sv <- renderText({
    WaffleText <- EHCP_waffle_sv %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$prop_EHCP_SV, "% of children who were cautioned or sentenced for a serious violence offence
    had ever had an EHC Plan. However, ", WaffleText$prop_also_EHCP_SV, "% of those who had ever had an EHC Plan
    were children who were cautioned or sentenced for a serious violence offence.")
  })

  # Output - EHCP waffle text 2 - sv
  output$waffleText_EHCP2_sv <- renderText({
    WaffleText <- EHCP_waffle_sv %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$prop_EHCP_SV, "% of children who were cautioned or sentenced for a serious violence offence
    had ever had an EHC Plan. However, ", WaffleText$prop_also_EHCP_SV, "% of those who had ever had an EHC Plan
    were children who were cautioned or sentenced for a serious violence offence.")
  })
  
  # Output - EHCP waffle 1 - offenders
  output$waffle_EHCP1_any <- renderPlot({
    EHCP_waffle_any <- EHCP_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_EHCP_any(EHCP_waffle_any, input$sclLAchoice)
  })
  
  # Output - EHCP waffle 2 - offenders
  output$waffle_EHCP2_any <- renderPlot({
    EHCP_waffle_any <- EHCP_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createWaffle_EHCP_any(EHCP_waffle_any, input$sclLAchoice2)
  })
  
  # Output - EHCP waffle text 1 - offenders
  output$waffleText_EHCP1_any <- renderText({
    WaffleText <- EHCP_waffle_any %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$prop_EHCP_any, "% of children who were cautioned or sentenced for an offence
    had ever had an EHC Plan. However, ", WaffleText$prop_also_EHCP_any, "% of those who had ever had an EHC Plan
    were children who were cautioned or sentenced for an offence.")
  })
  
  # Output - EHCP waffle text 2 - offenders
  output$waffleText_EHCP2_any <- renderText({
    WaffleText <- EHCP_waffle_any %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    paste0(WaffleText$prop_EHCP_any, "% of children who were cautioned or sentenced for an offence
    had ever had an EHC Plan. However, ", WaffleText$prop_also_EHCP_any, "% of those who had ever had an EHC Plan
    were children who were cautioned or sentenced for an offence.")
  })

  # output - EHCP waffle switch 
  output$scl_plot_waf_ehcp <- renderUI(
    if (input$ehcp_plot_switch_waf == "sv_off") {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for a serious violence 
                                                  offence and had ever had an EHC plan, and all pupils who had ever had an EHC plan, for pupils matched to 
                                                  KS4 academic years 2012/13 - 2017/18"), 
        column(h3(textOutput("sclTitle1_EHCPwaf")),
               width=6, 
               box(width = 12, 
                   br(),
                   textOutput("waffleText_EHCP1_sv"),
                   br(),
                   plotOutput("waffle_EHCP1_sv"), 
                   br())),
        column(h3(textOutput("sclTitle2_EHCPwaf")),
               width=6, 
               box(width = 12,
                   br(),
                   textOutput("waffleText_EHCP2_sv"),
                   br(),
                   plotOutput("waffle_EHCP2_sv"), 
                   br()))
      )
    } else {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for an 
            offence and had ever had an EHC plan, and all pupils who had ever had an EHC plan, for pupils matched to 
            KS4 academic years 2012/13 - 2017/18"), 
        column(h3(textOutput("sclTitle1_EHCPwaf")),
               width=6, 
               box(width = 12, 
                   br(),
                   textOutput("waffleText_EHCP1_any"),
                   br(),
                   plotOutput("waffle_EHCP1_any"), 
                   br())),
        column(h3(textOutput("sclTitle2_EHCPwaf")),
               width=6, 
               box(width = 12,
                   br(),
                   textOutput("waffleText_EHCP2_any"),
                   br(),
                   plotOutput("waffle_EHCP2_any"), 
                   br()))
      )
    }
  )

  # Output - SEN timing column 1 LA title
  output$sclTitle1_SENtime <- renderText({
    (SEN_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - SEN timing column 2 LA title
  output$sclTitle2_SENtime <- renderText({
    (SEN_timing %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - SEN timing 1
  output$timing_SEN1 <- renderPlot({
    SEN_timing <- SEN_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createSENTimingPlot(SEN_timing, input$sclLAchoice)
  })

  # Output - SEN timing 2
  output$timing_SEN2 <- renderPlot({
    SEN_timing <- SEN_timing %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createSENTimingPlot(SEN_timing, input$sclLAchoice2)
  })

  # Output - EHCP timing column 1 LA title
  output$sclTitle1_EHCPtime <- renderText({
    (EHCP_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - EHCP timing column 2 LA title
  output$sclTitle2_EHCPtime <- renderText({
    (EHCP_timing %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - EHCP timing 1
  output$timing_EHCP1 <- renderPlot({
    EHCP_timing <- EHCP_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createEHCPTimingPlot(EHCP_timing, input$sclLAchoice)
  })

  # Output - EHCP timing 2
  output$timing_EHCP2 <- renderPlot({
    EHCP_timing <- EHCP_timing %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createEHCPTimingPlot(EHCP_timing, input$sclLAchoice2)
  })

  # Output - SEMH timing column 1 LA title
  output$sclTitle1_SEMHtime <- renderText({
    (SEMH_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice) %>% slice_head())$LA
  })

  # Output - SEMH timing column 2 LA title
  output$sclTitle2_SEMHtime <- renderText({
    (SEMH_timing %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2) %>% slice_head())$LA
  })

  # Output - SEMH timing 1
  output$timing_SEMH1 <- renderPlot({
    SEMH_timing <- SEMH_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createSEMHTimingPlot(SEMH_timing, input$sclLAchoice)
  })

  # Output - SEMH timing 2
  output$timing_SEMH2 <- renderPlot({
    SEMH_timing <- SEMH_timing %>% filter(indicator == input$sclindichoice2, LA == input$sclLAchoice2)
    createSEMHTimingPlot(SEMH_timing, input$sclLAchoice2)
  })

  # Output - CSC column 1 LA title
  output$CSCTitle1 <- renderText({
    (EverCINCLA %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice) %>% slice_head())$LA
  })

  # Output - CSC column 2 LA title
  output$CSCTitle2 <- renderText({
    (EverCINCLA %>% filter(indicator == input$cscindichoice2, LA == input$cscLAchoice2)%>% slice_head())$LA
  })

  # Output - CSC chart 1
  output$CSCPlot1 <- renderPlot({
    EverCINCLA <- EverCINCLA %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice)
    createCSCPlot(EverCINCLA, input$cscLAchoice)
  })

  # Output - CSC chart 2
  output$CSCPlot2 <- renderPlot({
    EverCINCLA <- EverCINCLA %>% filter(indicator == input$cscindichoice2, LA == input$cscLAchoice2)
    createCSCPlot(EverCINCLA, input$cscLAchoice2)
  })

  # Output - CSC plot switch between waffle plots (offenders / sv)
  output$csc_plot_la_waf <- renderUI(
    if (input$csc_plot_switch_waf == "sv_off") {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for a serious violence offence and had ever been CIN, and all pupils who had ever been CIN, for pupils matched to KS4
            academic year 2012/13 - 2017/18"), 
        column(h3(textOutput("CSCTitle1_waf")),
               width=6, 
               box(width = 12,
                   br(),
                   textOutput("waffleText_CIN1_sv"),
                   br(),
                   plotOutput("waffle_CIN1_sv"), 
                   br())), 
        column(h3(textOutput("CSCTitle2_waf")),
               width=6, 
               box(width = 12,
                   br(),
                   textOutput("waffleText_CIN2_sv"),
                   br(),
                   plotOutput("waffle_CIN2_sv"), 
                   br()))
      )
    } else {
      tagList(
        h3("The proportion of children who had been cautioned or sentenced for an offence and had ever been CIN, and all pupils who had ever been CIN, for pupils matched to KS4
            academic year 2012/13 - 2017/18"), 
        column(h3(textOutput("CSCTitle1_waf")),
               width=6, 
               box(width = 12,
                   br(),
                   textOutput("waffleText_CIN1_any"),
                   br(),
                   plotOutput("waffle_CIN1_any"), 
                   br())), 
        column(h3(textOutput("CSCTitle2_waf")),
               width=6, 
               box(width = 12,
                   br(),
                   textOutput("waffleText_CIN2_any"),
                   br(),
                   plotOutput("waffle_CIN2_any"), 
                   br()))
      
      )
    }
  )
  
  # Output - CSC waffle column 1 LA title
  output$CSCTitle1_waf <- renderText({
    (CIN_waffle_sv %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice))$LA
  })

  # Output - CSC waffle column 2 LA title
  output$CSCTitle2_waf <- renderText({
    (CIN_waffle_sv %>% filter(indicator == input$cscindichoice2, LA == input$cscLAchoice2))$LA
  })

  # Output - CIN waffle text 1 - offenders
  output$waffleText_CIN1_any <- renderText({
    WaffleText <- CIN_waffle_any %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice)
    paste0(WaffleText$propany_count_CIN, "% of children who were cautioned or sentenced for an offence
    had ever been CIN. However, ", WaffleText$also_propany_count_CIN, "% of those who had ever been
    CIN were children who were cautioned or sentenced for an offence.")
  })
  
  # Output - CIN waffle text 2 - offenders
  output$waffleText_CIN2_any <- renderText({
    WaffleText <- CIN_waffle_any %>% filter(indicator == input$cscindichoice2, LA == input$cscLAchoice2)
    paste0(WaffleText$propany_count_CIN, "% of children who were cautioned or sentenced for an offence
    had ever been CIN. However, ", WaffleText$also_propany_count_CIN, "% of those who had ever been
    CIN were children who were cautioned or sentenced for an offence.")
  })
  
  # Output - CIN waffle 1 - offenders
  output$waffle_CIN1_any <- renderPlot({
    CIN_waffle_any <- CIN_waffle_any %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice)
    createWaffle_CIN_any(CIN_waffle_any, input$cscLAchoice)
  })
  
  # Output - CIN waffle 2 - offenders
  output$waffle_CIN2_any <- renderPlot({
    CIN_waffle_any <- CIN_waffle_any %>% filter(indicator == input$cscindichoice2, LA == input$cscLAchoice2)
    createWaffle_CIN_any(CIN_waffle_any, input$cscLAchoice2)
  })
  
  # Output - CIN waffle 1 - sv
  output$waffle_CIN1_sv <- renderPlot({
    CIN_waffle_sv <- CIN_waffle_sv %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice)
    createWaffle_CIN_sv(CIN_waffle_sv, input$cscLAchoice)
  })

  # Output - CIN waffle 2 - sv
  output$waffle_CIN2_sv <- renderPlot({
    CIN_waffle_sv <- CIN_waffle_sv %>% filter(indicator == input$cscindichoice2, LA == input$cscLAchoice2)
    createWaffle_CIN_sv(CIN_waffle_sv, input$cscLAchoice2)
  })

  # Output - CIN waffle text 1 - sv
  output$waffleText_CIN1_sv <- renderText({
    WaffleText <- CIN_waffle_sv %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice)
    paste0(WaffleText$propsv_count_CIN, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been CIN. However, ", WaffleText$also_propsv_count_CIN, "% of those who had ever been
    CIN were children who were cautioned or sentenced for a serious violence offence.")
  })

  # Output - CIN waffle text 2 - sv
  output$waffleText_CIN2_sv <- renderText({
    WaffleText <- CIN_waffle_sv %>% filter(indicator == input$cscindichoice2, LA == input$cscLAchoice2)
    paste0(WaffleText$propsv_count_CIN, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been CIN. However, ", WaffleText$also_propsv_count_CIN, "% of those who had ever been
    CIN were children who were cautioned or sentenced for a serious violence offence.")
  })

  # Output - CSC timing column 1 LA title
  output$CSCTitle1_time <- renderText({
    (CSC_timing %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice) %>% slice_head())$LA
  })

  # Output - CSC timing column 2 LA title
  output$CSCTitle2_time <- renderText({
    (CSC_timing %>% filter(indicator == input$cscindichoice2, LA == input$cscLAchoice2) %>% slice_head())$LA
  })

  # Output - CSC timing 1
  output$timing_CSC1 <- renderPlot({
    CSC_timing <- CSC_timing %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice)
    createCSCTimingPlot(CSC_timing, input$cscLAchoice)
  })

  # Output - CSC timing 2
  output$timing_CSC2 <- renderPlot({
    CSC_timing <- CSC_timing %>% filter(indicator == input$cscindichoice2, LA == input$cscLAchoice2)
    createCSCTimingPlot(CSC_timing, input$cscLAchoice2)
  })

  # Stop app ---------------------------------------------------------------------------------

  session$onSessionEnded(function() {
    stopApp()
  })
}
