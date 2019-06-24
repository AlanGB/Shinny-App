library(shiny)


shinyUI(fluidPage(
    titlePanel("Predict Stopping Distance from Car Speed"),
    sidebarLayout(
        sidebarPanel(
            fluidRow(
                column(width = 8,
                       sliderInput("sliderSpeed", "What is the speed of the car?", 1,25, value = 10),
                       box(selectInput("model", "Choose Model:", c("Linear Regression" = "modelA",
                                                                   "Spline Regression" = "modelB"), width=NULL)) 
                       )
            )
        ),
        mainPanel(
            plotOutput("plotA"),
            h3("Predicted Stopping Distance for selected Distance"),
            textOutput("pred")
        )
    )
    
))