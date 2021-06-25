myQuestionsPanel <- mainPanel(
  flowLayout(
    selectInput("P1_PT",p(br()),
                choices = list("-"=0,"SI"="SI","NO"="NO"),selected = 0),
    
    dateInput("P1_PT_date",h5(strong("Fecha"), align = "center"),value = Sys.Date())
  ),
  
  flowLayout(
    selectInput("P2_PT",p(br()),
                choices = list("-"=0,"SI"="SI","NO"="NO"),selected = 0),
    
    dateInput("P2_PT_date",h5(strong("Fecha"), align = "center"),value = Sys.Date())
  ),
  
  flowLayout(
    selectInput("P3_PT",p(br()),
                choices = list("-"=0,"SI"="SI","NO"="NO"),selected = 0),
    
    dateInput("P3_PT_date",h5(strong("Fecha"), align = "center"),value = Sys.Date())
  ),
  
  flowLayout(
    selectInput("P4_PT",p(br()),
                choices = list("-"=0,"SI"="SI","NO"="NO"),selected = 0),
    
    dateInput("P4_PT_date",h5(strong("Fecha"), align = "center"),value = Sys.Date())
  )
)