library(shiny)
library(shinydashboard)
library(plotly)

shinyUI(dashboardPage(
    dashboardHeader(title = "Stopping Distance for Car Speeds",
                    titleWidth = 450),
    dashboardSidebar(disable = TRUE),
    dashboardBody(
        tags$head(tags$style(HTML('
    /* logo */
        .skin-blue .main-header .logo {
                              background-color: #006b6f;
                              font-family: Courier;
                              }
    /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color: #00868B;
                              }'))),
        fluidRow(
            column(width = 4,
                   box(selectInput("model","Select Regression Model:",
                                   c("Linear Regression" = "fit.lm",
                                     "Spline Regression" = "fit.sp")),
                       width = NULL),
                   box(verbatimTextOutput("test.output"),
                       width = NULL),
                   box(sliderInput("slider.speed","What is the car's speed in mph?",0,25, value = 10),
                       width = NULL),
                   box(verbatimTextOutput("pred.output"), title = "The stopping distance in miles is:",
                       width = NULL)),
            column(width = 8,
                   box(plotOutput("modelPlot"), width = NULL),
                   box(plotOutput("resPlot"), width = NULL))
        )
    )
))