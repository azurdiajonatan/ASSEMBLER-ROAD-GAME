DELAYS macro constante
LOCAL E1,E2,EF
    push si
    push di
    mov si,constante
    E1:
        dec si
        jz EF
        mov di,constante
    E2:
        dec di
        jnz E2
        jmp E1
    EF:
        pop di
        pop si
endm

GRAFICARTEXTO macro buffer,numbytes,color,fila,columna
    push ax
    push cx
    push bx
    push dx
    mov ax, @data
    mov es, ax
    mov bp, offset buffer
    mov ah, 13h
    mov al, 01h
    xor bh, 0
    mov bl, color
    mov cx, numbytes
    mov dh, fila
    mov dl, columna
    int 10h
    pop dx
    pop bx
    pop cx
    pop ax
endm


PRINTPIXEL macro px,py, color ;PINTA UN PIXEL EN LA PANTALLA
    push cx
    mov ah,0ch
    mov al,color
    mov bh,0h
    mov dx,py
    mov cx,px
    int 10h
    pop cx
endm

GRAFICARMARGEN macro
LOCAL, ABC1,ABC2,ABC3,ABC4,ABC5
    mov cx,12
    mov dx,9
    ABC1:
        PRINTPIXEL cx,dx,1fh
        cmp cx,200
        je ABC2
        inc cx
        jmp ABC1
    ABC2:
        PRINTPIXEL cx,dx,1fh
        cmp dx,191
        je ABC3
        inc dx
        jmp ABC2
    ABC3:
        PRINTPIXEL cx,dx,1fh
        cmp cx,12
        je ABC4
        dec cx
        jmp ABC3
    ABC4:
        PRINTPIXEL cx,dx,1fh
        cmp dx,9
        je ABC5
        dec dx
        jmp ABC4
    ABC5:              
endm

GRAFICARCARRO macro psx,gcolor
LOCAL GCD,GCD2,GCD3
    push ax
    push bx
    push cx
    push dx
    xor dx,dx
    MOV cx,psx
    mov dx,160
    mov bx,cx
    add bx,17
    GCD:
        PRINTPIXEL cx,dx,gcolor
        cmp dx,185
        je  GCD2
        inc dx
        jmp GCD
    GCD2:
        PRINTPIXEL cx,dx,gcolor
        cmp cx,bx
        je GCD3
        inc cx
        mov dx,160
        jmp GCD

    GCD3:
        mov cx,psx
        sub cx,2
        PRINTPIXEL cx,165,19H
        PRINTPIXEL cx,166,19H
        PRINTPIXEL cx,167,19H
        PRINTPIXEL cx,168,19H
        PRINTPIXEL cx,178,19H
        PRINTPIXEL cx,179,19H
        PRINTPIXEL cx,180,19H
        PRINTPIXEL cx,181,19H
        inc cx
        PRINTPIXEL cx,165,19H
        PRINTPIXEL cx,166,19H
        PRINTPIXEL cx,167,19H
        PRINTPIXEL cx,168,19H
        PRINTPIXEL cx,178,19H
        PRINTPIXEL cx,179,19H
        PRINTPIXEL cx,180,19H
        PRINTPIXEL cx,181,19H ;DOS PARES DE LLANTAS
        add cx,19
        PRINTPIXEL cx,165,19H
        PRINTPIXEL cx,166,19H
        PRINTPIXEL cx,167,19H
        PRINTPIXEL cx,168,19H
        PRINTPIXEL cx,178,19H
        PRINTPIXEL cx,179,19H
        PRINTPIXEL cx,180,19H
        PRINTPIXEL cx,181,19H
        inc cx
        PRINTPIXEL cx,165,19H
        PRINTPIXEL cx,166,19H
        PRINTPIXEL cx,167,19H
        PRINTPIXEL cx,168,19H
        PRINTPIXEL cx,178,19H
        PRINTPIXEL cx,179,19H
        PRINTPIXEL cx,180,19H
        PRINTPIXEL cx,181,19H ;DOS PARES DE LLANTAS

    pop dx
    pop cx  
    pop bx
    pop ax  
endm

ACTUALIZARCARRO macro psx
LOCAL BCD,BCD2,BCD3
    push ax
    push bx
    push cx
    push dx
    xor bx,bx
    xor dx,dx
    MOV cx,psx
    mov dx,160
    mov bx,cx
    add bx,17
    BCD:
        PRINTPIXEL cx,dx,00h
        cmp dx,185
        je  BCD2
        inc dx
        jmp BCD
    BCD2:
        PRINTPIXEL cx,dx,00h
        cmp cx,bx
        je BCD3
        inc cx
        mov dx,160
        jmp BCD

    BCD3:
        mov cx,psx
        sub cx,2
        PRINTPIXEL cx,165,00H
        PRINTPIXEL cx,166,00H
        PRINTPIXEL cx,167,00H
        PRINTPIXEL cx,168,00H
        PRINTPIXEL cx,178,00H
        PRINTPIXEL cx,179,00H
        PRINTPIXEL cx,180,00H
        PRINTPIXEL cx,181,00H
        inc cx
        PRINTPIXEL cx,165,00H
        PRINTPIXEL cx,166,00H
        PRINTPIXEL cx,167,00H
        PRINTPIXEL cx,168,00H
        PRINTPIXEL cx,178,00H
        PRINTPIXEL cx,179,00H
        PRINTPIXEL cx,180,00H
        PRINTPIXEL cx,181,00H ;DOS PARES DE LLANTAS
        add cx,19
        PRINTPIXEL cx,165,00H
        PRINTPIXEL cx,166,00H
        PRINTPIXEL cx,167,00H
        PRINTPIXEL cx,168,00H
        PRINTPIXEL cx,178,00H
        PRINTPIXEL cx,179,00H
        PRINTPIXEL cx,180,00H
        PRINTPIXEL cx,181,00H
        inc cx
        PRINTPIXEL cx,165,00H
        PRINTPIXEL cx,166,00H
        PRINTPIXEL cx,167,00H
        PRINTPIXEL cx,168,00H
        PRINTPIXEL cx,178,00H
        PRINTPIXEL cx,179,00H
        PRINTPIXEL cx,180,00H
        PRINTPIXEL cx,181,00H ;DOS PARES DE LLANTAS

    pop dx
    pop cx  
    pop bx
    pop ax 
endm

PUSHDATOS macro
    PUSH ax
    PUSH bx
    PUSH dx
    PUSH cx
endm

POPDATOS macro
    POP cx
    POP dx
    POP bx
    POP ax
endm

SUMARPUNTOS macro valor
LOCAL UNNUM,DOSNUM,FINNUM,FINNUM2,FNN
    push ax
    push bx
    push cx
    mov cl,puntosglobales
    mov al,valor
    add cl,al
    mov puntosglobales,cl
    cmp cl,99
    jg FINNUM
    cmp cl,9
    jle UNNUM
    ja DOSNUM

    UNNUM:
        mov al,cl
        add al,30h
        mov pts[1],al
        sub al,30h
        jmp FINNUM
    DOSNUM:
        mov auxptglobal,cl
        mov al,auxptglobal
        AAM
        add ah,30h
        add al,30h
        mov pts[0],ah
        mov pts[1],al
    FINNUM:
        GRAFICARTEXTO pts,SIZEOF pts,15,16,33
        jmp FNN
    FINNUM2:
        mov pts[0],"9"
        mov pts[1],"9"
        mov banderasalida,1
        GRAFICARTEXTO pts,SIZEOF pts,15,16,33
    FNN:
    pop cx
    pop bx
    pop ax
endm

RESTARPUNTOS macro valor
LOCAL UNNUM_B,DOSNUM_B,FINNUM_B,FINNUM_B2,FNN2
    push ax
    push bx
    push cx
    mov cl,puntosglobales
    mov al,valor
    sub cl,al
    mov puntosglobales,cl
    cmp cl,00
    jl FINNUM_B2
    cmp cl,9
    jle UNNUM_B
    ja DOSNUM_B

    UNNUM_B:
        mov al,cl
        add al,30h
        mov pts[1],al
        sub al,30h
        jmp FINNUM_B
    DOSNUM_B:
        mov auxptglobal,cl
        mov al,auxptglobal
        AAM
        add ah,30h
        add al,30h
        mov pts[0],ah
        mov pts[1],al
    FINNUM_B:
        GRAFICARTEXTO pts,SIZEOF pts,15,16,33
        jmp FNN2
    FINNUM_B2:
        mov puntosglobales,0
        mov pts[0],"0"
        mov pts[1],"0"
        mov banderasalida,1
        GRAFICARTEXTO pts,SIZEOF pts,15,16,33
    FNN2:
    pop cx
    pop bx
    pop ax
endm

MOVEROBSTACULO macro xx,yy,color,premio
LOCAL MOB1,BOB,MOBFIN,AUMENTO
PUSHDATOS
    xor ax,ax
    xor bx,bx
    xor dx,dx
    xor cx,cx
    mov cx,xx
    mov dx,yy
    mov esposx,cx
    mov esposy,dx
    MOB1:
        BORRAROBSTACULO esposx,esposy
        add esposy,12
        mov bx,esposy
        cmp bx,182
        ja BOB
        mov esposy,bx
        xor cx,cx
        xor dx,dx
        xor ax,ax
        mov ah,0dh 
        mov cx, esposy
        mov dx, esposx
        int 10H
        cmp al,colorauto
        je AUMENTO
        cmp al,25
        je AUMENTO

        GRAFICAROBSTACULOS esposx,esposy,color
        jmp MOBFIN
    BOB:
        BORRAROBSTACULO esposx,esposy
        mov esposx,170
        mov esposy,10
        jmp MOBFIN
    AUMENTO:
        SUMARPUNTOS premio
        BORRAROBSTACULO esposx,esposy
        mov esposx,170
        mov esposy,10
    MOBFIN:
POPDATOS
endm

MOVEROBSTACULO2 macro xx,yy,color,castigo
LOCAL MOB1_B,BOB_B,MOBFIN_B,AUMENTO_B
PUSHDATOS
    xor ax,ax
    xor bx,bx
    xor dx,dx
    xor cx,cx
    mov cx,xx
    mov dx,yy
    mov posobx1,cx
    mov posoby1,dx
    MOB1_B:
        BORRAROBSTACULO posobx1,posoby1
        add posoby1,12
        mov bx,posoby1
        cmp bx,182
        ja BOB_B
        mov posoby1,bx
        xor cx,cx
        xor dx,dx
        xor ax,ax
        mov ah,0dh 
        mov cx, posoby1
        mov dx, posobx1
        int 10H
        cmp al,colorauto
        je AUMENTO_B
        cmp al,25
        je AUMENTO_B

        GRAFICAROBSTACULOS posobx1,posoby1,color
        jmp MOBFIN_B
    BOB_B:
        BORRAROBSTACULO posobx1,posoby1
        mov posobx1,20
        mov posoby1,10
        JMP MOBFIN_B
    AUMENTO_B:
        RESTARPUNTOS castigo
        BORRAROBSTACULO esposx,esposy
        mov posobx1,20
        mov posoby1,10
    MOBFIN_B:
POPDATOS
endm

BORRAROBSTACULO macro xx,yy
    LOCAL GE1,GE2,GE3
    push ax
    push bx
    push cx
    push dx
    xor ax,ax
    xor bx,bx  
    xor cx,cx
    xor dx,dx

    mov bx,yy ;numero fijo al cual regresar de fila
    MOV cx,xx ;filas esta se va a mover
    mov dx,yy ;columnas que recibo
    mov limite1,cx
    mov limite2,dx
    add limite1,12
    add limite2,12
    GE1:
        PRINTPIXEL cx,dx,00h
        cmp dx,limite2
        je GE2
        inc dx
        jmp GE1
    GE2:
        PRINTPIXEL cx,dx,00h
        cmp cx,limite1
        je GE3
        inc cx
        mov dx,bx
        jmp GE1    
    GE3:
        pop dx
        pop cx  
        pop bx
        pop ax     
endm

GRAFICAROBSTACULOS macro xx,yy,color
LOCAL GA1,GA2,GA3
    push ax
    push bx
    push cx
    push dx
    xor ax,ax
    xor bx,bx  
    xor cx,cx
    xor dx,dx

    mov bx,yy ;numero fijo al cual regresar de fila
    MOV cx,xx ;filas esta se va a mover
    mov dx,yy ;columnas que recibo
    mov limite1,cx
    mov limite2,dx
    add limite1,12
    add limite2,12
    GA1:    
        PRINTPIXEL cx,dx,color
        cmp dx,limite2
        je GA2
        inc dx
        jmp GA1
    GA2:
        PRINTPIXEL cx,dx,color
        cmp cx,limite1
        je GA3
        inc cx
        mov dx,bx
        jmp GA1        
    GA3:
        pop dx
        pop cx  
        pop bx
        pop ax 
endm

PROBARCRONO macro
    mov ax,0013h
    int 10h
    ;PINTARFONDO
    mov ah,10h
    int 16h
    mov ax,0003h
    int 10h
endm

IMPRIMIRTEXTO macro
    GRAFICARTEXTO mgnombre,SIZEOF mgnombre,4fh,5,27
    GRAFICARTEXTO rebusuario,SIZEOF rebusuario,15,7,28
    GRAFICARTEXTO mgnivel,SIZEOF mgnivel,4fh,9,27
    GRAFICARTEXTO mgpuntos,SIZEOF mgpuntos,4fh,14,27
    GRAFICARTEXTO mgtiempo,SIZEOF mgtiempo,4fh,19,27
    GRAFICARTEXTO pts,SIZEOF pts,15,16,33
    GRAFICARTEXTO numeronivel,SIZEOF numeronivel,15,11,28
endm

PANTALLAPRUEBA macro
    mov ax,0013h
    int 10h
    GRAFICAROBSTACULOS 12,90,68
    GRAFICAROBSTACULOS 120,90,48
    mov ah,10h
    int 16h
    mov ax,0003h
    int 10h
endm

GRAFICARJUEGOFABRICA macro gcolor,gtiempo,ptpre,pto
LOCAL GJ_B,GJ1_B,GJ2_B,PASAR_B,MOVIZQ_B,MOVDER_B,NODER_B,NOIZQ_B,PINTIZQ_B,PINTDER_B,SALDELJUEGO_B,PAUSAR_B,PAUSAJUEGO_B,QUITARPAUSA_B,INIT_A_B
    xor si,si
    xor ax,ax
    mov ax,0013h
    int 10h
    mov ah,02h
    int 1ah
    mov al,dh
    IMPRIMIRTEXTO
    GRAFICARMARGEN
    GJ_B:
        INIT_A_B:
            cmp si,gtiempo
            je SALDELJUEGO_B

        GJ1_B:
            push ax;para guardar el al
            GRAFICARCARRO posxi,gcolor
            mov ah,01h
            int 16h;20
            cmp ah,4bh
            je MOVIZQ_B
            cmp ah,4dh
            je MOVDER_B
            cmp al,27
            je PAUSAR_B
            cmp al,'b'
            je SALDELJUEGO_B
        GJ2_B:
            cmp banderasalida,1
            je SALDELJUEGO_B
            pop ax;para sacar el al
            mov ah,02h
            int 1ah
            cmp al,dh
            jnz PASAR_B
            jmp INIT_A_B
        PASAR_B:
            CALL CRONOS
            GRAFICARTEXTO Tiempo,SIZEOF Tiempo,15,21,31;20
            MOVEROBSTACULO esposx,esposy,48,ptpre
            MOVEROBSTACULO2 posobx1,posoby1,68,pto
            SUMARPUNTOS 1
            mov ah,02h
            int 1ah
            mov al,dh
            inc si
            jmp INIT_A_B  
        MOVIZQ_B:
            mov ah,00h
            int 16h
            cmp ah,4bh
            je PINTIZQ_B
            jmp GJ2_B
        MOVDER_B:
            mov ah,00h
            int 16h
            cmp ah,4dh
            je PINTDER_B
            jmp GJ2_B
        PINTIZQ_B:;20
            ACTUALIZARCARRO posxi
            cmp posxi,18
            jb NOIZQ_B
            sub posxi,5
            jmp GJ2_B
        NOIZQ_B:
            jmp GJ2_B
        NODER_B:
            jmp GJ2_B
        PINTDER_B:
            ACTUALIZARCARRO posxi
            cmp posxi,178
            ja NODER_B
            add posxi,5
            jmp GJ2_B
        PAUSAR_B:
            mov ah,00h
            int 16h
            cmp al,27
            je PAUSAJUEGO_B
            jmp GJ2_B
        PAUSAJUEGO_B:
            GRAFICARTEXTO mgpausa,SIZEOF mgpausa,4FH,13,8 ;pinto de un color 
            mov ah,00h
            int 16h
            cmp al,27
            je QUITARPAUSA_B
            jmp PAUSAJUEGO_B 
        QUITARPAUSA_B:
            GRAFICARTEXTO mgpausa,SIZEOF mgpausa,00H,13,8 ;pinto de negro para borrar 
            RESTARPUNTOS 5
            mov ah,02h
            int 1ah
            mov al,dh
            jmp INIT_A_B
        SALDELJUEGO_B:
            GRAFICARTEXTO mgsalida,SIZEOF mgsalida,4FH,13,8 ;pinto de negro para borrar 
            DELAYS retardoreloj
            MODIFICARARCHIVO_PTS
            MODIFICARARCHIVO_TMS
            mov posxi,95
            xor si,si
            mov ax,0003h
            int 10h
            VALORESFABRICA
endm

GRAFICARJUEGO macro gcolor,gtiempo,timeo,timep,ptob,ptpre
LOCAL GJ,GJINICIO,GJ2,PASARJ,MOVIZQ,MOVDER,NODER,NOIZQ,PINTIZQ,PINTDER,SAL,SALDELJUEGO,PAUSAR,PAUSAJUEGO,QUITARPAUSA,FINFALF,PASARNIVEL,INIT_A
    xor si,si
    xor ax,ax
    xor cx,cx
    xor dx,dx
    xor bx,bx
    mov dl,0 ;para tiempo de obstaculos
    mov dh,0 ;para tiempo de premios
    mov ax,0013h
    int 10h
    mov ah,02h
    int 1ah
    mov al,dh
    IMPRIMIRTEXTO
    GRAFICARMARGEN
        GJINICIO:
            cmp si,gtiempo
            je SALDELJUEGO
            push ax;para guardar el al
            GRAFICARCARRO posxi,gcolor
            mov ah,01h
            int 16h
            cmp ah,4bh
            je MOVIZQ
            cmp ah,4dh
            je MOVDER
            cmp al,27
            je PAUSAR
            cmp al,'b'
            je ACTIVARSALIDA
        GJ2:
            cmp banderasalida,1
            je SALDELJUEGO
            cmp dx,timeo
            je OBST
            cmp bx,timep
            je PREM
            pop ax;para sacar el al
            mov ah,02h
            int 1ah
            cmp al,dh
            jnz PASARJ
            jmp GJINICIO
        PASARJ:
            CALL CRONOS
            GRAFICARTEXTO Tiempo,SIZEOF Tiempo,15,21,31
            MOVEROBSTACULO esposx,esposy,48,ptpre
            MOVEROBSTACULO2 posobx1,posoby1,68,ptob
            ;SUMARPUNTOS 1
            mov ah,02h
            int 1ah
            mov al,dh
            inc si
            inc dx
            inc bx
            jmp GJINICIO    
        MOVIZQ:
            mov ah,00h
            int 16h
            cmp ah,4bh
            je PINTIZQ
            jmp GJ2
        MOVDER:
            mov ah,00h
            int 16h
            cmp ah,4dh
            je PINTDER
            jmp GJ2
        PINTIZQ:
            ACTUALIZARCARRO posxi
            cmp posxi,18
            jb NOIZQ
            sub posxi,5
            jmp GJ2
        NOIZQ:
            jmp GJ2
        NODER:
            jmp GJ2
        PINTDER:
            ACTUALIZARCARRO posxi
            cmp posxi,178
            ja NODER
            add posxi,5
            jmp GJ2
        OBST:
            ;CREACIONOBJETOS vectorjuego[di],10,68,ptob
            RESTARPUNTOS ptob
            mov dx,0
            jmp GJ2
        PREM:
            ;CREACIONOBJETOS vectorjuego[di],10,48,ptob
            SUMARPUNTOS ptpre
            mov bx,0
            jmp GJ2
        PAUSAR:
            mov ah,00h
            int 16h
            cmp al,27
            je PAUSAJUEGO
            jmp GJ2
        PAUSAJUEGO:
            GRAFICARTEXTO mgpausa,SIZEOF mgpausa,4FH,13,8 ;pinto de un color 
            mov ah,00h
            int 16h
            cmp al,27
            je QUITARPAUSA
            jmp PAUSAJUEGO 
        QUITARPAUSA:
            GRAFICARTEXTO mgpausa,SIZEOF mgpausa,00H,13,8 ;pinto de negro para borrar 
            RESTARPUNTOS 5
            mov ah,02h
            int 1ah
            mov al,dh
            jmp GJINICIO
        ACTIVARSALIDA:
            mov bandera27,1
            jmp SALDELJUEGO
        SALDELJUEGO:
            GRAFICARTEXTO mgpasarnivel,SIZEOF mgpasarnivel,4FH,13,5
            DELAYS retardoreloj
            GRAFICARTEXTO mgpasarnivel,SIZEOF mgpasarnivel,00H,13,5
            mov posxi,95
            xor si,si
            mov ax,0003h
            int 10h
        FINFALF:

endm

MODIFICARARCHIVO_PTS macro
LOCAL MDA1,ENTRO,BUSCAR,SUBBUSCAR,BUSCAR2,SUBBUSCAR2,MDA2,MDA3,FINALIZAR
    LIMPIARTXT recolector,SIZEOF recolector,24h
    ABRIRFILE rutpuntos,handler
    READFILE handler,recolector,SIZEOF recolector
    CERRARFILE handler
    xor si,si
    xor di,di
    MDA1:
        mov al,recolector[si]
        cmp rebusuario[di],al
        je ENTRO
        cmp al,"$"
        je FINALIZAR
        jmp MDA2
    ENTRO:
        mov al,recolector[si]
        cmp al,","
        je BUSCAR
        cmp rebusuario[di],al
        jne MDA2
        inc si
        inc di
        jmp ENTRO
    BUSCAR:
        inc si
        SUBBUSCAR:
            mov al,recolector[si]
            cmp al,","
            je BUSCAR2
            inc si
            jmp SUBBUSCAR
    BUSCAR2:
        inc si
        SUBBUSCAR2:
            mov al,pts[0]
            mov recolector[si],al
            inc si
            mov al,pts[1]
            mov recolector[si],al
            jmp FINALIZAR
    MDA2:
        mov al,recolector[si]
        cmp al,";"
        je MDA3
        inc si
        jmp MDA2
    MDA3:
        xor di,di
        inc si
        jmp MDA1
    FINALIZAR:
        ABRIRFILE rutpuntos,handler
        WRITEFILE handler,recolector,SIZEOF recolector
        CERRARFILE handler
endm

MODIFICARARCHIVO_TMS macro
LOCAL MDA1_B,MDA2_B,MDA3_B,ENTRO_B,FINALIZAR_B,BUSCAR_B,SUBBUSCAR_B
LOCAL BUSCAR2_B,SUBBUSCAR2_B
    LIMPIARTXT recolector,SIZEOF recolector,24h
    ABRIRFILE ruttiempos,handler
    READFILE handler,recolector,SIZEOF recolector
    CERRARFILE handler
    xor si,si
    xor di,di
    MDA1_B:
        mov al,recolector[si]
        cmp rebusuario[di],al
        je ENTRO_B
        cmp al,"$"
        je FINALIZAR_B
        jmp MDA2_B
    ENTRO_B:
        mov al,recolector[si]
        cmp al,","
        je BUSCAR_B
        cmp rebusuario[di],al
        jne MDA2_B
        inc si
        inc di
        jmp ENTRO_B
    BUSCAR_B:
        inc si
        SUBBUSCAR_B:
            mov al,recolector[si]
            cmp al,","
            je BUSCAR2_B
            inc si
            jmp SUBBUSCAR_B
    BUSCAR2_B:
        inc si
        SUBBUSCAR2_B:
            mov al,Tiempo[1]
            mov recolector[si],al
            inc si
            mov al,Tiempo[2]
            mov recolector[si],al
            inc si
            mov al,Tiempo[3]
            mov recolector[si],al
            jmp FINALIZAR_B
    MDA2_B:
        mov al,recolector[si]
        cmp al,";"
        je MDA3_B
        inc si
        jmp MDA2_B
    MDA3_B:
        xor di,di
        inc si
        jmp MDA1_B
    FINALIZAR_B:
        ABRIRFILE ruttiempos,handler
        WRITEFILE handler,recolector,SIZEOF recolector
        CERRARFILE handler
endm

LIMPIARTIEMPOS macro
    mov Tiempo[3],"0"
    mov Tiempo[2],"0"     
    mov Tiempo[1],"0"
    mov Tiempo[0],"0"
endm 

LIMPIARPUNTOS macro
    mov pts[0],"0"
    mov pts[1],"0"
    mov puntosglobales,0
endm

LIMPIARDATOSNIVEL macro
    LIMPIARTXT numeronivel,SIZEOF numeronivel, 24h
    LIMPIARTXT tiemponivel,SIZEOF tiemponivel, 24h
    LIMPIARTXT tiempoobstaculo,SIZEOF tiempoobstaculo, 24h
    LIMPIARTXT tiempopremio,SIZEOF tiempopremio, 24h
    LIMPIARTXT elementocolor,SIZEOF elementocolor, 24h
    LIMPIARTXT puntopremio,SIZEOF puntopremio, 24h
    LIMPIARTXT puntoobstaculo,SIZEOF puntoobstaculo, 24h
endm

LIMPIARNIVELES macro
    LIMPIARTXT nivel1,SIZEOF nivel1, 24h
    LIMPIARTXT nivel2,SIZEOF nivel2, 24h
    LIMPIARTXT nivel3,SIZEOF nivel3, 24h
    LIMPIARTXT nivel4,SIZEOF nivel4, 24h
    LIMPIARTXT nivel5,SIZEOF nivel5, 24h
    LIMPIARTXT nivel6,SIZEOF nivel6, 24h
endm

LEERARCHIVO macro buffer
    LIMPIARNIVELES
    LIMPIARDATOSNIVEL
    LIMPIARTXT catchbuffer, SIZEOF catchbuffer,24h
    LIMPIARTXT catchbuffer2, SIZEOF catchbuffer2,24h
    mov contadornivel,1
    INGRESARRUTA buffer
    ABRIRFILE buffer,handler
    READFILE handler,catchbuffer,SIZEOF catchbuffer
    CERRARFILE handler
    SEPARACION catchbuffer
    INICIO:
        TOMARNIVEL contadornivel
        mov cl,numerodeniveles
        cmp contadornivel,cl
        jle MPR
        JMP MSAL
    MPR:
        GRAFICARJUEGO colorauto,timenivel,timeobs,timepre,pointobs,pointpre
        cmp bandera27,1
        je MSAL
        cmp banderasalida,1
        je MSAL
        inc contadornivel
        jmp INICIO
    MSAL:
        GRAFICARTEXTO mgsalida,SIZEOF mgsalida,4FH,13,8 ;pinto de negro para borrar 
        DELAYS retardoreloj
        MODIFICARARCHIVO_PTS
        MODIFICARARCHIVO_TMS
        LIMPIARTIEMPOS
        LIMPIARPUNTOS
        mov posxi,95
        xor si,si
        VALORESFABRICA
endm

LIMPIARENEMIGOS macro
    LIMPIARTXT posicionesx,SIZEOF posicionesx,100
    LIMPIARTXT posicionesy,SIZEOF posicionesy,10
    LIMPIARTXT bloquescolores,SIZEOF bloquescolores,0
endm

VALORESFABRICA macro
    mov posxi,95
    mov contadornivel,1
    mov numerodeniveles,1
    mov timenivel,120
    mov colorauto,36
    mov banderasalida,0
    mov bandera27,0
    mov timeobs, 3
    mov timepre, 4
    mov pointobs, 2
    mov pointpre, 6
    LIMPIARDATOSNIVEL
    LIMPIARNIVELES
    LIMPIARTIEMPOS
    LIMPIARPUNTOS
endm

IMPRIMIRNIVELES macro
    SALTO
    PRINT nivel1
    SALTO
    PRINT nivel2
    SALTO
    PRINT nivel3
    SALTO
    PRINT nivel4
    SALTO
    PRINT nivel5
    SALTO
endm

IMPRIMIRDATOS macro
    SALTO
    PRINT numeronivel
    SALTO
    PRINT tiemponivel
    SALTO
    PRINT tiempoobstaculo
    SALTO
    PRINT tiempopremio
    SALTO
    PRINT elementocolor
    SALTO
    PRINT puntopremio
    SALTO
    PRINT puntoobstaculo
endm

;########################################################################################### @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ NO TOCAR
INGRESARRUTA macro buffer
LOCAL CARACT,SALIDA
    xor si, si
    CARACT:
        GETCHAR2
        cmp al, 0dh
        je SALIDA
        mov buffer[si],al
        inc si
        jmp CARACT

    SALIDA:
        mov al,00h
        mov buffer[si],al
endm

SEPARACION macro buffer
LOCAL PASO1,PASO2,P2,PFINAL,PASO3,P3,PASO4,P4,PASO5,P5,PASO6,P6
    xor di,di
    xor si,si
    PASO1:
        mov al,buffer[si]
        cmp al,0A
        je PASO2
        cmp al,0
        je PFINAL
        mov nivel1[di],al
        inc di
        inc si
        JMP PASO1
    
    PASO2:

        inc si
        xor di,di
        P2:
            mov al,buffer[si]
            cmp al,0A
            je PASO3
            cmp al,0
            je PFINAL
            mov nivel2[di],al
            inc di
            inc si
            JMP P2

    PASO3:
        inc si
        xor di,di
        P3:
            mov al,buffer[si]
            cmp al,0A
            je PASO4
            cmp al,0
            je PFINAL
            mov nivel3[di],al
            inc di
            inc si
            JMP P3

    PASO4:
        inc si
        xor di,di
        P4:
            mov al,buffer[si]
            cmp al,0A
            je PASO5
            cmp al,0
            je PFINAL
            mov nivel4[di],al
            inc di
            inc si
            JMP P4

    PASO5:
        inc si
        xor di,di
        P5:
            mov al,buffer[si]
            cmp al,0A
            je PASO6
            cmp al,0
            je PFINAL
            mov nivel5[di],al
            inc di
            inc si
            JMP P5

    PASO6:
        inc si
        xor di,di
        P6:
            mov al,buffer[si]
            cmp al,0A
            je PFINAL
            cmp al,0
            je PFINAL
            mov nivel6[di],al
            inc di
            inc si
            JMP P6

    PFINAL:
        CONTARNIVELES  
endm

;########################################### CUENTA NIVELES ALMACENADOS #########################
CONTARNIVELES macro
LOCAL N1,N2,N3,N4,N5,N6,NFINAL,N1A,N2A,N3A,N4A,N5A,N6A
    xor ax,ax
    N1:
        mov al,nivel1[0]
        cmp al,"N"
        je N1A
        jmp N2
    N1A:
        inc numerodeniveles
    N2:
        mov al,nivel2[0]
        cmp al,"N"
        je N2A
        jmp N3
    N2A:
        inc numerodeniveles
    N3:
        mov al,nivel3[0]
        cmp al,"N"
        je N3A
        jmp N4
    N3A:
        inc numerodeniveles
    N4:
        mov al,nivel4[0]
        cmp al,"N"
        je N4A
        jmp N5
    N4A:
        inc numerodeniveles
    N5:
        mov al,nivel5[0]
        cmp al,"N"
        je N5A
        jmp N6
    N5A:
        inc numerodeniveles
    N6:
        mov al,nivel6[0]
        cmp al,"N"
        je N6A
        jmp NFINAL  
    N6A:
        inc numerodeniveles  
    NFINAL:
        dec numerodeniveles
endm

;####################################### TOMA EL NIVEL Y LO MANDA A LAS VARIABLES #########################
TOMARNIVEL macro numerodenivel
LOCAL LEVEL1,LEVEL2,LEVEL3,LEVEL4,LEVEL5,LEVEL6,FUERAA
    cmp numerodenivel, 1
    je LEVEL1
    cmp numerodenivel, 2
    je LEVEL2
    cmp numerodenivel, 3
    je LEVEL3
    cmp numerodenivel, 4
    je LEVEL4
    cmp numerodenivel, 5
    je LEVEL5
    cmp numerodenivel, 6
    je LEVEL6
    jmp FUERAA

    LEVEL1:
        SEPARAR nivel1
        jmp FUERAA
    LEVEL2:
        SEPARAR nivel2
        jmp FUERAA
    LEVEL3:
        SEPARAR nivel3
        jmp FUERAA
    LEVEL4:
        SEPARAR nivel4
        jmp FUERAA
    LEVEL5:
        SEPARAR nivel5
        jmp FUERAA
    LEVEL6:
        SEPARAR nivel6
        jmp FUERAA

    FUERAA:
endm

CONVERTIR_CANTIDAD macro letras,deposito
    xor cx,cx
    mov al,letras[0]
    sub al,30h
    mov bl,10
    mul bl
    mov cl,al
    mov al,letras[1]
    sub al,30h
    add cl,al
    mov deposito,cx
endm

CONVERTIR_CANTIDAD2 macro letras,deposito
    xor cx,cx
    mov al,letras[0]
    sub al,30h
    mov bl,10
    mul bl
    mov cl,al
    mov al,letras[1]
    sub al,30h
    add cl,al
    mov deposito,cl
endm

;############################################ SEPARA EN VARIABLES LOS DATOS DEL NIVEL ########################################
SEPARAR macro buffercadena
LOCAL SP1,SP2,SP3,SP4,SP5,SP6,SP7,SP8
LOCAL NUMNIV,TIMNIV,TIMOBS,TIMPRE,PTOBS,PTPRE,ELCOLOR,NOUT
    xor di,di
    xor si,si
    SP1:
        mov al,buffercadena[si]
        cmp al,";"
        je NUMNIV
        inc si
        jmp SP1

    NUMNIV:
        inc si
        xor di,di
        SP2:
            mov al,buffercadena[si]
            cmp al,";"
            je TIMNIV
            mov numeronivel[di],al
            inc di
            inc si
            jmp SP2
    
    TIMNIV:
        inc si
        xor di,di
        SP3: 
            mov al,buffercadena[si]
            cmp al,";"
            je TIMOBS
            mov tiemponivel[di],al
            inc di
            inc si
            jmp SP3

    TIMOBS:
        inc si
        xor di,di
        SP4:
            mov al,buffercadena[si]
            cmp al,";"
            je TIMPRE
            mov tiempoobstaculo[di],al
            inc di
            inc SI
            jmp SP4

    TIMPRE:
        inc si
        xor di,di
        SP5:
            mov al,buffercadena[si]
            cmp al,";"
            je ELCOLOR
            mov tiempopremio[di],al
            inc si
            inc di 
            jmp SP5
    
    ELCOLOR:
        inc si
        xor di,di
        SP6:
            mov al,buffercadena[si]
            cmp al,";"
            je PTPRE
            mov puntoobstaculo[di],al
            inc di 
            inc si
            jmp SP6

    PTPRE:
        inc si
        xor di,di
        SP7:
            mov al,buffercadena[si]
            cmp al,";"
            je PTOBS
            mov puntopremio[di],al
            inc di 
            inc si
            jmp SP7
    
    PTOBS:
        inc si
        xor di,di
        SP8:
            mov al,buffercadena[si]
            cmp al,"$"
            je NOUT
            cmp al,0
            je NOUT
            cmp al,0A
            je NOUT
            mov elementocolor[di],al
            inc di 
            inc si
            jmp SP8

    NOUT:
        CONVERTIR_CANTIDAD tiemponivel,timenivel
        CONVERTIR_CANTIDAD tiempoobstaculo,timeobs
        CONVERTIR_CANTIDAD tiempopremio,timepre
        CONVERTIR_CANTIDAD2 puntoobstaculo,pointobs
        CONVERTIR_CANTIDAD2 puntopremio,pointpre
        TOMARCOLOR elementocolor
endm

TOMARCOLOR macro buffercadena
LOCAL F1,ESTADOR,ESTADORA,ESTADORB,ESTADORC
LOCAL ESTADOV,ESTADOV2,ESTADOV3,ESTADOV4,ESTADOV5
LOCAL ESTADOA,ESTADOA2,ESTADOA3,ESTADOA4
LOCAL ESTADOB,ESTADOB2,ESTADOB3,ESTADOB4,ESTADOB5,ESTADOB6,NINGUNO,FUERA
    xor si,si
    F1:
        mov al,buffercadena[si]
        cmp al,"r"
        je ESTADOR
        cmp al,"v"
        je ESTADOV
        cmp al,"a"
        je ESTADOA
        cmp al,"b"
        je ESTADOB
        jmp NINGUNO

    ESTADOR:
        inc si
        mov al,buffercadena[si]
        cmp al,"o"
        je ESTADORA
        jmp NINGUNO
    
    ESTADORA:
        inc si
        mov al,buffercadena[si]
        cmp al,"j"
        je ESTADORB
        jmp NINGUNO
    
    ESTADORB:
        inc si
        mov al,buffercadena[si]
        cmp al,"o"
        je ESTADORC
        jmp NINGUNO

    ESTADORC:
        LIMPIARTXT buffercadena,SIZEOF buffercadena,24h
        mov buffercadena[0], "2"
        mov buffercadena[1], "8"
        mov buffercadena[2], "h"
        mov colorauto,40
        jmp FUERA

    ;######################## FIN DEL ROJO
    ESTADOV:
        inc si
        mov al,buffercadena[si]
        cmp al,"e"
        je ESTADOV2
        jmp NINGUNO
    
    ESTADOV2:
        inc si
        mov al,buffercadena[si]
        cmp al,"r"
        je ESTADOV3
        jmp NINGUNO
    
    ESTADOV3:
        inc si
        mov al,buffercadena[si]
        cmp al,"d"
        je ESTADOV4
        jmp NINGUNO
    
    ESTADOV4:
        inc si
        mov al,buffercadena[si]
        cmp al,"e"
        je ESTADOV5
        jmp NINGUNO
    
    ESTADOV5:
        LIMPIARTXT buffercadena,SIZEOF buffercadena,24h
        mov buffercadena[0], "3"
        mov buffercadena[1], "0"
        mov buffercadena[2], "h"
        mov colorauto,48
        jmp FUERA
    ;######################### FIN DEL VERDE

    ESTADOA:
        inc si
        mov al,buffercadena[si]
        cmp al,"z"
        je ESTADOA2
        jmp NINGUNO

    ESTADOA2:
        inc si
        mov al,buffercadena[si]
        cmp al,"u"
        je ESTADOA3
        jmp NINGUNO
    
    ESTADOA3:
        inc si
        mov al,buffercadena[si]
        cmp al,"l"
        je ESTADOA4
        jmp NINGUNO

    ESTADOA4:
        LIMPIARTXT buffercadena,SIZEOF buffercadena,24h
        mov buffercadena[0], "2"
        mov buffercadena[1], "0"
        mov buffercadena[2], "h"
        mov colorauto,32
        jmp FUERA
    ;####################### FIN DEL AZUL

    ESTADOB:
        inc si
        mov al,buffercadena[si]
        cmp al,"l"
        je ESTADOB2
        jmp NINGUNO
    
    ESTADOB2:
        inc si
        mov al,buffercadena[si]
        cmp al,"a"
        je ESTADOB3
        jmp NINGUNO
    
    ESTADOB3:
        inc si
        mov al,buffercadena[si]
        cmp al,"n"
        je ESTADOB4
        jmp NINGUNO

    ESTADOB4:
        inc si
        mov al,buffercadena[si]
        cmp al,"c"
        je ESTADOB5
        jmp NINGUNO
    
    ESTADOB5:
        inc si
        mov al,buffercadena[si]
        cmp al,"o"
        je ESTADOB6
        jmp NINGUNO

    ESTADOB6:
        LIMPIARTXT buffercadena,SIZEOF buffercadena,24h
        mov buffercadena[0], "1"
        mov buffercadena[1], "f"
        mov buffercadena[2], "h"
        mov colorauto,31 
        jmp FUERA
    ;########################## FIN DE BLANCO

    NINGUNO:
        LIMPIARTXT buffercadena,SIZEOF buffercadena,24h
        mov buffercadena[0], "4"
        mov buffercadena[1], "4"
        mov buffercadena[2], "h" 
        mov colorauto,36 
        jmp FUERA 

    FUERA:  
endm


