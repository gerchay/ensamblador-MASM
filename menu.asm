;=============== SECCION DE IMPORTS ===========================
include macros.asm
;=============== DELARACIÓN DEL PROGRAMA =================
.model small 
;================= SEGMENTO DE PILA ============
.stack
;================ SEGMENTO DE DATO ========================
.data 

	encabezado db 	0ah,0dh,'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA',
					0ah,0dh,'FACULTAD DE INGENIERIA',
					0ah,0dh,'CIENCIAS Y SISTEMAS',
					0ah,0dh,'                    ',
					0ah,0dh,'		BIENVENIDO!!',
					0ah,0dh,'$'

	_menu db 	0ah,0dh,'1) Ingresar Texto',
				0ah,0dh,'2) Mostrar Texto',
				0ah,0dh,'3) Mostrar ARR[3]',
				0ah,0dh,'4) Mostrar ARR[SI]',
				0ah,0dh,'5) Salir',
				0ah,0dh,'Escoja Opcion: ',
				0ah,0dh,'$'

	arreglo db 20 dup('$'),'$'
	_salto db 0ah,0dh,'$' 	;\n

;================== SEGEMENTO DE CODIGO ===========================
.code	
	
	main proc
		print encabezado
		MenuPrincipal:
			print _menu
			getChar
			cmp al,'1'
			je INGRESAR
			cmp al,'2'
			je MOSTRAR
			cmp al,'3'
			je MOSTRAR1
			cmp al,'4'
			je MOSTRAR2
			cmp al,'5'
			je SALIR
			jmp MenuPrincipal

		MOSTRAR1:
			print _salto
			mov dh,arreglo[3]
			printChar dh
			getChar
			jmp MenuPrincipal

		MOSTRAR2:
			print _salto
			xor si,si
			mov dh,arreglo[si]
			printChar dh
			getChar
			jmp MenuPrincipal

		MOSTRAR:
			print _salto
			print arreglo
			getChar
			jmp MenuPrincipal

		INGRESAR:
			print _salto
			ObtenerTexto arreglo
			jmp MenuPrincipal

		SALIR:
			mov ah,4ch
			int 21h

	main endp

end