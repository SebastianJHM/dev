#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source(file = "server_modules/serverPreguntas.R")
source(file = "server_modules/serverNada.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    preguntasServer(input, output)
    printServer(input, output)
})
