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
      p("This app plots the trajectory of a ball thrown to the air."),
      p("You can control initial speed and the angle of the throw using the sliders in the sidebar on the left.  Select the Earth or the Moon for different gravitational environment."),
      p("The plots below show various aspects of the ball's motion for the inputs specified: altitude and vertical speed as functions of horizontal distance and time."),
      plotOutput("plot")
    )
  )
))
