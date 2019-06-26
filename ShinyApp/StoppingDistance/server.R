library(shiny)

shinyServer(function(input, output){
    cars$speedsp <- ifelse(cars$speed - 19 > 0, cars$speed - 19, 0)
    fit.lm <- lm(dist ~ speed - 1, data = cars)
    fit.sp <- lm(dist ~ speedsp + speed - 1, data = cars)

    modelApred <- reactive({
        speedInput <- input$slider.speed
        predict(fit.lm, newdata = data.frame(speed = speedInput))
    })
    modelBpred <- reactive({
        speedInput <- input$slider.speed
        predict(fit.sp, newdata =
                    data.frame(speed = speedInput,
                               speedsp = ifelse(speedInput -19 > 0,speedInput -19,0)))
    })    
    
    output$modelPlot <- renderPlot({
        plot(cars$speed, cars$dist, xlab = "Car Speed (mph)",
             ylab = "Stopping Distance (miles)", bty = "n", pch = 16,
             xlim = c(0,25), ylim = c(0,120))
        if(input$model == "fit.lm"){
            abline(fit.lm, col = "red", lwd = 2)
            points(input$slider.speed, modelApred(), col = "red", pch = 16, cex = 2)
            
        } else if(input$model == "fit.sp"){
            modelBlines <- predict(fit.sp, newdata = data.frame(
                speed = 1:25, speedsp = ifelse(1:25 - 19 > 0, 1:25 - 19, 0)
            ))
            lines(1:25, modelBlines, col = "blue", lwd = 2)
            points(input$slider.speed, modelBpred(), col = "blue", pch = 16, cex = 2)
        }
 
    })
    
    output$resPlot <- renderPlot({
        par(mfrow = c(1,4))
        
        if(input$model == "fit.lm"){
            plot(fit.lm)
        } else if(input$model == "fit.sp"){
            plot(fit.sp)
        }
    })
    
    output$test.output <- renderPrint({
        if(input$model == "fit.lm"){
            print(fit.lm)
        } else if(input$model == "fit.sp"){
            print(fit.sp)
        }
    })
    
    output$pred.output <- renderText({
        if(input$model == "fit.lm"){
            round(modelApred(), digits = 2)
        } else if(input$model == "fit.sp"){
            round(modelBpred(), digits = 2)
        }
    })
    
})