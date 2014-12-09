library(shiny)

shinyUI(fluidPage(

  titlePanel("Ball Motion"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("initial_speed",
                  "Initial speed (m/s):",
                  min = 1,
                  max = 10,
                  value = 5),
      sliderInput("angle",
                  "Angle (degrees)",
                  min = 0,
                  max = 90,
                  value = 30),
      radioButtons("location", "Location",
                   choices = list("Earth" = 'earth', "Moon" = 'moon'),
                   selected = 'earth')
    ),

    mainPanel(
      plotOutput("plot")
    )
  )
))
