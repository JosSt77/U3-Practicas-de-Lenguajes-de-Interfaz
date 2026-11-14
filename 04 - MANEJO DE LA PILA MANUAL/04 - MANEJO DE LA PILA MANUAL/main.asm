; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 04 - MANEJO DE LA PILA MANUAL
; Descripción: La pila. main apila dos valores y llama a un procedimiento que establece EBP 
; como punto de referencia para localizar los argumentos, conserva EBX con PUSH y POP, multiplica 
; ambos valores y regresa con RET 8 para que el propio procedimiento retire los argumentos de 
; la pila. 

INCLUDE Irvine32.inc

.code
main PROC

	;PREPARACIÓN DE LA LLAMADA
	mov ebx, 999 ; Valor que main necesita conservar

	push 3 ; Primer argumento apilado (quedará en [ebp+12])
	push 25 ; Segundo argumento apilado (quedará en [ebp+8])

	;LLAMADA
	call MultiplicacionPila ; Guarda la dirección de retorno en la pila y salta al procedimiento
	nop ; Punto de pausa

	exit ; Termina el programa

main ENDP

; Procedimiento MultiplicacionPila
; Recibe: dos argumentos en la pila, [ebp+8] = 25 y [ebp+12] = 3
; Devuelve: EAX = producto de ambos argumentos
; Modifica: EAX (EBX y EBP se restauran antes de regresar)
; Limpieza de pila: la realiza el procedimiento con RET 8 (dos argumentos de 4 bytes)
;
; Contenido de la pila después de PUSH EBP / MOV EBP, ESP / PUSH EBX:
;   [ebp+12] -> 3                      (primer argumento)
;   [ebp+8]  -> 25                     (segundo argumento)
;   [ebp+4]  -> dirección de retorno   (guardada por CALL)
;   [ebp]    -> EBP original de main   (guardado por PUSH EBP)
;   [ebp-4]  -> EBX original (999)     (guardado por PUSH EBX)

MultiplicacionPila PROC
; Recibe: [ebp+8] = 25 y [ebp+12] = 3
; Devuelve: EAX = producto de ambos argumentos
; Modifica: EAX
; Limpieza de pila: la realiza el procedimiento con RET 8

	mov ebp, esp ; PUNTO DE REFERENCIA EN LA PILA, EBP queda fijo aunque ESP cambie

	push ebx ; Conserva EBX porque se usará como registro de trabajo

	mov eax, [ebp+8] ; EAX = 25 (último argumento apilado)
	mov ebx, [ebp+12] ; EBX = 3 (primer argumento apilado)

	imul eax, ebx ; EAX = 25 * 3 = 75

	pop ebx ; Restaura EBX con su valor original (999)
	pop ebp ; Restaura el EBP del llamador

	ret 8 ; Recupera la dirección de retorno y además suma 8 a ESP para retirar los dos argumentos

MultiplicacionPila ENDP

END main