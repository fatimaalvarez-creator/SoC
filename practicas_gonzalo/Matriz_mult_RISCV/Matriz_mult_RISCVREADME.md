# Implementación de Multiplicación de Matrices 3x3 en Ensamblador RISC-V 32I
Fátima Álvarez Nuño <br/>
A01645815 <br/>
22/04/25 <br/>
<br/>

## OBJETIVO: <br/>
Implementar la multiplicación de dos matrices de 3x3 en lenguaje ensamblador para la arquitectura RISC-V 32I,
comprendiendo el manejo de memoria, bucles anidados y operaciones aritméticas de bajo nivel.

## INSTRUCCIONES PARA EL DESARROLLO: <br/>
1. Declarar las matrices A y B (3x3) en memoria: <br/>
  * Puedes inicializar con valores constantes. <br/>
  * Cada matriz puede almacenarse en una sección .data. <br/>
2. Implementar la multiplicación: <br/>
  * Utilizar tres bucles anidados (para recorrer filas de A, columnas de B y acumulador de multiplicación).
  * Guardar los resultados en una matriz C (también 3x3).
3. Utilizar registros temporales para acumuladores y direcciones de memoria.
4. Visualizar los resultados:
  * Puedes imprimir los resultados usando una syscall.

## FUNCIONAMIENTO: <br/>
Este programa implementa la multiplicación de dos matrices 3x3 en lenguaje ensamblador RISC-V. El algoritmo sigue el enfoque clásico de multiplicación de matrices donde cada elemento de la matriz resultante se calcula como el producto punto de la fila correspondiente de la primera matriz y la columna correspondiente de la segunda matriz.

El programa comienza definiendo las matrices de entrada A y B en la sección de datos, cada una con valores específicos. También reserva espacio para la matriz resultante C. La matriz A contiene valores como 3, 7, 2 en la primera fila, mientras que la matriz B tiene valores como 5, 8, 3 en su primera fila.

Para realizar la multiplicación, el programa utiliza tres bucles anidados, siguiendo la fórmula matemática estándar:

```assembly
    C[i][j] = suma(A[i][k] * B[k][j]) para k de 0 a 2
```

El bucle externo (i_loop) recorre las filas de la matriz A. Para cada fila i, un segundo bucle (j_loop) recorre las columnas de la matriz B. Para cada combinación (i,j), un tercer bucle interno (k_loop) calcula el producto punto entre la fila i de A y la columna j de B.

Dentro del bucle más interno, el programa primero calcula la dirección en memoria del elemento A[i][k], carga su valor, luego hace lo mismo para B[k][j], multiplica estos valores y acumula el resultado en un registro temporal. Este proceso se repite para k=0, k=1 y k=2, sumando todos los productos para formar un solo elemento de la matriz resultante.

Una vez calculado el valor completo de C[i][j], el programa lo almacena en la posición correspondiente de la matriz C. Este proceso se repite hasta que todos los elementos de la matriz resultante han sido calculados.

El acceso a los elementos de las matrices se realiza mediante aritmética de direcciones. Para acceder al elemento (i,j) de una matriz 3x3, el programa calcula el desplazamiento como (i*3 + j)*4, donde 3 es el número de columnas y 4 es el tamaño en bytes de cada elemento (palabra).

Al finalizar, el programa restaura los registros que había guardado inicialmente y termina su ejecución. El resultado final es una matriz C que contiene el producto de las matrices A y B.

Este código ejemplifica conceptos fundamentales de programación en lenguaje ensamblador como el manejo de memoria, bucles anidados, cálculo de direcciones y el uso eficiente de registros para operaciones matemáticas complejas.

## Explicación paso a paso del código
```assembly
.data
```
Esta directiva indica el inicio de la sección de datos, donde se declaran variables.

```assembly
# Matriz A (3x3)
A: .word 3, 7, 2
   .word 8, 1, 5
   .word 4, 9, 6
```
Define la matriz A de 3x3 con valores específicos. Cada `.word` representa una fila de la matriz.

```assembly
# Matriz B (3x3)
B: .word 5, 8, 3
   .word 2, 7, 9
   .word 1, 4, 6
```
Define la matriz B de 3x3 con valores específicos.

```assembly
# Matriz C (resultado 3x3)
C: .space 36     # 9 elementos * 4 bytes
```
Reserva espacio para la matriz resultado C: 36 bytes (9 elementos de 4 bytes cada uno).

```assembly
.text
```
Marca el inicio de la sección de código.

```assembly
.globl main
```
Declara el símbolo `main` como global para que sea visible al enlazador.

```assembly
main:
```
Etiqueta que marca el inicio de la función principal.

```assembly
    # Guardar registros usados
    addi sp, sp, -16
```
Ajusta el puntero de pila (sp) para reservar 16 bytes.

```assembly
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s2, 0(sp)
```
Guarda los registros que se usarán (ra, s0, s1, s2) en la pila para preservar sus valores.

```assembly
    li s0, 0               # i = 0
```
Inicializa el registro s0 con 0, que servirá como índice i para recorrer filas de A.

```assembly
i_loop:
```
Etiqueta que marca el inicio del bucle externo (filas de A).

```assembly
    li s1, 0               # j = 0
```
Inicializa el registro s1 con 0, que servirá como índice j para recorrer columnas de B.

```assembly
j_loop:
```
Etiqueta que marca el inicio del bucle intermedio (columnas de B).

```assembly
    li t0, 0               # suma = 0
```
Inicializa el registro t0 con 0, que acumulará la suma para el elemento C[i][j].

```assembly
    li s2, 0               # k = 0
```
Inicializa el registro s2 con 0, índice k para el producto punto.

```assembly
k_loop:
```
Etiqueta que marca el inicio del bucle interno (producto punto).

```assembly
    # t1 = A[i][k]
    la t2, A
```
Carga la dirección base de la matriz A en t2.

```assembly
    mul t3, s0, 3
```
Multiplica i (s0) por 3 (número de columnas) para obtener el desplazamiento de fila.

```assembly
    add t3, t3, s2
```
Suma k (s2) para obtener el índice lineal del elemento A[i][k].

```assembly
    slli t3, t3, 2
```
Multiplica por 4 (tamaño de word) mediante un desplazamiento lógico a la izquierda.

```assembly
    add t4, t2, t3
```
Suma el desplazamiento a la dirección base para obtener la dirección de A[i][k].

```assembly
    lw t1, 0(t4)
```
Carga el valor de A[i][k] en t1.

```assembly
    # t5 = B[k][j]
    la t2, B
```
Carga la dirección base de la matriz B en t2.

```assembly
    mul t3, s2, 3
```
Multiplica k (s2) por 3 (número de columnas) para obtener el desplazamiento de fila.

```assembly
    add t3, t3, s1
```
Suma j (s1) para obtener el índice lineal del elemento B[k][j].

```assembly
    slli t3, t3, 2
```
Multiplica por 4 (tamaño de word).

```assembly
    add t4, t2, t3
```
Suma el desplazamiento a la dirección base para obtener la dirección de B[k][j].

```assembly
    lw t5, 0(t4)
```
Carga el valor de B[k][j] en t5.

```assembly
    # suma += A[i][k] * B[k][j]
    mul t6, t1, t5
```
Multiplica A[i][k] (t1) por B[k][j] (t5) y guarda el resultado en t6.

```assembly
    add t0, t0, t6
```
Añade el producto al acumulador suma (t0).

```assembly
    addi s2, s2, 1
```
Incrementa k (s2) en 1.

```assembly
    li t1, 3
```
Carga 3 en t1 (límite del bucle k).

```assembly
    blt s2, t1, k_loop
```
Si k (s2) < 3 (t1), salta a k_loop para continuar el bucle interno.

```assembly
    # Guardar suma en C[i][j]
    la t1, C
```
Carga la dirección base de la matriz C en t1.

```assembly
    mul t2, s0, 3
```
Multiplica i (s0) por 3 para obtener el desplazamiento de fila.

```assembly
    add t2, t2, s1
```
Suma j (s1) para obtener el índice lineal del elemento C[i][j].

```assembly
    slli t2, t2, 2
```
Multiplica por 4 (tamaño de word).

```assembly
    add t3, t1, t2
```
Suma el desplazamiento a la dirección base para obtener la dirección de C[i][j].

```assembly
    sw t0, 0(t3)
```
Almacena el valor acumulado (t0) en C[i][j].

```assembly
    addi s1, s1, 1
```
Incrementa j (s1) en 1.

```assembly
    li t4, 3
```
Carga 3 en t4 (límite del bucle j).

```assembly
    blt s1, t4, j_loop
```
Si j (s1) < 3 (t4), salta a j_loop para continuar el bucle intermedio.

```assembly
    addi s0, s0, 1
```
Incrementa i (s0) en 1.

```assembly
    li t4, 3
```
Carga 3 en t4 (límite del bucle i).

```assembly
    blt s0, t4, i_loop
```
Si i (s0) < 3 (t4), salta a i_loop para continuar el bucle externo.

```assembly
    # Restaurar registros y terminar
    lw s2, 0(sp)
    lw s1, 4(sp)
    lw s0, 8(sp)
    lw ra, 12(sp)
```
Restaura los valores originales de los registros desde la pila.

```assembly
    addi sp, sp, 16
```
Ajusta el puntero de pila para liberar el espacio reservado.

```assembly
    li a7, 10
    ecall
```
Carga el código de syscall 10 (exit) en a7 y ejecuta la llamada al sistema para terminar el programa.

En resumen, este código implementa la multiplicación de matrices 3x3 usando tres bucles anidados: el bucle externo recorre las filas de A, 
el intermedio recorre las columnas de B, y el interno calcula el producto punto para cada elemento de C. Al final, la matriz C contendrá el resultado de A×B.

## CAPTURA DE PANTALLA: <br/>
![Captura de pantalla 2025-04-22 180851](https://github.com/user-attachments/assets/d326a193-9951-4b2a-99e0-d98fbf97e7ef)
