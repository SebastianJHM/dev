vector_numerico <- c(5,3,2)
vector_numerico2 <- c(1,2,3)
vector_numerico3 <- vector_numerico + vector_numerico2
vector_numerico3

vector_caracteres <- c("Lunes", "Martes", "Miercoles", "Jueves", "Viernes")
vector_caracteres

vector_bool <- c(TRUE, FALSE, FALSE)
vector_bool

x <- c(1, 5.4, TRUE, "hello")
x

y <- 2:-2
y

x <- seq(1, 3, by=0.2)
x

x <- c(34,56,17,32,100)
x

x[1] # >34

x[c(1,3)] # >34,17

x[c(2.4, 3.54)] # >56, 17

x[c(TRUE, FALSE, FALSE, TRUE, TRUE)] # > 34,32,100

x[x>33]

z <- c(x,y)
z



