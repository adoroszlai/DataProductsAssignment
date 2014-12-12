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
# vertical speed at time t
vertical_speed <- function(g, vi, angle, t) {
  vi * sin(angle) - g * t
}

# calculate horizontal position, altitude and vertical speed of ball
calculate_trajectory <- function (g, vi, angle) {
  angle <- angle * pi / 180 # convert to radians
  max_t <- 2 * max_height_time(g, vi, angle)
  t <- seq(from = 0, to = max_t + freq, by = freq)
  y <- height(g, vi, angle, t)
  x <- distance(vi, angle, t)
  v <- vertical_speed(g, vi, angle, t)
  
  # make data end at 0 altitude
  last <- length(x)
  t[last] <- max_t
  y[last] <- 0
  x[last] <- distance(vi, angle, max_t)
  
  data.frame(t, x, y, v)
}

# calculate x/y limits of the plots (independent of 'angle')
calculate_plot_limits <- function(g, vi) {
  # max height if thrown upwards, used to decide plot limits
  max_t <- 2 * max_height_time(g, vi, pi/2)
  max_y <- height(g, vi, pi/2, max_t/2)
  ylim <- c(0, max_y)
  xlim <- 2 * ylim
  tlim <- c(0, max_t)
  vlim <- c(-vi, vi)
  
  data.frame(t = tlim, x = xlim, y = ylim, v = vlim)
}

create_plot <- function(trajectory, lim) {
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
}