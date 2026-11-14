; Materia: Lenguajes de Interfaz
; Alumno: Sotelo Izaguirre José Ángel
; Horario: 10-11
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 02- Validación Cadena
; Descripción: Procedimiento que pida por consola una cadena, una vez ingresada validar que la cadena 
;esté vacía o no vacía (mediante el tamaño) con procedimiento (el procedimiento arrojará un cero o un 
;uno si está vacía o no usando una comparación) y mandar un mensaje con un cero o uno que represente si 
;la cadena esté vacía o no vacía, si eax (valor en donde se almacena la comparativa) es igual a 0 saltar
;a un mensaje que diga cadena vacía, si es 1 saltar a un mensaje que diga cadena no vacía

INCLUDE Irvine32.inc

.data
TAM_MAX = 20 ; Número máximo de caracteres que se leerán de la consola
cadena BYTE TAM_MAX + 1 DUP(0) ; Buffer donde se guarda la cadena (más uno para el terminador nulo)

;Mensajes que se mostrarán a lo largo del programa
mensajePeticion BYTE "Ingresa una cadena: ", 0
mensajeResultado BYTE "Resultado de la validacion: ", 0
mensajeVacia BYTE "Cadena vacia", 0
mensajeNoVacia BYTE "Cadena no vacia", 0

.code
main PROC

	call capturarCadena ; Pide la cadena

	call validarCadena ; Recibe la longitud en EAX

	;BLOQUE 3: MOSTRAR EL VALOR DE LA COMPARACIÓN

	mov edx, OFFSET mensajeResultado 
	call WriteString ; Imprime el mensaje
	push eax ; Respalda EAX (resultado de la validación) en la pila
	call WriteDec ; Imprime el 0 o el 1 almacenado en EAX
	pop eax ; Restaura EAX para poder compararlo
	call Crlf

	cmp eax, 0 ; Compara el resultado con 0
	je mostrarVacia ; Si EAX = 0 salta al mensaje de cadena vacía
	cmp eax, 1 ; Compara el resultado con 1
	je mostrarNoVacia ; Si EAX = 1 salta al mensaje de cadena no vacía
	jmp finPrograma ; Ningún caso esperado, termina sin mostrar mensaje

	mostrarVacia:
		mov edx, OFFSET mensajeVacia 
		call WriteString ; Imprime el mensaje
		call Crlf 
		jmp finPrograma ; Evita ejecutar el bloque de cadena no vacía

	mostrarNoVacia:
		mov edx, OFFSET mensajeNoVacia 
		call WriteString ; Imprime el mensaje
		call Crlf

	finPrograma:
		exit ; Termina el programa

main ENDP

capturarCadena PROC
;Devuelve: EAX = cantidad de caracteres capturados
	mov edx, OFFSET mensajePeticion 
	call WriteString ; Imprime "Ingresa una cadena"
	mov edx, OFFSET cadena ;dirección del buffer donde se guardará el texto
	mov ecx, TAM_MAX ; máximo de caracteres que ReadString puede leer
	call ReadString ; Lee la cadena
	ret ; Regresa a main con la longitud en EAX
capturarCadena ENDP

validarCadena PROC
; Recibe: EAX = longitud de la cadena
; Devuelve: EAX = 0 si la cadena está vacía, EAX = 1 si no está vacía
	cmp eax, 0 ; Compara la longitud con 0
	je cadenaVaciaValidacion ; Si la longitud es 0, salta a poner el resultado en 0
	mov eax, 1 ; Longitud mayor que 0, la cadena no está vacía
	jmp finValidacion ; Salta para no sobrescribir el resultado

	cadenaVaciaValidacion:
	mov eax, 0 ; Longitud igual a 0: la cadena está vacía

	finValidacion:
	ret ; Regresa a main con el resultado en EAX
validarCadena ENDP

END main