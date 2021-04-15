import sys

def fibonacci_recursivo(n):
    if n == 0 or n == 1:
        return 1

    return fibonacci_recursivo(n - 1) + fibonacci_recursivo(n - 2)

## Los algoritmos de programación dinámica son similares a los recursivos. La
## diferencia es que van guardando los valores calculados, así no tienen que hacer varias 
## veces operaciones que ya se han hecho. Por ejemplo, Fib(6) = Fib(5) + Fib(4), pero
## para calcular Fib(5) se tiene que calcular otra vez Fib(4)

def fibonacci_dinamico(n, memo = {}):
    if n == 0 or n == 1:
        return 1

    try:
        return memo[n]
    except KeyError:
        resultado = fibonacci_dinamico(n - 1, memo) + fibonacci_dinamico(n - 2, memo)
        memo[n] = resultado

        return resultado

if __name__ == '__main__':
    sys.setrecursionlimit(10002) ## Cambiar el número de iteraciones de los algoritmos recursivos
    n = int(input('Escoge un numero: '))
    resultado = fibonacci_dinamico(n)
    print(resultado)