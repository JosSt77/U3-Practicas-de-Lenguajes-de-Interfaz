; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 01 - Práctica Procedimiento
; Descripción: Definición y llamada de un procedimiento con PROC y ENDP. El procedimiento mostrarAviso
; se define una sola vez y se llama dos veces desde main con CALL;

INCLUDE Irvine32.inc

.data
;Mensajes que se muestran en la consola
mensajeInicio BYTE "Inicio del programa", 0 
mensajeProcedimiento BYTE "Estoy dentro del procedimiento", 0 
mensajeFin BYTE "Fin del programa", 0 

.code
main PROC
	;BLOQUE 1: MENSAJE DE INICIO
	mov edx, OFFSET mensajeInicio ; 
	call WriteString ; Imprime "Inicio del programa"
	call Crlf ; Salto de línea

	call mostrarAviso ; Guarda la dirección de retorno en la pila (ESP decrementa 4 bytes) y salta a mostrarAviso

	mov eax, 20 ; Esta instrucción se ejecuta al regresar del primer llamado

	call mostrarAviso ; Se ejecutan las mismas instrucciones otra vez

	mov eax, 30 ; Se ejecuta al regresar del segundo llamado; EAX cambia a 30

	mov edx, OFFSET mensajeFin ; EDX recibe la dirección del mensaje final
	call WriteString ; Imprime "Fin del programa"
	call Crlf

	exit

main ENDP ; Finalización del procedimiento main


mostrarAviso PROC
	mov edx, OFFSET mensajeProcedimiento ; Carga la dirección del mensaje del procedimiento
	call WriteString ; Imprime "Estoy dentro del procedimiento"
	call Crlf
	ret ; Toma la dirección de retorno de la cima de la pila (ESP aumenta 4 bytes) y regresa al llamador
mostrarAviso ENDP

END main