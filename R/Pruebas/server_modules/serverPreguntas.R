preguntasServer <- function(input, output){
  celsius_to_kelvin <- function(temp_C) {
    temp_K <- temp_C + 273.15
    return(temp_K)
  }
  
  my_logic <- function(i) {
    id <- paste("P",toString(i),"_PT",sep="")
    id_date <- paste("P",toString(i),"_PT_date",sep="")
    observeEvent(input[[id]],{
      if(input[[id]]=="SI"){
        shinyjs::enable(id_date)
      }else{
        shinyjs::disable(id_date)
      }
    })
  }
  
  for (i in 1:4) {
    print(celsius_to_kelvin(i))
    my_logic(i)
  }
}

