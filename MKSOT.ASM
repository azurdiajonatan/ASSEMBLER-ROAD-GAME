LIMPIARRELOJ macro
    mov Tiempo2[0],"0"
    mov Tiempo2[1],"0"
    mov Tiempo2[3],"0"
    mov Tiempo2[4],"0"
endm

LIMPIARPANTALLA2 macro
    mov ax,0003h
    int 10h
    mov ax,0013h
    int 10h
endm

SOLICITARVELOCIDAD macro 
LOCAL TOMARNUMERO,STFIN
    GETCHAR2
    cmp al,"0"
    je TOMARNUMERO
    cmp al,"1"
    je TOMARNUMERO
    cmp al,"2"
    je TOMARNUMERO
    cmp al,"3"
    je TOMARNUMERO
    cmp al,"4"
    je TOMARNUMERO
    cmp al,"5"
    je TOMARNUMERO
    cmp al,"6"
    je TOMARNUMERO
    cmp al,"7"
    je TOMARNUMERO
    cmp al,"8"
    je TOMARNUMERO
    cmp al,"9"
    je TOMARNUMERO
    jmp STFIN

    TOMARNUMERO:
        mov msgvel[0],al
        sub al,30h
        mov velocidad, al
    STFIN:
endm

RETARDANTE macro
LOCAL RTINIT,RTFIN,REFRESH,NOREFRESH
    xor cx,cx
    mov Cl, velocidad
    cmp Cl,0
    je RTFIN
    RTINIT:
        PUSH cx
        DELAYS 120
        inc contadordeveces
        cmp contadordeveces,68
        ja REFRESH
        jmp NOREFRESH
        REFRESH:
            CALL CRONOS2
            GRAFICARTEXTO Tiempo2,SIZEOF Tiempo2,15,1,22
            mov contadordeveces,0
        NOREFRESH:
        POP cx
        ;dec cl
        ;cmp cl,0
        ;jne RTFIN ;lo hace aun mas rapido 
    LOOP RTINIT ;es mas lento con loop
    RTFIN:
endm

MARGEN_BARRAS macro
LOCAL MG1,MG2,MG3,MG4,MG5
    mov cx,2
    mov dx,18
    MG1:
        PRINTPIXEL cx,dx,1fh
        cmp cx,318
        je MG2
        inc cx
        jmp MG1
    MG2:
        PRINTPIXEL cx,dx,1fh
        cmp dx,195
        je MG3
        inc dx
        jmp MG2
    MG3:
        PRINTPIXEL cx,dx,1fh
        cmp cx,2
        je MG4
        dec cx
        jmp MG3
    MG4:
        PRINTPIXEL cx,dx,1fh
        cmp dx,18
        je MG5
        dec dx
        jmp MG4
    MG5:  
endm

COLORBARRA macro numero
LOCAL ROJO,AZUL,AMAR,VERDE,BLANCO,CBFIN
    cmp numero,20
    jle ROJO
    cmp numero,40
    jle AZUL
    cmp numero,60
    jle AMAR
    cmp numero,80
    jle VERDE
    cmp numero,81
    jge BLANCO
    ROJO:
        mov mgcolor,40
        jmp CBFIN
    AZUL:
        mov mgcolor,32
        jmp CBFIN
    AMAR:
        mov mgcolor,68
        jmp CBFIN
    VERDE:
        mov mgcolor,48
        jmp CBFIN
    BLANCO:
        mov mgcolor,15
        jmp CBFIN
    CBFIN:
endm

SELECCIONSONIDO macro frecuencia
LOCAL RS,RAZ,RAMA,RVER,RBL,SSFIN
    cmp frecuencia,20
    jle RS
    cmp frecuencia,40
    jle RAZ
    cmp frecuencia,60
    jle RAMA
    cmp frecuencia,80
    jle RVER
    cmp frecuencia,81
    jge RBL
    RS:
        mov ax,frecuenciaroja
        mov mgsonido,ax
        jmp SSFIN
    RAZ:
        mov ax,frecuenciaazul
        mov mgsonido,ax
        jmp SSFIN
    RAMA:
        mov ax,frecuenciaamarilla
        mov mgsonido,ax
        jmp SSFIN
    RVER:
        mov ax,frecuenciaverde
        mov mgsonido,ax
        jmp SSFIN
    RBL:
        mov ax,frecuenciablanca
        mov mgsonido,ax
        jmp SSFIN
    SSFIN:
endm

SONIDO macro frecuencia
    push ax
    push bx
    push dx
    push cx
    mov al, 86h
    out 43h, al
    SELECCIONSONIDO frecuencia
    mov ax, mgsonido
    out 42h, al
    mov al, ah
    out 42h, al
    in al, 61h
    or al, 00000011b
    out 61h, al
    RETARDANTE;AQUI INSERTAR UN DELAY PARA QUE SE EJECUTE EL SONIDO UN MOMENTO
    in al, 61h
    and al, 11111100b
    out 61h,al 
    pop cx
    pop dx
    pop bx
    pop ax
endm

CONTARELEMENTOS macro arreglo
LOCAL CE1,CEFIN
    mov cntusuarios,0
    xor si,si
    CE1:
        mov al,arreglo[si]
        cmp al,0
        je CEFIN
        inc si
        inc cntusuarios
        jmp CE1
    CEFIN:
        xor si,si
endm

ENCONTRARMAYOR macro arreglo ;ENCUENTRA EL VALOR MAS GRANDE DEL ARREGLO
LOCAL EM1,EMJ,EMF
    mov mayorvalor_p,0
    xor si,si
    EM1:
        mov dl,arreglo[si]
        cmp dl,0
        je EMF
        cmp dl,mayorvalor_p
        ja EMJ
        inc si
        jmp EM1
    EMJ:
        mov mayorvalor_p,dl
        inc si
        jmp EM1
    EMF:
endm

REGLADETRES macro numero
    mov dl,numero
    mov mgtempo,dl
    mov al,mgtempo
    mov bl,19
    mul bl
    mov mgtempo,al
    mov al,mgtempo
    mov bl,mayorvalor_p
    div bl
    mov mgtempo,al
endm

POSICIONINICIAL macro numero
    mov ah,0
    mov al,mgfinal
    mov si,numero
    mul si
    add al,2
    mov mginicio,al
endm

ANCHOBARRAS macro 
    xor ax,ax
    xor cx,cx
    xor bx,bx
    mov bx,cntusuarios
    mov cl,bl
    mov al,36
    mov bx,cntusuarios
    div bl
    mov mgfinal,al
endm

PANTALLAGRAFICAS macro ;PRUEBAS DEL METODO GRAFICO 
    mov ax,0013h
    int 10h
    mov mayorvalor_t,52
    REGLADETRES 60
    COLORBARRA mayorvalor_t
    GRAFICARBARRA mgtempo,mgcolor,4,2
    MARGEN_BARRAS
    mov ax,0003h
    int 10h
endm

GRAFICARBARRA macro altura,color,psx,psxf
LOCAL AMONOS
    push ax
    push bx
    push cx
    push dx
    cmp altura,0
    je AMONOS
    mov ah, 06h
    mov al, altura;ALTO DE LA BARRA 
    mov bh, color ;COLOR
    mov CH, 0 ;POSICION INICIAL DE ABAJO PARA ARRIBA; ## NO MODIFICAR ##
    mov CL, psx ;INICIO DEL ANCHO DE LA BARRA
    mov DH, 21 ; POSICION DONDE ESTA AL FINAL DE LA PANTALLA ## NO MODIFICAR ## 
    mov DL, psxf ;FINAL DEL ANCHO DE LA BARRA
    add dl,psx
    sub dl,2
    int 10h
AMONOS:
    pop dx
    pop cx  
    pop bx
    pop ax  
endm

CREATENUM macro arreglo
    mov al,arreglo
    mov shtemporal,al
    mov al,shtemporal
    AAM
    add ah,30h
    add al,30h
    mov shnumber[0],ah
    mov shnumber[1],al
endm

CREATENUM2 macro arreglo
    mov al,arreglo
    mov shtemporal,al
    mov al,shtemporal
    AAM
    add al,30h
    mov shnumber2[2],al
    mov al,ah
    AAM
    add ah,30h
    add al,30h
    mov shnumber2[0],ah
    mov shnumber2[1],al
endm

SHOW_GRAFICA macro arreglo
LOCAL DATOS,DATOSFIN
    xor si,si
    DATOS:
        REGLADETRES arreglo[si]
        COLORBARRA arreglo[si]
        POSICIONINICIAL si
        PUSH si
        SONIDO arreglo[si]
        mov al,arreglo[si]
        mov tomarvalor,al
        CALL DEFINIR
        GRAFICARBARRA mgtempo,mgcolor,mginicio,mgfinal
        CALL TIPODETEXTO
        POP si
        inc si
        cmp arreglo[si],0 ;CONTINUO HASTA QUE ENCUENTRE UN VALOR 0 EN EL ARREGLO
        jne DATOS
    DATOSFIN:
endm

;##########################################################################################################
OBTENERDATOS macro
    LIMPIARTXT catchbuffer, SIZEOF catchbuffer,24h
    LIMPIARTXT recolector, SIZEOF recolector,24h
    ABRIRFILE rutpuntos,handler
    READFILE handler, recolector,SIZEOF recolector
    CERRARFILE handler
    CATCHPUNTOS recolector
    LIMPIARTXT arreglonumeros,SIZEOF arreglonumeros,0
    LIMPIARTXT pila,SIZEOF pila,0
    LIMPIARTXT mostrardatos,SIZEOF mostrardatos,24h
    CONVERT_PTS catchbuffer,arreglonumeros
    ENCONTRARMAYOR arreglonumeros
    CONTARELEMENTOS arreglonumeros
    ANCHOBARRAS
    OBTENERALTO arreglonumeros
endm

OBTENERDATOST macro
    LIMPIARTXT catchbuffer, SIZEOF catchbuffer,24h
    LIMPIARTXT catchbuffer2, SIZEOF catchbuffer2,24h
    LIMPIARTXT recolector, SIZEOF recolector,24h
    ABRIRFILE ruttiempos,handler
    READFILE handler, recolector,SIZEOF recolector
    CERRARFILE handler
    CATCHTIEMPOS recolector
    ARREGLARTIEMPOS catchbuffer,catchbuffer2
    LIMPIARTXT arreglonumeros,SIZEOF arreglonumeros,0
    LIMPIARTXT pila,SIZEOF pila,0
    CONVERT_TMS catchbuffer2,arreglonumeros
    ENCONTRARMAYOR arreglonumeros
    CONTARELEMENTOS arreglonumeros
    ANCHOBARRAS
    OBTENERALTO arreglonumeros
endm

OBTENERDATOS2 macro arreglo
    LIMPIARPANTALLA2
    SHOW_GRAFICA arreglo
    MARGEN_BARRAS
endm

CATCHTIEMPOS macro arreglo
LOCAL CHT,CHT2,CHT3,CHT4,CHTFIN,SCHT2,SCHT3
    xor si,si
    xor di,di
    CHT:
        mov al,arreglo[si]
        cmp al,","
        je CHT2
        cmp al,"$"
        je CHTFIN
        inc si
        jmp CHT
    CHT2:
        inc si
        SCHT2:
            mov al,arreglo[si]
            cmp al,","
            je CHT3
            inc si
            jmp SCHT2
    CHT3:
        inc si
        SCHT3:
            mov al,arreglo[si]
            cmp al,";"
            je CHT4
            mov catchbuffer[di],al
            inc si
            inc di
            jmp SCHT3
    CHT4:
        mov catchbuffer[di],","
        inc si
        inc di
        jmp CHT
    CHTFIN:
        dec di
        mov catchbuffer[di],"$"
endm

ARREGLARTIEMPOS macro arreglo,arreglo2
LOCAL ART1,CERO2,CERO3,CERO1,ART2,ARTCL,ARTFIN,SUBART2
    xor si,si
    xor di,di
    ART1:
        mov al,arreglo[si]
        cmp al,"0"
        je CERO1
        cmp al,"$"
        je ARTFIN
        mov arreglo2[di],al
        jmp ART2

    CERO1:
        mov al,arreglo[si+1]
        cmp al,"0"
        je CERO2
        mov al,arreglo[si]
        mov arreglo2[di],al
        inc di
        mov al,arreglo[si+1]
        mov arreglo2[di],al
        inc di
        mov al,arreglo[si+2]
        mov arreglo2[di],al
        inc di
        add si,3
        mov al,arreglo[si]
        cmp al,","
        je ARTCL
        cmp al,"$"
        je ARTFIN
    
    CERO2:
        mov al,arreglo[si+2]
        cmp al,"0"
        je CERO3
        mov al,arreglo[si]
        mov arreglo2[di],al
        inc di
        mov al,arreglo[si+1]
        mov arreglo2[di],al
        inc di
        mov al,arreglo[si+2]
        mov arreglo2[di],al
        inc di
        add si,3
        mov al,arreglo[si]
        cmp al,","
        je ARTCL
        cmp al,"$"
        je ARTFIN

    CERO3:
        add si,4
        jmp ART1

    ART2:
        inc si
        inc di
        SUBART2:
            mov al,arreglo[si]
            cmp al,","
            je ARTCL
            mov arreglo2[di],al
            inc si
            inc di
            jmp SUBART2
    ARTCL:
        mov arreglo2[di],","
        inc di
        inc si
        jmp ART1

    ARTFIN:
        dec di
        mov arreglo2[di],"$"
endm

CATCHPUNTOS macro arreglo 
LOCAL CHP,CHP2,CHP3,SCHP2,SCHP3,CHPFIN,CHP4,CHPVER,CHPAND,CHPPAS
    xor si,si
    xor di,di
    CHP:
        mov al,arreglo[si]
        cmp al,","
        je CHP2
        cmp al,"$"
        je CHPFIN
        inc si
        jmp CHP
    CHP2:
        inc si
        SCHP2:
            mov al,arreglo[si]
            cmp al,","
            je CHP3
            inc si
            jmp SCHP2
    CHP3:
        inc si
        SCHP3:
            mov al,arreglo[si]
            cmp al,";"
            je CHP4
            cmp al,"0"
            je CHPVER
            mov catchbuffer[di],al
            inc si
            inc di
            jmp SCHP3
    CHPVER:
        inc si
        mov al,arreglo[si]
        cmp al,"0"
        je CHPPAS
        cmp al,";"
        je CHPAND
        mov catchbuffer[di],"0"
        inc di
        mov catchbuffer[di],al
        inc si
        inc di
        jmp SCHP3

    CHPPAS:
        inc si
        inc si
        jmp CHP
    CHPAND:
        mov catchbuffer[di],"0"
        inc di
        jmp SCHP3
    CHP4:
        mov catchbuffer[di],","
        inc si
        inc di
        jmp CHP
    CHPFIN:
        dec di
        mov catchbuffer[di],"$"
endm

;##########################################
CONVERT_PTS macro vector,nuevovector
LOCAL PRE1,PRE2,PRE3,AGAIN,FIN
    LIMPIARTXT nuevovector,SIZEOF nuevovector,0
    xor di,di
    xor si,si
    PRE1:
        mov al,vector[si]
        sub al,30h
        mov bl,10
        mul bl
        mov numerotemporal,al
        inc si 
    PRE2:
        mov al,vector[si]
        sub al,30h
        add numerotemporal,al
        mov cl,numerotemporal
        mov nuevovector[di],cl
        inc si
    PRE3:
        mov al,vector[si]
        cmp al,","
        je AGAIN
        cmp al,"$"
        je FIN
    AGAIN:
        mov cl,0
        mov numerotemporal,0
        inc si
        inc di
        jmp PRE1

    FIN:
        mov numerotemporal,0
endm

CONVERT_TMS macro vector,nuevovector
LOCAL PRET1,PRET2,PRET3,AGAINT,FINT,PRET4
    LIMPIARTXT nuevovector,SIZEOF nuevovector,0
    xor di,di
    xor si,si
    PRET1:
        mov al,vector[si]
        sub al,30h
        mov bl,100
        mul bl
        mov numerotemporal,al
        inc si 
    PRET2:
        mov bh,numerotemporal
        mov al,vector[si]
        sub al,30h
        mov bl,10
        mul bl
        add bh,al
        mov numerotemporal,bh
        inc si
    PRET3:
        mov al,vector[si]
        sub al,30h
        add numerotemporal,al
        mov cl,numerotemporal
        mov nuevovector[di],cl
        inc si
    PRET4:
        mov al,vector[si]
        cmp al,","
        je AGAINT
        cmp al,"$"
        je FINT
    AGAINT:
        mov cl,0
        mov numerotemporal,0
        inc si
        inc di
        jmp PRET1

    FINT:
        mov numerotemporal,0
endm

DESCONVERT_PTS macro nuevovector,deposito
    LOCAL POS1,POS2,POSOUT
    xor di,di
    xor si,si
    POS1:
        mov cl,nuevovector[si]
        mov numerotemporal,cl
        mov al,numerotemporal
        cmp al,0
        je POSOUT

    POS2:
        AAM
        add ah,30h
        add al,30h
        mov deposito[di],ah
        mov deposito[di+1],al
        mov deposito[di+2],","
        inc si
        add di,3
        jmp POS1

    POSOUT:
        dec di
        mov deposito[di],"$"
endm

;ASCENDENTE
BUBBLE_A macro nuevovector
LOCAL BUBLE1,CONTAR,PROCESO,SUBBE1,AJUSTEBB,CHANGEB,NOCHANGEB,SALBBLE
    mov ax,0013h
    int 10h
    ;CONTAR ELEMENTOS EN EL ARREGLO
    xor si,si
    BUBLE1:
        mov al,nuevovector[si]
        cmp al,0
        jne CONTAR
        jmp PROCESO

    CONTAR:
        inc si
        inc contadorbubble
        jmp BUBLE1

    ;PROCESO PARA ORDENAR
    PROCESO:
        dec contadorbubble
        xor si,si
        xor di,di
        SUBBE1:;17
            cmp contadorbubble,si
            je AJUSTEBB
            mov al,nuevovector[si]
            mov numero1,al
            mov al,nuevovector[si+1]
            mov numero2,al
            mov cl,numero1
            cmp cl,numero2
            ja CHANGEB
            jmp NOCHANGEB
        
        CHANGEB:
            mov nuevovector[si+1],cl
            mov al,numero2
            mov nuevovector[si],al
            PUSH SI
            OBTENERDATOS2 nuevovector
            POP SI
            inc si
            jmp SUBBE1          

        AJUSTEBB:
            mov si,0
            cmp contadorbubble,0
            je SALBBLE
            dec contadorbubble
            jmp SUBBE1

        NOCHANGEB:
            inc si
            jmp SUBBE1

        SALBBLE:
            GRAFICARTEXTO msgbubble,SIZEOF msgbubble,15,1,0
            GRAFICARTEXTO msgvel,SIZEOF msgvel,15,1,38
            GRAFICARTEXTO msgveloc,SIZEOF msgveloc,15,1,34
            GRAFICARTEXTO mgtiempo,SIZEOF mgtiempo,15,1,14
            GRAFICARTEXTO Tiempo2,SIZEOF Tiempo2,15,1,22
            GETCHAR8
            mov ah,10h
            int 16h
            mov ax,0003h
            int 10h
            LIMPIARRELOJ
endm

;DESCENDENTE 
BUBBLE_B macro nuevovector
LOCAL BUBLE1_B,CONTAR_B,PROCESO_B,SUBBE1_B,AJUSTEBB_B,CHANGEB_B,NOCHANGEB_B,SALBBLE_B
    ;CONTAR ELEMENTOS EN EL ARREGLO
    mov ax,0013h
    int 10h
    xor si,si
    BUBLE1_B:
        mov al,nuevovector[si]
        cmp al,0
        jne CONTAR_B
        jmp PROCESO_B

    CONTAR_B:
        inc si
        inc contadorbubble
        jmp BUBLE1_B

    ;PROCESO PARA ORDENAR
    PROCESO_B:
        dec contadorbubble
        xor si,si
        xor di,di
        SUBBE1_B:;17
            cmp contadorbubble,si
            je AJUSTEBB_B
            mov al,nuevovector[si]
            mov numero1,al
            mov al,nuevovector[si+1]
            mov numero2,al
            mov cl,numero1
            cmp cl,numero2
            jb CHANGEB_B
            jmp NOCHANGEB_B
        
        CHANGEB_B:
            mov nuevovector[si+1],cl
            mov al,numero2
            mov nuevovector[si],al
            PUSH SI
            OBTENERDATOS2 nuevovector
            POP SI
            inc si
            jmp SUBBE1_B          

        AJUSTEBB_B:
            mov si,0
            cmp contadorbubble,0
            je SALBBLE_B
            dec contadorbubble
            jmp SUBBE1_B

        NOCHANGEB_B:
            inc si
            jmp SUBBE1_B

        SALBBLE_B:
            GRAFICARTEXTO msgbubble,SIZEOF msgbubble,15,1,0
            GRAFICARTEXTO msgvel,SIZEOF msgvel,15,1,38
            GRAFICARTEXTO msgveloc,SIZEOF msgveloc,15,1,34
            GRAFICARTEXTO mgtiempo,SIZEOF mgtiempo,15,1,14
            GRAFICARTEXTO Tiempo2,SIZEOF Tiempo2,15,1,22
            GETCHAR8
            mov ah,10h
            int 16h
            mov ax,0003h
            int 10h
            LIMPIARRELOJ
endm

;################################################### SHELL SORT ############
;ASCENDENTE
SHELLSORT_A macro nuevovector
LOCAL SHELL1,CONTARS,PROCESOS,CALCULO,SUBSHELL1,CAMBIARS,NOCAMBIARS,VERSHELL,AJUSTESH
LOCAL CASOESPECIAL,SUBESPECIAL,SUBCAMBIO,SUBNOCAMBIO,SALSHELL
    ;CONTAR ELEMENTOS EN EL ARREGLO
    mov ax,0013h
    int 10h
    xor ax,ax
    xor si,si
    SHELL1:
        mov bl,nuevovector[si]
        cmp bl,0
        jne CONTARS
        jmp PROCESOS

    CONTARS:
        inc si
        inc ax
        jmp SHELL1
;########################### proceso ;14
    PROCESOS:
        xor di,di
        xor si,si
        CALCULO:
            mov constantek,ax
            xor ax,ax
            mov ax,constantek
            mov bl,2
            div bl
            mov ah,0
            mov constantek,ax
            jmp SUBSHELL1

        SUBSHELL1:;28
            cmp constantek,1
            je CASOESPECIAL
            mov bl,nuevovector[si]
            mov numero1s,bl
            add di,ax
            mov bl,nuevovector[di]
            mov numero2s,bl
            cmp numero1s,bl
            ja CAMBIARS
            jmp NOCAMBIARS

        CAMBIARS:
            mov bl,numero2s
            mov nuevovector[si],bl
            mov bl,numero1s
            mov nuevovector[di],bl
            PUSH ax
            PUSH si
            OBTENERDATOS2 nuevovector
            PUSH si
            POP ax
            xor si,si
            xor di,di
            jmp SUBSHELL1

        NOCAMBIARS:
            add si,ax
            mov bl,nuevovector[si]
            mov numero1s,bl
            add di,ax
            mov bl,nuevovector[di]
            mov numero2s,bl
            cmp numero2s,0
            je AJUSTESH
            jne VERSHELL

        VERSHELL:
            mov bl,numero2s
            cmp numero1s,bl
            ja CAMBIARS
            jmp NOCAMBIARS

        AJUSTESH:
            xor si,si
            xor di,di
            jmp CALCULO

        CASOESPECIAL:
            xor si,si
            xor di,di
            SUBESPECIAL:
                mov bl,nuevovector[si]
                mov numero1s,bl
                mov bl,nuevovector[si+1]
                mov numero2s,bl
                cmp bl,0
                je SALSHELL
                cmp numero1s,bl
                ja SUBCAMBIO
                jmp SUBNOCAMBIO
            SUBCAMBIO:
                mov bl,numero2s
                mov nuevovector[si],bl
                mov bl,numero1s
                mov nuevovector[si+1],bl
                PUSH si
                OBTENERDATOS2 nuevovector
                POP si
                xor si,si
                jmp SUBESPECIAL
            SUBNOCAMBIO:
                inc si
                jmp SUBESPECIAL
        SALSHELL:
            GRAFICARTEXTO msgshell,SIZEOF msgshell,15,1,0
            GRAFICARTEXTO msgvel,SIZEOF msgvel,15,1,38
            GRAFICARTEXTO msgveloc,SIZEOF msgveloc,15,1,34
            GRAFICARTEXTO mgtiempo,SIZEOF mgtiempo,15,1,14
            GRAFICARTEXTO Tiempo2,SIZEOF Tiempo2,15,1,22
            GETCHAR8
            mov ah,10h
            int 16h
            mov ax,0003h
            int 10h
            LIMPIARRELOJ
endm

;DESCENDENTE 
SHELLSORT_B macro nuevovector
LOCAL SHELL1_B,CONTARS_B,PROCESOS_B,CALCULO_B,SUBSHELL1_B,CAMBIARS_B,NOCAMBIARS_B,VERSHELL_B,AJUSTESH_B
LOCAL CASOESPECIAL_B,SUBESPECIAL_B,SUBCAMBIO_B,SUBNOCAMBIO_B,SALSHELL_B
    ;CONTAR ELEMENTOS EN EL ARREGLO
    mov ax,0013h
    int 10h
    xor ax,ax
    xor si,si
    SHELL1_B:
        mov bl,nuevovector[si]
        cmp bl,0
        jne CONTARS_B
        jmp PROCESOS_B

    CONTARS_B:
        inc si
        inc ax
        jmp SHELL1_B
;########################### proceso ;14
    PROCESOS_B:
        xor di,di
        xor si,si
        CALCULO_B:
            mov constantek,ax
            xor ax,ax
            mov ax,constantek
            mov bl,2
            div bl
            mov ah,0
            mov constantek,ax
            jmp SUBSHELL1_B

        SUBSHELL1_B:;28
            cmp constantek,1
            je CASOESPECIAL_B
            mov bl,nuevovector[si]
            mov numero1s,bl
            add di,ax
            mov bl,nuevovector[di]
            mov numero2s,bl
            cmp numero1s,bl
            jb CAMBIARS_B
            jmp NOCAMBIARS_B

        CAMBIARS_B:
            mov bl,numero2s
            mov nuevovector[si],bl
            mov bl,numero1s
            mov nuevovector[di],bl
            PUSH ax
            PUSH SI
            OBTENERDATOS2 nuevovector
            POP SI
            POP ax
            xor si,si
            xor di,di
            jmp SUBSHELL1_B

        NOCAMBIARS_B:
            add si,ax
            mov bl,nuevovector[si]
            mov numero1s,bl
            add di,ax
            mov bl,nuevovector[di]
            mov numero2s,bl
            cmp numero2s,0
            je AJUSTESH_B
            jne VERSHELL_B

        VERSHELL_B:
            mov bl,numero2s
            cmp numero1s,bl
            jb CAMBIARS_B
            jmp NOCAMBIARS_B

        AJUSTESH_B:
            xor si,si
            xor di,di
            jmp CALCULO_B

        CASOESPECIAL_B:
            xor si,si
            xor di,di
            SUBESPECIAL_B:
                mov bl,nuevovector[si]
                mov numero1s,bl
                mov bl,nuevovector[si+1]
                mov numero2s,bl
                cmp bl,0
                je SALSHELL_B
                cmp numero1s,bl
                jb SUBCAMBIO_B
                jmp SUBNOCAMBIO_B
            SUBCAMBIO_B:
                mov bl,numero2s
                mov nuevovector[si],bl
                mov bl,numero1s
                mov nuevovector[si+1],bl
                PUSH SI
                OBTENERDATOS2 nuevovector
                POP SI
                xor si,si
                jmp SUBESPECIAL_B
            SUBNOCAMBIO_B:
                inc si
                jmp SUBESPECIAL_B
        SALSHELL_B:
            GRAFICARTEXTO msgshell,SIZEOF msgshell,15,1,0
            GRAFICARTEXTO msgvel,SIZEOF msgvel,15,1,38
            GRAFICARTEXTO msgveloc,SIZEOF msgveloc,15,1,34
            GRAFICARTEXTO mgtiempo,SIZEOF mgtiempo,15,1,14
            GRAFICARTEXTO Tiempo2,SIZEOF Tiempo2,15,1,22
            GETCHAR8
            mov ah,10h
            int 16h
            mov ax,0003h
            int 10h
            LIMPIARRELOJ
endm

;####################################################### QUICK SORT
;SOLO PARA LOS REGISTRO DE QUICK Y NO PERDER INFO
PUSHQUICK MACRO 
    PUSH di
    PUSH si
    PUSH cx
    PUSH dx
    PUSH ax
ENDM
;SOLO PARA RECUPERAR LOS REGISTRO DE QUICK Y NO PERDER INFO
POPQUICK MACRO
    POP ax
    POP dx
    POP cx
    POP si
    POP di
ENDM

OBTENERALTO macro arreglo
LOCAL OBA,OBF
    xor di,di
    OBA:
        mov al,arreglo[di]
        cmp al,0
        je OBF
        inc di
        inc indexhigh
        jmp OBA
    OBF:
        dec indexhigh ;HASTA AQUI TODO BIEN
endm

PARTICION_A macro arreglo,ibajo,ialto
LOCAL CICLO,SWAP,PFIN
    xor si,si
    xor di,di
    xor cx,cx
    xor dx,dx

    mov cl,ibajo
    sub cl,1
    mov ch,0
    mov ayudante,cl ;i = (i-1)

    mov cl,ialto
    mov ch,0
    mov di,cx
    mov cl,arreglo[di]
    mov pivote,cl

    xor cx,cx
    mov cl,ibajo
    mov di,cx

    xor cx,cx
    mov cl,ialto
    mov tope,cx

    CICLO:;15
        ;SALTO
        ;PRINT nameadmin
        ;GETCHAR8
        mov cl,pivote
        cmp arreglo[di],cl
        jl SWAP
        inc di
        cmp di,tope
        jl CICLO
        jmp PFIN
    SWAP:
        mov cl,ayudante
        add cl,1
        mov ayudante,cl
        xor cx,cx
        mov cl,ayudante
        mov si,cx
        xor dx,dx
        mov dl,arreglo[si]
        mov dh,arreglo[di]
        mov arreglo[si],dh
        mov arreglo[di],dl
        inc di
        jmp CICLO
    PFIN:
        xor cx,cx ;aumentar antes
        mov cl,ayudante
        inc cl
        mov ayudante,cl
        xor si,si
        xor di,di
        mov si,cx
        mov dl,ialto
        mov dh,0
        mov di,dx ; di = alto
        mov dl,arreglo[si]
        mov dh,arreglo[di]
        mov arreglo[si],dh
        mov arreglo[di],dl
        ;aumentar despues se encicla y acumula basura
        OBTENERDATOS2 arreglo
endm

QUICKSORT_A macro arreglo,ibajo,ialto
LOCAL WHILE,QCK2,QCK3,LEFT,RIGHT,SALWHILE
    xor si,si
    xor di,di
    xor ax,ax
    xor cx,cx

    dec di
    add di,1
    mov al,ibajo
    mov pila[di],al
    add di,1
    mov al,ialto
    mov pila[di],al
    WHILE:
        mov al,pila[di]
        mov ialto,al
        sub di,1
        mov al,pila[di]
        mov ibajo,al
        sub di,1

        PUSHQUICK
        PARTICION_A arreglo,ibajo,ialto
        POPQUICK

        mov al,ibajo
        dec ayudante
        cmp ayudante,al
        jg LEFT
        inc ayudante
        jmp QCK2
    
    LEFT:
        inc ayudante
        add di,1
        mov al,ibajo
        mov pila[di],al
        add di,1
        dec ayudante
        mov al,ayudante
        mov pila[di],al
        inc ayudante
        jmp QCK2

    QCK2:
        mov al,ialto
        inc ayudante
        cmp ayudante,al
        jl RIGHT
        dec ayudante
        jmp QCK3

    RIGHT:
        dec ayudante
        add di,1
        inc ayudante
        mov al,ayudante
        mov pila[di],al
        dec ayudante
        add di,1
        mov al,ialto
        mov pila[di],al
        jmp QCK3
    QCK3:
        cmp di,0
        jge WHILE
    SALWHILE:
            GRAFICARTEXTO msgquick,SIZEOF msgquick,15,1,0
            GRAFICARTEXTO msgvel,SIZEOF msgvel,15,1,38
            GRAFICARTEXTO msgveloc,SIZEOF msgveloc,15,1,34
            GRAFICARTEXTO mgtiempo,SIZEOF mgtiempo,15,1,14
            GRAFICARTEXTO Tiempo2,SIZEOF Tiempo2,15,1,22
            LIMPIARRELOJ
endm


PARTICION_B macro arreglo,ibajo,ialto
LOCAL CICLO_B,SWAP_B,PFIN_B
    xor si,si
    xor di,di
    xor cx,cx
    xor dx,dx

    mov cl,ibajo
    sub cl,1
    mov ch,0
    mov ayudante,cl ;i = (i-1)

    mov cl,ialto
    mov ch,0
    mov di,cx
    mov cl,arreglo[di]
    mov pivote,cl

    xor cx,cx
    mov cl,ibajo
    mov di,cx

    xor cx,cx
    mov cl,ialto
    mov tope,cx

    CICLO_B:;15
        ;SALTO
        ;PRINT nameadmin
        ;GETCHAR8
        mov cl,pivote
        cmp arreglo[di],cl
        jg SWAP_B
        inc di
        cmp di,tope
        jl CICLO_B
        jmp PFIN_B
    SWAP_B:
        mov cl,ayudante
        add cl,1
        mov ayudante,cl
        xor cx,cx
        mov cl,ayudante
        mov si,cx
        xor dx,dx
        mov dl,arreglo[si]
        mov dh,arreglo[di]
        mov arreglo[si],dh
        mov arreglo[di],dl
        inc di
        jmp CICLO_B
    PFIN_B:
        xor cx,cx ;aumentar antes
        mov cl,ayudante
        inc cl
        mov ayudante,cl
        xor si,si
        xor di,di
        mov si,cx
        mov dl,ialto
        mov dh,0
        mov di,dx ; di = alto
        mov dl,arreglo[si]
        mov dh,arreglo[di]
        mov arreglo[si],dh
        mov arreglo[di],dl
        ;aumentar despues se encicla y acumula basura
        OBTENERDATOS2 arreglo
endm

QUICKSORT_B macro arreglo,ibajo,ialto
LOCAL WHILE_B,QCK2_B,QCK3_B,LEFT_B,RIGHT_B,SALWHILE_B
    xor si,si
    xor di,di
    xor ax,ax
    xor cx,cx

    dec di
    add di,1
    mov al,ibajo
    mov pila[di],al
    add di,1
    mov al,ialto
    mov pila[di],al
    WHILE_B:
        mov al,pila[di]
        mov ialto,al
        sub di,1
        mov al,pila[di]
        mov ibajo,al
        sub di,1

        PUSHQUICK
        PARTICION_B arreglo,ibajo,ialto
        POPQUICK

        mov al,ibajo
        dec ayudante
        cmp ayudante,al
        jg LEFT_B
        inc ayudante
        jmp QCK2_B
    
    LEFT_B:
        inc ayudante
        add di,1
        mov al,ibajo
        mov pila[di],al
        add di,1
        dec ayudante
        mov al,ayudante
        mov pila[di],al
        inc ayudante
        jmp QCK2_B
        

    QCK2_B:
        mov al,ialto
        inc ayudante
        cmp ayudante,al
        jl RIGHT_B
        dec ayudante
        jmp QCK3_B

    RIGHT_B:
        dec ayudante
        add di,1
        inc ayudante
        mov al,ayudante
        mov pila[di],al
        dec ayudante
        add di,1
        mov al,ialto
        mov pila[di],al
        jmp QCK3_B
    QCK3_B:
        cmp di,0
        jge WHILE_B
    SALWHILE_B:
            GRAFICARTEXTO msgquick,SIZEOF msgquick,15,1,0
            GRAFICARTEXTO msgvel,SIZEOF msgvel,15,1,38
            GRAFICARTEXTO msgveloc,SIZEOF msgveloc,15,1,34
            GRAFICARTEXTO mgtiempo,SIZEOF mgtiempo,15,1,14
            GRAFICARTEXTO Tiempo2,SIZEOF Tiempo2,15,1,22
            LIMPIARRELOJ
endm