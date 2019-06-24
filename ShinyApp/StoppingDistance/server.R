library(shiny)

shinyServer(function(input, output) {
    cars$speedsp <- ifelse(cars$speed - 19 > 0, cars$speed -19, 0)
    modelA <- lm(dist ~ speed - 1, data = cars)
    modelB <- lm(dist ~ speedsp + speed - 1, data = cars)
    
    modelApred <- reactive({
        speedInput <- input$sliderSpeed
        predict(modelA, newdata = data.frame(speed = speedInput))
    })
    
    modelBpred <- reactive({
        speedInput <- input$sliderSpeed
        predict(modelB, newdata =
                    data.frame(speed = speedInput,
                               speedsp = ifelse(speedInput - 19 > 0,
                                                speedInput - 19, 0)))
    })
    output$plotA <- renderPlot({
        speedInput <- input$sliderSpeed
        
        plot(cars$speed, cars$dist, xlab = "Car Speed",
             ylab = "Stopping Distance", bty = "n", pch = 16,
             xlim = c(0,25), ylim = c(0,120))
        if(input$showModelA){
            abline(modelA, col = "red", lwd = 2)
        }
        if(input$showModelB){
            modelBlines <- predict(modelB, newdata = data.frame(
                speed = 1:25, speedsp = ifelse(1:25 - 19 > 0, 1:25 - 19, 0)
            ))
            lines(1:25, modelBlines, col = "blue", lwd = 2)
        }
        legend(1, 100, c("Model B Prediction", "Model B Prediction"), pch = 16,
               col = c("red","blue"), bty = "n", cex = 1.2)
        points(speedInput, modelApred(), col = "red", pch = 16, cex = 2)
        points(speedInput, modelBpred(), col = "blue", pch = 16, cex = 2)
    })
    
    output$predA <- renderText({
        modelApred()
    })
    
    output$predB <- renderText({
        modelBpred()
    })
})
