.8086
.MODEL small

.STACK 100h

.DATA

filename db 'test1.bmp',0
start    db 'capst.bmp',0
credit  db  "capcr.bmp",0
exit  db  "capex.bmp",0
erroropcion   db "Que flasheaste? Volve a ingresar una opcion.",0ah,0dh,24h
errornombre   db "No sos nadie sin un nombre!",0ah,0dh,24h
salto       db 0dh,0ah,24h

filehandle dw ?

Header db 54 dup (0)

Palette db 256*4 dup (0)

ScrLine db 320 dup (0)

ErrorMsg db 'fallo la imagen, perdon :( pero usted siga!', 13, 10,'$'

;===============================================PUBLIC============================================================
.CODE

;PRIMERO SE LLAMA A NOMBREVAR PARA ELEGIR EL NOMBRE DEL ARCHIVO Y DESPUES BMP PARA CARGARLO
;EL NOMBRE DEL ARCHIVO TIENE QUE SER 5 LETRAS .BMP (ej CAPI2.BMP)
;NOMBRE DE LOS ARCHIVOS VA A ESTAR COMO VARIABLE
public NombreVar
public bmp
public lecTexto     ;recibe en bx el offset de la variable de texto de hasta 255, finaliza con un enter
public imprimir     ;recibe en dx el offset a imprimir
public printarStack ;recibe un stack [bp+4] donde se guarda en bx para ir imprimiendo de a 1 tecla y salir con sonido
public lecNum       ;coloca en bx la opcion
public set_cursor   ;inicualiza el cursor
public clear_screen2;limpia pantalla
public menu         ;el menu
;==============================================FUNCIONES=============================================================
;___________________________________________________________________________________________________________________
proc NombreVar ;NOMBREVAR CAMBIA EL NOMBRE DEL ARCHIVO BMP A LEER
               ;RECIBE EL OFFSET DE LA VARIABLE A LEER EN SI 
               ;lea si, nombreImagen
               ;call nombreVar
               ;call bmp 
    push bx
    push ax
    push si
    push cx

    mov cx, 9
    lea bx, filename
    
    carga:  
    mov al, byte ptr[si]
    mov byte ptr[bx], al 
    inc bx
    inc si             
    loop carga    

    finCarga:
    pop cx
    pop si
    pop ax
    pop bx
    ret
NombreVar endp

proc menu
    push ax
    push dx
    push bx
    ; Graphic mode
    mov ax, 13h
    int 10h

pantallaStart:
    lea dx, start
    call OpenFileStart
    call ReadHeader
    call ReadPalette
    call CopyPal
    call CopyBitmap
    mov dh, 4
    call SPEAKER


    ;Libera el filehandle
    mov ah, 3eh
    mov bx, [filehandle]
    int 21h

cambia:
; Wait for key press
    mov ah, 0
    int 16h
    cmp ah, 4Bh ;IZQUIERDA
    je pantallaExit
    cmp ah, 4DH ;DERECHA
    je pantallaCredit
    cmp ah, 1Ch
    je enterStart
    jmp cambia

pantallaCredit:
    lea dx, credit
    call OpenFileStart
    call ReadHeader
    call ReadPalette
    call CopyPal
    call CopyBitmap
    mov dh, 4
    call SPEAKER

 
    ;Libera el filehandle
    mov ah, 3eh
    mov bx, [filehandle]
    int 21h

cambia2:
    ; Wait for key press
    mov ah, 0
    int 16h
    cmp ah, 4Bh
    je pantallaStart
    cmp ah, 4DH
    je pantallaExit
    cmp ah, 1Ch
    je enterCred
    jmp cambia2

pantallaExit:
    lea dx, exit
    call OpenFileStart
    call ReadHeader
    call ReadPalette
    call CopyPal
    call CopyBitmap
    mov dh, 4
    call SPEAKER

    ;Libera el filehandle
    mov ah, 3eh
    mov bx, [filehandle]
    int 21h

cambia3:
    ; Wait for key press
    mov ah, 0
    int 16h
    cmp ah, 4Bh
    je pantallaCredit
    cmp ah, 4DH
    je CpantallaStart
    cmp ah, 1Ch
    je enterExit
    jmp cambia3

CPantallaStart:
    jmp pantallaStart

enterCred:
    mov cl, 0
    jmp finMenu

enterStart:
    mov cl, 1
    jmp finMenu

enterExit:
    mov cl, 2

finMenu:
    pop bx
    pop dx
    pop ax
ret 
endp menu


proc OpenFileStart
push ax
open:
    ; Open file
    mov ah, 3Dh
    xor al, al
    int 21h
    jc openerror
    mov [filehandle], ax
    pop ax
    ret

    openerror:
    mov dx, offset ErrorMsg
    mov ah, 9h
    int 21h

    mov ah, 1
    int 21h
    pop ax

    ;libera el filehandle
    mov ah, 3eh
    mov bx, [filehandle]
    int 21h

     mov ah, 0
     mov al, 2
     int 10h
    ret
endp OpenFileStart
;___________________________________________________________________________________________________________________

proc bmp 
    push ax
    push dx
    push bx
    ; Graphic mode
    mov ax, 13h
    int 10h
    ; mov ah, 6
    ; mov al, 0
    ; int 10h
    ; Process BMP file
    call OpenFile
    call ReadHeader
    call ReadPalette
    call CopyPal
    call CopyBitmap

    ;AGREGADO PARA IMAGEN Q COLAPSA
    ;close file cierra el archivo bmp
    mov ah, 3eh
    mov bx, [filehandle]
    int 21h

    pop bx
    pop dx

    cmp dl, 2
    je finBMP
    cmp dl, 0
    je noTexto
    call printarStack
    jmp finBMP

noTexto:
; Wait for key press
    mov ah,1
    int 21h
    cmp al, 0dh
    jne noTexto
finBMP:
    pop ax
    ret 
endp bmp

;___________________________________________________________________________________________________________________
proc OpenFile
push ax
open2:
    ; Open file
    mov ah, 3Dh
    xor al, al
    mov dx, offset filename
    int 21h
    jc openerror2
    mov [filehandle], ax
    pop ax
    ret

    openerror2:

    mov dx, offset ErrorMsg
    mov ah, 9h
    int 21h

    mov ah, 1
    int 21h
    pop ax

    ;if any open filehandle then it closes them and tries again
    mov ah, 3eh
    mov bx, [filehandle]
    int 21h

    ; ;esto lo agrego pedro. no sabemos por que pero parece arreglar algo
     mov ah, 0
     mov al, 2
     int 10h
    ret
endp OpenFile
;___________________________________________________________________________________________________________________
proc ReadHeader
    ; Read BMP file header, 54 bytes
    mov ah,3fh
    mov bx, [filehandle]
    mov cx,54
    mov dx,offset Header
    int 21h
    ret
    endp ReadHeader
    proc ReadPalette
    ; Read BMP file color palette, 256 colors * 4 bytes (400h)
    mov ah,3fh
    mov cx,400h
    mov dx,offset Palette
    int 21h
    ret
endp ReadPalette
;___________________________________________________________________________________________________________________
proc CopyPal

    ; Copy the colors palette to the video memory
    ; The number of the first color should be sent to port 3C8h
    ; The palette is sent to port 3C9h
    mov si,offset Palette
    mov cx,256
    mov dx,3C8h
    mov al,0
    ; Copy starting color to port 3C8h
    out dx,al
    ; Copy palette itself to port 3C9h
    inc dx
    PalLoop:
    ; Note: Colors in a BMP file are saved as BGR values rather than RGB.
    mov al,[si+2] ; Get red value.
    shr al,2 ; Max. is 255, but video palette maximal
    ; value is 63. Therefore dividing by 4.
    out dx,al ; Send it.
    mov al,[si+1] ; Get green value.
    shr al,2
    out dx,al ; Send it.
    mov al,[si] ; Get blue value.
    shr al,2
    out dx,al ; Send it.
    add si,4 ; Point to next color.
    ; (There is a null chr. after every color.)
    loop PalLoop
    ret
endp CopyPal

;___________________________________________________________________________________________________________________
proc CopyBitmap

    ; BMP graphics are saved upside-down.
    ; Read the graphic line by line (200 lines in VGA format),
    ; displaying the lines from bottom to top.
    mov ax, 0A000h
    mov es, ax
    mov cx,200
    PrintBMPLoop:
    push cx
    ; di = cx*320, point to the correct screen line
    mov di,cx
    shl cx,6
    shl di,8
    add di,cx
    ; Read one line
    mov ah,3fh
    mov cx,320
    mov dx,offset ScrLine
    ;add dx,0
    int 21h
    ; Copy one line into video memory
    cld 
    ; Clear direction flag, for movsb
    mov cx,320
    mov si,offset ScrLine
    rep movsb 
    ; Copy line to the screen
    ;rep movsb is same as the following code:
    ;mov es:di, ds:si
    ;inc si
    ;inc di
    ;dec cx
    ;loop until cx=0
    pop cx
    loop PrintBMPLoop
    ret
endp CopyBitmap

;___________________________________________________________________________________________________________________
lecTexto proc                          ;Lectura del Nombre ingresado
    push bx
    push ax
    mov cx,0

freno: 
    mov ah,1
    int 21h
    cmp al, 0dh
    jne sigue
    mov ah, 09h
    lea dx, errornombre
    int 21h
    jmp freno

sigue:      
    mov byte ptr [bx], al
    inc bx
    inc cx

carga_lec:
    mov ah,1
    int 21h
    cmp al,0dh
    je cargue   
    mov byte ptr [bx], al
    cmp bx,255
    je cargue
    inc bx
    inc cx
    jmp carga_lec

cargue:
pop ax
pop bx
ret
lecTexto endp
;___________________________________________________________________________________________________________________
imprimir proc                           ;Impresion de caracteres
    push ax
    push dx
        mov ah, 9
        int 21h
    pop dx
    pop ax
    ret
imprimir endp 
;_______________________________________SONIDO CARACTER A CARACTER____________________________________________________
TONO MACRO NUMERO               ;Esta macro recibe el tono
        MOV     BX,NUMERO       ;y manda a llamar a los procedimientos
        CALL    BOCINA
ENDM
;----------------------------------------------------------------------------
CLRSCR PROC
;Limpia la pantalla
        MOV     AH,6
        XOR     AL,AL
        XOR     CX,CX
        MOV     DX,184FH
        MOV     BH,13
        INT     10H
        RET
ENDP
;----------------------------------------------------------------------------
BocinaOn  PROC                  ;Activa la bocina
        IN      AL, 61h
        OR      AL, 11B
        OUT     61h, AL
        RET
BocinaOn  ENDP
;----------------------------------------------------------------------------
BocinaOff  PROC                 ;Desactiva la bocina
        IN      AL, 61h
        AND     AL, 11111100b
        OUT     61h, AL
        RET
BocinaOff  ENDP
;----------------------------------------------------------------------------
Ajustar  PROC                  ;Ajusta la bocina con la frecuencia dada
        PUSH    BP
        MOV     BP, SP
        MOV     DX, 18      
        MOV     AX, 13353   
        MOV     BX, [BP + 4]
        DIV     BX
        MOV     BX, AX  
        MOV     AL, 0B6h
        OUT     43h, AL
;ENVIAR AL PUERTO LA FRECUENCIA EN DOS BYTES POR SEPARADO.
        MOV     AX, BX
        OUT     42h, AL ;ENVIA PRIMER BYTE. (PUERTO PARALELO = 378H)
        MOV     AL, AH
        OUT     42h, AL ;ENVIA SEGUNDO BYTE. (PUERTO SERIAL = 3F8H)
        POP     BP
        RET
Ajustar  ENDP
;----------------------------------------------------------------------------
Suena proc                      ;Activa la bocina y coloca el nombre de
        CALL bocinaON           ;la tecla.
        MOV     AX,40H
        MOV     ES,AX
        MOV     DX,ES:[006EH]
        MOV     AX,ES:[006CH]
        ADD     AX,2            ; Velocidad del sonido
        ADC     DX,0            ;Se le suma 7 unidades a ese valor
CLIC:
        CMP     DX,ES:[006EH]   ;Y se compara hasta que sean iguales
        JB      FINI            ;Pasando por un ciclo, cuando llegen
        JA      CLIC            ;a ser iguales se sale del ciclo y
        CMP     AX,ES:[006CH]
        JA      CLIC
FINI:
        CALL    BocinaOff       ;Se desconecta la bocina y regresa.
        RET
Suena endp
;----------------------------------------------------------------------------
Bocina proc                     ;Este procedimiento guarda AX y BX en
        PUSH    BX              ;la pila para no perder su valor, con
        MOV     AX, BX          ;esto llama a ajusta y a suena
        PUSH    AX
        CALL    Ajustar         ;Pone la frecuencia en el puerto.
        POP     AX
        POP     BX
        CALL    SUENA           ;Activa el speaker y lo desactiva.
        ret
Bocina endp
;----------------------------------------------------------------------------
;CONVERTIR A MINUSCULA SI ERA MAYUSCULA
MINUSCULA PROC
        CMP AL, 65    ;'A'
        JB  CONTINUAR ;SI LA TECLA ES MENOR QUE LA 'A' NO HACE NADA
        CMP AL, 90    ;'Z'
        JA  CONTINUAR ;SI LA TECLA ES MAYOR QUE LA 'Z' NO HACE NADA
        ADD AL, 32    ;Convierte may£scula en min£scula.
     CONTINUAR:
        RET
MINUSCULA ENDP

;----------------------------------------------------------------------------
SPEAKER PROC
        push bx
        push dx
        ;Chequea si queres que haga solo 1 sonido, si no asigna un sonido a cada letra
        cmp dh,0
        je FinCasi
        cmp dh, 1
        je uno
        cmp dh, 2
        je dos
        cmp dh, 3
        je tres
        cmp dh, 4
        je cuatro
        cmp dh, 5
        je cinco
        cmp dh, 6
        je seis
        jmp comienza
FinCasi:
    jmp fin

uno:
     test cx, 1
     jz esPar1
     TONO 498 ;LA BAJO
     inc cx
     jmp fin
esPar1:
     inc cx
     TONO 392 ;SOL BAJO
     JMP FIN
dos: 
     test cx, 1
     jz esPar2
     TONO 523 ;DO ALTO
     inc cx
     jmp fin
esPar2:
     inc cx
     TONO 880 ;LA ALTO
     jmp fin
   
tres:
    test cx, 1
    jz esPar3
    TONO 659 ;MI ALTO
    inc cx
    JMP FIN
esPar3:
    TONO 740    ;FA# ALTO
    inc cx
    jmp fin

cuatro:
     TONO 988
     JMP FIN
     inc cx
cinco:
    TONO 923
    JMP FIN
    inc cx
seis:
    TONO 329
    JMP FIN
    inc cx

COMIENZA:        
        CMP     AL,'q'   ;DO alto
        JNE     S1       ;SI NO ES LA TECLA ESPERADA, SALTA PARA VERIFICAR LA SIGUIENTE.
        TONO    523      ;SI ES LA TECLA ESPERADA, GENERA EL SONIDO CORRESPONDIENTE
        JMP     Fin ;SI ENCONTRO LA TECLA SALTA Y TERMINA.
S1:     CMP     AL,'w'   ;RE alto
        JNE     S2
        TONO    587
        JMP     Fin
S2:     CMP     AL,'e'   ;MI alto
        JNE     S3
        TONO    659
        JMP     Fin
S3:     CMP     AL,'r'   ;FA alto
        JNE     S4
        TONO    698
        JMP     Fin
S4:     CMP     AL,'t'   ;SOL alto
        JNE     S5
        TONO    784
        JMP     Fin
S5:     CMP     AL,'y'   ;LA alto
        JNE     S6
        TONO    880
        JMP     Fin
S6:     CMP     AL,'u'   ;SI alto
        JNE     S8
        TONO    988
        JMP     NOSALTO1
SALTO1:
   JMP COMIENZA
NOSALTO1:
        JMP     Fin
S8:     CMP     AL,'2'   ;DO# alto
        JNE     S9
        TONO    554
        JMP     Fin
S9:     CMP     AL,'3'   ;RE# alto
        JNE     S10
        TONO    622
        JMP     Fin
S10:    CMP     AL,'5'   ;FA# alto
        JNE     S11
        TONO    740
        JMP     Fin
S11:    CMP     AL,'6'   ;SOL# alto
        JNE     S12
        TONO    830
        JMP     Fin
S12:    CMP     AL,'7'   ;SIb alto
        JNE     S13
        TONO    923
        JMP     Fin
S13:    CMP     AL,'z'   ;DO bajo
        JNE     S14
        TONO    261
        JMP     Fin
S14:    CMP     AL,'x'   ;RE bajo
        JNE     S15
        TONO    293
        JMP     Fin
S15:    CMP     AL,'c'   ;MI bajo
        JNE     S16
        TONO    329
        JMP     NOSALTO2
SALTO2:
   JMP SALTO1
NOSALTO2:
        JMP     Fin
S16:    CMP     AL,'v'   ;FA bajo
        JNE     S17
        TONO    349
        JMP     Fin
S17:    CMP     AL,'b'   ;SOL bajo
        JNE     S18
        TONO    392
        JMP     Fin
S18:    CMP     AL,'n'   ;LA bajo
        JNE     S19
        TONO    466
        JMP     Fin
S19:    CMP     AL,'m'   ;SI bajo
        JNE     S20
        TONO    498
        JMP     Fin
S20:    CMP     AL,'s'   ;DO# bajo
        JNE     S21
        TONO    277
        JMP     Fin
S21:    CMP     AL,'d'   ;RE# bajo
        JNE     S22
        TONO    311
        JMP     Fin
S22:    CMP     AL,'g'   ;FA# bajo
        JNE     S23
        TONO    370
        JMP     Fin
S23:    CMP     AL,'h'   ;SOL# bajo
        JNE     S24
        TONO    415
        JMP     Fin
S24:    CMP     AL,'j'   ;SIb bajo
        JNE     S25
        TONO    515
        JMP     Fin
S25:    ;CMP     AL,27 ;27 = tecla ESC (terminar).
        
Fin:
        pop dx
        pop bx
        RET
SPEAKER ENDP
;----------------------------------------------------------------------------
printarStack proc
    ;ya no printa stack, sorry :(
    ;RECIBE EN BX OFFSET DE UNA VARIALBE DB E IMPRIME CARACTER A CARACTER HASTA ENCONTRAR UN $
    push ax
    push dx

arribaStack:
    cmp byte ptr [bx], 24h
    je finStack
    mov al, byte ptr[bx]
    ;CALL MINUSCULA

    CALL SPEAKER
    XOR ax,ax
    mov ah, 2
    mov dl, [bx]
    int 21h
    inc bx
    jmp arribaStack 


finStack:
    pop dx    
    cmp dl, 2
    je finstack2
    ;Wait for key press
    mov ah,1
    int 21h
    cmp al, 0dh
    jne finStack
finstack2:
    pop ax
    ret

printarStack endp
;___________________________________________________________________________________________________________________
lecNum proc
;coloca en bx el numero para la opcion, leida de teclado
        push ax
        push cx  
        xor bx, bx       
carga1:  
        mov ah, 1
        int 21h
        cmp al, 31h
        je bienOp
        cmp al, 32h
        je bienOp
        mov ah, 9
        lea dx, salto
        int 21h
        mov ah, 9
        lea dx, erroropcion
        int 21h
        mov ah, 9
        lea dx, salto
        int 21h
        jmp carga1
bienOp:
        mov bl, al

        pop cx
        pop ax
        ret
lecNum endp
;___________________________________________________________________________________________________________________

proc set_cursor
  push ax
  push bx
  push dx

  mov ah, 02h
  mov bh, 02h ;pagina
  mov dh, 50h  ;fila
  mov dl, 10h ;columna
  int 10h

  mov ah, 01h
  mov ch, 00
  mov cl, 14
  int 10h

  pop dx
  pop bx
  pop ax
  ret
endp set_cursor
;___________________________________________________________________________________________________________________
; CLEAR_SCREEN PROC
;         PUSH AX
;         PUSH BX

;         ;CONFIGURACIÓN DE VIDEO (HABRIA QUE ESPECIFICAR MÁS).
;         MOV AH, 00H
;         MOV AL, 13H
;         INT 10H
;         ;SETEO FONDO EN NEGRO:
;         MOV AH, 0BH
;         MOV BH, 00H
;         MOV BL, 00H
;         INT 10H
;         ;...

;         POP BX
;         POP AX
;         RET
;     CLEAR_SCREEN ENDP

clear_screen2 PROC
;Limpia la pantalla
        push ax
        push cx
        push dx
        push bx

        MOV     AH,6
        XOR     AL,AL
        XOR     CX,CX
        MOV     DX,184FH
        MOV     BH,13
        INT     10H
        
        pop bx
        pop dx
        pop cx
        pop ax

        RET
ENDP

end 