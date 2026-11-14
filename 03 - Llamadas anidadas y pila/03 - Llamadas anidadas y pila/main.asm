; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 03 - Llamadas anidadas y pila
; Descripción:  Hacer un proceso anidado de llamar un procedimiento, demostrar, que el valor que
; se guarda es el último. Imprimir el valor de la dirección en esp con un valor hexadecimal 


INCLUDE Irvine32.inc

.data
;Mensajes que se muestra al rededor de la ejecución del programa
mensajeMain1 BYTE "1.Antes de llamar a funcion1 ESP = ", 0
mensajeF1Entrada BYTE "2. Al entrar a la funcion1 ESP = ", 0
mensajeF2Entrada BYTE "3. Al entrar a la funcion2 ESP = ", 0
mensajeF1Regreso BYTE "4. Tras regresar de funcion2  ESP = ", 0
mensajeMain2 BYTE "5. Tras regresar de funcion1 (estando en el main) ESP = ", 0
mensajeRetMain BYTE "[ESP] retorno a main = ", 0
mensajeRetF1 BYTE "[ESP] retorno a funcion1  = ", 0
mensajeRetMainDebajo BYTE "[ESP+4] retorno a main = ", 0

.code
main PROC

	;ESP ANTES DE CUALQUIER LLAMADA
	mov edx, OFFSET mensajeMain1 ; Mensaje del punto 1
	mov eax, esp ; Copia la dirección de la cima de la pila a EAX
	call mostrarHex ; Imprime ESP en hexadecimal
	call Crlf ; Salto de línea

	;PRIMER LLAMADO
	call funcion1 ; Guarda en la pila la dirección de retorno a main y salta a funcion1
	nop ; Punto de pausa

	;ESP AL REGRESAR
	call Crlf
	mov edx, OFFSET mensajeMain2 ; Mensaje del punto 5
	mov eax, esp ; ESP debe ser igual al del punto 1
	call mostrarHex

	exit ; Termina el programa

main ENDP


funcion1 PROC
;Al entrar, CALL ya guardó la dirección de retorno a main y ESP decrementó 4 bytes
	mov edx, OFFSET mensajeF1Entrada ; Mensaje del punto 2
	mov eax, esp ; ESP actual (4 bytes menos que en main)
	call mostrarHex
	mov edx, OFFSET mensajeRetMain ; Mensaje del valor guardado en la cima
	mov eax, [esp] ; Lee el contenido de la cima, la dirección de retorno a main
	call mostrarHex ; Imprime la dirección de retorno en hexadecimal

	call funcion2 ; Llamada anidada
	nop ; Punto de pausa

	;ESP vuelve al valor que tenía al entrar a funcion1
	mov edx, OFFSET mensajeF1Regreso ; Mensaje del punto 4
	mov eax, esp ; ESP debe ser igual al del punto 2
	call mostrarHex 
	mov edx, OFFSET mensajeRetMain ; Mensaje del valor guardado en la cima
	mov eax, [esp] ; La cima vuelve a tener la dirección de retorno a main
	call mostrarHex 

	ret ; Recupera de la cima la dirección de retorno a main y regresa
funcion1 ENDP


funcion2 PROC
	;Al entrar, CALL guardó la dirección de retorno a funcion1 y ESP decrementó otros 4 bytes
	mov edx, OFFSET mensajeF2Entrada ; Mensaje del punto 3
	mov eax, esp ; 8 bytes menos que en main
	call mostrarHex ; Imprime ESP en hexadecimal
	mov edx, OFFSET mensajeRetF1 ; Mensaje del valor guardado en la cima
	mov eax, [esp] ; La cima contiene el  retorno a funcion1
	call mostrarHex
	mov edx, OFFSET mensajeRetMainDebajo ; Mensaje del valor que está debajo de la cima
	mov eax, [esp+4] ; Un elemento más abajo está el retorno a main
	call mostrarHex

	ret ; Recupera la cima y ESP aumenta 4 bytes
funcion2 ENDP

mostrarHex PROC
; Recibe: EDX = dirección del mensaje, EAX = valor a imprimir
	call WriteString ; Imprime el mensaje apuntado por EDX
	call WriteHex ; Imprime EAX en hexadecimal (8 dígitos)
	call Crlf 
	ret ; Regresa al procedimiento que lo llamó
mostrarHex ENDP

END main