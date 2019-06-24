library(shiny)


shinyUI(fluidPage(
    titlePanel("Predict Stopping Distance from Car Speed"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderSpeed", "What is the speed of the car?", 1,25, value = 10),
            checkboxInput("showModelA", "Show/Hide Model A", value = TRUE),
            checkboxInput("showModelB", "Show/Hide Model B", value = TRUE)
        ),
        mainPanel(
            plotOutput("plotA"),
            h3("Predicted Stopping Distance from Model A:"),
            textOutput("predA"),
            h3("Predicted Stopping Distance from Model B:"),
            textOutput("predB")
        )
    )
    
))