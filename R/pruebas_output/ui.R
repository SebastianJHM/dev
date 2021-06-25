#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    textInput("txt", "Enter the text to display belów:"),
    textOutput("text"),
    verbatimTextOutput("verb"),
    
    fluidPage(
        fluidRow(
            column(5,
                   uiOutput("moreControls")
            ),
            column(5,
                   uiOutput("moreControls2"),
            )
        )
    ),
    
    actionButton("button", "Guardar",
                 width = "200px", icon("far fa-save"),
                 style = "color: #fff; background-color: #337ab7; border-color: #2e6da4"
    ),
    actionButton("button2", "Guardar",
                 width = "200px", icon("far fa-save"),
                 style = "color: #fff; background-color: #337ab7; border-color: #2e6da4"
    )
))
