## Inicializar Matriz
y <- 2:-2
x <- c(34,56,17,32,100)

my_matrix <- matrix(c(x,y), nrow=2, byrow = TRUE)
my_matrix


## Otra forma
x <- matrix(1:12, nrow = 4, ncol = 3, byrow = TRUE)
x

x[1,1]
x[1,]
x[,1]

## Matriz transpuesta
y <- matrix(0, nrow = ncol(x), ncol = nrow(x), byrow = TRUE)
for (i in 1:4){
  for (j in 1:3){
    y[j,i] <- x[i,j]
  }
}
y

## Nombres de filas y de columnas
dias <- c("Lunes", "Martes", "Miercoles", "Jueves", "Viernes")
filas <- c("fila1", "fila2")

colnames(my_matrix) = dias
rownames(my_matrix) = filas
my_matrix

## Agregar columna a la matriz
my_matrix <- cbind(my_matrix, Sabado = c(1, 2))
my_matrix

## Agregar fila a la matriz
my_matrix <- rbind(my_matrix, fila3 = 1:6)
my_matrix

my_matrix["fila2","Lunes"]
