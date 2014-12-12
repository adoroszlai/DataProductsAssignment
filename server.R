library(shiny)
source('functions.R')

shinyServer(function(input, output) {

  gravity <- reactive({ switch (input$location, 'earth' = 9.80665, 'moon' = 1.622) })
  
  # create plots
  output$plot <- renderPlot({
    g <- gravity()
    create_plot(
      calculate_trajectory(g, input$initial_speed, input$angle),
      calculate_plot_limits(g, input$initial_speed)
    )
  })

})
