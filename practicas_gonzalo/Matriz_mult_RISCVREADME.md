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
Este código implementa la multiplicación de matrices usando: <br/>
- **Tres bucles anidados**: <br/>
  - **Externo (i)**: recorre las filas de la matriz **A**. <br/>
  - **Intermedio (j)**: recorre las columnas de la matriz **B**. <br/>
  - **Interno (k)**: realiza la suma acumulada de productos. <br/>

- La dirección de cada elemento se calcula como `i * 3 + j`, ya que cada fila tiene 3 columnas. <br/>

- En cada iteración del bucle interno se realiza el producto: <br/>
<br/><br/><br/><br/>A[i][k] * B[k][j] <br/>
  y se acumula el resultado en una variable temporal. <br/>

- Una vez finalizado el bucle interno, el valor acumulado se guarda en la posición correspondiente de la matriz **C**: <br/>
<br/><br/><br/><br/>C[i][j] = ∑ A[i][k] * B[k][j] <br/>

- Se utilizan registros temporales para cargar los valores desde memoria, multiplicarlos y luego almacenarlos. <br/>

## CAPTURA DE PANTALLA: <br/>