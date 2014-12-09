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
                  "Angle (degrees):",
                  min = 0,
                  max = 90,
                  value = 30),
      radioButtons("location", "Location:",
                   choices = list("Earth" = 'earth', "Moon" = 'moon'),
                   selected = 'earth')
    ),

    mainPanel(
      p("This app plots the trajectory of a ball thrown to the air.  You can control initial speed and the angle of the throw.  Select the Earth or the Moon for different gravitational environment."),
      plotOutput("plot")
    )
  )
))
