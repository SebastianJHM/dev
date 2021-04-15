## Cargar dataset
mtcars <- read.table("C:/Users/USUARIO/Desktop/Programas/R/Curso/mtcars.csv", header = TRUE,  sep = ",")
mtcars

## Mostrar las filas que tienen cy menor  que 6
filter_dataset <- mtcars[mtcars$cy<7,]
filter_dataset

## Mostrar algunas columnas
filter_dataset[c("model","mpg","cyl","disp")]

## Cargar datos orangeec
orangeec <- read.table("C:/Users/USUARIO/Desktop/Programas/R/Curso/orangeec.csv", header = TRUE,  sep = ",")

## Filtrar dos columnas y seleccionar todos los nombres
new_orangeec <- subset(orangeec, Internet.penetration...population > 80
                       & Education.invest...GDP >= 4.5,
                       select = names(orangeec))
new_orangeec

new_orangeec <- subset(orangeec, Internet.penetration...population > 80
                       & Education.invest...GDP >= 4.5,
                       select = c(Country,Internet.penetration...population,Median.age))
new_orangeec

## Todas las columnas del dataframe
names(orangeec)

## Renombrar una columna
olnames(new_orangeec)[which(names(new_orangeec) == "Internet.penetration...population")] <- "Otro nombre"
new_orangeec

## Librería dplyr
require("dplyr")
glimpse(orangeec)

select(new_orangeec,Country,Internet.penetration...population,Median.age)