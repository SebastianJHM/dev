library(shinydashboard)
ui2_template <- dashboardPage(
    dashboardHeader(title = "Basic dashboard", style = "background-color: #337ab7;"),
    dashboardSidebar(
        actionButton("Salir", "Salir",
                     width = "200px",
                     style = "color: red; background-color: #337ab7; border-color: #2e6da4"
        )
    ),
    dashboardBody(
        
    )
)
