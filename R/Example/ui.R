library(shiny)

shinyUI(
    fluidPage(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
        ),
        
        
        # App title ----
        titlePanel("Hello Shiny!"),
        
        # Sidebar layout with input and output definitions ----
        sidebarLayout(
            
            # Sidebar panel for inputs ----
            sidebarPanel(
                
                # Input: Slider for the number of bins ----
                sliderInput(inputId = "bins",
                            label = "Number of bins:",
                            min = 1,
                            max = 50,
                            value = 30)
                
            ),
            
            # Main panel for displaying outputs ----
            mainPanel(
                
                # Output: Histogram ----
                plotOutput(outputId = "distPlot")
                
            )
        ),
        p("Hola"),
        tags$div("Que pasa", class = "header"),
        HTML("<div class='header'>Otro Que pasa con clase header</div>"),
        tags$script(src = "myscript.js"),
    )
)