# Lenguajes de Interfaz - Unidad 3

## Datos Generales

- **Materia:** Lenguajes de Interfaz
- **Alumno:** Sotelo Izaguirre José Ángel
- **Horario:** 10-11
- **Docente:** Dr José Luís Medina Jiménez
- **Tema:** Unidad 3. Modularización

## Índice de Prácticas

## 1. [Práctica Procedimiento](https://github.com/JosSt77/U3-Practicas-de-Lenguajes-de-Interfaz/blob/main/01%20-%20Pr%C3%A1ctica%20Procedimiento/01%20-%20Pr%C3%A1ctica%20Procedimiento/main.asm)

Define el procedimiento `mostrarAviso` con `PROC` y `ENDP` y lo llama dos veces desde `main` con `CALL`. Imprime un mensaje de inicio, el mensaje del procedimiento (dos veces) y un mensaje de fin.

**¿Qué se comprobó?**
- El mensaje "Estoy dentro del procedimiento" aparece dos veces, aunque el procedimiento se define una sola vez.
- Después de cada `CALL` la ejecución continúa en la instrucción siguiente (`mov eax, 20` y `mov eax, 30`), lo que demuestra que `RET` regresa al punto correcto.
- Al depurar, `ESP` baja 4 bytes al hacer `CALL` y sube 4 bytes al ejecutar `RET`.

## 2. [Validación Cadena](https://github.com/JosSt77/U3-Practicas-de-Lenguajes-de-Interfaz/blob/main/02-%20Validaci%C3%B3n%20Cadena/02-%20Validaci%C3%B3n%20Cadena/main.asm)

Pide una cadena por consola (`capturarCadena`), valida su tamaño con un procedimiento (`validarCadena`), que devuelve en `EAX` un 0 si está vacía o un 1 si no lo está, e imprime ese valor. Después compara `EAX`: si es 0 salta al mensaje "Cadena vacia" y si es 1 salta al mensaje "Cadena no vacia".

**Qué se comprobó:**
- Al presionar solo Enter, el resultado es 0 y se muestra "Cadena vacia".
- Al escribir cualquier texto, el resultado es 1 y se muestra "Cadena no vacia".
- Una cadena formada solo por espacios cuenta como no vacía, porque se valida el tamaño y no el contenido.

## 3. [Llamadas anidadas y pila](https://github.com/JosSt77/U3-Practicas-de-Lenguajes-de-Interfaz/blob/main/03%20-%20Llamadas%20anidadas%20y%20pila/03%20-%20Llamadas%20anidadas%20y%20pila/main.asm)

`main` llama a `funcion1` y `funcion1` llama a `funcion2` con una llamada anidada. En cada punto imprime en hexadecimal (con `WriteHex`) el valor de `ESP` y el contenido de la cima de la pila, que es la dirección de retorno guardada por `CALL`.

**Qué se comprobó:**
- `ESP` baja 4 bytes en cada `CALL`: el valor en `funcion1` es 4 menos que en `main`, y el de `funcion2` es 8 menos.
- En `funcion2`, `[ESP]` contiene la dirección de retorno a `funcion1` (el último valor guardado, en la cima) y `[ESP+4]` contiene la de `main` (el primero, debajo de ella), los regresos ocurren en orden LIFO.
- Al regresar de `funcion2`, `ESP` y `[ESP]` vuelven a tener los valores que tenían al entrar a `funcion1`; al regresar a `main`, `ESP` es igual al inicial. La pila queda equilibrada.

## 4. [Manejo de la Pila Manual](https://github.com/JosSt77/U3-Practicas-de-Lenguajes-de-Interfaz/blob/main/04%20-%20MANEJO%20DE%20LA%20PILA%20MANUAL/04%20-%20MANEJO%20DE%20LA%20PILA%20MANUAL/main.asm)

`main` apila dos argumentos (3 y 25) y llama a `MultiplicacionPila`. El procedimiento fija `EBP` como referencia, conserva `EBX` con `PUSH`/`POP`, lee los argumentos con `[ebp+8]` y `[ebp+12]`, los multiplica con `imul` y regresa con `ret 8` para retirar los argumentos de la pila.

**Qué se comprobó:**
- Después de la llamada, `EAX = 75` (3 × 25).
- `EBX` vuelve a valer 999, por lo que el procedimiento restauró el registro que usó.
- `ESP` queda igual que antes de los `PUSH`, es decir, `ret 8` limpió correctamente los dos argumentos.

## 5. [Macros](https://github.com/JosSt77/U3-Practicas-de-Lenguajes-de-Interfaz/blob/main/05-Macros/05-Macros/main.asm)
Define la macro `MostrarMensaje` con `MACRO` y `ENDM`. Recibe como parámetro el nombre de una cadena e imprime su contenido con un salto de línea. Se usa dos veces en `main` (bienvenida y despedida) y después se escriben a mano las mismas instrucciones para compararlas con lo que genera la macro.

**Qué se comprobó:**
- La consola muestra cuatro líneas: "BIENVENIDO A TU SALON FAVORITO", "NOS VEMOS, VUELVA PRONTO", y luego las mismas dos de nuevo. Las dos primeras salen de la macro y las dos últimas del código escrito a mano, por lo que el resultado es idéntico.
- Una sola definición sirve para distintos argumentos: el ensamblador sustituye el parámetro `texto` por `MensajeInicio` o `MensajeFin` en cada uso.
- A diferencia de un procedimiento, la macro no usa `CALL` ni `RET`: sus instrucciones se copian en `main` al ensamblar.

