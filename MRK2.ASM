;############# LIBRERIAS
include MKUSE.ASM
include MKGAM.ASM
include MKSOT.ASM
;######################## ESTRUCTURA
.model small
.stack
.DATA
;######################### DATOS ADMIN ####################################
nameadmin db "admin,1234;","$"
saltolinea db 0dh,0ah,'$'
Tiempo db "0000" ;FORMATO PARA LA HORA
Tiempo2 db "00:00"
segundo db 0
retardoreloj dw 1200
;######################### ENCABEZADO #####################################
ENCABEZADO db   10,13,"UNIVERSIDAD DE SAN CARLOS DE GUATEMALA",
	            10,13,"FACULTAD DE INGENIERIA",
	            10,13,"CIENCIAS Y SISTEMAS",
	            10,13,"ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1",
	            10,13,"NOMBRE: JONATAN AZURDIA",
	            10,13,"CARNET: 201512786",
	            10,13,"SECCION: A",10,13,'$'
;######################## MENU 1 #####################################################################################################
MENU1 db 10,13," MENU ",
	    10,13,"1) INGRESAR",
	    10,13,"2) REGISTRAR",
	    10,13,"3) SALIR",
	    10,13,"SELECCIONE UNA OPCION -> ","$"      
;######################## MENU 2 #####################################################################################################
MENU2 db 10,13," ROAD FIGTHER ",
	    10,13,"1) INICIAR JUEGO",
	    10,13,"2) CARGAR JUEGO",
	    10,13,"3) SALIR",
	    10,13,"SELECCIONE UNA OPCION -> ","$"
;######################## MENU 3 #####################################################################################################
MENU3 db 10,13," ROAD FIGTHER ",
	    10,13,"1) TOP 10 PUNTOS",
	    10,13,"2) TOP 10 TIEMPO",
	    10,13,"3) SALIR",
	    10,13,"SELECCIONE UNA OPCION -> ","$"
;######################## MENU 4 #####################################################################################################
MENU4 db 10,13," SELECCIONE UN TIPO DE ORDENAMIENTO ",
	    10,13,"1) BUBBLESORT",
	    10,13,"2) SHELLSORT",
	    10,13,"3) QUICKSORT",
        10,13,"4) SALIR",
	    10,13,"SELECCIONE UNA OPCION -> ","$"
;######################## MENU 5 #####################################################################################################
MENU5 db 10,13,"1) ASCENDENTE",
	     10,13,"2) DESCENDENTE",
	     10,13,"3) SALIR",
	     10,13,"SELECCIONE UNA OPCION -> ","$"
;######################## TITULOS ####################################################################################################
titulo1 db "######## INGRESAR ########","$"
titulo2 db "######## REGISTRAR ########","$"
titulo3 db 10,13,"######## TOP 10 PUNTOS ########","$"
titulo4 db 10,13,"######## TOP 10 TIEMPOS ########","$"
;######################## FALLOS #######################################################################################################
falloabrir db 10,13,"ERROR, NO SE PUDO ABRIR EL ARCHIVO","$"
falloarchivo db 10,13,"ERROR, NO SE PUDO CREAR EL ARCHIVO","$"
falloleer db 10,13,"ERROR, NO SE PUDO LEER EL ARCHIVO","$"
falloescritura db 10,13,"ERROR, NO SE PUDO ESCRIBIR EN EL ARCHIVO","$"
falloencontrar db 10,13,"ERROR, ESTE ARCHIVO NO FUE ENCONTRADO. VERIFIQUE","$"
fallocerrar db 10,13,"ERROR, HUBO UN ERROR AL CERRAR EL ARCHIVO","$"
;##################### MENSAJES PARA LOGIN ####################################################################################################
mensajesalida db 10,13,"GRACIAS POR JUGAR","$"
mensajepedir db 10,13,"INGRESE LA RUTA DEL ARCHIVO: ","$"
mensajeopcionincorrecta db 10,13,"OPCION INCORRECTA, VUELVA A INTENTARLO","$"
mensajeingresouser db 10,13,"INGRESE EL NOMBRE DE USUARIO: ","$"
mensajeingresopass db 10,13,"INGRESE LA CONTRASENA: ","$"
mensajecaracternovalido db 10,13,"CARACTER NO VALIDO...","$"
mensajerepetir db 10,13,"INGRESO MAS CARACTERES, EMPIEZE OTRA VEZ...","$"
mensajeyaexiste db 10,13,"ESTE USUARIO YA EXISTE, INGRESE OTRO USUARIO...","$"
existeusuario db 10,13,"ACCESO CONCEDIDO...","$"
noexiste db 10,13,"LAS CREDENCIALES SON INCORRECTAS...","$"
;###################### MENSAJES EN PANTALLA DEL JUEGO ################
mgnombre db "Nombre: ",0
mgnivel db "Nivel: ",0
mgpuntos db "Puntos: ",0
mgpasarnivel db "NUEVO NIVEL",0
pts db "00",0
puntosglobales db 0
auxptglobal db 0
mgtiempo db "Tiempo: ",0
mgpausa db "PAUSA",0
mgsalida db "GAME OVER!",0
mgtop10 db "JUGADORES TOP 10",0
mgordenamiento db "ORDENAMIENTO:"
msgbubble db "BUBBLESORT"
msgquick db "QUICKSORT"
msgshell db "SHELLSORT"
msgveloc db "VEL:"
;########################## FRECUENCIAS #################################
frecuenciaroja dw 1193180 / 100
frecuenciaazul dw 1193180 / 300 
frecuenciaamarilla dw 1193180 / 500
frecuenciaverde dw 1193180 / 700
frecuenciablanca dw 1193180 / 900
;#################### ARREGLOS PARA TOP 10 PUNTOS #######################
pts1 db 10,13,"1)          ","            ","              ","               ","$"
pts2 db 10,13,"2)          ","            ","              ","               ","$"
pts3 db 10,13,"3)          ","            ","              ","               ","$"
pts4 db 10,13,"4)          ","            ","              ","               ","$"
pts5 db 10,13,"5)          ","            ","              ","               ","$"
pts6 db 10,13,"6)          ","            ","              ","               ","$"
pts7 db 10,13,"7)          ","            ","              ","               ","$"
pts8 db 10,13,"8)          ","            ","              ","               ","$"
pts9 db 10,13,"9)          ","            ","              ","               ","$"
pts10 db 10,13,"10)          ","            ","              ","               ","$"
;#################### ARREGLOS PARA TOP 10 TIEMPOS #######################
tms1 db 10,13,"1)          ","            ","              ","               ","$"
tms2 db 10,13,"2)          ","            ","              ","               ","$"
tms3 db 10,13,"3)          ","            ","              ","               ","$"
tms4 db 10,13,"4)          ","            ","              ","               ","$"
tms5 db 10,13,"5)          ","            ","              ","               ","$"
tms6 db 10,13,"6)          ","            ","              ","               ","$"
tms7 db 10,13,"7)          ","            ","              ","               ","$"
tms8 db 10,13,"8)          ","            ","              ","               ","$"
tms9 db 10,13,"9)          ","            ","              ","               ","$"
tms10 db 10,13,"10)          ","            ","              ","               ","$"
;#################### RUTAS ############################################################################################################
rutausuarios db "USERS.PLY",0
rutpuntos db "UPTS.PLY",0
ruttiempos db "UTMS.PLY",0
rut10pts db "PUTS.REP",0
rut10tms db "TMPS.REP",0
limite1 dw 0
limite2 dw 0
vectorjuego dw 140,40,20,120,60,100,80,160,0 ;ARREGLO DEL JUEGO
posicionesy dw 900 dup(10)
posicionesx dw 900 dup(100)
bloquescolores db 1500 dup(0)
enemigosx dw 0
enemigosy dw 0
esposx dw 170
esposy dw 10
banderasalida db 0
almacenartiempo db "$$$$","$"
cantidad dw 0
;#################### VARIABLES (1) SOLO PARA EL LOGIN #####################################################################################################
caracter db '?','$'
handler dw ?
posxi dw 95
contadorletras dw 0
rebusuario db 10 dup ('$')
rebpassword db 10 dup ('$')
conjunto db 20 dup ('$')
recolector db 500 dup ('$')
;######################## PARA TOP 10 ############################
copia1 db 500 dup('$')
copia2 db 500 dup ('$')
subnombre db 10 dup("$")
number db 5 dup("$")
subnivel db 5 dup("$")
subnumero db 0
numeroasistente db 0
temporal db 0
temporalmenor db 0
contadorusuarios db 0
subcadena db 10 dup('$')
;##################### GUARDAR LOS NIVELES ##################################################################################################
catchbuffer db 300 dup('$')
catchbuffer2 db 300 dup('$')
catchruta db 40 dup ('$')
contadornivel db 1
numerodeniveles db 1
nivel1 db 50 dup('$')
nivel2 db 50 dup('$')
nivel3 db 50 dup('$')
nivel4 db 50 dup('$')
nivel5 db 50 dup('$')
nivel6 db 50 dup('$')
;##################### VARIABLES PARA EL JUEGO ##########################################################################################################
numeronivel db 9 dup("$")
tiemponivel db 4 dup("$")
tiempoobstaculo db 4 dup("$")
tiempopremio db 4 dup("$")
elementocolor db 8 dup("$")
puntopremio db 4 dup("$")
puntoobstaculo db 4 dup("$")
colorauto db 36
timenivel dw 60
timeobs dw 3
timepre dw 4
pointobs db 2
pointpre db 6
subdl dw 0 
subdh dw 0
activos dw 0
altercolor db 0
;#################### VARIABLES PARA LAS BARRAS ########################################
msgvelocidad db "INGRESE UNA VELOCIDAD ENTRE 0 Y 9: ","$"
tiemposonido dw 500
mayorvalor_p db 0
mayorvalor_t db 0
mgnumero db 0
mgtempo db 0
mgcolor db 0
mgfinal db 0
posicion db 0
mginicio db 0
arreglonumeros db 60 dup(0)
cntusuarios dw 0
velocidad db 0
mgsonido dw 0
contadordeveces dw 0
msgvel db 1 dup("$")
shtemporal db 0
shnumber db "00"
shnumber2 db "000"
bandera db 0
tomarvalor db 0
;################### ORDENAMIENTOS #################################
;############### BUBLESORT
datos db "77,42,35,12,55,33,02","$"
numero1 db 0
numero2 db 0
numerotemporal db 0
newvector db 30 dup(0)
mostrardatos db 60 dup("$")
contadorbubble dw 0
;############### SHELLSORT
datos2 db "15,34,12,05,67,49,82,98,71,22","$" ;arreglo
numero1s db 0 ;guardar si
numero2s db 0 ;guardar si+k
constantek dw 0 ;constante que determina cuando cambiar 
vectorshell db 30 dup(0) ;vector donde se depositan numeros
mostrarshell db 60 dup("$") ;vector para mostrar luego
;############### QUICKSORT
datos3 db "10,80,30,90,40,50,70","$"
indexlow db 0
indexhigh db 0
ayudante db 0
pivote db 0
pila db 50 dup(0)
tamano db 0
tope dw 0
;########################################################## OBSTACULOS
bandera27 db 0
;--------------------1
posobx1 dw 20
posoby1 dw 10

;##################### CODIGO ##########################################################################################################
.code 
MAIN proc;INICIO DEL PROCESO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	MOV AX,seg @DATA
	MOV DS, AX
	;INICIOPROGRAMA
	PRESENTACION:
        LIMPIARPANTALLA
        PRINT ENCABEZADO
        PRINT MENU1
        GETCHAR2
        SALTO
        cmp al,"1"
        je INGRESAR
        cmp al,"2"
        je REGISTRAR
        cmp al,"3"
        je SALIRJUEGO
        jmp REGRESARPRESENTACION

    INGRESAR:
        LIMPIARPANTALLA
        LIMPIARTXT conjunto,SIZEOF conjunto,24h
        LIMPIARTXT rebusuario,SIZEOF rebusuario,24h
        LIMPIARTXT rebpassword,SIZEOF rebpassword,24h
        LIMPIARTXT recolector,SIZEOF recolector,24h
        Y1:
            PRINT titulo1
            PRINT mensajeingresouser
            INGRESARU rebusuario
        Y2:
            PRINT titulo1
            PRINT mensajeingresopass
            INGRESARP rebpassword
            UNIRDATOS rebusuario,rebpassword
            ANALIZARA conjunto
            PRINT conjunto
        Y3:
            GETCHAR8
            jmp PRESENTACION
	
	REGISTRAR:
        LIMPIARPANTALLA
        LIMPIARTXT conjunto,SIZEOF conjunto,24h
        LIMPIARTXT rebusuario,SIZEOF rebusuario,24h
        LIMPIARTXT rebpassword,SIZEOF rebpassword,24h
        LIMPIARTXT recolector,SIZEOF recolector,24h
        Z1:
            PRINT titulo2
            PRINT mensajeingresouser
            INGRESARUSUARIO rebusuario
        Z2:
            PRINT titulo2
            PRINT mensajeingresopass
            INGRESARPASSWORD rebpassword
            UNIRDATOS rebusuario,rebpassword
            REGISTRARUSUARIOS recolector,conjunto
        Z3:
            GETCHAR8
            jmp PRESENTACION

    SALIRJUEGO:
        PANTALLAPRUEBA
        PRINT mensajesalida
        mov ax,4c00h
        int 21h

    REGRESARPRESENTACION:
        PRINT mensajeopcionincorrecta
        jmp PRESENTACION
;############################################ SEGUNDO MENU #######################################################################################
    PRESENTACION2:
        LIMPIARPANTALLA
        PRINT MENU2
        GETCHAR2
        cmp al,"1"
        je INICIARJUEGO
        cmp al,"2"
        je REAUNUDAR
        cmp al,"3"
        je REGRESAR
        jmp REGRESARPRESENTACION2

        INICIARJUEGO:
            VALORESFABRICA
            GRAFICARJUEGOFABRICA colorauto,timenivel,pointpre,pointobs
            jmp PRESENTACION2

        REAUNUDAR:
            PRINT mensajepedir
            LEERARCHIVO catchruta
            jmp PRESENTACION2

        REGRESARPRESENTACION2:
            PRINT mensajeopcionincorrecta
            GETCHAR8
            jmp PRESENTACION2

;############################################### TERCER MENU #################################################################################
    PRESENTACION3:
        LIMPIARPANTALLA 
        PRINT MENU3
        GETCHAR2
        cmp al,"1"
        je SHOWPTS
        cmp al,"2"
        je SHOTMS
        cmp al,"3"
        je REGRESAR
        jmp REGRESARPRESENTACION3
    ;########################################### PUNTOS
    SHOWPTS:
        mov bandera,1
        LIMPIARPANTALLA
        BORRARPTS
        TOP10PUNTOS
        PRINT10PTS
        GETCHAR8
        cmp al," "
        je SHOWGRA
        JMP PRESENTACION3

    SHOWGRA:
        LIMPIARPANTALLA
        PRINT MENU4
        GETCHAR2
        cmp al,"1"
        je ORDBUBB
        cmp al,"2"
        je ORDSHELL
        cmp al,"3"
        je ORDQUICK
        cmp al,"4"
        je PRESENTACION3 
        jmp SHOWGRA
    ORDBUBB:
        SALTO
        PRINT msgvelocidad
        SOLICITARVELOCIDAD
        SALTO
        PRINT MENU5
        GETCHAR2
        cmp al,"1"
        je BUBB_A
        cmp al,"2"
        je BUBB_B
        jmp SHOWGRA

    BUBB_A:
        OBTENERDATOS
        BUBBLE_A arreglonumeros
        GETCHAR8
        JMP SHOWGRA

    BUBB_B:
        OBTENERDATOS
        BUBBLE_B arreglonumeros
        GETCHAR8
        jmp SHOWGRA

    ORDSHELL:
        SALTO
        PRINT msgvelocidad
        SOLICITARVELOCIDAD
        SALTO
        PRINT MENU5
        GETCHAR2
        cmp al,"1"
        je SHELLP1
        cmp al,"2"
        je SHELLP2
        jmp SHOWGRA

    SHELLP1:
        OBTENERDATOS
        SHELLSORT_A arreglonumeros
        GETCHAR8
        JMP SHOWGRA

    SHELLP2:
        OBTENERDATOS
        SHELLSORT_B arreglonumeros
        GETCHAR8
        JMP SHOWGRA

    ORDQUICK:
        SALTO
        PRINT msgvelocidad
        SOLICITARVELOCIDAD
        SALTO
        PRINT MENU5
        GETCHAR2
        cmp al,"1"
        je QUICKP1
        cmp al,"2"
        je QUICKP2
        jmp SHOWGRA

    QUICKP1:
        OBTENERDATOS
        QUICKSORT_A arreglonumeros,indexlow,indexhigh
        GETCHAR8
        mov tope,0
        mov indexhigh,0
        mov indexlow,0
        mov ayudante,0
        mov pivote,0
        JMP SHOWGRA

    QUICKP2:
        OBTENERDATOS
        QUICKSORT_B arreglonumeros,indexlow,indexhigh
        GETCHAR8
        mov tope,0
        mov indexhigh,0
        mov indexlow,0
        mov ayudante,0
        mov pivote,0
        JMP SHOWGRA
        ;######################################################## TIEMPOS
    SHOTMS:
        mov bandera,0
        LIMPIARPANTALLA
        BORRARTMS
        TOP10TIEMPOS
        PRINT10TMS
        GETCHAR8
        cmp al," "
        je SHOWGRATMS
        JMP PRESENTACION3

    SHOWGRATMS:
        LIMPIARPANTALLA
        PRINT MENU4
        GETCHAR2
        cmp al,"1"
        je ORDBUBBT
        cmp al,"2"
        je ORDSHELLT
        cmp al,"3"
        je ORDQUICKT
        cmp al,"4"
        je PRESENTACION3 
        jmp SHOWGRATMS

    ORDBUBBT:
        SALTO
        PRINT msgvelocidad
        SOLICITARVELOCIDAD
        SALTO
        PRINT MENU5
        GETCHAR2
        cmp al,"1"
        je BUBB_AT
        cmp al,"2"
        je BUBB_BT
        jmp SHOWGRATMS

    BUBB_AT:
        OBTENERDATOST
        BUBBLE_A arreglonumeros
        GETCHAR8
        JMP SHOWGRATMS

    BUBB_BT:
        OBTENERDATOST
        BUBBLE_B arreglonumeros
        GETCHAR8
        jmp SHOWGRATMS

    ORDSHELLT:
        SALTO
        PRINT msgvelocidad
        SOLICITARVELOCIDAD
        SALTO
        PRINT MENU5
        GETCHAR2
        cmp al,"1"
        je SHELLP1T
        cmp al,"2"
        je SHELLP2T
        jmp SHOWGRATMS

    SHELLP1T:
        OBTENERDATOST
        SHELLSORT_A arreglonumeros
        GETCHAR8
        JMP SHOWGRATMS

    SHELLP2T:
        OBTENERDATOST
        SHELLSORT_B arreglonumeros
        GETCHAR8
        JMP SHOWGRATMS

    ORDQUICKT:
        SALTO
        PRINT msgvelocidad
        SOLICITARVELOCIDAD
        SALTO
        PRINT MENU5
        GETCHAR2
        cmp al,"1"
        je QUICKP1T
        cmp al,"2"
        je QUICKP2T
        jmp SHOWGRATMS

    QUICKP1T:
        OBTENERDATOST
        QUICKSORT_A arreglonumeros,indexlow,indexhigh
        GETCHAR8
        mov tope,0
        mov indexhigh,0
        mov indexlow,0
        mov ayudante,0
        mov pivote,0
        JMP SHOWGRATMS

    QUICKP2T:
        OBTENERDATOST
        QUICKSORT_B arreglonumeros,indexlow,indexhigh
        GETCHAR8
        mov tope,0
        mov indexhigh,0
        mov indexlow,0
        mov ayudante,0
        mov pivote,0
        JMP SHOWGRATMS
    
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    REGRESARPRESENTACION3:
        PRINT mensajeopcionincorrecta
        jmp PRESENTACION3

    REGRESAR:
        LIMPIARTXT rebusuario,SIZEOF rebusuario,24h
        LIMPIARTXT rebpassword,SIZEOF rebpassword,24h
        LIMPIARPANTALLA
        jmp PRESENTACION
;######################## FALLOS #################################################################################################################
    FALLA1:
        PRINT falloabrir
        GETCHAR8
        SALTO
        jmp PRESENTACION

    FALLA2:
        PRINT fallocerrar
        GETCHAR8
        SALTO
        jmp PRESENTACION

    FALLA3:
        PRINT falloleer
        GETCHAR8
        SALTO
        jmp PRESENTACION

    FALLA4:
        PRINT falloarchivo
        GETCHAR8
        SALTO
        jmp PRESENTACION

    FALLA5:
        PRINT falloescritura
        GETCHAR8
        SALTO
        jmp PRESENTACION
;#####################################################################################################
MAIN endp;FINAL DEL PROCESO  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

DEFINIR:
    cmp bandera,1
    je SONDOS
    cmp bandera,0
    je SONTRES

    SONDOS:
        CREATENUM tomarvalor
        jmp SONFINAL
    SONTRES:
        CREATENUM2 tomarvalor
        JMP SONFINAL
    SONFINAL:
ret

TIPODETEXTO:
    CMP bandera,1
    je TIPO1
    CMP bandera,0
    je TIPO2

    TIPO1:
        GRAFICARTEXTO shnumber,SIZEOF shnumber,15,23,mginicio
        jmp TIPOF
    TIPO2:
        GRAFICARTEXTO shnumber2,SIZEOF shnumber2,15,23,mginicio
        jmp TIPOF
    TIPOF:
ret

CRONOS2 proc
    push ax
    push bx
    push dx
    xor dx,dx
    SEG1:
        mov dl,Tiempo2[4]
        cmp dl,"9"
        je SEG2
        sub dl,30h
        inc dl
        add dl,30h
        mov Tiempo2[4],dl
        jmp FINCN
    SEG2:
        mov Tiempo2[4],"0"
        mov dl,Tiempo2[3]
        sub dl,30h
        inc dl
        add dl,30h
        cmp dl,"6"
        je MIN1
        mov Tiempo2[3],dl
        jmp FINCN
    MIN1:
        mov Tiempo2[4],'0'
        mov Tiempo2[3],'0'
        mov dl,Tiempo2[1]
        sub dl,30h
        inc dl
        add dl,30h
        mov Tiempo2[1],dl
        jmp FINCN
    FINCN:
        pop dx
        pop bx
        pop ax
        ret
CRONOS2 endp

CRONOS proc ;1
    push ax
    push bx
    push dx
    push cx ;POR SI HAY REGISTROS
    xor dx,dx
        SEGUNDO1:
            mov dl,Tiempo[3]
            cmp dl,"9"
            je SEGUNDO2
            sub dl,30h
            inc dl
            add dl,30h
            mov Tiempo[3],dl
            jmp FINRES
        SEGUNDO2:
            MOV Tiempo[3],'0'
            MOV dl,Tiempo[2]
            sub dl,30h
            inc dl
            add dl,30h
            cmp dl,'9'
            je MINUTO1
            mov Tiempo[2],dl
            jmp FINRES
        MINUTO1:
            mov Tiempo[3],'0'
            mov Tiempo[2],'0'
            mov dl,Tiempo[1]
            sub dl,30h
            inc dl
            add dl,30h
            cmp dl,'9'
            je MINUTO2
            mov Tiempo[1],dl
            jmp FINRES
        MINUTO2:
            mov Tiempo[3],'0'
            mov Tiempo[2],'0'
            mov Tiempo[1],'0'
            mov dl,Tiempo[0]
            sub dl,30h
            inc dl
            add dl,30h
            cmp dl,'9'
            je RESETEAR
            mov Tiempo[0],dl
            jmp FINRES

        RESETEAR:
            MOV Tiempo[4],'0'
            MOV Tiempo[3],'0'
            MOV Tiempo[1],'0'
            MOV Tiempo[0],'0'
            jmp FINRES
    FINRES:
        pop cx ;RECUPERO REGISTROS
        pop dx
        pop bx
        pop ax
        ret
CRONOS endp

end
