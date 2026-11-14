; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 05-Macros
; Descripción: Imprime una cadena seguida de un salto de línea. El ensamblador sustituye el parámetro y
; expande sus instrucciones en cada lugar donde se usa, sin CALL ni RET. Para comparar, al final de
; main se escriben a mano las mismas instrucciones que genera la macro.

INCLUDE Irvine32.inc

; Macro MostrarMensaje
; Parámetros: texto = nombre de una variable BYTE (cadena terminada en 0) que se va a imprimir
; Modifica: EDX y los registros que usen WriteString y Crlf
;Se crea el macro 
MostrarMensaje MACRO texto
;Su parametro es el texto que representa el nombre de una variable BYTE (cadena terminada en 0) que se va a imprimir
	mov edx, OFFSET texto ; EDX recibe la dirección de la cadena 
	call WriteString ; Imprime la cadena
	call Crlf ; Salto de línea
ENDM

.data
MensajeInicio BYTE "BIENVENIDO A TU SALON FAVORITO", 0 ; Mensaje de bienvenida
MensajeFin BYTE "NOS VEMOS, VUELVA PRONTO", 0 ; Mensaje de despedida

.code
main PROC

	;USO DE LA MACRO
	MostrarMensaje MensajeInicio ; Se expande con texto = MensajeInicio e imprime la bienvenida
	MostrarMensaje MensajeFin ; Se expande con texto = MensajeFin e imprime la despedida

	;Sin uso de MACRO
	mov edx, OFFSET MensajeInicio ; Carga la dirección del mensaje de bienvenida
	call WriteString ; Imprime
	call Crlf ; Salto de línea

	mov edx, OFFSET MensajeFin ; Carga la dirección del mensaje de despedida
	call WriteString ; Imprime
	call Crlf ; Salto

	exit ; Termina el programa

main ENDP

END main