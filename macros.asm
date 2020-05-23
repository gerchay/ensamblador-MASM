; ==================================================
;      Imprimir cadena en salida estandar.
; ==================================================
print macro cadena
    mov ax,@data
    mov ds, ax
    mov ah,09h       
    mov dx, offset cadena  
    int 21h
endm

; ==================================================
;     Obtiene texto ingresado por teclado
; ==================================================
ObtenerTexto macro buffer
    PUSH SI
    PUSH AX

    xor si,si
    CONTINUE:
    getChar
    cmp al,0dh
    je FIN
    mov buffer[si],al
    inc si
    jmp CONTINUE
    FIN:
    mov al,'$'
    mov buffer[si],al

    POP AX
    POP SI
endm

; ==================================================
;     Obtiene ascii de tecla presionada
; ==================================================
getChar macro
    mov ah,0dh
    int 21h
    mov ah,01h
    int 21h
endm

; ==================================================
;    Imprimir caracter en la salida estandar.
; ==================================================
printChar macro char
    mov ah,02h
    mov dl,char
    int 21h
endm

; ==================================================
;    Ingresa al modo Video.
; ==================================================
ModoVideo macro
    mov ah,00h
    mov al,13h
    int 10h
endm

; ==================================================
;    Ingresa al modo Texto.
; ==================================================
ModoTexto macro
    mov ah,03h
    mov al,13h
    int 10h
endm

; ==================================================
;    Limpia el texto o el buffer deseado
; ==================================================
clearBuffer macro _buffer, _bytes, _char 
    LOCAL CICLO
    PUSH si
    PUSH cx
    xor si,si
    xor cx,cx
    mov cx,_bytes
    CICLO:
        mov _buffer[si],_char
        inc si
        loop CICLO
    POP cx
    POP si
endm

; ==================================================
;    Abre el archivo 
; ==================================================
OpenFile macro _buffer, _handler 
    mov ah,3dh
    mov al,02h
    lea dx,_buffer
    int 21h

    jc ERROR1 ;se reporta en el menú 

    mov _handler,ax
endm

; ==================================================
;    Cierra el archivo 
; ==================================================
CloseFile macro _handler 
    mov ah,3eh
    mov bx,_handler
    int 21h
endm

; ==================================================
;    Lee el archivo
; ==================================================
ReadFile macro _handler,_buffer,_bytes 
    mov ah,3fh
    mov bx,_handler
    mov cx,_bytes
    lea dx,_buffer
    int 21h
    
    jc ERROR2 ;se reporta en el menú 
endm

; ==================================================
;    Escribe en el archivo especificado
; ==================================================
WriteText macro _handle,_buffer
    mov ah,40h
    mov bx,_handle
    mov cx, sizeof _buffer
    lea dx,_buffer
    int 21h
    jc ERROR4 ;se reporta en el menú 
endm

; ==================================================
;    Crea un nuevo Archivo
; ==================================================
NewFile macro _name,_handle ;CREA UN ARCHIVO
    mov ah,3ch
    mov cx,00000000b
    lea dx,_name
    int 21h
    jc ERROR3 ;se reporta en el menú 

    mov _handle,ax
endm

; ==================================================
;    Limpiar pantalla cuando se esta en modo texto.
; ==================================================
LIMPIAR_PANTALLA macro 
    mov ax,0600h         ;toda la pantalla
    mov bh,7             ;sigue video color normal
    mov cx,0000          ;vÇrtice superior izq.
    mov dx,184Fh         ;vÇrtice inferior derecho
    int 10h              ;llamada a BIOS
endm

; ==============================================================
;    ubicar cursor en la pantalla cuando se esta en modo texto.
; ==============================================================
UBICAR_CURSOR macro  fila,columna
    mov ah,02h              ;func. de ubic. del cursor
    mov dh,fila             ;fila
    mov dl,columna          ;columna
    mov bh,0                ;pag. #0
    int 10h
endm