.8086
.model small

.stack 100h

.data
;_______________________________________________DIALOGOS_________________________________________________
IngreseNombre db "Bienvenido a tu historia, peque¤o",0dh,0ah
              db "carpincho! Cual es tu nombre?",0dh,0ah,24h
nombre        db 255 dup (24h)
connombre     db ", que vas a hacer?",0ah,0dh,24h

Historia      db "Habia una vez un peque¤o grupo de",0ah,0dh
              db "carpinchos pacificos y amistosos ",0ah,0dh 
              db "viviendo en Nordelta.",0dh,0ah
              db "Los grandes roedores pueden reproducirse",0ah,0dh
              db "todo el a¤o pero lo hacen especialmente en los meses de mucha lluvia.",0dh,0ah
              db "Son muy sociables y curiosos.",0dh,0ah
              db "Cuando se edifica en sus espacios,",0ah,0dh
              db "los carpinchos pierden su habitat",0ah,0dh
              db "y deben encontrar uno nuevo...",0ah,0dh,24h

Historia1     db "Es un dia humedo y lluvioso,",0ah,0dh
              db "recien te despertas. Para tu horror,",0ah,0dh 
              db "encontras una enorme pared gris",0ah,0dh
              db "donde deberia haber verde cesped",0ah,0dh
              db "y un gran lago.",0ah,0dh
              db "Tus opciones son hacer un pozo o rodear la pared.",0ah,0dh,24h

Historia1op1  db "1) A lo profundo!",0dh,0ah,24h
Historia1op2  db "2) Que habra hacia el final?",0dh,0ah,24h
Reinicio      db "Esa maldita pared! Que vas a hacer? Tus opciones son hacer un pozo o rodear la    pared.",0ah,0dh,24h

Historia2     db "Podes llamar a amigos para que te ayuden",0dh,0ah
              db "o podes usar esos dientitos.",0ah,0dh,24h
Historia2op1  db "1) Llamar a la compa¤ia",0dh,0ah,24h
Historia2op2  db "2) Roer el arbol",0dh,0ah,24h

Alemania      db "Oops! Saliste en Alemania.",0dh,0ah,24h 
HistoriaB     db "Te convidan una bebida tipica.",0ah,0dh
              db "Aceptas alcoholizarte o decidis",0ah,0dh 
              db "resumergirte en el pozo?",0ah,0dh,24h
Historia3op1  db "1) Tomas cerveza. (Prost!)",0dh,0ah,24h
Historia3op2  db "2) A la oscuridad se ha dicho!",0dh,0ah,24h
TextoAleman   db "Hallo Freund! Wie geht es dir?",0ah,0dh 
              db "Mochten Sie Bier trinken?",0dh,0ah,24h

Islandia      db "Oops! Saliste en Islandia.",0ah,0dh,24h
TextoIslandes db "Hae vinur! hvernig hefurdtu pfad?",0ah,0dh 
              db "Langar pfig i Birki?",0dh,0ah,24h
Historia3op3  db "1) Tomas Birki.(Skoll!)",0dh,0ah,24h
Historia3op4  db "2) A la oscuridad se ha dicho!",0dh,0ah,24h

Mexico        db "Oops! Saliste en Mexico.",0dh,0ah,24h 
TextoMexicano db "Que onda guey! Te has perdido? Quieres",0ah,0dh 
              db "Tequila?",0ah,0dh,24h
Historia3op5  db "1) Tomas Tequila.(Salud!)",0dh,0ah,24h
Historia3op6  db "2) A la oscuridad se ha dicho!",0dh,0ah,24h

Historia4     db "Del otro lado podes ver un ave colorida",0ah,0dh
              db "o podes correr al lugar donde esta",0ah,0dh
              db "el resto de tu especie del sexo opuesto.",0ah,0dh,24h 

Historia4op1  db "1) Un pajaro con la cola plumuda!",0dh,0ah,24h
Historia4op2  db "2) Coshe por tu alma hijo!",0dh,0ah,24h

Historia5     db "Quizas deberia comer algo y reponer",0ah,0dh
              db "energia ...o sigo corriendo?",0ah,0dh,24h
Historia5op1  db "1) Panza llena corazon contento",0dh,0ah,24h
Historia5op2  db "2) La meta esta cerca!",0dh,0ah,24h

Historia6     db "Llegaste a una encrucijada.",0ah,0dh
              db "Podes ir a la izquierda o seguir hacia   adelante.",0ah,0dh,24h

Historia6op1  db "1) La caja, la caja!",0ah,0dh,24h
Historia6op2  db "2) A seguir corriendo!",0ah,0dh,24h

Historia7     db "Llegaste a una encrucijada y podes ir a la izquierda o a la derecha",0ah,0dh
              db "(considera que eres diurno y nocturno)",0ah,0dh,24h
Historia7op1  db "1)Por el este sale el sol",0ah,0dh,24h
Historia7op2  db "2)Si quieres ir al este, no vayas al",0ah,0dh 
              db "oeste.",0ah,0dh,24h

Arbol         db "Al final de la pared encontras un enorme tronco caido que evita que sigas.",0ah,0dh,24h

Friends       db "Tus colegas van al rescate!",0dh,0ah,24h

Roer          db "Tus afilados dientes desarman facilmente la corteza, pero caes rendido del",0ah,0dh
              db "cansancio a un pozo!",0ah,0dh,24h

TextoPozo     db "Es peligroso caer en lo obscuro,",0ah,0dh
              db "toma esto: -recibe una rama-",0ah,0dh,24h
TextoPozoBor  db "Imposible seguir asi, te caes en un pozo!",0ah,0dh,24h

TextoBorracho db "Uy-! Que mareo!",0ah,0ah,24h
TextoMuyBorracho db "Estas demasiado borracho para seguir.",0ah,0dh 
              db "O quizas, fue todo un sue¤o dentro de un sue¤o...",0ah,0dh,24h

Distraccion   db "Que ave mas colorida! Pasas un rato",0dh,0ah
              db "tomando el sol con ella.",0dh,0ah 
              db "Y...Eso es comida?",0ah,0dh,24h

TextoComida   db "Encontraste Lechuga!Esa panza esta       demasiado llena!",0dh,0ah,24h

Corre         db "Tus patitas seran cortas pero podes",0ah,0dh 
              db "correr rapidito.",0ah,0dh,24h
Corre2        db "Tu puedes! Ya casi llegas...",0ah,0dh,24h

Final1        db "La concentracion y tu esfuerzo te han",0ah,0dh 
              db "llevado a tu objetivo, volviste a tu     grupo, y podes reproducirte!",0ah,0dh,24h
Final2        db "Cansado de tantas distracciones,",0ah,0dh
              db "los nordeltenses te encuentran",0dh,0ah
              db "y te echan de tu habitat natural!",0ah,0dh,24h
nohandle      db "que flashesaste",0ah,0dh,24h
erroropcion   db "Que flasheaste? Volve a ingresar una",0ah,0dh 
              db "opcion.",0ah,0dh,24h
salto         db 0dh,0ah,24h

;_______________________________________________IMAGENES_________________________________________________
testbmp     db "test1.bmp",0
CapiInicial db "capst.bmp",0
CapiCred    db "capcr.bmp",0
CapiGenerico  db "capy0.bmp",0
CapiAleman db "capyg.bmp",0
CapiIslandes db "capys.bmp",0
CapiMexicano db "capym.bmp",0
ParedGris db "wall1.bmp",0
GranTronco db "tronc.bmp",0
Pozo db "capyh.bmp",0
BanderaAlemana db "beer1.bmp",0
BanderaIslandesa db "birch.bmp",0
BanderaMexicana db "tequi.bmp",0
CapiBorracho db "capyd.bmp",0
CapiBorracho2 db "capyx.bmp",0
TroncoRoido db "tron1.bmp",0
AveColorida db "birdy.bmp",0
CapiCorriendo db "runni.bmp",0
CapiComiendo db "capyp.bmp",0
CapiHumano db "capy1.bmp",0
CapiHumano2 db "capy2.bmp",0
CapiCorazones db "capye.bmp",0
CapiFamilia db "capyf.bmp",0
Credits db "creds.bmp",0
ImagenFin db "final.bmp",0
;_______________________________________________Codigo_________________________________________________
.code
 extrn imprimir:proc
 extrn bmp:proc                        ;dl 0 para no imprimir un texto (solo imagen)
                                       ;dl 1 para imprimir un texto (llama printar stack
                                       ;dl 2 para imprimir imagen sin esperar la tecla
 extrn menu:proc                       ;menu de imagenes
 extrn nombreVar:proc
 extrn lecTexto:proc
 extrn printarStack:proc               ;Ingresa variable a leer por bx
                                       ;mov dh 0 para no hacer sonidos
                                       ;mov dh del 1 al 6 para distintos sonidos
                                       ;y mov cx 0 para intercalar silencios y sonidos
                                       ;mov dh a cualquier otra cosa para randomizar
 extrn lecNum:proc                     ;Lee por teclado el numero       
 extrn clear_screen2:proc     
;_______________________________________________ARRANCA MAIN_________________________________________________
 main proc

  mov ax,@data
  mov ds,ax                   

  ;aumenta el numero de handles que podes tener abiertos
  mov ah, 67h
  mov bx, 255
  jc nosepudo
  jmp etMenu

nosepudo:
  mov ah,9
  lea dx, nohandle
  int 21h         

etMenu:
      call clear_screen2
      call menu
      cmp cl, 1
      je start
      cmp cl, 2
      je casiFin
      jmp creditos

casiFin:
      jmp fin

start:
      lea si, CapiGenerico
      call nombreVar
      mov dl, 2
      call bmp

      lea bx, IngreseNombre              
      mov dl, 2
      mov dh, 7
      mov cx, 0
      call printarStack

      lea bx, nombre                     ;limpia variable nombre
      mov cx, 255
limpia: 
       mov byte ptr [bx], 24h
       inc bx 
       loop limpia

      lea bx, nombre                   ;carga nombrer en funcion
      call lecTexto                    

H1:
      lea bx, Historia                  ;Cuenta la historia
      mov cx, 0
      mov dh, 7
      mov dl, 1
      call printarStack 

      lea si, ParedGris
      call nombreVar
      lea bx, Historia1                  ;historia 1 con sus 2 opciones juntas
      mov dl,1
      mov dh,7
      mov cx,0
      call bmp  

      call clear_screen2

      mov dl,2
      call bmp

      lea dx, nombre              ;PRINT NOMBRE
      call imprimir

      lea dx, connombre
      call imprimir

      lea dx, salto              ;PRINT SALTO
      call imprimir

      lea dx, Historia1op1        ;agujero
      call imprimir

      lea dx, Historia1op2        ;rodear = His1op2
      call imprimir

      call lecNum                  ;bx contiene la opcion
      cmp bx, 31h
      je His1op1
      cmp bx, 32h
      je CasiHis1op2


CasiHis1op2:
   jmp His1op2

reinicia:
      call clear_screen2
      lea si, ParedGris
      call nombreVar
      lea bx, Reinicio                    ;historia 1 con sus 2 opciones juntas
      mov dl, 1
      mov dh, 7
      mov cx, 0 
      call bmp

      call clear_screen2

      mov dl,2
      call bmp

      lea dx, Historia1op1        ;agujero
      mov ah,9
      int 21h

      lea dx, Historia1op2        ;rodear = His1op2
      int 21h

   call lecNum                ;bx contiene la opcion
      cmp bx, 31h
      je His1op1 
      cmp bx, 32h
      je CasiHis1op2

;========================================DEUTSCHLAND====================================

His1op1:
      call clear_screen2

      lea si, pozo                          ;Imagen de pozo
      call nombreVar
      lea bx, TextoPozo                   ;Cuenta la historia del pozo
      mov dl, 1
      mov cx, 0
      mov dh, 3
      call bmp

      lea si, CapiAleman                       ;Imagen Alemana
      call nombreVar
      lea bx, Alemania
      mov dl, 1
      mov cx, 0
      mov dh, 7
      call bmp 

      call clear_screen2

      lea si, CapiAleman                       ;Imagen Alemana
      call nombreVar
      lea bx, TextoAleman
      mov dl, 1
      mov cx, 0
      mov dh, 1
      call bmp 
Hd:
      lea bx, HistoriaB                        ;Te ofrecen bebida
      mov cx, 0
      mov dh, 7
      call printarStack 
      
      lea dx, nombre              ;PRINT NOMBRE
      call imprimir

      lea dx, connombre
      call imprimir

      lea dx, salto              ;PRINT SALTO
      call imprimir

      lea dx, Historia3op1                        ;bebida
      call imprimir

      lea dx, Historia3op2                        ;agujero
      call imprimir

      call lecNum                ;bx contiene la opcion
      cmp bx, 31h
      je His3op1
      cmp bx, 32h
      je His3op2

His3op1:
      lea si, CapiBorracho                    ;Imagen de borrachera1
      call nombreVar
      lea bx, TextoBorracho                   ;que borrachera
      mov cx, 0
      mov dh, 7
      mov dl, 1
      call bmp

      lea si, pozo                          ;Imagen de pozo
      call nombreVar
      lea Bx, TextoPozoBor                     ;caer pozo
      mov cx, 0
      mov dh, 7
      mov dl, 1
      call bmp

      call clear_screen2
      jmp reinicia
;========================================ISLENSKA=====================================

His3op2:
      lea si, CapiIslandes                       ;Imagen Islandesa
      call nombreVar
      lea bx, Islandia                      ;Cuenta que saliste en Islandia
      mov dl, 1
      mov dh, 7
      mov cx, 0
      call bmp 

      call clear_screen2

      lea bx, TextoIslandes                        ;GODT!
      mov dl, 1
      mov dh, 2
      mov cx, 0
      call bmp

Hi:
      lea bx, HistoriaB                        ;Opciones Islandia
      mov cx, 0
      mov dh, 7
      call printarStack 

      lea dx, nombre              ;PRINT NOMBRE
      call imprimir

      lea dx, connombre
      call imprimir

      lea dx, salto              ;PRINT SALTO
      call imprimir

      lea dx, Historia3op3                       ;bebida
      call imprimir
      lea dx, Historia3op4                       ;agujero
      call imprimir

      call lecNum                ;bx contiene la opcion
      cmp bx, 31h
      je His3op3
      cmp bx, 32h
      je His3op4

His3op3:
      lea si, CapiBorracho                    ;Imagen de borrachera1
      call nombreVar
      lea bx, TextoBorracho
      mov dl, 1
      mov dh, 7
      mov cx, 0
      call bmp

      lea si, CapiBorracho2                   ;Imagen de borrachera2
      call nombreVar
      lea bx, TextoMuyBorracho
      mov dl, 1
      mov cx, 0
      mov dh, 7
      call bmp

      lea si, pozo                          ;Imagen de pozo
      call nombreVar
      lea Bx, TextoPozoBor                     ;caer pozo
      mov cx, 0
      mov dh, 7
      mov dl, 1
      call bmp

      call clear_screen2

   jmp reinicia 
;========================================MEXICO=====================================
His3op4:
      lea si, CapiMexicano               ;Imagen Mexicana
      call nombreVar
      lea bx, Mexico                     ;Cuenta que saliste en Mexico
      mov dl, 1
      mov cx, 0
      mov dh, 7
      call bmp 

      call clear_screen2

      mov dl,2
      call bmp

      lea bx, TextoMexicano                       ;CHIDO
      mov cx, 0
      mov dh, 3
      call printarStack 
Hm:
      lea bx, HistoriaB                        ;Opciones Mexico
      mov cx, 0
      mov dh, 7
      call printarStack 

      lea dx, nombre              ;PRINT NOMBRE
      call imprimir

      lea dx, connombre
      call imprimir

      lea dx, salto              ;PRINT SALTO
      call imprimir

      lea dx, Historia3op5                       ;bebida
      call imprimir

      lea dx, Historia3op6                        ;agujero
      call imprimir

      call lecNum                ;bx contiene la opcion
      cmp bx, 31h
      je His3op5
      cmp bx, 32h
      je His3op6


 His3op5:
   jmp FINALmalo 

 His3op6:
      lea si, CapiGenerico                      ;Imagen capi
      call nombreVar
      lea bx, Historia7
      mov dl, 1
      mov dh, 7
      mov cx, 0
      call bmp 
H7:
      
      lea dx, nombre              ;PRINT NOMBRE
      call imprimir

      lea dx, connombre
      call imprimir

      lea dx, salto              ;PRINT SALTO
      call imprimir

      mov ah, 9
      lea dx, Historia7op1                       ;final2
      int 21h

      lea dx, Historia7op2                       ;rodeo = His1op2
      int 21h

      call lecNum                ;bx contiene la opcion
      cmp bx, 31h
      je CasiHis7op1
      cmp bx, 32h
      je CasiHis7op2


CasiHis7op1:
   jmp His7op1

CasiHis7op2:
   jmp H2
;---------------------------------------RODEO--------------------------------------

His1op2: 
      call clear_screen2

      lea si, GranTronco                    ;Imagen de tronco 
      call nombreVar
      lea bx, arbol                         ;Cuenta la historia del arbol caido
      mov dl,1
      mov dh,7
      mov cx,0
      call bmp

H2:
      call clear_screen2

      lea si, CapiGenerico                      ;Imagen capi
      call nombreVar
      lea bx, Historia2                      ;Cuenta opciones de historia arbol caido
      mov dh, 7
      mov cx, 0
      mov dl, 1
      call bmp

      lea dx, nombre              ;PRINT NOMBRE
      call imprimir

      lea dx, connombre
      call imprimir

      lea dx, salto              ;PRINT SALTO
      call imprimir      


      lea dx, Historia2op1                      ;amigos
      call imprimir

      lea dx, Historia2op2                      ;roer
      call imprimir

      call lecNum                ;bx contiene la opcion
      cmp bx, 31h
      je His2op1
      cmp bx, 32h
      je CasHis2op2

CasHis2op2:
      jmp His2op2

His2op1:
      lea si, CapiFamilia                    ;Imagen de grupete de capys
      call nombreVar
      lea bx, Friends
      mov dl, 1
      mov dh, 7
      mov cx, 0
      call bmp
H4:
      lea bx, Historia4                        ;Opciones ave corre
      mov dh, 7
      mov cx, 0
      call printarStack 

      lea si, CapiFamilia
      call nombreVar
      mov dl, 2
      call bmp

      lea dx, nombre              ;PRINT NOMBRE
      call imprimir

      lea dx, connombre
      call imprimir

      lea dx, salto              ;PRINT SALTO
      call imprimir

      lea dx, Historia4op1                       ;ave 
      call imprimir

      lea dx, Historia4op2                       ;correr
      call imprimir

      call lecNum                ;bx contiene la opcion
      cmp bx, 31h
      je His4op1
      cmp bx, 32h
      je His4op2

His4op1:
      lea si, AveColorida                   ;Imagen de avechucho
      call nombreVar
      lea bx, distraccion
      mov dl, 1
      mov dh, 7
      mov cx, 0
      call bmp

H5:
      lea bx, Historia5                       ;Opciones comida corre
      mov dh, 7
      mov cx, 0
      call printarStack 

      lea dx, nombre              ;PRINT NOMBRE
      call imprimir

      lea dx, connombre
      call imprimir

      lea dx, salto              ;PRINT SALTO
      call imprimir

      lea dx, Historia5op1                       ;comida
      call imprimir

      lea dx, Historia5op2                       ;corre
      call imprimir

      call lecNum                ;bx contiene la opcion
      cmp bx, 31h
      je His5op1
      cmp bx, 32h
      je His5op2

His5op1:
      lea si, CapiComiendo                   ;Imagen de comida
      call nombreVar
      lea bx, TextoComida
      mov dl, 1
      mov dh, 7
      mov cx, 0
      call bmp

   jmp FINALmalo

His5op2:
   jmp His4op2

His4op2:

      lea si, CapiCorriendo                ;Imagen de capy flash
      call nombreVar
      lea bx, Corre                       ;corre
      mov dl, 1
      mov dh, 7
      mov cx, 0
      call bmp

H6:
      lea bx, Historia6                        ;Opciones izq o sigue (corre2)
      mov dl, 1
      mov dh, 7
      mov cx, 0
      call printarStack 

      lea dx, nombre              ;PRINT NOMBRE
      call imprimir

      lea dx, connombre
      call imprimir

      lea dx, salto              ;PRINT SALTO
      call imprimir

      lea dx, Historia6op1                       ;izq
      call imprimir

      lea dx, Historia6op2                        ;corre2
      call imprimir

      call lecNum                ;bx contiene la opcion
      cmp bx, 31h
      je His6op1
      cmp bx, 32h
      je His6op2

His6op1:
   jmp His5op1

His6op2:
      lea si, CapiCorriendo                   ;Imagen de capy flash
      call nombreVar
      lea bx, corre2
      mov dl, 1
      mov dh, 7
      mov cx, 0
      call bmp


   jmp FINALbueno

His2op2:
      lea si, TroncoRoido                   ;Imagen de tronco roido
      call nombreVar
      lea bx, roer
      mov dl, 1
      mov dh, 7
      mov cx, 0
      call bmp

   jmp His3op2

His7op1:
   jmp FINALmalo


FINALbueno:
      lea si, CapiCorazones                 ;Imagen de felicidat
      call nombreVar
      lea bx, final1
      mov dh, 7
      mov dl, 1
      mov cx, 0
      call bmp
      jmp TheEnd

FINALmalo:
      lea si, CapiHumano                  ;Imagen de humano malo
      call nombreVar
      lea bx, Final2
      mov dl, 1
      mov dh, 7
      mov cx, 0
      call bmp
      jmp TheEnd

TheEnd: 
      lea si, ImagenFin                     ;FIN
      call nombreVar
      mov dl, 0
      call bmp
      jmp etMenu

Creditos:
      lea si, Credits                     ;texto creditos
      call nombreVar
      mov dl, 0
      call bmp 
      ; cmp cl, 0
      ; jne fin no creo que necesitemos esto si va a volver al menu
      jmp etMenu

  fin:
  CALL clear_screen2
  mov ax, 07h
  int 10h

  mov ax,4c00h
  int 21h
 main endp
end





