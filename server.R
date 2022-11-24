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
      updateSelectInput(session, "cscLAchoice", selected = input$sclLAchoice2)
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

  # Code to sync inputs across tabs: indichoice (Home or School)
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

  # Code to sync inputs across tabs: groupchoice (all pupils, offenders, sv offenders)
  observeEvent(input$demgroupchoice, {
    if (input$navlistPanel == "tab_demo") {
      updateSelectInput(session, "sclgroupchoice", selected = input$demgroupchoice)
      updateSelectInput(session, "cscgroupchoice", selected = input$demgroupchoice)
    }
  })

  observeEvent(input$sclgroupchoice, {
    if (input$navlistPanel == "tab_scl") {
      updateSelectInput(session, "demgroupchoice", selected = input$sclgroupchoice)
      updateSelectInput(session, "cscgroupchoice", selected = input$sclgroupchoice)
    }
  })

  observeEvent(input$cscgroupchoice, {
    if (input$navlistPanel == "tab_csc") {
      updateSelectInput(session, "demgroupchoice", selected = input$cscgroupchoice)
      updateSelectInput(session, "sclgroupchoice", selected = input$cscgroupchoice)
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
  output$demotable <- renderDataTable(
    {
      info_table <- info_table %>%
        filter(indicator == input$demindichoice, LA %in% c(input$demLAchoice, input$demLAchoice2)) %>%
        rename(
          "Local authority" = LA,
          "Number of pupils" = all,
          "Number of children cautioned or sentenced\nfor an offence (%)" = offenders_perc,
          "Number of children cautioned or sentences for a serious violence offence (%)" = sv_perc,
          "[3*] Number of children cautioned or sentenced for a serious violence offence with a prior offence (%)" = prev_perc,
          "Number of children who live or go to school in different LA (%)" = all_dif_perc,
          "Number of children cautioned or sentenced for an offence who live or go to school in different LA (%)" = off_dif_perc,
          "Number of children cautioned or sentenced for a serious violence offence who live or go to school in different LA (%)" = sv_dif_perc
        ) %>%
        select(!indicator)

      info_table <- t(info_table)
    },
    rownames = TRUE,
    options = list(pageLength = 8, searchable = FALSE)
  )

  # Gender plot 1
  output$GenderPlot1 <- renderPlot({
    Genderplot <- Gender %>% filter(indicator == input$demindichoice, LA == input$demLAchoice, group %in% c(input$demgroupchoice))
    createGenderPlot(Genderplot, input$demLAchoice)
  })

  # Gender plot 2
  output$GenderPlot2 <- renderPlot({
    Genderplot <- Gender %>% filter(indicator == input$demindichoice, LA == input$demLAchoice2, group %in% c(input$demgroupchoice))
    createGenderPlot(Genderplot, input$demLAchoice2)
  })

  # Ethnicity plot 1
  output$EthPlot1 <- renderPlot({
    ethplot <- Ethnicity %>% filter(indicator == input$demindichoice, LA == input$demLAchoice, group %in% c(input$demgroupchoice))
    createEthPlot(ethplot, input$demLAchoice)
  })

  # Ethnicity plot 2
  output$EthPlot2 <- renderPlot({
    ethplot <- Ethnicity %>% filter(indicator == input$demindichoice, LA == input$demLAchoice2, group %in% c(input$demgroupchoice))
    createEthPlot(ethplot, input$demLAchoice2)
  })

  # Output - FSM chart 1
  output$fsmPlot1 <- renderPlot({
    fsmplot <- FSM %>% filter(indicator == input$demindichoice, LA == input$demLAchoice, group %in% c(input$demgroupchoice))
    createFSMPlot(fsmplot, input$demLAchoice)
  })

  # Output - FSM chart 2
  output$fsmPlot2 <- renderPlot({
    fsmplot <- FSM %>% filter(indicator == input$demindichoice, LA == input$demLAchoice2, group %in% c(input$demgroupchoice))
    createFSMPlot(fsmplot, input$demLAchoice2)
  })

  # Output - FSM waffle 1
  output$waffle_FSM1 <- renderPlot({
    FSM_waffle <- FSM_waffle %>% filter(indicator == input$demindichoice, LA == input$demLAchoice)
    createWaffle_FSM(FSM_waffle, input$demLAchoice)
  })

  # Output - FSM waffle 2
  output$waffle_FSM2 <- renderPlot({
    FSM_waffle <- FSM_waffle %>% filter(indicator == input$demindichoice, LA == input$demLAchoice2)
    createWaffle_FSM(FSM_waffle, input$demLAchoice2)
  })

  # Output - FSM waffle Text 1
  output$WaffleTextFSM1 <- renderText({
    WaffleText <- FSM_waffle %>% filter(indicator == input$demindichoice, LA == input$demLAchoice)
    paste0(WaffleText$sv_prop_count_FSM, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been eligible for FSM. However, ", WaffleText$also_sv_prop_count_FSM, "% of those who had ever been eligible
    for FSM were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - FSM waffle Text 2
  output$WaffleTextFSM2 <- renderText({
    WaffleText <- FSM_waffle %>% filter(indicator == input$demindichoice, LA == input$demLAchoice2)
    paste0(WaffleText$sv_prop_count_FSM, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been eligible for FSM. However, ", WaffleText$also_sv_prop_count_FSM, "% of those who had ever been eligible
    for FSM were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - age first offence chart 1
  output$ageofplot1 <- renderPlot({
    age_plot <- age_offence %>% filter(indicator == input$demindichoice, LA == input$demLAchoice, group %in% c(input$demgroupchoice))
    createAgeOffence(age_plot, input$demLAchoice)
  })

  # Output - age first offence chart 2
  output$ageofplot2 <- renderPlot({
    age_plot <- age_offence %>% filter(indicator == input$demindichoice, LA == input$demLAchoice2, group %in% c(input$demgroupchoice))
    createAgeOffence(age_plot, input$demLAchoice2)
  })

  # Output - KS2 attainment chart 1
  output$ks2attainplot1 <- renderPlot({
    KS2_attain <- KS2_attain %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice, group %in% c(input$sclgroupchoice))
    createKS2plot(KS2_attain, input$sclLAchoice)
  })

  # Output - KS2 attainment chart 2
  output$ks2attainplot2 <- renderPlot({
    KS2_attain <- KS2_attain %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2, group %in% c(input$sclgroupchoice))
    createKS2plot(KS2_attain, input$sclLAchoice2)
  })

  # Output - KS4 attainment chart 1
  output$ks4attainplot1 <- renderPlot({
    KS4_attain <- KS4_attain %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice, group %in% c(input$sclgroupchoice))
    createKS4plot(KS4_attain, input$sclLAchoice)
  })

  # Output - KS4 attainment chart 2
  output$ks4attainplot2 <- renderPlot({
    KS4_attain <- KS4_attain %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2, group %in% c(input$sclgroupchoice))
    createKS4plot(KS4_attain, input$sclLAchoice2)
  })

  # Output - PA/PAUO chart 1
  output$PAPlot1 <- renderPlot({
    EverPAPAUO <- EverPAPAUO %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice, group %in% c(input$sclgroupchoice))
    createPAPlot(EverPAPAUO, input$sclLAchoice)
  })

  # Output - PA/PAUO chart 2
  output$PAPlot2 <- renderPlot({
    EverPAPAUO <- EverPAPAUO %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2, group %in% c(input$sclgroupchoice))
    createPAPlot(EverPAPAUO, input$sclLAchoice2)
  })

  # Output - PA waffle 1
  output$waffle_PA1 <- renderPlot({
    PA_waffle <- PA_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_PA(PA_waffle, input$sclLAchoice)
  })

  # Output - PA waffle 2
  output$waffle_PA2 <- renderPlot({
    PA_waffle <- PA_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createWaffle_PA(PA_waffle, input$sclLAchoice2)
  })

  # Output - PA waffle text 1
  output$waffleText_PA1 <- renderText({
    WaffleText <- PA_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$sv_prop_count_PA, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been persistently absent. However, ", WaffleText$also_sv_prop_count_PA, "% of those who had ever been persistently absent
             were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - PA waffle text 2
  output$waffleText_PA2 <- renderText({
    WaffleText <- PA_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    paste0(WaffleText$sv_prop_count_PA, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been persistently absent. However, ", WaffleText$also_sv_prop_count_PA, "% of those who had ever been persistently absent
    for FSM were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - PA timing 1
  output$timing_PA1 <- renderPlot({
    PAPAUO_timing <- PAPAUO_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createPATimingPlot(PAPAUO_timing, input$sclLAchoice)
  })

  # Output - PA timing 2
  output$timing_PA2 <- renderPlot({
    PAPAUO_timing <- PAPAUO_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createPATimingPlot(PAPAUO_timing, input$sclLAchoice2)
  })

  # Output - Sus/Excl 1
  output$SusExclPlot1 <- renderPlot({
    EverSusExcl <- EverSusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice, group %in% c(input$sclgroupchoice))
    createSusExclPlot(EverSusExcl, input$sclLAchoice)
  })

  # Output - Sus/Excl 2
  output$SusExclPlot2 <- renderPlot({
    EverSusExcl <- EverSusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2, group %in% c(input$sclgroupchoice))
    createSusExclPlot(EverSusExcl, input$sclLAchoice2)
  })

  # Output - Suspension waffle 1
  output$waffle_Sus1 <- renderPlot({
    SusExcl_waffle <- SusExcl_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_Sus(SusExcl_waffle, input$sclLAchoice)
  })

  # Output - Suspension waffle 2
  output$waffle_Sus2 <- renderPlot({
    SusExcl_waffle <- SusExcl_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createWaffle_Sus(SusExcl_waffle, input$sclLAchoice2)
  })

  # Output - Exclusion waffle 1
  output$waffle_Excl1 <- renderPlot({
    SusExcl_waffle <- SusExcl_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_Excl(SusExcl_waffle, input$sclLAchoice)
  })

  # Output - Exclusion waffle 2
  output$waffle_Excl2 <- renderPlot({
    SusExcl_waffle <- SusExcl_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createWaffle_Excl(SusExcl_waffle, input$sclLAchoice2)
  })

  # Output - sus waffle text 1
  output$waffleText_sus1 <- renderText({
    WaffleText <- SusExcl_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$sv_prop_count_Sus, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been suspended. However, ", WaffleText$also_sv_prop_count_Sus, "% of those who had ever been suspended
           were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - sus waffle text 2
  output$waffleText_sus2 <- renderText({
    WaffleText <- SusExcl_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    paste0(WaffleText$sv_prop_count_Sus, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been suspended. However, ", WaffleText$also_sv_prop_count_Sus, "% of those who had ever been suspended
           were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - Excl waffle text 1
  output$waffleText_excl1 <- renderText({
    WaffleText <- SusExcl_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$sv_prop_count_Excl, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been permanently excluded. However, ", WaffleText$also_sv_prop_count_Excl, "% of those who had ever been permanently
    excluded were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - Excl waffle text 2
  output$waffleText_excl2 <- renderText({
    WaffleText <- SusExcl_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    paste0(WaffleText$sv_prop_count_Excl, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been permanently excluded. However, ", WaffleText$also_sv_prop_count_Excl, "% of those who had ever been permanently
    excluded were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - first suspension timing 1
  output$FstSusTime1 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createSusTimePlot(fst.clst_SusExcl, input$sclLAchoice, "First")
  })

  # Output - first suspension timing 2
  output$FstSusTime2 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createSusTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "First")
  })

  # Output - closest suspension timing 1
  output$clstSusTime1 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createSusTimePlot(fst.clst_SusExcl, input$sclLAchoice, "Closest")
  })

  # Output - closest suspension timing 2
  output$clstSusTime2 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createSusTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "Closest")
  })

  # Output - first Exclusion timing 1
  output$FstExclTime1 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice, "First")
  })

  # Output - first Exclusion timing 2
  output$FstExclTime2 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "First")
  })

  # Output - closest Exclusion timing 1
  output$clstExclTime1 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice, "Closest")
  })

  # Output - closest Exclusion timing 2
  output$clstExclTime2 <- renderPlot({
    fst.clst_SusExcl <- fst.clst_SusExcl %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createExclTimePlot(fst.clst_SusExcl, input$sclLAchoice2, "Closest")
  })

  # Output - AP chart 1
  output$APchart1 <- renderPlot({
    EverAP <- EverAP %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice, group %in% c(input$sclgroupchoice))
    createAPPlot(EverAP, input$sclLAchoice)
  })

  # Output - AP chart 2
  output$APchart2 <- renderPlot({
    EverAP <- EverAP %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2, group %in% c(input$sclgroupchoice))
    createAPPlot(EverAP, input$sclLAchoice2)
  })

  # Output - AP waffle 1
  output$waffle_AP1 <- renderPlot({
    AP_waffle <- AP_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_AP(AP_waffle, input$sclLAchoice)
  })

  # Output - AP waffle 2
  output$waffle_AP2 <- renderPlot({
    AP_waffle <- AP_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createWaffle_AP(AP_waffle, input$sclLAchoice2)
  })

  # Output - AP waffle text 1
  output$waffleText_AP1 <- renderText({
    WaffleText <- AP_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$sv_prop_count_AP, "% of children who were cautioned or sentenced for a serious violence offence
    had ever attended alternative provision. However, ", WaffleText$also_sv_prop_count_AP, "% of those who had ever attended alternative
    provision were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - AP waffle text 2
  output$waffleText_AP2 <- renderText({
    WaffleText <- AP_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    paste0(WaffleText$sv_prop_count_AP, "% of children who were cautioned or sentenced for a serious violence offence
    had ever attended alternative provision. However, ", WaffleText$also_sv_prop_count_AP, "% of those who had ever attended alternative
    provision were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - AP timing 1
  output$timing_AP1 <- renderPlot({
    AP_timing <- AP_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createAPTimingPlot(AP_timing, input$sclLAchoice)
  })

  # Output - AP timing 2
  output$timing_AP2 <- renderPlot({
    AP_timing <- AP_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createAPTimingPlot(AP_timing, input$sclLAchoice2)
  })

  # Output - SEN chart 1
  output$SENchart1 <- renderPlot({
    EverSEN <- EverSEN %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice, group %in% c(input$sclgroupchoice))
    createSENPlot(EverSEN, input$sclLAchoice)
  })

  # Output - SEN chart 2
  output$SENchart2 <- renderPlot({
    EverSEN <- EverSEN %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2, group %in% c(input$sclgroupchoice))
    createSENPlot(EverSEN, input$sclLAchoice2)
  })

  # Output - SEN waffle 1
  output$waffle_SEN1 <- renderPlot({
    SEN_waffle <- SEN_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_SEN(SEN_waffle, input$sclLAchoice)
  })

  # Output - SEN waffle 2
  output$waffle_SEN2 <- renderPlot({
    SEN_waffle <- SEN_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createWaffle_SEN(SEN_waffle, input$sclLAchoice2)
  })

  # Output - EHCP waffle 1
  output$waffle_EHCP1 <- renderPlot({
    EHCP_waffle <- EHCP_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createWaffle_EHCP(EHCP_waffle, input$sclLAchoice)
  })

  # Output - EHCP waffle 2
  output$waffle_EHCP2 <- renderPlot({
    EHCP_waffle <- EHCP_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createWaffle_EHCP(EHCP_waffle, input$sclLAchoice2)
  })

  # Output - SEN waffle text 1
  output$waffleText_SEN1 <- renderText({
    WaffleText <- SEN_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$prop_SEN_support_SV, "% of children who were cautioned or sentenced for a serious violence offence
    had ever had SEN Support. However, ", WaffleText$prop_also_SEN_support_SV, "% of those who had ever had SEN Support
    were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - SEN waffle text 2
  output$waffleText_SEN2 <- renderText({
    WaffleText <- SEN_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    paste0(WaffleText$prop_SEN_support_SV, "% of children who were cautioned or sentenced for a serious violence offence
    had ever had SEN Support. However, ", WaffleText$prop_also_SEN_support_SV, "% of those who had ever had SEN Support
    were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - EHCP waffle text 1
  output$waffleText_EHCP1 <- renderText({
    WaffleText <- EHCP_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    paste0(WaffleText$prop_EHCP_SV, "% of children who were cautioned or sentenced for a serious violence offence
    had ever had an EHC Plan. However, ", WaffleText$prop_also_EHCP_SV, "% of those who had ever had an EHC Plan
    were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - EHCP waffle text 2
  output$waffleText_EHCP2 <- renderText({
    WaffleText <- EHCP_waffle %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    paste0(WaffleText$prop_EHCP_SV, "% of children who were cautioned or sentenced for a serious violence offence
    had ever had an EHC Plan. However, ", WaffleText$prop_also_EHCP_SV, "% of those who had ever had an EHC Plan
    were children who were cautioned or sentenced for a serious violence offence")
  })

  # Output - SEN timing 1
  output$timing_SEN1 <- renderPlot({
    SEN_timing <- SEN_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createSENTimingPlot(SEN_timing, input$sclLAchoice)
  })

  # Output - SEN timing 2
  output$timing_SEN2 <- renderPlot({
    SEN_timing <- SEN_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createSENTimingPlot(SEN_timing, input$sclLAchoice2)
  })

  # Output - EHCP timing 1
  output$timing_EHCP1 <- renderPlot({
    EHCP_timing <- EHCP_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createEHCPTimingPlot(EHCP_timing, input$sclLAchoice)
  })

  # Output - EHCP timing 2
  output$timing_EHCP2 <- renderPlot({
    EHCP_timing <- EHCP_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createEHCPTimingPlot(EHCP_timing, input$sclLAchoice2)
  })

  # Output - SEMH timing 1
  output$timing_SEMH1 <- renderPlot({
    SEMH_timing <- SEMH_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice)
    createSEMHTimingPlot(SEMH_timing, input$sclLAchoice)
  })

  # Output - SEMH timing 2
  output$timing_SEMH2 <- renderPlot({
    SEMH_timing <- SEMH_timing %>% filter(indicator == input$sclindichoice, LA == input$sclLAchoice2)
    createSEMHTimingPlot(SEMH_timing, input$sclLAchoice2)
  })

  # Output - CSC chart 1
  output$CSCPlot1 <- renderPlot({
    EverCINCLA <- EverCINCLA %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice, group %in% c(input$cscgroupchoice))
    createCSCPlot(EverCINCLA, input$cscLAchoice)
  })

  # Output - CSC chart 2
  output$CSCPlot2 <- renderPlot({
    EverCINCLA <- EverCINCLA %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice2, group %in% c(input$cscgroupchoice))
    createCSCPlot(EverCINCLA, input$cscLAchoice2)
  })

  # Output - CIN waffle 1
  output$waffle_CIN1 <- renderPlot({
    CIN_waffle <- CIN_waffle %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice)
    createWaffle_CIN(CIN_waffle, input$cscLAchoice)
  })

  # Output - CIN waffle 2
  output$waffle_CIN2 <- renderPlot({
    CIN_waffle <- CIN_waffle %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice2)
    createWaffle_CIN(CIN_waffle, input$cscLAchoice2)
  })

  # Output - CIN waffle text 1
  output$waffleText_CIN1 <- renderText({
    WaffleText <- CIN_waffle %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice)
    paste0(WaffleText$propsv_count_CIN, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been CIN on 31st March in any given year. However, ", WaffleText$also_propsv_count_CIN, "% of those who had ever been 
    CIN on 31st March in any given year were children who were cautioned or sentenced for a serious violence offence")
  })
  
  # Output - CIN waffle text 2
  output$waffleText_CIN2 <- renderText({
    WaffleText <- CIN_waffle %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice2)
    paste0(WaffleText$propsv_count_CIN, "% of children who were cautioned or sentenced for a serious violence offence
    had ever been CIN on 31st March in any given year. However, ", WaffleText$also_propsv_count_CIN, "% of those who had ever been 
    CIN on 31st March in any given year were children who were cautioned or sentenced for a serious violence offence")
  })
  
  # Output - CSC timing 1
  output$timing_CSC1 <- renderPlot({
    CSC_timing <- CSC_timing %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice)
    createCSCTimingPlot(CSC_timing, input$cscLAchoice)
  })

  # Output - CSC timing 2
  output$timing_CSC2 <- renderPlot({
    CSC_timing <- CSC_timing %>% filter(indicator == input$cscindichoice, LA == input$cscLAchoice2)
    createCSCTimingPlot(CSC_timing, input$cscLAchoice2)
  })

  # Stop app ---------------------------------------------------------------------------------

  session$onSessionEnded(function() {
    stopApp()
  })
}
