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

  # Code to sync inputs across tabs: LA choice
  observeEvent(input$demLAchoice,{
    if(input$navlistPanel=='tab_demo'){
      updateSelectInput(session, "sclLAchoice", selected=input$demLAchoice)
    }
  })

  observeEvent(input$demLAchoice2,{
    if(input$navlistPanel=='tab_demo'){
      updateSelectInput(session, "sclLAchoice2", selected=input$demLAchoice2)
    }
  })
  
  observeEvent(input$sclLAchoice,{
    if(input$navlistPanel=='tab_scl'){
      updateSelectInput(session, "demLAchoice", selected=input$sclLAchoice)
    }
  })
  
  observeEvent(input$sclLAchoice2,{
    if(input$navlistPanel=='tab_scl'){
      updateSelectInput(session, "demLAchoice2", selected=input$sclLAchoice2)
    }
  })
  
  # Code to sync inputs across tabs: indichoice (Home or School)
  observeEvent(input$demindichoice,{
    if(input$navlistPanel=='tab_demo'){
      updateSelectInput(session, "sclindichoice", selected=input$demindichoice)
    }
  })
  
  observeEvent(input$sclindichoice,{
    if(input$navlistPanel=='tab_scl'){
      updateSelectInput(session, "demindichoice", selected=input$sclindichoice)
    }
  })
  
  # Code to sync inputs across tabs: groupchoice (all pupils, offenders, sv offenders)
  observeEvent(input$demgroupchoice,{
    if(input$navlistPanel=='tab_demo'){
      updateSelectInput(session, "sclgroupchoice", selected=input$demgroupchoice)
    }
  })
  
  observeEvent(input$sclgroupchoice,{
    if(input$navlistPanel=='tab_scl'){
      updateSelectInput(session, "demgroupchoice", selected=input$sclgroupchoice)
    }
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
    ggplotly(plotAvgRevBenchmark(reactiveBenchmark()) %>%
      config(displayModeBar = F),
    height = 420
    )
  })

  output$tabBenchmark <- renderDataTable({
    datatable(reactiveBenchmark() %>%
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
      paste0("£", format((reactiveRevBal() %>% filter(
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
  
  # LA  table in Demographics tab
  output$demotable <- renderDataTable({
    info_table <- info_table %>% filter(indicator==input$demindichoice, LA %in% c(input$demLAchoice, input$demLAchoice2)) %>%
      rename("Local authority" = LA,
             "Number of pupils" = all,
             "Number of children cautioned or sentenced\nfor an offence" = offenders,
             "Number of children cautioned or sentences for a serious violence offence" = sv,
             "Proportion of children cautioned or sentenced for\nan offence" = prop_off, 
             "Proportion of children cautioned or sentences for a serious violence offence" = prop_sv, 
             "Number of children cautioned or sentenced for a serious violence offence with a prior offence" = count_previous, 
             "Proportion of children cautioned or sentenced for a serious violence offence with a prior offence" = prop_previous,
             "Number of children who live or go to school in different LA" = count_all_dif, 
             "Number of children cautioned or sentenced for an offence who live or go to school in different LA" = count_any_dif , 
             "Number of children cautioned or sentenced for a serious violence offence who live or go to school in different LA" = count_sv_dif,
             "Proportion of children who live or go to school in different LA" = prop_count_all_dif, 
             "Proportion of children cautioned or sentenced for an offence who live or go to school in different LA" = prop_count_any_dif, 
             "Proportion of children cautioned or sentenced for a serious violence offence who live or go to school in different LA" = prop_count_sv_dif) 
    
    info_table <- t(info_table)
    
  }, rownames = TRUE, options = list(pageLength = 15))  
  
  # Gender plot 1
  output$GenderPlot1 <-  renderPlotly({
    Genderplot <- Gender %>% filter(indicator==input$demindichoice, LA==input$demLAchoice, group %in% c(input$demgroupchoice))
    ggplotly(createGenderPlot(Genderplot, input$demLAchoice) %>% 
        config(displayModeBar = F))
    })
  
  # Gender plot 2
  output$GenderPlot2 <-  renderPlotly({
    Genderplot <- Gender %>% filter(indicator==input$demindichoice, LA==input$demLAchoice2, group %in% c(input$demgroupchoice))
    ggplotly(createGenderPlot(Genderplot, input$demLAchoice2) %>%
               config(displayModeBar = F))
  })

  # Ethnicity plot 1
  output$EthPlot1 <-  renderPlotly({
    ethplot <- Ethnicity %>% filter(indicator==input$demindichoice, LA==input$demLAchoice, group %in% c(input$demgroupchoice))
    ggplotly(createEthPlot(ethplot, input$demLAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Ethnicity plot 2
  output$EthPlot2 <-  renderPlotly({
    ethplot <- Ethnicity %>% filter(indicator==input$demindichoice, LA==input$demLAchoice2, group %in% c(input$demgroupchoice))
    ggplotly(createEthPlot(ethplot, input$demLAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Output - FSM chart 1
  output$fsmPlot1 <- renderPlotly({
    fsmplot <- FSM %>% filter(indicator==input$demindichoice, LA==input$demLAchoice, group %in% c(input$demgroupchoice))
    ggplotly(createFSMPlot(fsmplot, input$demLAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Output - FSM chart 2
  output$fsmPlot2 <- renderPlotly({
    fsmplot <- FSM %>% filter(indicator==input$demindichoice, LA==input$demLAchoice2, group %in% c(input$demgroupchoice))
    ggplotly(createFSMPlot(fsmplot, input$demLAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Output - FSM waffle 1
  output$waffle_FSM1 <- renderPlot({
    FSM_waffle <- FSM_waffle %>% filter(indicator==input$demindichoice, LA==input$demLAchoice)
    createWaffle_FSM(FSM_waffle, input$demLAchoice) 
  })
  
  # Output - FSM waffle 2
  output$waffle_FSM2 <- renderPlot({
    FSM_waffle <- FSM_waffle %>% filter(indicator==input$demindichoice, LA==input$demLAchoice2)
    createWaffle_FSM(FSM_waffle, input$demLAchoice2) 
  })
  
  # Output - age first offence chart 1
  output$ageofplot1 <- renderPlotly({
    age_plot <- age_offence %>% filter(indicator==input$demindichoice, LA==input$demLAchoice, group %in% c(input$demgroupchoice))
    ggplotly(createAgeOffence(age_plot, input$demLAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Output - age first offence chart 2
  output$ageofplot2 <- renderPlotly({
    age_plot <- age_offence %>% filter(indicator==input$demindichoice, LA==input$demLAchoice2, group %in% c(input$demgroupchoice))
    ggplotly(createAgeOffence(age_plot, input$demLAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Output - KS2 attainment chart 1
  output$ks2attainplot1 <- renderPlotly({
    KS2_attain <- KS2_attain %>% filter(indicator==input$demindichoice, LA==input$sclLAchoice, group %in% c(input$sclgroupchoice))
    ggplotly(createKS2plot(KS2_attain, input$sclLAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Output - KS2 attainment chart 2
  output$ks2attainplot2 <- renderPlotly({
    KS2_attain <- KS2_attain %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2, group %in% c(input$sclgroupchoice))
    ggplotly(createKS2plot(KS2_attain, input$sclLAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Output - KS4 attainment chart 1
  output$ks4attainplot1 <- renderPlotly({
    KS4_attain <- KS4_attain %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice, group %in% c(input$sclgroupchoice))
    ggplotly(createKS4plot(KS4_attain, input$sclLAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Output - KS4 attainment chart 2
  output$ks4attainplot2 <- renderPlotly({
    KS4_attain <- KS4_attain %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2, group %in% c(input$sclgroupchoice))
    ggplotly(createKS4plot(KS4_attain, input$LAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Output - PA/PAUO chart 1
  output$PAPlot1 <- renderPlotly({
    EverPAPAUO <- EverPAPAUO %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice, group %in% c(input$sclgroupchoice))
    ggplotly(createPAPlot(EverPAPAUO, input$sclLAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Output - PA/PAUO chart 2
  output$PAPlot2 <- renderPlotly({
    EverPAPAUO <- EverPAPAUO %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2, group %in% c(input$sclgroupchoice))
    ggplotly(createPAPlot(EverPAPAUO, input$sclLAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Output - PA waffle 1
  output$waffle_PA1 <- renderPlot({
    PA_waffle <- PA_waffle %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice)
    createWaffle_PA(PA_waffle, input$sclLAchoice) 
  })
  
  # Output - PA waffle 2
  output$waffle_PA2 <- renderPlot({
    PA_waffle <- PA_waffle %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2)
    createWaffle_PA(PA_waffle, input$sclLAchoice2) 
  })
  
  # Output - PA timing 1
  output$timing_PA1 <- renderPlotly({
    PAPAUO_timing <- PAPAUO_timing %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice)
    createPATimingPlot(PAPAUO_timing, input$sclLAchoice) 
  })
  
  # Output - PA timing 2
  output$timing_PA2 <- renderPlotly({
    PAPAUO_timing <- PAPAUO_timing %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2)
    createPATimingPlot(PAPAUO_timing, input$sclLAchoice2) 
  })
  
  # Output - Sus/Excl 1
  output$SusExclPlot1 <- renderPlotly({
    EverSusExcl <- EverSusExcl %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice)
    createSusExclPlot(EverSusExcl, input$sclLAchoice) 
  })
  
  # Output - Sus/Excl 2
  output$SusExclPlot2 <- renderPlotly({
    EverSusExcl <- EverSusExcl %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2)
    createSusExclPlot(EverSusExcl, input$sclLAchoice2) 
  })
  
  # Output - Suspension waffle 1
  output$waffle_Sus1 <- renderPlot({
    SusExcl_waffle <- SusExcl_waffle %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice)
    createWaffle_Sus(SusExcl_waffle, input$sclLAchoice) 
  })
  
  # Output - Suspension waffle 2
  output$waffle_Sus2 <- renderPlot({
    SusExcl_waffle <- SusExcl_waffle %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2)
    createWaffle_Sus(SusExcl_waffle, input$sclLAchoice2) 
  })
  
  # Output - Exclusion waffle 1
  output$waffle_Excl1 <- renderPlot({
    SusExcl_waffle <- SusExcl_waffle %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice)
    createWaffle_Excl(SusExcl_waffle, input$sclLAchoice) 
  })
  
  # Output - Exclusion waffle 2
  output$waffle_Excl2 <- renderPlot({
    SusExcl_waffle <- SusExcl_waffle %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2)
    createWaffle_Excl(SusExcl_waffle, input$sclLAchoice2) 
  })
  
  # Output - first suspension timing 1
  output$FstSusTime1 <- renderPlotly({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice)
    createSusTimePlot(fst.clst_SusExcl, input$sclLAchoice, "First") 
  })
  
  # Output - first suspension timing 2
  output$FstSusTime2 <- renderPlotly({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2)
    createSusTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "First") 
  })
  
  # Output - closest suspension timing 1
  output$clstSusTime1 <- renderPlotly({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice)
    createSusTimePlot(fst.clst_SusExcl, input$sclLAchoice, "Closest") 
  })
  
  # Output - closest suspension timing 2
  output$clstExclTime2 <- renderPlotly({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "Closest") 
  })
  
  # Output - first suspension timing 1
  output$FstExclTime1 <- renderPlotly({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice, "First") 
  })
  
  # Output - first suspension timing 2
  output$FstExclTime2 <- renderPlotly({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "First") 
  })
  
  # Output - closest suspension timing 1
  output$clstExclTime1 <- renderPlotly({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice, "Closest") 
  })
  
  # Output - closest suspension timing 2
  output$clstExclTime2 <- renderPlotly({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "Closest") 
  })
  
  # Output - AP chart 1
  output$APchart1 <- renderPlotly({
    EverAP <- EverAP %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice, group %in% c(input$sclgroupchoice))
    ggplotly(createAPPlot(EverAP, input$sclLAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Output - AP chart 1
  output$APchart2 <- renderPlotly({
    EverAP <- EverAP %>% filter(indicator==input$sclindichoice, LA==input$sclLAchoice2, group %in% c(input$sclgroupchoice))
    ggplotly(createAPPlot(EverAP, input$sclLAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Stop app ---------------------------------------------------------------------------------

  session$onSessionEnded(function() {
    stopApp()
  })
}
