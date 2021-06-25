source("./ui1.R")
source("./ui2.R")
library(digest)


shinyServer(function(input, output) {
    output$screen <- renderUI({
        ui1_template
    })
    
    observeEvent(input$Entrar, {
        
        if ( digest(input$contrasena_login, "sha256", serialize = FALSE) == "2d711642b726b04401627ca9fbac32f5c8530fb1903cc4db02258717921a4881" ) {
            output$screen <- renderUI({
                ui2_template
            })
            output$credencialesIncorrectas <- renderUI({})
            
        } else {
            output$credencialesIncorrectas <- renderUI({
                fluidRow(
                    p(icon("fas fa-exclamation-circle", lib = "font-awesome"), strong("El usuario o la contraseña ingresada no son correctos"), style="color: red;"),
                    style="
                        margin-top: 20px;
                        width: 80%;
                        max-width: 400px;
                        margin-left: auto;
                        margin-right: auto;
                        padding: 0:
                    "
                    
                )
            })
        }
        
    })
    
    observeEvent(input$Salir, {

        output$screen <- renderUI({
            ui1_template
        })
        
        
        
    })
    
})