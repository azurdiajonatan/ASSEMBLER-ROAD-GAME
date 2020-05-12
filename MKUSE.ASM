PRINT macro texto ; ESTA SE ENCARGA DE IMPRIMIR UN MENSAJE
	MOV AH,09
	MOV DX, offset texto
	INT 21h
endm

GETCHAR2 macro;OBTIENE EL CARACTER
    mov ah,01h
    int 21h
    mov caracter,al
endm

GETCHAR8 macro;OBTIENE EL CARACTER
    mov ah,08h
    int 21h
    mov caracter,al
endm

SALTO macro ;REALIZA UN SALTO DE LINEA
    mov ah,09h
    lea dx, saltolinea
    int 21h
endm

LIMPIARPANTALLA macro
    mov ax,0013h
    int 10h
    mov ax,0003h
    int 10h
endm
;################## PARA LEER,ABRIR,CREAR,CERRAR ARCHIVOS ######################################################################################
ABRIRFILE macro buffer,handler ;ABRIR UN ARCHIVO
    mov ah,3dh
    mov al,02h
    lea dx,buffer
    int 21h
    jc FALLA1
    mov handler,ax 
endm

CERRARFILE macro handler ;CERRAR UN ARCHIVO
    mov ah,3eh
    mov bx,handler
    int 21h
    jc FALLA2
endm

READFILE macro handler,buffer,numbytes ;LEER UN ARCHIVO Y AGREGARLO A UNA CADENA
    mov ah,3fh
    mov bx,handler
    mov cx,numbytes
    lea dx,buffer
    int 21h 
    jc FALLA3
endm

CREATEFILE macro buffer,handler ;CREAR UN ARCHIVO
    mov ah,3ch
    mov cx,00h
    lea dx,buffer
    int 21h
    jc FALLA4
    mov handler,ax
endm

WRITEFILE macro handler,buffer,numbytes ;ESCRIBIR UN ARCHIVO
    mov ah,40h
    mov bx,handler
    mov cx,numbytes
    mov dx, offset buffer
    int 21h
    jc FALLA5
endm

LIMPIARTXT macro buffer,numbytes,car  ;LIMPIA LA DEL USUARIO
LOCAL REPEAT 
    xor di,di
    xor cx,cx
    mov cx,numbytes
    REPEAT:
        mov buffer[di],car
        inc di
        loop REPEAT
endm;CAMBIE SI POR DI
;##################### AL INICIAR EL PROGRAMA ########################
INICIOPROGRAMA macro
;USUARIOS
    CREATEFILE  rutausuarios,handler
    WRITEFILE handler,recolector,SIZEOF recolector
    CERRARFILE handler
;PUNTOS
    CREATEFILE  rutpuntos,handler
    WRITEFILE handler,recolector,SIZEOF recolector
    CERRARFILE handler
;TIEMPOS
    CREATEFILE  ruttiempos,handler
    WRITEFILE handler,recolector,SIZEOF recolector
    CERRARFILE handler
endm

UNIRUSUARIO macro buffer1,buffer2
LOCAL UNS1,UNS2
    LIMPIARTXT buffer2,SIZEOF buffer2,24h
    xor di,di
    xor si,si
    UNS1:
        mov al,buffer1[si]
        cmp al,"$"
        je UNS2
        mov buffer2[di],al
        inc di
        inc si
        jmp UNS1
    
    UNS2:
        mov buffer2[di],","
        mov buffer2[di+1],"0"
        mov buffer2[di+2],"0"
        mov buffer2[di+3],","
        mov buffer2[di+4],"0"
        mov buffer2[di+5],"0"
        mov buffer2[di+6],";"
endm

UNIRTIEMPO macro buffer1,buffer2
LOCAL UNT1,UNT2
    LIMPIARTXT conjunto,SIZEOF conjunto,24h
    xor di,di
    xor si,si
    UNT1:
        mov al,buffer1[si]
        cmp al,"$"
        je UNT2
        mov buffer2[di],al
        inc di
        inc si
        jmp UNT1
    
    UNT2:
        mov buffer2[di],","
        mov buffer2[di+1],"0"
        mov buffer2[di+2],"0"
        mov buffer2[di+3],","
        mov buffer2[di+4],"0"
        mov buffer2[di+5],"0"
        mov buffer2[di+6],"0"
        mov buffer2[di+7],";"
endm

;############################## INGRESAR NOMBRE Y CONTRASEÑA ################
INGRESARUSUARIO macro buffer
    LOCAL,RECIBIR,ENTER,ESCAPE
    mov contadorletras,0
    xor si,si
    RECIBIR:
        GETCHAR2
        cmp al,0dh ;SI RECIBE EL ENTER
        je ENTER
        cmp al,1bh ;SI RECIBE ESCAPE
        je ESCAPE
        cmp contadorletras,6 ; SI RECIBE MAS DE 7 CARACTERES
        ja TRAVEZ
        mov buffer[si],al
        inc si
        inc contadorletras
        jmp RECIBIR

    ESCAPE:
        LIMPIARPANTALLA
        jmp PRESENTACION

    TRAVEZ:
        PRINT mensajerepetir
        GETCHAR8
        LIMPIARPANTALLA
        LIMPIARTXT buffer,SIZEOF buffer,24h
        jmp Z1

    ENTER:
        ANALIZAR buffer

endm

ANALIZAR macro buffer
    ABRIRFILE rutausuarios,handler
    READFILE handler, recolector,SIZEOF recolector
    CERRARFILE handler
        mov di,0
        xor si,si
        ENTERB:
            mov al,recolector[si]
            cmp al,buffer[di]
            je ENTERC
            cmp al,"$"
            je NADA
            jmp PASAR
            
        ENTERC:
            mov al,recolector[si]
            cmp al,","
            je ALGO
            cmp al,buffer[di]
            jne PASAR
            inc si
            inc di
            jmp ENTERC

        PASAR:
            mov al,recolector[si]
            cmp al,";"
            je PASAR2
            inc si
            jmp PASAR

        PASAR2:
            mov di,0
            inc si
            jmp ENTERB

        ALGO:
            PRINT mensajeyaexiste
            GETCHAR8
            jmp REGISTRAR

        NADA:
endm

INGRESARPASSWORD macro buffer
    LOCAL,RECIBIR2,ENTER2,ESCAPE2,UNIR
    mov contadorletras,0
    xor si,si
    RECIBIR2:
        GETCHAR2
        cmp al,0dh ;SI RECIBE EL ENTER
        je ENTER2
        cmp al,1bh ;SI RECIBE ESCAPE
        je ESCAPE2
        cmp contadorletras,3 ; SI RECIBE MAS DE 4 CARACTERES
        ja TRAVEZ2
        cmp al,"0"
        je UNIR
        cmp al,"1"
        je UNIR
        cmp al,"2"
        je UNIR
        cmp al,"3"
        je UNIR
        cmp al,"4"
        je UNIR
        cmp al,"5"
        je UNIR
        cmp al,"6"
        je UNIR
        cmp al,"7"
        je UNIR
        cmp al,"8"
        je UNIR
        cmp al,"9"
        je UNIR
        jmp NOVALIDO

    UNIR:
        mov buffer[si],al
        inc si
        inc contadorletras
        jmp RECIBIR2

    ESCAPE2:
        LIMPIARPANTALLA
        jmp PRESENTACION

    TRAVEZ2:
        PRINT mensajerepetir
        GETCHAR8
        LIMPIARPANTALLA
        jmp Z2
    
    NOVALIDO:
        PRINT mensajecaracternovalido
        GETCHAR8
        jmp Z2

    ENTER2:    
endm

UNIRDATOS macro buffer1,buffer2
    LOCAL TOMA1,TOMA2,TOMA2B,ENTER3
    mov di,0
    xor si,si
    TOMA1:
        mov al,buffer1[si]
        cmp al,"$"
        je TOMA2
        mov conjunto[di],al
        inc si
        inc di
        jmp TOMA1
    TOMA2:
        mov conjunto[di],","
        inc di
        xor si,si
        TOMA2B:
            mov al,buffer2[si]
            cmp al,"$"
            je ENTER3
            mov conjunto[di],al
            inc si
            inc di
            jmp TOMA2B
    ENTER3:
        mov conjunto[di],";"
endm

UNIRTRESDATOS macro buffer1,buffer2,buffer3
LOCAL UNT1,UNT2,UNT3,UNT4,SUBT2,SUBT3
    xor di,di
    xor si,si
    UNT1:
        mov al,buffer1[si]
        cmp al,"$"
        je UNT2
        mov conjunto[di],al
        inc si
        inc di
        jmp UNT1
    UNT2:
        MOV conjunto[di],","
        inc di
        xor si,si
        SUBT2:
            mov al,buffer2[si]
            cmp al,"$"
            je UNT3
            mov conjunto[di],al
            inc si
            inc di
            JMP SUBT2
    UNT3:
        mov conjunto[di],","
        inc di
        xor si,si
        SUBT3:
            mov al,buffer3[si]
            cmp al,"$"
            je UNT4
            mov conjunto[di],al
            inc si
            inc di
            jmp SUBT3
    UNT4:
        mov conjunto[di],";"
endm
;####################################### REGISTRAR #############################################################################################
REGISTRARUSUARIOS macro buffer1,buffer2
    ABRIRFILE rutausuarios,handler
    READFILE handler, buffer1,SIZEOF buffer1
    CERRARFILE handler
    AGREGARUSER buffer1,buffer2
    ABRIRFILE rutausuarios,handler
    WRITEFILE handler,buffer1,SIZEOF buffer1
    CERRARFILE handler ;HASTA AQUI PARA AGREGAR EL USUARIO AL ARCHIVO
    ;------------------------------------------------------------------------------------------
    ADDPUNTAJE buffer1
    ;------------------------------------------------------------------------------------------
    ADDTIEMPO buffer1
    jmp PRESENTACION2
endm

ADDPUNTAJE macro buffer1
    LIMPIARTXT buffer1,SIZEOF buffer1,24h
    ABRIRFILE rutpuntos,handler
    READFILE handler, buffer1,SIZEOF buffer1
    CERRARFILE handler
    UNIRUSUARIO rebusuario,conjunto
    AGREGARUSER buffer1,conjunto
    ABRIRFILE rutpuntos,handler
    WRITEFILE handler,buffer1,SIZEOF buffer1
    CERRARFILE handler
endm

ADDTIEMPO macro buffer1
    LIMPIARTXT buffer1,SIZEOF buffer1,24h
    ABRIRFILE ruttiempos,handler
    READFILE handler, buffer1,SIZEOF buffer1
    CERRARFILE handler
    UNIRTIEMPO rebusuario,conjunto
    AGREGARUSER buffer1,conjunto
    ABRIRFILE ruttiempos,handler
    WRITEFILE handler,buffer1,SIZEOF buffer1
    CERRARFILE handler
endm
AGREGARUSER macro buffer,buffer2
LOCAL A1,A2,A3
    mov di,0
    xor si,si
    A1:
        mov al,buffer[si]
        cmp al,"$"
        je A2
        inc si
        jmp A1
    A2:
        mov al,buffer2[di]
        cmp al,"$"
        je A3
        mov buffer[si],al
        inc di
        inc si
        jmp A2
    A3:   
endm
;################################### INGRESAR ##############################################################################
INGRESARP macro buffer
    LOCAL,RECIBIR2,ENTER2,ESCAPE2,UNIR
    mov contadorletras,0
    xor si,si
    B1:
        GETCHAR2
        cmp al,0dh ;SI RECIBE EL ENTER
        je ENTERAB
        cmp al,1bh ;SI RECIBE ESCAPE
        je ESCAPEB
        cmp contadorletras,3 ; SI RECIBE MAS DE 4 CARACTERES
        ja TRAVEZB
        cmp al,"0"
        je UNIRB
        cmp al,"1"
        je UNIRB
        cmp al,"2"
        je UNIRB
        cmp al,"3"
        je UNIRB
        cmp al,"4"
        je UNIRB
        cmp al,"5"
        je UNIRB
        cmp al,"6"
        je UNIRB
        cmp al,"7"
        je UNIRB
        cmp al,"8"
        je UNIRB
        cmp al,"9"
        je UNIRB
        jmp NOVALIDOB

    UNIRB:
        mov buffer[si],al
        inc si
        inc contadorletras
        jmp B1

    ESCAPEB:
        LIMPIARPANTALLA
        jmp PRESENTACION

    TRAVEZB:
        PRINT mensajerepetir
        GETCHAR8
        LIMPIARPANTALLA
        jmp Y2
        
    NOVALIDOB:
        PRINT mensajecaracternovalido
        GETCHAR8
        jmp Y2

    ENTERAB:
        
endm

INGRESARU macro buffer
    mov contadorletras,0
    xor si,si
    REC:
        GETCHAR2
        cmp al,0dh ;SI RECIBE EL ENTER
        je ENTERA
        cmp al,1bh ;SI RECIBE ESCAPE
        je ESPA
        cmp contadorletras,6 ; SI RECIBE MAS DE 7 CARACTERES
        ja TRAVEZA
        mov buffer[si],al
        inc si
        inc contadorletras
        jmp REC

    ESPA:
        LIMPIARPANTALLA
        jmp PRESENTACION

    TRAVEZA:
        PRINT mensajerepetir
        GETCHAR8
        LIMPIARPANTALLA
        LIMPIARTXT buffer,SIZEOF buffer,24h
        jmp Y1

    ENTERA: 
endm

ANALIZARA macro buffer
    ADMIN:
        mov di,0
        xor si,si
        D1:
            mov al,nameadmin[si]
            cmp al,buffer[di]
            je D2
            jmp OTRO

        D2:
            mov al,nameadmin[si]
            cmp al,";"
            je ALGD
            cmp al,buffer[di]
            jne PA
            inc si
            inc di
            jmp D2

        ALGD:
            LIMPIARPANTALLA
            jmp PRESENTACION3

        PA:
            jmp OTRO

    OTRO:
        ABRIRFILE rutausuarios,handler
        READFILE handler, recolector,SIZEOF recolector
        CERRARFILE handler

        mov di,0
        xor si,si
            C1:
                mov al,recolector[si]
                cmp al,buffer[di]
                je C2
                cmp al,"$"
                je NADA2
                jmp PA1
                
            C2:
                mov al,recolector[si]
                cmp al,";"
                je ALGO2
                cmp al,buffer[di]
                jne PA1
                inc si
                inc di
                jmp C2

            PA1:
                mov al,recolector[si]
                cmp al,";"
                je PA2
                inc si
                jmp PA1

            PA2:
                mov di,0
                inc si
                jmp C1

            ALGO2:
                PRINT existeusuario
                GETCHAR8
                jmp PRESENTACION2

            NADA2:
                PRINT noexiste
                GETCHAR8
                jmp PRESENTACION
endm
;###########################################################################
TOP10PUNTOS macro
    LIMPIARTXT recolector,SIZEOF recolector,24h
    LIMPIARTXT copia1,SIZEOF copia1,24h
    ABRIRFILE rutpuntos,handler
    READFILE handler,recolector,SIZEOF recolector
    CERRARFILE handler
    ;LEEMOS EL ARCHIVO Y LUEGO VEREMOS EL TOP 10
    ORDENARTOP10 recolector
    CONTAR_USER recolector
    ORDENARRESTO recolector
    CREAR10 copia1
    CREATEFILE rut10pts,handler
    WRITEFILE handler,recolector,SIZEOF recolector
    CERRARFILE handler
    RELLENAR10PTS
endm

TOP10TIEMPOS macro
    LIMPIARTXT recolector,SIZEOF recolector,24h
    LIMPIARTXT copia2,SIZEOF copia2,24h
    ABRIRFILE ruttiempos,handler
    READFILE handler,recolector,SIZEOF recolector
    CERRARFILE handler
    ;LEEMOS EL ARCHIVO Y LUEGO VEREMOS EL TOP 10
    ORDENARTOP10T recolector
    CONTAR_USER recolector
    ORDENATIEMPOS recolector
    CREAR10 copia2
    CREATEFILE rut10tms,handler
    WRITEFILE handler,recolector,SIZEOF recolector
    CERRARFILE handler
    RELLENAR10TMS
endm

CREAR10 macro arreglo
LOCAL CTP,CTP2,CTP3,CTPF
    mov numeroasistente,0
    LIMPIARTXT recolector,SIZEOF recolector,24h
    xor si,si
    xor di,di
    CTP:
        mov al,arreglo[si]
        cmp al,";"
        je CTP2
        cmp al,"$"
        je CTP3
        mov recolector[di],al
        inc di
        inc si
        jmp CTP

    CTP2: 
        mov recolector[di],";"
        inc si
        inc di
        inc numeroasistente
        cmp numeroasistente,10
        je CTPF
        jmp CTP

    CTP3:
        inc numeroasistente
        cmp numeroasistente,10
        je CTPF
        jmp CTP

    CTPF:
        mov numeroasistente,0
endm

COPIARNOMBRE macro nm1,nm2
LOCAL CN1,CN2
    xor di,di
    xor si,si
    CN1:
        mov al,nm1[di]
        cmp al,"$"
        je CN2
        mov nm2[si],al
        inc si
        inc di

        jmp CN1
    CN2:
        xor di,di
        xor si,si
endm

ORDENARTOP10 macro arreglo
LOCAL ORD1,ORD_B,DDD,ORD2,S_ORD2,ORD3,CHGED,ORDFIN
    xor di,di
    xor si,si
    ORD1:
        mov al,arreglo[si]
        cmp al,","
        je ORD_B
        cmp al,"$"
        je ORDFIN
        mov subnombre[di],al
        inc si
        inc di
        jmp ORD1

    ORD_B:
        inc si
        LIMPIARTXT subnivel,SIZEOF subnivel,24h
        xor di,di
        DDD:
            mov al,arreglo[si]
            cmp al,","
            je ORD2
            mov subnivel[di],al
            inc di
            inc si
            jmp DDD
    ORD2:
    inc si
    xor di,di
        S_ORD2:
            mov al,arreglo[si]
            cmp al,";"
            je ORD3
            mov number[di],al
            inc si
            inc di
            jmp S_ORD2

    ORD3:
        CONVER2NUM number,subnumero
        mov bl,subnumero
        cmp bl,temporal
        ja CHGED
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        inc si
        jmp ORD1
    CHGED:
        mov temporal,bl
        PUSH si
        LIMPIARTXT conjunto,SIZEOF conjunto,24h
        LIMPIARTXT rebusuario,SIZEOF rebusuario,24h
        COPIARNOMBRE subnombre,rebusuario
        UNIRTRESDATOS rebusuario,subnivel,number
        pop si
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        inc si
        jmp ORD1
    ORDFIN:
        AGREGARUSER copia1,conjunto
endm

CONTAR_USER macro arreglo
LOCAL CTU,CTU1,CTOUT
    xor si,si
    mov contadorusuarios,0
    CTU:
        mov al,arreglo[si]
        cmp al,";"
        je CTU1
        cmp al,"$"
        je CTOUT
        inc si
        jmp CTU

    CTU1:
        inc si
        inc contadorusuarios
        jmp CTU

    CTOUT:
        xor si,si
endm

ORDENARTOP10T macro arreglo
LOCAL ORT1,ORT2,ORT3,ORT_B,DDT,S_ORT2,CHGET,ORTFIN
    xor di,di
    xor si,si
    ORT1:
        mov al,arreglo[si]
        cmp al,","
        je ORT_B
        cmp al,"$"
        je ORTFIN
        mov subnombre[di],al
        inc si
        inc di
        jmp ORT1

    ORT_B:
        inc si
        LIMPIARTXT subnivel,SIZEOF subnivel,24h
        xor di,di
        DDT:
            mov al,arreglo[si]
            cmp al,","
            je ORT2
            mov subnivel[di],al
            inc di
            inc si
            jmp DDT

    ORT2:
    inc si
    xor di,di
        S_ORT2:
            mov al,arreglo[si]
            cmp al,";"
            je ORT3
            mov number[di],al
            inc si
            inc di
            jmp S_ORT2

    ORT3:
        CONVER3NUM number,subnumero
        mov bl,subnumero
        cmp bl,temporal
        ja CHGET
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        inc si
        jmp ORT1
    CHGET:
        mov temporal,bl
        PUSH si
        LIMPIARTXT conjunto,SIZEOF conjunto,24h
        LIMPIARTXT rebusuario,SIZEOF rebusuario,24h
        COPIARNOMBRE subnombre,rebusuario
        UNIRTRESDATOS rebusuario,subnivel,number
        pop si
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        inc si
        jmp ORT1
    ORTFIN:
        AGREGARUSER copia2,conjunto   
endm

ORDENARRESTO macro arreglo
LOCAL ORR,ORR_B,ORR2,ORR3,ORRFIN,FINORR,VEROTRO,AJT1,BBB,S_ORR2
    LIMPIARTXT subnombre,SIZEOF subnombre,24h
    LIMPIARTXT rebusuario,SIZEOF rebusuario,24h
    xor si,si
    xor di,di
    ORR:
        mov al,arreglo[si]
        cmp al,","
        je ORR_B
        cmp al,"$"
        je ORRFIN
        mov subnombre[di],al
        inc si
        inc di
        jmp ORR

    ORR_B:
        inc si
        LIMPIARTXT subnivel,SIZEOF subnivel,24h
        xor di,di
        BBB:
            mov al,arreglo[si]
            cmp al,","
            je ORR2
            mov subnivel[di],al
            inc di
            inc si
            jmp BBB
    ORR2:
        inc si
        xor di,di
        S_ORR2:
            mov al,arreglo[si]
            cmp al,";"
            je ORR3
            mov number[di],al
            inc si
            inc di
            jmp S_ORR2
    ORR3:
        CONVER2NUM number,subnumero
        mov bl,subnumero
        cmp bl,temporal
        jb VEROTRO
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        inc si
        jmp ORR 
    VEROTRO:
        cmp bl,temporalmenor
        ja AJT1
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        inc si
        jmp ORR
    AJT1:
        mov temporalmenor,bl
        PUSH si
        LIMPIARTXT conjunto,SIZEOF conjunto,24h
        LIMPIARTXT rebusuario,SIZEOF rebusuario,24h
        COPIARNOMBRE subnombre,rebusuario
        UNIRTRESDATOS rebusuario,subnivel,number
        pop si
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        inc si
        jmp ORR
    ORRFIN:
        cmp contadorusuarios,0
        je FINORR
        dec contadorusuarios
        AGREGARUSER copia1,conjunto
        LIMPIARTXT conjunto,SIZEOF conjunto,24h
        LIMPIARTXT rebusuario,SIZEOF rebusuario,24h
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        xor si,si
        mov dl,temporalmenor
        mov temporal,dl
        mov temporalmenor,0
        jmp ORR
    FINORR:   
endm

ORDENATIEMPOS macro arreglo
LOCAL TOR1,TOR2,TOR3,TOR4,TTT,S_TOR3,VERTOR,AJTOR1,TORFIN,FINTOR
    LIMPIARTXT subnombre,SIZEOF subnombre,24h
    LIMPIARTXT rebusuario,SIZEOF rebusuario,24h
    xor si,si
    xor di,di
    TOR1:
        mov al,arreglo[si]
        cmp al,","
        je TOR2
        cmp al,"$"
        je TORFIN
        mov subnombre[di],al
        inc si
        inc di
        jmp TOR1

    TOR2:
        inc si
        LIMPIARTXT subnivel,SIZEOF subnivel,24h
        xor di,di
        TTT:
            mov al,arreglo[si]
            cmp al,","
            je TOR3
            mov subnivel[di],al
            inc di
            inc si
            jmp TTT
    TOR3:
        inc si
        xor di,di
        S_TOR3:
            mov al,arreglo[si]
            cmp al,";"
            je TOR4
            mov number[di],al
            inc si
            inc di
            jmp S_TOR3
    TOR4:
        CONVER3NUM number,subnumero
        mov bl,subnumero
        cmp bl,temporal
        jb VERTOR
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        inc si
        jmp TOR1 
    VERTOR:
        cmp bl,temporalmenor
        ja AJTOR1
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        inc si
        jmp TOR1
    AJTOR1:
        mov temporalmenor,bl
        PUSH si
        LIMPIARTXT conjunto,SIZEOF conjunto,24h
        LIMPIARTXT rebusuario,SIZEOF rebusuario,24h
        COPIARNOMBRE subnombre,rebusuario
        UNIRTRESDATOS rebusuario,subnivel,number
        pop si
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        inc si
        jmp TOR1
    TORFIN:
        cmp contadorusuarios,0
        je FINTOR
        dec contadorusuarios
        AGREGARUSER copia2,conjunto
        LIMPIARTXT conjunto,SIZEOF conjunto,24h
        LIMPIARTXT rebusuario,SIZEOF rebusuario,24h
        LIMPIARTXT subnombre,SIZEOF subnombre,24h
        xor di,di
        xor si,si
        mov dl,temporalmenor
        mov temporal,dl
        mov temporalmenor,0
        jmp TOR1
    FINTOR:   
endm
;##################################################################### CONVERSION DE NUMEROS ############################################
CONVER2NUM macro number1,deposito
    mov al,number1[0]
    mov numeroasistente,al
    mov al,numeroasistente
    sub al,30h
    mov bl,10
    mul bl
    mov numeroasistente,al
    mov al,number1[1]
    sub al,30h
    add numeroasistente,al
    mov bh,numeroasistente
    mov deposito,bh
    mov numeroasistente,0
endm

CONVER3NUM macro number1,deposito
    mov al,number1[0]
    mov numeroasistente,al
    mov al,numeroasistente
    sub al,30h
    mov bl,100
    mul bl
    mov numeroasistente,al ;SACO EL MAYOR DE TODOS
    mov bh,numeroasistente
    mov al,number1[1]
    sub al,30h
    mov bl,10
    mul bl
    add bh,al
    mov numeroasistente,bh
    mov al,number1[2]
    sub al,30h
    add numeroasistente,al
    mov bh,numeroasistente
    mov deposito,bh
    mov numeroasistente,0
endm

BORRARVECTORES macro vector
LOCAL PT1,PT2
    xor si,si
    mov si,12
    PT1:
        cmp si,50
        je PT2
        mov vector[si]," "
        inc si
        jmp PT1
    PT2:
     
endm

BORRARPTS macro
    BORRARVECTORES pts1
    BORRARVECTORES pts2
    BORRARVECTORES pts3
    BORRARVECTORES pts4
    BORRARVECTORES pts5
    BORRARVECTORES pts6
    BORRARVECTORES pts7
    BORRARVECTORES pts8
    BORRARVECTORES pts9
    BORRARVECTORES pts10
endm

BORRARTMS macro
    BORRARVECTORES tms1
    BORRARVECTORES tms2
    BORRARVECTORES tms3
    BORRARVECTORES tms4
    BORRARVECTORES tms5
    BORRARVECTORES tms6
    BORRARVECTORES tms7
    BORRARVECTORES tms8
    BORRARVECTORES tms9
    BORRARVECTORES tms10
endm
;########################################################################################################################################
RELLENAR10PTS macro
    LIMPIARTXT recolector,SIZEOF recolector,24h
    ABRIRFILE rut10pts,handler
    READFILE handler,recolector,SIZEOF recolector
    CERRARFILE handler
    xor si,si
    ESCRIBIR10PTS recolector,pts1
    ESCRIBIR10PTS recolector,pts2
    ESCRIBIR10PTS recolector,pts3
    ESCRIBIR10PTS recolector,pts4
    ESCRIBIR10PTS recolector,pts5
    ESCRIBIR10PTS recolector,pts6
    ESCRIBIR10PTS recolector,pts7
    ESCRIBIR10PTS recolector,pts8
    ESCRIBIR10PTS recolector,pts9
    ESCRIBIR10PTS recolector,pts10
    xor si,si
    xor di,di
endm

PRINT10PTS macro
    PRINT titulo3
    PRINT pts1
    PRINT pts2
    PRINT pts3
    PRINT pts4
    PRINT pts5
    PRINT pts6
    PRINT pts7
    PRINT pts8
    PRINT pts9
    PRINT pts10
    SALTO
endm

RELLENAR10TMS macro
    LIMPIARTXT recolector,SIZEOF recolector,24h
    ABRIRFILE rut10tms,handler
    READFILE handler,recolector,SIZEOF recolector
    CERRARFILE handler
    xor si,si
    ESCRIBIR10PTS recolector,tms1
    ESCRIBIR10PTS recolector,tms2
    ESCRIBIR10PTS recolector,tms3
    ESCRIBIR10PTS recolector,tms4
    ESCRIBIR10PTS recolector,tms5
    ESCRIBIR10PTS recolector,tms6
    ESCRIBIR10PTS recolector,tms7
    ESCRIBIR10PTS recolector,tms8
    ESCRIBIR10PTS recolector,tms9
    ESCRIBIR10PTS recolector,tms10
    xor si,si
    xor di,di
endm

PRINT10TMS macro
    PRINT titulo4
    PRINT tms1
    PRINT tms2
    PRINT tms3
    PRINT tms4
    PRINT tms5
    PRINT tms6
    PRINT tms7
    PRINT tms8
    PRINT tms9
    PRINT tms10
    SALTO
endm

ESCRIBIR10PTS macro arreglo,contenedor
LOCAL EPTS,EPTS2,EPTS3,EPTS4,EPTSF,SUBPT2,SUBPT3
    mov di,12
    EPTS:
        mov al,arreglo[si]
        cmp al,","
        je EPTS2
        cmp al,"$"
        je EPTSF
        mov contenedor[di],al
        inc di
        inc si
        jmp EPTS
    
    EPTS2:
        inc si
        mov di,27
        SUBPT2:
            mov al,arreglo[si]
            cmp al,","
            je EPTS3
            mov contenedor[di],al
            inc di
            inc si
            jmp SUBPT2
    
    EPTS3:
        inc si
        mov di,38
        SUBPT3:
            mov al,arreglo[si]
            cmp al,";"
            je EPTS4
            mov contenedor[di],al
            inc di
            inc si
            jmp SUBPT3

    EPTS4:
        inc si
    EPTSF:
endm