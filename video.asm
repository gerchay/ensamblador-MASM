;=============== SECCION DE IMPORTS ===========================
include macros.asm
;=============== DELARACIÓN DEL PROGRAMA =================
.model small
;================= SEGMENTO DE PILA ============
.stack
;================ SEGMENTO DE DATO ======================== 
.data
	_menu db 	0ah,0dh,'1) Video',
				0ah,0dh,'2) Texto',
				0ah,0dh,'3) Salir',
				0ah,0dh,'Escoja Opcion: ',
				0ah,0dh,'$'
				
;================== SEGEMENTO DE CODIGO ===========================
.code	
	
	main proc
		MenuPrincipal:
			print _menu
			getChar
			cmp al,'1'
			je VIDEO
			cmp al,'2'
			je TEXTO
			cmp al,'3'
			je SALIR
			jmp MenuPrincipal

		VIDEO:
	        ModoVideo
	        jmp MenuPrincipal
	    TEXTO:
	        ModoTexto
	        jmp MenuPrincipal
		SALIR:
			mov ah,4ch
			int 21h

	main endp

end