---
title       : Ball Motion
subtitle    : Basic Interactive Physics Experiment
author      : Doroszlai, Attila
job         : 
framework   : io2012
highlighter : highlight.js
hitheme     : tomorrow
widgets     : []
mode        : selfcontained
knit        : slidify::knit2slides
---

## Concept

The [Ball Motion app](https://adoroszlai.shinyapps.io/ball_motion) simulates a ball thrown to the air.  It demonstrates how gravity and initial velocity (speed and angle) affect the trajectory of the ball.

<img src='inputs.png' />

--- 

## Functionality



The app draws 4 plots that dynamically adapt to user input.  Example with ball thrown at 6 m/s initial speed at 42 degrees on the Earth:

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2.png) 

---

## Purpose

Users can find out answers for the following questions and more:

  1. What is the best angle to throw the ball in order to make it land the farthest possible?
  1. Does initial speed affect the shape of the trajectory?
  1. How does the strength of gravity affect the time until the ball hits the ground?

---

## Acknowledgements

Thanks to Louis A. Bloomfield's [How Things Work](https://www.coursera.org/course/howthingswork1) course for the idea.

The app's [source is available on github](https://github.com/adoroszlai/DataProductsAssignment/tree/master).
