#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$text <- renderText({ input$txt })
    output$verb <- renderText({ input$txt })
    
    titulo <- "HOla"
    observeEvent(input$button, {
        output$moreControls <- renderUI({
            fluidPage(
                h1(paste(titulo, "jajaj"), align="center"),
                br(),
                p("x"),
                style="
                    background: rgba(97, 97, 97, 0.3);
                    box-shadow: 0 0 0 10px rgba(30, 77, 83, 0.5);
                "
            )
        })
    })
    
    
    
    observeEvent(input$button2, {
        output$moreControls2 <- renderUI({
            fluidPage(
                h1(input$txt, align="center"),
                br(),
                p("x"),
                style="
                    border-radius: 10px;
                    background: rgba(97, 97, 97, 0.3); 
                    margin-top: 10px;
                    box-shadow: 5px 5px rgba(0, 0, 0, 0.1);"
            )
        })
    })
    
})
