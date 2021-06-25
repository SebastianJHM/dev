#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source(file = "ui_templates/preguntas.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),
    shinyjs::useShinyjs(),
    
    # Application title
    titlePanel("Old Faithful Geyser Data"),

    actionButton("action", "Guardar",width = '200px',icon("far fa-save"), 
                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
    
    
    myQuestionsPanel
    
))
