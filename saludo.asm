; Imprimi una cadena
print macro cadena
    mov ax,@data
    mov ds, ax
    mov ah,09h                  ;numero de función para imprimir cadena en pantalla 
    mov dx, offset cadena       ;equivalente a lea dx, cadena. Inicializa en dx la posición donde comienza la cadena
    int 21h
endm

;=============== DELARACIÓN DEL PROGRAMA ===============
.model small
;================= SEGMENTO DE PILA ============
.stack 100h 
;================ SEGMENTO DE DATOS ====================
.data
saludo db 0ah,0dh,'Hola Mundo','$' ;db -> dato byte -> 8 bits

;================== SEGMENTO DE CODIGO ===============
.code 
	main proc
		print saludo	; Se manda a llamar el macro 'PRINT'. Se le pasa como parametro la variable saludo de tipo de dato byte, que contiene el texto

		Salir: 
			MOV ah,4ch
			int 21h
	main endp
end