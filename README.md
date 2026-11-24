# Solitario de Pirámide — Pharo 12

Trabajo Práctico Integrador (5° Instancia de Evaluación — Programación Orientada a Objetos)**  
Institución:** Universidad Tecnológica Nacional — Facultad Regional Resistencia (UTN FRRe)  
Comisión: (K2.1)  
Repositorio: https://github.com/RetamozoIvo/solitario-piramide

### Integrantes
- Daniel Agustín, Almada.
- Tomas, Hernán Adrian.
- Sol Magali, Avalos.
- Ivo Luciano Emanuel, Retamozo Cabaña.
- Milagros Belén, Ruiz Diaz.

# Ejecución del Juego
1. Abrir PlayGround en Pharo 
2. Escribir: VentanaSolitario abrir
3. Ejecutar

---

## Descripción

Implementación en Smalltalk (Pharo 12) del juego "Solitario de Pirámide", diseñada bajo el paradigma de Programación Orientada a Objetos con separación estricta entre el modelo de dominio (`SolitarioPiramide-Modelo`) y la interfaz gráfica Morphic (`SolitarioPiramide-UI`).

### Reglas y aportes originales incorporados
* **Mecánica clásica:** pirámide de 7 filas (28 cartas) y pozo auxiliar con reserva de 24 cartas. Se eliminan pares de cartas libres cuyos valores sumen 13 (`A = 1`, `J = 11`, `Q = 12`) o reyes (`K = 13`) de forma individual.
* **Mazo temático UTN FRRe:** las 52 cartas sustituyen los palos tradicionales por ilustraciones personalizadas de cuatro especialidades de ingeniería de la facultad:
  * **Tréboles (`ISI`):** Ingeniería en Sistemas de Información
  * **Corazones (`IQ`):** Ingeniería Química
  * **Diamantes (`IM`):** Ingeniería Mecatrónica
  * **Picas (`IEM`):** Ingeniería Electromecánica
  * **Reverso de la reserva:** incluye el logotipo institucional (`assets/LOGO.png`).
* **Reversión de movimientos (*Deshacer*):** historial completo que permite revertir eliminaciones de pares, eliminaciones de reyes, robos de la reserva y reciclajes del pozo.
* **Reciclaje del pozo:** cuando la reserva queda vacía y existen cartas en el descarte, permite mezclar y devolver el descarte a la reserva para continuar jugando.
* **Temporizador lógico y fin de partida:** límite inicial de **300 segundos**. La partida finaliza con victoria al vaciar la pirámide, o con derrota al agotarse el tiempo o no quedar jugadas posibles.
* **Sistema de puntuación y récord persistente:**
  * Par eliminado: `+10` puntos
  * Rey eliminado: `+5` puntos
  * Fila completa despejada: `+15` puntos
  * Bonificación por victoria: `+100` puntos base + `1` punto por cada segundo restante
  * El mejor puntaje se guarda automáticamente en `solitario-piramide-record.txt` dentro del directorio de la imagen de Pharo.

---

## Requisitos del entorno

* **Pharo 12** (también verificado sobre **Moose Suite 12**, basado en Pharo 12).
* No requiere dependencias externas ni conexión a internet para su carga y ejecución local.

---

## Estructura del proyecto

```text
solitario-piramide/
├── SolitarioPiramide-Modelo/   # Lógica de dominio (21 clases) y pruebas SUnit (12 clases, 52 tests)
├── SolitarioPiramide-UI/       # Interfaz gráfica Morphic (VentanaSolitario y CartaMorph)
├── assets/                     # Logo institucional y 52 imágenes del mazo temático por palo
│   ├── LOGO.png
│   ├── corazones/              # IQ-*.jpg
│   ├── diamantes/              # IM-*.jpg
│   ├── picas/                  # IEM-*.jpg
│   └── treboles/               # ISI-*.jpg
├── docs/
│   └── diagrama-clases.md      # Diagrama de clases completo en formato Mermaid
├── .project
├── .properties
└── README.md
