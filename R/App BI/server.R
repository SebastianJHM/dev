

server <- function(input, output,session) {
  

##Descargar informacion
output$downloadData <- downloadHandler(
  filename = function() {
    paste("BASE",".xlsx")
  },
  content = function(file) {
    write_xlsx(BASE, file, col_names = TRUE)
  }
)
 
  
  
  
  
###SI TIENE CUIDADOR
  observeEvent(input$Cuidador,{
    if(input$Cuidador == 1){
    shinyjs::enable("NCuidador")
    shinyjs::enable("TCuidador")
    updateTextInput(session,"NCuidador",value = "")
    updateTextInput(session,"TCuidador",value = "")
    }else{
    updateTextInput(session,"NCuidador",value = "NA")
    updateTextInput(session,"TCuidador",value = 0)
    shinyjs::disable("NCuidador")
    shinyjs::disable("TCuidador")
    }
  })
  
###SI PERTENECE A UN GRUPO ETNICO
  observeEvent(input$GEtnico,{
    if(input$GEtnico==1){
      shinyjs::enable("NGEtnico")
      updateTextInput(session,"NGEtnico",value = "")
    }else{
      shinyjs::disable("NGEtnico")
      updateTextInput(session,"NGEtnico",value = "NA")
    }
  })
 

  
  
###HABILITAR LAS ESCALAS, GUARDAR DATOS INCIIALES
  observeEvent(input$action,{
    
    
    ####GUARDAR DATOS INICIALES
    
              
    
    BASE2 <- BASE %>% filter(TipoID == 8)
    BASE2[1,"TipoID"] <- input$TipoID 
    BASE2[1,"ID"] <- input$ID
    BASE2[1,"date"] <- input$date
    BASE2[1,"Genero"] <- input$Genero
    BASE <- BASE %>% rbind(BASE2)
    
    
    BASE$date <- as.numeric(BASE$date)
    BASE$date <- as.Date(BASE$date, origin = '1970-01-01')
    
    save(BASE,file = "BASE.Rdata")


    
     
    
    ##HABILITAR LAS ESCALAS
    
        #& input$date != Sys.Date()& input$Genero!= 0 & input$FName!="" &input$SName!=""&input$FLName!=""
        #& input$SLName!=""& input$TEL!="" &input$Cel!=""&input$Direccion!=""&input$Ciudad!=""&input$Departamento!=""&input$EPS!=""&input$Regimen!=""
        #&input$Cuidador!=0 & input$NCuidador!="" &input$TCuidador!=""&input$GEtnico!=0 &input$NGEtnico!=""& input$GEspecial!=0 &input$EMedico!=0 
        #& input$Programa!=0
    
    if(input$TipoID != 0 & input$ID != "" ){
      shinyjs::disable("TipoID")
      shinyjs::disable("ID")
      shinyjs::disable("date")
      shinyjs::disable("Genero")
      shinyjs::disable("FName")
      shinyjs::disable("SName")
      shinyjs::disable("FLName")
      shinyjs::disable("SLName")
      shinyjs::disable("TEL")
      shinyjs::disable("Cel")
      shinyjs::disable("Direccion")
      shinyjs::disable("Ciudad")
      shinyjs::disable("Departamento")
      shinyjs::disable("EPS")
      shinyjs::disable("Regimen")
      shinyjs::disable("Cuidador")
      shinyjs::disable("NCuidador")
      shinyjs::disable("TCuidador")
      shinyjs::disable("GEtnico")
      shinyjs::disable("NGEtnico")
      shinyjs::disable("GEspecial")
      shinyjs::disable("EMedico")
      shinyjs::disable("Programa")

      output$recOpt <- renderMenu({
                   menuItem("Escalas obligatorias",tabName = "menu_1",
                            menuSubItem("Mini Mental State",tabName="sub1_1"),
                            menuSubItem("Escala de Barthel",tabName="sub1_2"),
                            menuSubItem("Lawton Brody",tabName="sub1_3"),
                            menuSubItem("APGAR Familiar",tabName="sub1_4")
                   )
      })
      
      output$recOpt2 <- renderMenu({
        menuItem("Escalas adicionales",tabName = "menu_2",
                 menuSubItem("GAD - 2",tabName="sub2_1"),
                 menuSubItem("HAMILTON",tabName="sub2_2"))
      })
      
    }else{
      shinyjs::alert("Complete todas las preguntas")
    }
  })
  
  
###APGAR Familiar
  
observeEvent(input$GApgar,{
  
    
  if(input$AP_P1 != 0 & input$AP_P2 != 0 & input$AP_P3 != 0 & input$AP_P4 != 0 & input$AP_P5 != 0 & input$AP_P6 != 0 & input$AP_P7 != 0 &
     input$AP_P8 != 0 & input$AP_P9 != 0 & input$AP_P10 != 0 ){
    
    shinyjs::disable("AP_P1")
    shinyjs::disable("AP_P2")
    shinyjs::disable("AP_P3")
    shinyjs::disable("AP_P4")
    shinyjs::disable("AP_P5")
    shinyjs::disable("AP_P6")
    shinyjs::disable("AP_P7")
    shinyjs::disable("AP_P8")
    shinyjs::disable("AP_P9")
    shinyjs::disable("AP_P10")
    
    #TotalAP <- input$AP_P1 + input$AP_P2 + input$AP_P3 + input$AP_P4 + input$AP_P5 + input$AP_P6 + input$AP_P7 +input$AP_P8 + input$AP_P9 + input$AP_P10 
    
    TotalAP <- (as.integer(input$AP_P1) + as.integer(input$AP_P2) + as.integer(input$AP_P3) + as.integer(input$AP_P4) + as.integer(input$AP_P5)+ 
      as.integer(input$AP_P6) + as.integer(input$AP_P7) + as.integer(input$AP_P8) + as.integer(input$AP_P9) + as.integer(input$AP_P10))-10
    
    
    if(TotalAP>=18){
      output$Resultado_AP = renderText(paste("Resultado:", TotalAP, "ALTA SATISFACCION: BUENA FUNCION FAMILIAR"))
      output$Resultado_AP_F = renderText(paste("Continuar seguimiento"))
    }
    
    if(TotalAP<=17 & TotalAP>=14){
      output$Resultado_AP = renderText(paste("Resultado:", TotalAP, "MEDIANA SATISFACCION: DISFUNSION LEVE"))
      output$Resultado_AP_F = renderText(paste("Remitir psicologia y/o trabajo social"))
    }
    
    if(TotalAP<=13 & TotalAP>=10){
      output$Resultado_AP = renderText(paste("Resultado:", TotalAP, "BAJA SATISFACCION: DISFUNCION MODERADA"))
      output$Resultado_AP_F = renderText(paste("Remitir psicologia y/o trabajo social"))
    }
    
    if(TotalAP<=9){
      output$Resultado_AP = renderText(paste("Resultado:", TotalAP, "BAJA SATISFACCION: DISFUNSION SEVERA"))
      output$Resultado_AP_F = renderText(paste("Remitir psicologia y/o trabajo social"))
    }
    
    
    
    
  }else{
    shinyjs::alert("Complete todas las preguntas")
  }
  

})
  
  
  
  
  
  
  
  
  
  
  
  
  
}










