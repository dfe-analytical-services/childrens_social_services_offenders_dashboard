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
    info_table <- info_table %>% filter(indicator==input$indichoice, LA %in% c(input$LAchoice, input$LAchoice2)) %>%
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
    Genderplot <- Gender %>% filter(indicator==input$indichoice, LA==input$LAchoice, group %in% c(input$groupchoice))
    ggplotly(createGenderPlot(Genderplot, input$LAchoice) %>% 
        config(displayModeBar = F))
    })
  
  # Gender plot 2
  output$GenderPlot2 <-  renderPlotly({
    Genderplot <- Gender %>% filter(indicator==input$indichoice, LA==input$LAchoice2, group %in% c(input$groupchoice))
    ggplotly(createGenderPlot(Genderplot, input$LAchoice2) %>%
               config(displayModeBar = F))
  })

  # Ethnicity plot 1
  output$EthPlot1 <-  renderPlotly({
    ethplot <- Ethnicity %>% filter(indicator==input$indichoice, LA==input$LAchoice, group %in% c(input$groupchoice))
    ggplotly(createEthPlot(ethplot, input$LAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Ethnicity plot 2
  output$EthPlot2 <-  renderPlotly({
    ethplot <- Ethnicity %>% filter(indicator==input$indichoice, LA==input$LAchoice2, group %in% c(input$groupchoice))
    ggplotly(createEthPlot(ethplot, input$LAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Output - FSM chart 1
  output$fsmPlot1 <- renderPlotly({
    fsmplot <- FSM %>% filter(indicator==input$indichoice, LA==input$LAchoice, group %in% c(input$groupchoice))
    ggplotly(createFSMPlot(fsmplot, input$LAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Output - FSM chart 2
  output$fsmPlot2 <- renderPlotly({
    fsmplot <- FSM %>% filter(indicator==input$indichoice, LA==input$LAchoice2, group %in% c(input$groupchoice))
    ggplotly(createFSMPlot(fsmplot, input$LAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Output - FSM waffle 1
  output$waffle_FSM1 <- renderPlot({
    FSM_waffle <- FSM_waffle %>% filter(indicator==input$indichoice, LA==input$LAchoice)
    createWaffle_FSM(FSM_waffle, input$LAchoice) 
  })
  
  # Output - FSM waffle 2
  output$waffle_FSM2 <- renderPlot({
    FSM_waffle <- FSM_waffle %>% filter(indicator==input$indichoice, LA==input$LAchoice2)
    createWaffle_FSM(FSM_waffle, input$LAchoice2) 
  })
  
  # Output - age first offence chart 1
  output$ageofplot1 <- renderPlotly({
    age_plot <- age_offence %>% filter(indicator==input$indichoice, LA==input$LAchoice, group %in% c(input$groupchoice))
    ggplotly(createAgeOffence(age_plot, input$LAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Output - age first offence chart 2
  output$ageofplot2 <- renderPlotly({
    age_plot <- age_offence %>% filter(indicator==input$indichoice, LA==input$LAchoice2, group %in% c(input$groupchoice))
    ggplotly(createAgeOffence(age_plot, input$LAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Output - KS2 attainment chart 1
  output$ks2attainplot1 <- renderPlotly({
    KS2_attain <- KS2_attain %>% filter(indicator==input$indichoice, LA==input$LAchoice, group %in% c(input$groupchoice))
    ggplotly(createKS2plot(KS2_attain, input$LAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Output - KS2 attainment chart 2
  output$ks2attainplot2 <- renderPlotly({
    KS2_attain <- KS2_attain %>% filter(indicator==input$indichoice, LA==input$LAchoice2, group %in% c(input$groupchoice))
    ggplotly(createKS2plot(KS2_attain, input$LAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Output - KS4 attainment chart 1
  output$ks4attainplot1 <- renderPlotly({
    KS4_attain <- KS4_attain %>% filter(indicator==input$indichoice, LA==input$LAchoice, group %in% c(input$groupchoice))
    ggplotly(createKS4plot(KS4_attain, input$LAchoice) %>%
               config(displayModeBar = F))
  })
  
  # Output - KS4 attainment chart 2
  output$ks4attainplot2 <- renderPlotly({
    KS4_attain <- KS4_attain %>% filter(indicator==input$indichoice, LA==input$LAchoice2, group %in% c(input$groupchoice))
    ggplotly(createKS4plot(KS4_attain, input$LAchoice2) %>%
               config(displayModeBar = F))
  })
  
  # Stop app ---------------------------------------------------------------------------------

  session$onSessionEnded(function() {
    stopApp()
  })
}
