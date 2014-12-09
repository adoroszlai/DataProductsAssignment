library(shiny)

freq <- 1/100 # frequency with which positions are calculated

# altitude at time t
height <- function(g, vi, angle, t) {
  vi * sin(angle) * t - g * t^2 /2
}
# horizontal distance at time t
distance <- function(vi, angle, t) {
  vi * cos(angle) * t
}
# time when ball reaches max. height
max_height_time <- function(g, vi, angle) {
  vi * sin(angle) / g
}
vertical_speed <- function(g, vi, angle, t) {
  vi * sin(angle) - g * t
}

shinyServer(function(input, output) {

  gravity <- reactive({ switch (input$location, 'earth' = 9.83, 'moon' = 1.622) })
  
  calculate_trajectory <- reactive({
    vi <- input$initial_speed
    angle <- input$angle * pi / 180
    g <- gravity()
    
    max_t <- 2 * max_height_time(g, vi, angle)
    t <- seq(from = 0, to = max_t + freq, by = freq)
    y <- height(g, vi, angle, t)
    x <- distance(vi, angle, t)
    v <- vertical_speed(g, vi, angle, t)
    
    # limit data to y >= 0
    last <- length(x)
    t[last] <- max_t
    y[last] <- 0
    x[last] <- distance(vi, angle, max_t)
    
    data.frame(t, x, y, v)
  })
  
  limits <- reactive({
    vi <- input$initial_speed
    g <- gravity()
    
    # max height if thrown upwards, used to decide plot limits
    max_t <- 2 * max_height_time(g, vi, pi/2)
    max_y <- height(g, vi, pi/2, max_t/2)
    ylim <- c(0, max_y)
    xlim <- 2 * ylim
    tlim <- c(0, max_t)
    vlim <- c(-vi, vi)
    
    data.frame(t = tlim, x = xlim, y = ylim, v = vlim)
  })
  
  output$plot <- renderPlot({
    trajectory <- calculate_trajectory()
    lim <- limits()
    
    par(mfcol=c(2,2))
    # plot altitude vs horizontal position (trajectory)
    plot(trajectory$x, trajectory$y, xlim = lim$x, ylim = lim$y,
      type = 'l', col = 'red', lwd = 2,
      xlab = "Distance (m)", ylab = "Altitude (m)")
    abline(h=0)
    abline(h=max(trajectory$y), col = 'gray')
    
    # plot vertical speed vs horizontal position
    plot(trajectory$x, trajectory$v, xlim = lim$x, ylim = lim$v,
      type = 'l', col = 'blue', lwd = 2,
      xlab = "Distance (m)", ylab = "Vertical speed (m/s)")
    abline(h=0)
    abline(h=min(trajectory$v), col = 'gray')
    abline(h=max(trajectory$v), col = 'gray')
    abline(v=max(trajectory$x), col = 'gray')
    
    # plot altitude vs time
    plot(trajectory$t, trajectory$y, xlim = lim$t, ylim = lim$y,
      type = 'l', col = 'red', lwd = 2,
      xlab = "Time (s)", ylab = "Altitude (m)")
    abline(h=0)
    abline(h=max(trajectory$y), col = 'gray')
    
    # plot vertical speed vs time
    plot(trajectory$t, trajectory$v, xlim = lim$t, ylim = lim$v,
      type = 'l', col = 'blue', lwd = 2,
      xlab = "Time (s)", ylab = "Vertical speed (m/s)")
    abline(h=0)
    abline(h=min(trajectory$v), col = 'gray')
    abline(h=max(trajectory$v), col = 'gray')
    abline(v=max(trajectory$t), col = 'gray')
  })

})
