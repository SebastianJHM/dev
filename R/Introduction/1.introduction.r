#Asignar variables
x <- 5
y <- 3
print(x+y)

## Cargar dataset
mtcars <- read.table("C:/Users/USUARIO/Desktop/dev/R/Introduction/mtcars.csv", header = TRUE,  sep = ",")
mtcars

## Estructura del dataset
str(mtcars)

## Cambiar el tipo de dato de cierta columna
mtcars <- transform(mtcars, vs = as.logical(vs))
str(mtcars)

# Otra forma de convertir el tipo de dato
mtcars$vs = as.logical(mtcars$vs)
mtcars$am = as.logical(mtcars$am)
class(mtcars$vs)
class(mtcars$am)
str(mtcars)

## Transformar columna
mtcars_new <- transform(mtcars, wt = wt*2.2)
mtcars_new



## DATASET: orangeec
orangeec <- read.table("C:/Users/USUARIO/Desktop/Programas/R/Curso/orangeec.csv", header = TRUE,  sep = ",")
summary(orangeec)



