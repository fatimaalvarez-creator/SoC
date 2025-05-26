# Implementación de Single cycle en RISCV
Fátima Álvarez Nuño <br/>
A01645815 <br/>
25/05/25 <br/>
<br/>

## Objetivo

Este proyecto implementa un procesador **RISC-V** en arquitectura **single-cycle**, donde cada instrucción se ejecuta en un solo ciclo de reloj. El diseño está desarrollado en Verilog e incluye módulos que representan la memoria de instrucciones, unidad de control, ALU, registros, extensión de inmediato y memoria de datos.

---

## 📦 Descripción de cada módulo

### `single_cycle_RISCV.v`
Módulo principal que interconecta todos los componentes del procesador.

### `single_cycle_RISCV_tb.v`
Testbench para el módulo `single_cycle_RISCV`. Ggenera un reloj, simula 20 ciclos, y muestra la evolución del `PC`, la instrucción actual y el contenido de registros clave.

### `alu_decoder.v`
Decodifica señales específicas (`funct3`, `funct7_5`, `op[5]`, y `alu_op`) para generar el código de control (`alu_control`) que selecciona la operación a realizar por la ALU. Incluye soporte para instrucciones tipo R y operaciones como `add`, `sub`, `and`, `or`, `slt`.

### `alu.v`
Implementa la ALU (Unidad Aritmético-Lógica) que realiza operaciones como suma, resta, AND, OR y comparación (`SLT`). También activa la señal `zero` si el resultado de la operación es cero.

### `control_unit.v`
Integra los módulos `main_decoder` y `alu_decoder` para generar todas las señales de control necesarias para el funcionamiento del procesador. Toma como entrada la instrucción y produce señales como `branch`, `jump`, `mem_write`, `alu_src`, `reg_write`, `imm_src`, `result_src` y `alu_control`.

### `data_memory.v`
Simula una memoria de datos de 32 bits. Permite operaciones de lectura y escritura condicionadas por la señal `WE` (Write Enable).

### `extend.v`
Realiza la extensión de signo de los operandos inmediatos. Soporta instrucciones tipo I, S, B y J según el valor de `imm_src`. Convierte los campos inmediatos a valores de 32 bits con extensión de signo.

### `instruction_memory.v`
Memoria de instrucciones que carga instrucciones desde un archivo externo (`instructions.txt`) al inicio. Usa la dirección del `PC` para acceder a la instrucción correspondiente.

### `main_decoder.v`
Este módulo se encarga de generar las señales de control principales a partir del campo `op` de la instrucción. Aunque en el fragmento compartido no está completo, se espera que emita señales como `branch`, `jump`, `mem_write`, `alu_src`, `reg_write`, `result_src`, `imm_src`, y `alu_op`.

### `main_decoder_tb.v`
Testbench para el módulo `main_decoder`. Simula diferentes valores de `op` y verifica la salida de señales de control para distintas instrucciones (`lw`, `sw`, `R-type`, `beq`, `jal`).

---

## 📁 Archivos Adicionales

- `instructions.txt`: Archivo de texto que contiene las instrucciones a ser cargadas en la memoria de instrucciones (`instruction_memory`).

---


## Diagrama del camino de datos completo.
El camino de datos del procesador RISC-V de un solo ciclo implementa todos los componentes necesarios para ejecutar una instrucción en un solo ciclo de reloj. El diseño incluye:

* PC (Program Counter): Registra la dirección de la siguiente instrucción a ejecutar.
* Instruction Memory: Devuelve la instrucción codificada en la dirección especificada por el PC.
* Register File: Lee dos registros fuente y escribe un registro destino.
* Unidad de Control (Control Unit): Genera señales de control basadas en el opcode y los campos de función de la instrucción.
* Extensor de Inmediato (Extend): Expande los campos de inmediato de 12 o 20 bits a 32 bits, según el tipo de instrucción.
* ALU (Unidad Aritmético-Lógica): Ejecuta operaciones aritméticas o lógicas.
* Memoria de Datos (Data Memory): Se accede en instrucciones tipo lw o sw.
* Multiplexores (MUXes): Permiten seleccionar entre diferentes rutas de datos, como entre inmediato o registro, y entre datos de la ALU o de memoria.
* Adders: Calculan PC + 4 y PC + inmediato para instrucciones de salto o ramificación.
* MUX final para el resultado: Determina si se escribe en el registro el resultado de la ALU o la lectura de memoria. 

### Diagrama en ASCII:
                               +--------------------+
                               |                    |
                               |     Program        |
                               |     Counter (PC)   |
                               |                    |
                               +---------+----------+
                                         |
                                         v
                               +--------------------+
                               |                    |
                               | Instruction Memory |
                               |                    |
                               +---------+----------+
                                         |
                                         v
                              +----------+-----------+
                              |                      |
                              |   Instruction [31:0] |
                              |                      |
                              +----------+-----------+
                                         |
    +------------------------+-----------+------------+------------------------+
    |                        |                        |                        |
    v                        v                        v                        v
+--------+           +---------------+         +------------+          +----------------+
| immext |<----------|  Imm. Extend  |         |  Control   |<---------|   Main Decoder  |
+--------+           +---------------+         +------------+          +----------------+
   |                        |                           |                          |
   |                        |                           v                          |
   |                        |                   +---------------+                 |
   |                        |                   |               |                 |
   |                        |                   |   ALU Control |                 |
   |                        |                   +---------------+                 |
   |                        |                           |                          |
   |                        |                           v                          |
   |              +---------+---------+       +---------+----------+               |
   |              |                   |       |                    |               |
   +------------->|     MUX (ALU)     +------->        ALU         +---------------+
                  | (Reg2 or Immext) |       |                    |
                  +---------+--------+       +----------+---------+
                            |                          |
                            v                          v
                     +--------------+          +-------------------+
                     | Register File|          |     Data Memory   |
                     |              |<---------|                   |
                     +--------------+          +-------------------+
                            |
                            v
                   +-------------------+
                   |       MUX         |
                   | (ALU/Data Memory) |
                   +--------+----------+
                            |
                            v
                     +-------------+
                     | Write Back  |
                     | to Reg File |
                     +-------------+


---

## 🧪 Evidencia de Simulación


## Conclusión
El procesador es capaz de ejecutar instrucciones tipo R, I, S, B y J.
La simulación confirma el correcto flujo de datos y control.