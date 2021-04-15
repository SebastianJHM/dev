

# Definir donde trabajen
#setwd("//eu.boehringer.com/users/bog/users2/graciaj/Desktop/Proyectos R/Notas_BI")


dashboardPage(
  
              skin = "green",
              # Dashboard Page Setup ----------------------------------------------------
              dashboardHeader(
                title = "VIGOR"
              ),
              
              # Dashboard Sidebar -------------------------------------------------------
              dashboardSidebar(
                sidebarMenu(id="sbmenu",
                            menuItem("Inicio",tabName = "menu_0"),
                            menuItemOutput("recOpt"),
                            menuItemOutput("recOpt2")
                            
                            
                            
                )
              ),
              
              # Dashboard Body ----------------------------------------------------------
              dashboardBody(
                
               
                tabItems( 
                  
                  tabItem("menu_0", h1(strong("Registro"), align = "center"),br(),
                
                          # Dashboard Body ----------------------------------------------------------       
                          
                          shinyjs::useShinyjs(),
                          
                          flowLayout(
                                     selectInput("TipoID",h5(strong("Tipo Identificaci\u00F3n"), align = "center"),choices =list("-"=0,"TI"="TI","CC"="CC","CE"="CE","Otro"="Otro")),
                                     numericInput("ID",h5(strong("Identificacion"),align= "center"),value = ""),
                                     dateInput("date",h5(strong("Fecha de nacimiento"), align = "center"),value = Sys.Date()),
                                     selectInput("Genero",h5(strong("Genero"), align = "center"),choices =list("-"=0,"Femenino"="Femenino","Masculino"="Masculino")),
                                     textInput("FName",h5(strong("1er Nombre"),align= "center")),
                                     textInput("SName",h5(strong("2do Nombre"),align= "center")),
                                     textInput("FLName",h5(strong("1er Apellido"),align= "center")),
                                     textInput("SLName",h5(strong("2do Apellido"),align= "center")),
                                     numericInput("TEL",h5(strong("Telefono"),align= "center"),""),
                                     numericInput("Cel",h5(strong("Celular"),align= "center"),""),
                                     textInput("Direccion",h5(strong("Direccion"),align= "center")),
                                     textInput("Ciudad",h5(strong("Ciudad"),align= "center")),
                                     textInput("Departamento",h5(strong("Departamento"),align= "center")),
                                     textInput("EPS",h5(strong("EPS del paciente"),align= "center")),
                                     textInput("Regimen",h5(strong("Regimen de afiliacion"),align= "center")),
                                     selectInput("Cuidador",h5(strong("Tiene Cuidador"), align = "center"),choices =list("-"=0,"Si"=1,"No"=2)),
                                     textInput("NCuidador",h5(strong("Nombre del cuidador"),align= "center")),
                                     numericInput("TCuidador",h5(strong("Telefono del cuidador"),align= "center"),""),
                                     selectInput("GEtnico",h5(strong("Pertenece a un grupo etnico"), align = "center"),choices =list("-"=0,"Si"=1,"No"=2)),
                                     textInput("NGEtnico",h5(strong("Cual"),align= "center")),
                                     selectInput("GEspecial",h5(strong("Pertenece a un grupo especial"), align = "center"),choices =list("-"=0,"Si"=1,"No"=2)),
                                     selectInput("EMedico",h5(strong("Especialidad medico tratante"), align = "center"),choices =list("-"=0,"Si"=1,"No"=2)),
                                     selectInput("Programa",h5(strong("Programa"), align = "center"),choices =list("-"=0,"Si"=1,"No"=2))
                                     ),
                          br(),
                          br(),
                          fluidRow(actionButton("action", "Guardar",width = '200px',icon("far fa-save"), 
                                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),align= "center"),
                          
                          br(),
                          br(),
                          
                          downloadButton("downloadData", "Download")
                          
                          # Dashboard Body ----------------------------------------------------------
                          ),
                  
                  tabItem("sub1_1",h1(strong("Mini Mental State"), align = "center"),br(),
                          
                          # Dashboard Body ----------------------------------------------------------       
                          shinyjs::useShinyjs(),
                          
                          fluidPage(
                            fluidRow(em(strong("Objetivo de aplicacion:"), "valorar el estado cognoscitivo de las personas adultas mayores.")),
                            
                            br(),
                            br(),
                            
                            flowLayout(
                              selectInput("MinM_P1", p("Pregunta 1:",br(),em("En que ano estamos"),br(),br()),
                                          choices = list("-"=0,"Correcto" = 1, "Incorrecto" = 2)),
                              
                              selectInput("MinM_P2", p("Pregunta 2:",br(),em("En que mes estamos"),br(),br()),
                                          choices = list("-"=0,"Correcto" = 1, "Incorrecto" = 2)),
                              
                              selectInput("MinM_P3", p("Pregunta 3:",br(),em("En que dia estamos"),br(),br()),
                                          choices = list("-"=0,"Correcto" = 1, "Incorrecto" = 2)),
                              
                              selectInput("MinM_P4", p("Pregunta 4:",br(),em("Dia de la semana"),br(),br()),
                                          choices = list("-"=0,"Correcto" = 1, "Incorrecto" = 2)),
                              
                              selectInput("MinM_P5", p("Pregunta 5:",br(),em("Hora (manana - tarde - noche)"),br(),br()),
                                          choices = list("-"=0,"Correcto" = 1, "Incorrecto" = 2)),
                              
                              selectInput("MinM_P6", p("Pregunta 6:",br(),em("En que pais estamos"),br(),br()),
                                          choices = list("-"=0,"Correcto" = 1, "Incorrecto" = 2)),
                              
                              selectInput("MinM_P7", p("Pregunta 7:",br(),em("En que departamento estamos"),br(),br()),
                                          choices = list("-"=0,"Correcto" = 1, "Incorrecto" = 2)),
                              
                              selectInput("MinM_P8", p("Pregunta 8:",br(),em("En que ciudad estamos"),br(),br()),
                                          choices = list("-"=0,"Correcto" = 1, "Incorrecto" = 2)),
                              
                              selectInput("MinM_P9", p("Pregunta 9:",br(),em("En que barrio o localidad (vereda)"),br(),br()),
                                          choices = list("-"=0,"Correcto" = 1, "Incorrecto" = 2)),
                              
                              selectInput("MinM_P10", p("Pregunta 10:",br(),em("Lugar o piso donde nos encontramos")),
                                          choices = list("-"=0,"Correcto" = 1, "Incorrecto" = 2))  
                            ),
                            
                            br(),

                            strong("Pregunta 11"),        
                              br(),
                              em("Repita las siguientes palabras: CASA, MESA, ARBOL. Grabese estas 
                                                        palabras porque mas adelante se las voy a preguntar"),
                            br(),
                            br(),
                            flowLayout(
                              selectInput("MinM_P11a",p(em("Cuantas palabras acerto"),br(),br()),
                                          choices = list("-"=0,"0" = 1, "1" = 2,"2"=3,"3"=4)),

                              numericInput("MinM_P11b",p(em("Numero de ensayos requeridos para acertar las tres palbras"),align= "center"),"-",max = 10,min = 0) 
                            ),
                            
                            br(),
                            
                            strong("Pregunta 12"), 
                            br(),
                            em("Restar de 100 - 7 en forma sucesiva. Pare a la quinta respuesta. Registre un punto por cada 
                               respuesta correcta. (93, 86, 79, 72, 65) - tambien se puede reemplazar por decir los meses del ano al reves 
                               (Diciembre, Noviembre, Octubre...)"),
                            flowLayout(
                              selectInput("MinM_P12",p(br()),
                                          choices = list("-"=0,"0" = 1, "1" = 2,"2"=3,"3"=4,"4"=5,"5"=6 ))
                            ),
                            
                            br(),
                            
                            strong("Pregunta 13"), 
                            br(),
                            em("Recuerde las tres palabras que le repeti antes. Registre el numero de palabras que recuerde."),
                            flowLayout(
                              selectInput("MinM_P13",p(br()),
                                          choices = list("-"=0,"0" = 1, "1" = 2,"2"=3,"3"=4))
                            ),
                            
                            br(),
                            
                            strong("Pregunta 14"), 
                            br(),
                            em("Denominar dos objetos: que es esto (Y senalar un reloj, lapiz, entre otros objetos comunes)."),
                            flowLayout(
                              selectInput("MinM_P14",p(br()),
                                          choices = list("-"=0,"0" = 1, "1" = 2,"2"=3))
                            ),
                            
                            br(),
                            
                            strong("Pregunta 15"), 
                            br(),
                            em("Repetir: En un trigal habia cinco perros. (Marcar 1 punto si el paciente repitio perfectamente)."),
                            flowLayout(
                              selectInput("MinM_P15",p(br()),
                                          choices = list("-"=0,"0" = 1, "1" = 2))
                            ),
                            
                            br(),
                            
                            strong("Pregunta 16"), 
                            br(),
                            em("Comprension: Obedecer una orden en tres etapas: tome la hoja con su mano derecha, doblela por 
                               la mitad y pongala en el suelo (Cada etapa corresponde a 1 punto)"),
                            flowLayout(
                              selectInput("MinM_P16",p(br()),
                                          choices = list("-"=0,"0" = 1, "1" = 2,"2"=3,"3"=4))
                            ),
                            
                            strong("Pregunta 17"), 
                            br(),
                            em("Lea y obedezca las siguientes ordenes, (Marcar 1 punto si el paciente obedecio las ordenes)"),
                            br(),
                            br(),
                            flowLayout(
                              selectInput("MinM_P17a",p(em("Cierre los ojos")),
                                          choices = list("-"=0,"0" = 1, "1" = 2)),
                              
                              selectInput("MinM_P17b",p(em("Escriba una frase")),
                                          choices = list("-"=0,"0" = 1, "1" = 2)),
                              
                              selectInput("MinM_P17C",p(em("Copie el diseno o dibujo"),img(src="Img1.png")),
                                          choices = list("-"=0,"0" = 1, "1" = 2)) 
                            )

                            
                            ),
                          
                          br(),
                          br(),
                          fluidRow(actionButton("GMMental", "Guardar",width = '200px',icon("far fa-save"), 
                                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),align= "center")
                         
                      
                          
                          
                          
                  
                          
                          
                          # Dashboard Body ----------------------------------------------------------
                  ),
                  tabItem("sub1_2",h3("Pagina en constricción1_2")
                          
                          # Dashboard Body ----------------------------------------------------------       
                          
                          
                          
                          # Dashboard Body ----------------------------------------------------------
                  ),
                  tabItem("sub1_3",h3("Liquidacion de Rebates")
                          
                          # Dashboard Body ----------------------------------------------------------       
                    
                          
                          # Dashboard Body ----------------------------------------------------------
                  ),
                  
                  tabItem("sub1_4",h1(strong("APGAR Familiar"), align = "center"),
                          
                          # Dashboard Body ----------------------------------------------------------       
                          
                          shinyjs::useShinyjs(),
                          
                          fluidPage(
                            fluidRow(em(strong("Objetivo de aplicacion:"), "Cuestionario para la evaluacion de la funcionalidad en la familia"))),
                          
                            br(),
                            
                         flowLayout(
                            
                           
                           
                            
                           selectInput("AP_P1", p("Pregunta 1:",br(),em("Le satisface la ayuda que recibe de su familia cuando tiene algun problema y/o necesidad"),br(),br()),
                                        choices = list("-"=0,"Nunca" = 1, "Casi nunca" = 2,
                                                      "Algunas veces" = 3,"Casi siempre"=4,
                                                      "Siempre"=5), selected = 0),
                          
                          selectInput("AP_P2", p("Pregunta 2:",br(),em("Le satisface como en su familia hablan y comparten sus problemas"),br(),br(),br()),
                                     choices = list("-"=0,"Nunca" = 1, "Casi nunca" = 2,
                                                    "Algunas veces" = 3,"Casi siempre"=4,
                                                    "Siempre"=5), selected = 0),
                  
                          selectInput("AP_P3", p("Pregunta 3:",br(),em("Le satisface como en su familia aceptan y apoyan su deseo de emprender nuevas actividades"),br(),br()),
                                      choices = list("-"=0,"Nunca" = 1, "Casi nunca" = 2,
                                                     "Algunas veces" = 3,"Casi siempre"=4,
                                                     "Siempre"=5), selected = 0),
                          
                          selectInput("AP_P4", p("Pregunta 4:",br(),em("Le satisface como su familia expresa afecto y responde a sus emociones tales 
                                                              como rabia, tristeza, amor")),
                                      choices = list("-"=0,"Nunca" = 1, "Casi nunca" = 2,
                                                     "Algunas veces" = 3,"Casi siempre"=4,
                                                     "Siempre"=5), selected = 0),
                          
                          selectInput("AP_P5", p("Pregunta 5:",br(),em("Le satisface como compartimos en mi familia en ambitos generales"),br(),br(),br()),
                                      choices = list("-"=0,"Nunca" = 1, "Casi nunca" = 2,
                                                     "Algunas veces" = 3,"Casi siempre"=4,
                                                     "Siempre"=5), selected = 0),
                          
                          selectInput("AP_P6", p("Pregunta 6:",br(),em("Le satisface como compartimos en mi familia el tiempo para estar juntos"),br(),br()),
                                      choices = list("-"=0,"Nunca" = 1, "Casi nunca" = 2,
                                                     "Algunas veces" = 3,"Casi siempre"=4,
                                                     "Siempre"=5), selected = 0),
                          
                          selectInput("AP_P7", p("Pregunta 7:",br(),em("Le satisface como compartimos en mi familia los espacios en la casa"),br(),br(),br()),
                                      choices = list("-"=0,"Nunca" = 1, "Casi nunca" = 2,
                                                     "Algunas veces" = 3,"Casi siempre"=4,
                                                     "Siempre"=5), selected = 0),
                          
                          selectInput("AP_P8", p("Pregunta 8:",br(),em("Le satisface como compartimos en mi familia el dinero"),br(),br(),br()),
                                      choices = list("-"=0,"Nunca" = 1, "Casi nunca" = 2,
                                                     "Algunas veces" = 3,"Casi siempre"=4,
                                                     "Siempre"=5), selected = 0),
                          
                          selectInput("AP_P9", p("Pregunta 9:",br(),em("Usted tiene un(a) amigo(a) cercano a quien pueda buscar cuando necesite ayuda"),br(),br()),
                                      choices = list("-"=0,"Nunca" = 1, "Casi nunca" = 2,
                                                     "Algunas veces" = 3,"Casi siempre"=4,
                                                     "Siempre"=5), selected = 0),
                          
                          selectInput("AP_P10", p("Pregunta 10:",br(),em("Estoy satisfecho(a) con el soporte que recibo de mis amigos (as)"),br(),br(),br()),
                                      choices = list("-"=0,"Nunca" = 1, "Casi nunca" = 2,
                                                     "Algunas veces" = 3,"Casi siempre"=4,
                                                     "Siempre"=5), selected = 0)
                          

                            
                            
                          ),
              
                          br(),
                          br(),
                          fluidRow(actionButton("GApgar", "Guardar",width = '200px',icon("far fa-save"), 
                                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),align= "center"),
                          br(),
                          textOutput("Resultado_AP"),
                          br(),
                          textOutput("Resultado_AP_F")
                          
                          # Dashboard Body ----------------------------------------------------------
                  ),
                  tabItem("sub2_1",h3("Pagina en constricción2_1")                
                          # Dashboard Body ----------------------------------------------------------       
                          
                          
                          
                          
                          # Dashboard Body ----------------------------------------------------------
                  ),
                  tabItem("sub2_2",h3("Pagina en constricción2_2")
                          
                          # Dashboard Body ----------------------------------------------------------       
                          
                          
                          
                          
                          # Dashboard Body ----------------------------------------------------------
                  )
                                   
                )
              )
)
