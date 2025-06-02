# 🧠 System on Chip (SoC) - Proyectos y Prácticas

Este repositorio contiene los proyectos, prácticas y recursos desarrollados durante el curso de **System on Chip (SoC)**. El objetivo de esta materia es diseñar, implementar y probar sistemas embebidos complejos en un solo chip, integrando módulos de procesamiento, control, comunicación y periféricos.

## 📚 Contenido del repositorio
`
SoC/
├── README.md                                  <- README principal del repositorio
└── practicas_gonzalo/                         <- Directorio para las prácticas
    ├── Matriz_mult_RISCV/                     <- Práctica: Multiplicación de Matrices en RISC-V
    │   ├── Matriz_mult_RISCV.txt              <- Código de la multiplicación de matrices (quizás ensamblador o datos)
    │   └── README.md                          <- README específico de esta práctica
    └── Single_cycle_RISCV/                    <- Práctica: Procesador RISC-V de Ciclo Único
        ├── simulation/questa                  <- Archivos de simulación (e.g., resultados, logs)
        ├── .gitignore                         <- Archivo para ignorar archivos en Git
        ├── README.md                          <- README específico de esta práctica
        ├── RISCV.qpf                          <- Archivo de proyecto Quartus (o similar)
        ├── RISCV.qsf                          <- Archivo de configuración de Quartus (o similar)
        ├── alu.v                              <- Módulo de la Unidad Aritmético-Lógica (ALU)
        ├── alu_decoder.v                      <- Módulo decodificador de la ALU
        ├── control_unit.v                     <- Módulo de la Unidad de Control
        ├── data_memory.v                      <- Módulo de la Memoria de Datos
        ├── extend.v                           <- Módulo de Extensión de Inmediatos
        ├── image.png                          <- Imagen de evidencia de simulación
        ├── instruction_memory.v               <- Módulo de la Memoria de Instrucciones
        ├── instructions.txt                   <- Archivo de texto con las instrucciones de prueba
        ├── main_decoder.v                     <- Módulo decodificador principal
        ├── program_counter.v                  <- Módulo del Program Counter (PC)
        ├── register_file.v                    <- Módulo del Archivo de Registros
        ├── single_cycle_RISCV.v               <- Módulo principal del procesador de ciclo único
        └── single_cycle_RISCV_tb.v            <- Testbench para el procesador de ciclo único
`

## 🛠️ Tecnologías y herramientas

- 🧬 **Verilog HDL / VHDL**
- 🔧 **Intel Quartus Prime / Vivado**
- 🧪 **ModelSim / GTKWave** para simulación
  
