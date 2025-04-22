# Implementación de Multiplicación de Matrices 3x3 en Ensamblador RISC-V 32I
Fátima Álvarez Nuño <br/>
A01645815 <br/>
22/04/25 <br/>
<br/>

## OBJETIVO: <br/>
Implementar la multiplicación de dos matrices de 3x3 en lenguaje ensamblador para la arquitectura RISC-V 32I,
comprendiendo el manejo de memoria, bucles anidados y operaciones aritméticas de bajo nivel.

# Instrucciones para el Desarrollo: <br/>
1. Declarar las matrices A y B (3x3) en memoria: <br/>
  * Puedes inicializar con valores constantes. <br/>
  * Cada matriz puede almacenarse en una sección .data. <br/>
2. Implementar la multiplicación: <br/>
  * Utilizar tres bucles anidados (para recorrer filas de A, columnas de B y acumulador de multiplicación).
  * Guardar los resultados en una matriz C (también 3x3).
3. Utilizar registros temporales para acumuladores y direcciones de memoria.
4. Visualizar los resultados:
  * Puedes imprimir los resultados usando una syscall.
