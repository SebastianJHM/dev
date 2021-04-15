## Importar data
mtcars <- read.table("C:/Users/USUARIO/Desktop/Programas/R/Curso/mtcars.csv", header = TRUE,  sep = ",")
orangeec <- read.table("C:/Users/USUARIO/Desktop/Programas/R/Curso/orangeec.csv", header = TRUE,  sep = ",")
orangeec

## Visualizar primeros n elementos
head(mtcars, 5)

## Visualizar últimos n elemntos
tail(mtcars,3)

## Seleccion de elementos arbitrariamente
mtcars[c(4,7,23),c("model","mpg","cyl")]