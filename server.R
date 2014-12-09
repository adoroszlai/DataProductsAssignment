library(shiny)

freq <- 1/100 # frequency with which positions are calculated

shinyServer(function(input, output) {

  output$plot <- renderPlot({
    vi <- input$initial_speed
    angle <- input$angle * pi / 180
    g <- switch (input$location, 'earth' = 9.83, 'moon' = 1.622)

    # altitude at time t
    height <- function(angle, t) {
      vi * sin(angle) * t - g * t^2 /2
    }
    # horizontal distance at time t
    distance <- function(angle, t) {
      vi * cos(angle) * t
    }
    # time when ball reaches max. height
    max_height_time <- function(angle) {
      vi * sin(angle) / g
    }
    
    # max height if thrown upwards, used to decide plot limits
    max_height_time_up <- max_height_time(pi/2)
    max_height_up <- height(pi/2, max_height_time_up)
    ylim <- c(0, max_height_up)
    xlim <- 2 * ylim
    
    t <- seq(from = 0, to = 2 * max_height_time_up, by = freq)
    y <- height(angle, t)
    x <- distance(angle, t)
    
    # limit data to y >= 0
    last <- which(y <= 0)[2]
    x[last] <- distance(angle, max_height_time(angle)*2)
    y[last] <- 0
    x <- x[y >= 0]
    y <- y[y >= 0]
    
    # plot trajectory
    plot(x, y, type = 'l', col = 'red', lwd = 2,
      xlim = xlim, ylim = ylim, xlab = "Distance (m)", ylab = "Altitude (m)")
    abline(h=0)
  })

})
