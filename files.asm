;=============== SECCION DE MACROS ===========================
include macros.asm
;================= DECLARACION TIPO DE EJECUTABLE ============
.model small 
;================= SEGMENTO DE PILA ============
.stack 100h 
;================ SECCION DE DATOS ================
.data
	_encab db 	0ah,0dh,'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA',
				0ah,0dh,'FACULTAD DE INGENIERIA',
				0ah,0dh,'CIENCIAS Y SISTEMAS',
				0ah,0dh,'                    ',
				0ah,0dh,'		MANEJO DE ARCHIVOS ENSAMBLADOR ASM!!',
				0ah,0dh,'$'

	_menu db 	0ah,0dh,'1) Abrir Archivo',
				0ah,0dh,'2) Crear Archivo',
				0ah,0dh,'3) Mostrar texto del Archivo',
				0ah,0dh,'4) Salir',
				0ah,0dh,'Escoja Opcion:   ', '$'

	_error1 db 'ERROR AL ABRIR EL ARCHIVO',13,10,'$'
    _error2 db 'ERROR AL LEER EL ARCHIVO',13,10,'$'
    _error3 db 'ERROR AL CREAR EL ARCHIVO',13,10,'$'
    _error4 db 'ERROR AL ESCRIBIR EL ARCHIVO',13,10,'$'
 	_error5 db 'ERROR COMANDO INCORRECTO! ','$'

 	_msj1 db 'Se ha Creado el archivo correctamente',13,10,'$'
 	_msj2 db 'Se ha Leido el archivo correctamente',13,10,'$'
 	_msj3 db 'El contenido del archivo es: ',13,10,'$'

	;------------ Variables -------------
	_salto db 0ah,0dh,'$' 	;\n
	_tab db 9,'$'  			;\r
	_name db 'ejemplo.txt',0 ;Nombre Archivo
	texto db 'Hola, Soy el Texto dentro del archivo. 	ejemplo.txt '

	bufferLectura db 100 dup('$')	;Buffer donde se almacenara el contenido del archivo
	handleFichero dw ?		;Variable File

;================== SECCION DE CODIGO ===========================
.code 
	main proc 
		LIMPIAR_PANTALLA
		UBICAR_CURSOR 1,0
		print _encab
		getChar

		MENU:
			LIMPIAR_PANTALLA
			UBICAR_CURSOR 1,0
			print _menu
			getChar
			cmp al,'1'
			je ABRIR
			cmp al,'2'
			je CREAR
			cmp al,'3'
			je MOSTRAR
			cmp al,'4'
			je SALIR

			print _salto
			print _error5
			getChar
			jmp MENU

		ABRIR:
			clearBuffer bufferLectura,SIZEOF bufferLectura,24h 				;Se limpia el bufferLectura
			OpenFile _name,handleFichero 									;Se Abre el archivo
			ReadFile handleFichero ,bufferLectura,SIZEOF bufferLectura		;Se almacena el conteindo del archivo en el bufferLectura
			CloseFile handleFichero											;Se cierra el archivo

			print _salto
			print _msj2
			getChar
			jmp MENU

		CREAR:
			NewFile _name,handleFichero 			;Se crea el archivo
			WriteText handleFichero,Texto       ;Se escribe el texto en el archivo
			CloseFile handleFichero				;Se cierra el archivo

			print _salto
			print _msj1
			getChar
			jmp MENU

		MOSTRAR:
			LIMPIAR_PANTALLA
			UBICAR_CURSOR 1,0
			print _msj3
			print _salto
			UBICAR_CURSOR 3,3
			print bufferLectura
			getChar
			jmp MENU

	    ERROR1:
            print _salto
            print _tab
            print _error1
            getChar
            jmp MENU
        
        ERROR2:
            print _salto
            print _tab
            print _error2
            getChar
            jmp MENU

        ERROR3:
            print _salto
            print _tab
            print _error3
            getChar
            jmp MENU

        ERROR4:
            print _salto
            print _tab
            print _error4
            getChar
            jmp MENU

		SALIR: 
			MOV ah,4ch 
			int 21h
	main endp
;================ FIN DE SECCION DE CODIGO ========================
end