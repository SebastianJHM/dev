ui1_template <- fluidPage(

    fluidRow(
        h2(
            tags$img(src="isotipox.png", height='35px', style="margin-right: 0px; margin-bottom: 1px"),
            tags$img(src="logotipox.svg", height='35px'),
            align="center"
        ),
        textInput("usuario_login", placeholder="Username", label = tagList(icon("user"), "Username"), width = "100%"),
        passwordInput("contrasena_login", placeholder="Password", label = tagList(icon("unlock-alt"), "Password"), width = "100%"),
        style="
                border-radius: 5px;
                background: rgba(97, 97, 97, 0.3);
                margin-top: 100px;
                width: 80%;
                max-width: 400px;
                margin-left: auto;
                margin-right: auto;
                padding-left: 20px;
                padding-right: 20px;
            "
        
    ),
    
    uiOutput("credencialesIncorrectas"),
    
    fluidRow(
        actionButton("Entrar", "Entrar",
                     width = "200px",
                     style = "color: #fff; background-color: #337ab7; border-color: #2e6da4"
        ),
        style="margin-top: 35px;",
        align = "center"
    ),
    
    style="
        height: 100vh;
        background: rgba(237, 237, 237, 0.712);
    "
    
)