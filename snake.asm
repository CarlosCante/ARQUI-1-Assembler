PintarPixel macro coordenadaX, coordenadaY, color
	mov cx, coordenadaX
	mov dx, coordenadaY
	mov ah, 0ch
	mov al, color
	int 10h
endm
PintarCirculo macro coordenadaInicialX, coordenadaInicialY, color
	mov cx, coordenadaInicialX
	mov dx, coordenadaInicialY

	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color

	mov cx, coordenadaInicialX
	inc dx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color

	mov cx, coordenadaInicialX
	inc dx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color

	mov cx, coordenadaInicialX
	inc dx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color

	mov cx, coordenadaInicialX
	inc cx
	inc dx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
	inc cx
	PintarPixel cx, dx, color
endm
PintarCaracter macro linea, columna, caracter, color
	mov dh,linea 
    mov dl,columna 
    mov bh,0 
    mov ah,2 
    int 10h 

    mov ah,9 
    mov al,caracter 
    mov bh,0     
    mov bl,color 
    mov cx,1       
    int 10h 
endm
LimpiarPantalla macro
	mov ah,0
	mov al,3h 
	int 10h 

	mov ax,0600h 
	mov bh,07h 
	mov cx,0000h
	mov dx,184Fh
	int 10h
endm
ImprimirCadena macro texto
	mov dx, offset texto
	mov ah, 9
	int 21h
endm
CrearArchivo macro nombre 
	mov ax,@data  
	mov ds,ax
	mov ah,3ch 
	mov cx,0 
	mov dx,offset nombre 
	int 21h
	mov bx,ax
	
	mov ah,3eh 
	int 21h
endm
EscribirArchivo macro nombre, vector
	mov ah,3dh
	mov al,1h 
	mov dx,offset nombre
	int 21h

	mov bx,ax 
	mov cx,si 
	mov dx,offset vector
	mov ah,40h
	int 21h
	cmp cx,ax
	
	mov ah,3eh  
	int 21h
endm
EliminarArchivo macro nombre
	mov ah,41h 
	mov dx, offset nombre
	int 21h  
endm
.model small

.stack 128
.data

p1  db 10,13,'--------------------------------------------------','$'
p2  db 10,13,'Universidad de San Carlos de Guatemala','$'
p3  db 10,13,'Facultad de Ingenieria','$'
p4  db 10,13,'Arquitectura de Computadoras y Ensambladores 1','$'
p5	db 10,13,'Primer Semestre 2017','$'
p6	db 10,13,'Seccion A','$'
p7	db 10,13,'Proyecto 2','$'
p8	db 10,13,'         Brayan Ezequiel Santiago Brito','$'
p9	db 10,13,'                  201114566','$'
p10 db 10,13,'--------------------------------------------------','$'
p11 db 10,13,'1. Ingresar','$'
p12 db 10,13,'2. Registrar','$'
p13 db 10,13,'3. Salir','$'
p14 db 10,13,'Elija una Opcion:','$'
			  
r1  db 10,13,'Menu de registro de usuarios','$'
r2  db 10,13,'Ingrese un nombre de usuario de maximo 7 caracteres:','$'
r3  db 10,13,'Ingrese una contrasena de maximo 4 numeros:','$'
r4  db 10,13,'Contrasena invalida','$'
r5  db 10,13,'Usuario existente!','$'
r6  db 10,13,'Menu de ingreso de usuarios','$'
ma1  db 10,13,'Menu de administrador','$'
ma2  db 10,13,'1. Top 10 Puntos','$'
ma3  db 10,13,'2. Top 10 Tiempo','$'
ma4  db 10,13,'3. Regresar al menu principal','$'


nombreExiste db 0
admin db 'adminAP,1234;','$'
archivoUsuarios db 'SNAKEUSU.txt',0
archivoUsuariosDos db 'SNAKEU.txt',0
cantidadCaracteresArchivoUsuarios dw 0

contenidoArchivo db 1300 dup('$')


contadorCicloUno dw 0
contadorCicloDos dw 0
contadorCicloTres dw 0
contadorCicloCuatro dw 0
negro db 0
blanco db 15
verde db 50
rojo db 54
x0 dw 0
y0 dw 0
col db 0
comida db 0
direccion db 0
direccionDos db 0
nivel db 1
punteoUnidad db 0
punteoDecena db 0
salirJuego db 0
modoSalir db 0
;sx dw 145,140,135,0,0,0,0,0,0,0,0,0,0
;sy dw 105,105,105,0,0,0,0,0,0,0,0,0,0

contadorAux db 0
cantidadCaracteresNombre db 0
n1 db 32
n2 db 32
n3 db 32
n4 db 32
n5 db 32
n6 db 32
n7 db 32

c1 db 0
c2 db 0
c3 db 0
c4 db 0

fin db 0

sn1 db 0
sn2 db 0
sn3 db 0
sn4 db 0
sn5 db 0
sn6 db 0
sn7 db 0

sc1 db 0
sc2 db 0
sc3 db 0
sc4 db 0

x db 0
y db 0
car db 0
tiempo db 3
cicloTiempo db 10

contadorTiempo db 0
segundosUno db 0
segundosDos db 0
minutosUno db 0
minutosDos db 0
horasUno db 0
horasDos db 0

sx1 dw 145
sy1 dw 105
sx2 dw 140
sy2 dw 105
sx3 dw 135
sy3 dw 105
sx4 dw 0
sy4 dw 0
sx5 dw 0
sy5 dw 0
sx6 dw 0
sy6 dw 0
sx7 dw 0
sy7 dw 0
sx8 dw 0
sy8 dw 0
sx9 dw 0
sy9 dw 0
sx10 dw 0
sy10 dw 0
sx11 dw 0
sy11 dw 0
sx12 dw 0
sy12 dw 0

.code
.startup
main proc
	call AgregarAdministrador
	
	Menu:
	call ReiniciarVaribles
	call MostrarMenuPrincipal

    mov ah,08 
    int 21h
    cmp al,49 
    je Ingresar 
	cmp al,50 
    je Registrar
	cmp al,51 
    je SalirAplicacion
	jmp Menu
	
	Ingresar:
	call IngresoUsuario
	cmp n1,97
	jne finEsAdministrador
	cmp n2,100
	jne finEsAdministrador
	cmp n3,109
	jne finEsAdministrador
	cmp n4,105
	jne finEsAdministrador
	cmp n5,110
	jne finEsAdministrador
	cmp n6,65
	jne finEsAdministrador
	cmp n7,80
	jne finEsAdministrador
	
	cmp c1,49
	jne finEsAdministrador
	cmp c2,50
	jne finEsAdministrador
	cmp c3,51
	jne finEsAdministrador
	cmp c4,52
	jne finEsAdministrador
	
	esAdministrador:
		call MenuReportes
		mov ah,08 
		int 21h
		cmp al,51 
		je Menu
		jmp esAdministrador
	finEsAdministrador:
	jmp Inicio
	
	Registrar:
	call RegistrarUsuario
	jmp Menu
	
	
	SalirAplicacion:
	mov ax,4c00h
	int 21h
	
	Inicio:

	mov ax,0013h
 	int 10h

	mov ax, 0000h
	mov bx, 0000h
	mov cx, 0000h
	mov dx, 0000h

	call PintarExterior 
	call PintarInterior 
	
		
	Juego:
		mov contadorCicloDos, 0
		call BorrarCola
		call ActualizarCuerpo
		call ActualizarCabeza
		call PintarSerpiente
		call PintarComida
		call PintarObstaculoUno
		call PintarObstaculoDos
		call VerificarAlimentoComido
		call VerificarColision
		call ActualizarTiempo
		call PintarEstadisticas
		cicloDos:
			cicloUno:
					call LeerMovimientos
					call VerificarTeclaEscape
					cmp salirJuego,1
					je regresarMenuPrincipal
					inc contadorCicloUno
					cmp contadorCicloUno, 0ff0h
					jnz cicloUno
			mov contadorCicloUno, 0
			inc contadorCicloDos
			
			cmp nivel,1
			je cicloNivelUno
			cmp nivel,2
			je cicloNivelDos
			cmp nivel,3
			je cicloNivelTres
			
			cicloNivelUno:
			cmp contadorCicloDos, 04h
			jnz cicloDos
			jmp seguirCiclo
			
			cicloNivelDos:
			cmp contadorCicloDos, 03h
			jnz cicloDos
			jmp seguirCiclo
			
			cicloNivelTres:
			cmp contadorCicloDos, 02h
			jnz cicloDos
			jmp seguirCiclo
			
			regresarMenuPrincipal:
			mov salirJuego,0
			
			cmp modoSalir,1
			je modoSalirVictoria
			cmp modoSalir,2
			je modoSalirDerrota
			jmp seguirRegresarMenuPrincipal
			
			modoSalirVictoria:
			call Victoria
			jmp seguirRegresarMenuPrincipal
			
			modoSalirDerrota:
			call Derrota
			jmp seguirRegresarMenuPrincipal
			
			seguirRegresarMenuPrincipal:
			jmp Menu
			
			seguirCiclo:
			
			
	jmp Juego
	
	ReiniciarVaribles:
		mov sx1,145
		mov sy1,105
		mov sx2,140
		mov sy2,105
		mov sx3,135
		mov sy3,105
		mov sx4,0
		mov sy4,0
		mov sx5,0
		mov sy5,0
		mov sx6,0
		mov sy6,0
		mov sx7,0
		mov sy7,0
		mov sx8,0
		mov sy8,0
		mov sx9,0
		mov sy9,0
		mov sx10,0
		mov sy10,0
		mov sx11,0
		mov sy11,0
		mov sx12,0
		mov sy12,0
		
		mov contadorTiempo,0
		mov segundosUno,0
		mov segundosDos,0
		mov minutosUno,0
		mov minutosDos,0
		mov horasUno,0
		mov horasDos,0
		
		mov x,0
		mov y,0
		mov car,0
		mov tiempo,3
		mov cicloTiempo,10
		
		mov fin,0
		
		mov x0,0
		mov y0,0
		mov col,0
		mov comida,0
		mov direccion,0
		mov direccionDos,0
		mov nivel,1
		mov punteoUnidad,0
		mov punteoDecena,0
		mov salirJuego,0
		
		mov contadorCicloUno,0
		mov contadorCicloDos,0
		mov contadorCicloTres,0
		mov contadorCicloCuatro,0
		
		mov modoSalir, 0
	ret
	
	AgregarAdministrador:
		mov si, 0
		mov contenidoArchivo[si],97
		add si,1
		mov contenidoArchivo[si],100
		add si,1
		mov contenidoArchivo[si],109
		add si,1
		mov contenidoArchivo[si],105
		add si,1
		mov contenidoArchivo[si],110
		add si,1
		mov contenidoArchivo[si],65
		add si,1
		mov contenidoArchivo[si],80
		add si,1
		mov contenidoArchivo[si],44
		add si,1
		mov contenidoArchivo[si],49
		add si,1
		mov contenidoArchivo[si],50
		add si,1
		mov contenidoArchivo[si],51
		add si,1
		mov contenidoArchivo[si],52
		add si,1
		mov contenidoArchivo[si],59
		mov cantidadCaracteresArchivoUsuarios,13
	ret
	
	MostrarMenuPrincipal:
	
		LimpiarPantalla
				
		ImprimirCadena p1
		ImprimirCadena p2
		ImprimirCadena p3
		ImprimirCadena p4
		ImprimirCadena p5
		ImprimirCadena p6
		ImprimirCadena p7
		ImprimirCadena p8
		ImprimirCadena p9
		ImprimirCadena p10
		ImprimirCadena p11
		ImprimirCadena p12
		ImprimirCadena p13
		ImprimirCadena p14
	ret
	
	MenuReportes:
		LimpiarPantalla
		ImprimirCadena ma1
		ImprimirCadena ma2
		ImprimirCadena ma3
		ImprimirCadena ma4
	ret
	
	RegistrarUsuario:
			
		call LeerNombreUsuario
				
	ret
	
	IngresoUsuario:
		LimpiarPantalla

		ImprimirCadena r6
		ImprimirCadena r2
		
		mov n1,32
		mov n2,32
		mov n3,32
		mov n4,32
		mov n5,32
		mov n6,32
		mov n7,32
		mov contadorAux,0
		mov cantidadCaracteresNombre,0
		
		leerNombreIU:
			cmp contadorAux,0
			je leerCaracterUnoIU
			cmp contadorAux,1
			je leerCaracterDosIU
			cmp contadorAux,2
			je leerCaracterTresIU
			cmp contadorAux,3
			je leerCaracterCuatroIU
			cmp contadorAux,4
			je leerCaracterCincoIU
			cmp contadorAux,5
			je leerCaracterSeisIU
			cmp contadorAux,6
			je leerCaracterSieteIU
			leerCaracterUnoIU:
			mov ah,01h
			int 21h
			cmp al,0dh
			je salirLeerNombreIU
			mov n1, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombreIU
			
			leerCaracterDosIU:
			mov ah,01h
			int 21h
			cmp al,0dh
			je salirLeerNombreIU
			mov n2, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombreIU
			
			leerCaracterTresIU:
			mov ah,01h
			int 21h
			cmp al,0dh
			je salirLeerNombreIU
			mov n3, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombreIU
			
			leerCaracterCuatroIU:
			mov ah,01h
			int 21h
			cmp al,0dh
			je salirLeerNombreIU
			mov n4, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombreIU
			
			leerCaracterCincoIU:
			mov ah,01h
			int 21h
			cmp al,0dh
			je salirLeerNombreIU
			mov n5, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombreIU
			
			leerCaracterSeisIU:
			mov ah,01h
			int 21h
			cmp al,0dh
			je salirLeerNombreIU
			mov n6, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombreIU
			
			leerCaracterSieteIU:
			mov ah,01h
			int 21h
			cmp al,0dh
			je salirLeerNombreIU
			mov n7, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			
		salirLeerNombreIU:	
		call LeerContrasenaUsuario
	ret
	
	LeerNombreUsuario:
		LimpiarPantalla

		ImprimirCadena r1
		ImprimirCadena r2
		
		mov n1,32
		mov n2,32
		mov n3,32
		mov n4,32
		mov n5,32
		mov n6,32
		mov n7,32
		mov contadorAux,0
		mov cantidadCaracteresNombre,0
		
		leerNombre:
			cmp contadorAux,0
			je leerCaracterUno
			cmp contadorAux,1
			je leerCaracterDos
			cmp contadorAux,2
			je leerCaracterTres
			cmp contadorAux,3
			je leerCaracterCuatro
			cmp contadorAux,4
			je leerCaracterCinco
			cmp contadorAux,5
			je leerCaracterSeis
			cmp contadorAux,6
			je leerCaracterSiete
			leerCaracterUno:
			mov ah,01h
			int 21h
			cmp al,0dh
			je verificacion
			mov n1, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombre
			
			leerCaracterDos:
			mov ah,01h
			int 21h
			cmp al,0dh
			je verificacion
			mov n2, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombre
			
			leerCaracterTres:
			mov ah,01h
			int 21h
			cmp al,0dh
			je verificacion
			mov n3, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombre
			
			leerCaracterCuatro:
			mov ah,01h
			int 21h
			cmp al,0dh
			je verificacion
			mov n4, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombre
			
			leerCaracterCinco:
			mov ah,01h
			int 21h
			cmp al,0dh
			je verificacion
			mov n5, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombre
			
			leerCaracterSeis:
			mov ah,01h
			int 21h
			cmp al,0dh
			je verificacion
			mov n6, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			jmp leerNombre
			
			leerCaracterSiete:
			mov ah,01h
			int 21h
			cmp al,0dh
			je verificacion
			mov n7, al
			add contadorAux,1
			add cantidadCaracteresNombre,1
			
		verificacion:
		;call VerificarExisteUsuario
		mov si,0
		call BuscarSiguienteNombreYContrasena
		cmp nombreExiste,1
		jne salirLeerNombre
		ImprimirCadena r5
		ImprimirCadena r2
		mov n1,32
		mov n2,32
		mov n3,32
		mov n4,32
		mov n5,32
		mov n6,32
		mov n7,32
		mov contadorAux,0
		mov cantidadCaracteresNombre,0
		mov nombreExiste,0
		jmp leerNombre
			
		salirLeerNombre:	
		call LeerContrasenaUsuario
		call AgregarUsuario
		
		 
	ret
	
	VerificarExisteUsuario:
		mov si,0
		
		buscarNombreEnArchivo:
			call BuscarSiguienteNombreYContrasena
			cmp cantidadCaracteresNombre, 1
			je caracterUno
			cmp cantidadCaracteresNombre, 2
			je caracterDos
			cmp cantidadCaracteresNombre, 3
			je caracterTres
			cmp cantidadCaracteresNombre, 4
			je caracterCuatro
			cmp cantidadCaracteresNombre, 5
			je caracterCinco
			cmp cantidadCaracteresNombre, 6
			je caracterSeis
			cmp cantidadCaracteresNombre, 7
			je caracterSiete
			
			caracterSiete:
				cmp sn7,0
				je seguirBuscando
				mov al, n7
				cmp sn7, al
				jne seguirBuscando
			caracterSeis:
				cmp sn6,0
				je seguirBuscando
				mov al, n6
				cmp sn6, al
				jne seguirBuscando
			caracterCinco:
				cmp sn5,0
				je seguirBuscando
				mov al, n5
				cmp sn5, al
				jne seguirBuscando
			caracterCuatro:
				cmp sn4,0
				je seguirBuscando
				mov al, n4
				cmp sn4, al
				jne seguirBuscando
			caracterTres:
				cmp sn3,0
				je seguirBuscando
				mov al, n3
				cmp sn3, al
				jne seguirBuscando
			caracterDos:
				cmp sn2,0
				je seguirBuscando
				mov al, n2
				cmp sn2, al
				jne seguirBuscando
			caracterUno:
				cmp sn1,0
				je seguirBuscando
				mov al, n1
				cmp sn1, al
				jne seguirBuscando
			
			mov nombreExiste,1
			jmp salirVerificarExisteUsuario
			
		seguirBuscando:
		
		cmp fin,1
		je salirVerificarExisteUsuario
		add si,1
		jmp buscarNombreEnArchivo
			
		salirVerificarExisteUsuario:
			
	ret
	
	BuscarSiguienteNombreYContrasena:
		mov sn1,0
		mov sn2,0
		mov sn3,0
		mov sn4,0
		mov sn5,0
		mov sn6,0
		mov sn7,0
		siguienteNombre:
			mov al, contenidoArchivo[si]
			mov sn1, al
			add si,1
			cmp contenidoArchivo[si],44
			je siguienteContrasena
			mov al, contenidoArchivo[si]
			mov sn2, al
			add si,1
			cmp contenidoArchivo[si],44
			je siguienteContrasena
			mov al, contenidoArchivo[si]
			mov sn3, al
			add si,1
			cmp contenidoArchivo[si],44
			je siguienteContrasena
			mov al, contenidoArchivo[si]
			mov sn4, al
			add si,1
			cmp contenidoArchivo[si],44
			je siguienteContrasena
			mov al, contenidoArchivo[si]
			mov sn5, al
			add si,1
			cmp contenidoArchivo[si],44
			je siguienteContrasena
			mov al, contenidoArchivo[si]
			mov sn6, al
			add si,1
			cmp contenidoArchivo[si],44
			je siguienteContrasena
			mov al, contenidoArchivo[si]
			mov sn7, al
			add si,1
			cmp contenidoArchivo[si],44
			je siguienteContrasena
					
		siguienteContrasena:
			add si,1
			mov al, contenidoArchivo[si]
			mov sc1, al
			add si,1
			mov al, contenidoArchivo[si]
			mov sc2, al
			add si,1
			mov al, contenidoArchivo[si]
			mov sc3, al
			add si,1
			mov al, contenidoArchivo[si]
			mov sc4, al
			add si,1
			
			sub cantidadCaracteresArchivoUsuarios,1
			cmp si,cantidadCaracteresArchivoUsuarios
			add cantidadCaracteresArchivoUsuarios,1
			je salirSiguienteNombreYContrasena
			ja salirSiguienteNombreYContrasena
			mov fin,1
			
		salirSiguienteNombreYContrasena:
			
	ret
	
	AgregarUsuario:
		mov ax, cantidadCaracteresArchivoUsuarios
		mov si, ax
		
		mov al, n1
		mov contenidoArchivo[si],al
		add si, 1
		cmp cantidadCaracteresNombre,1
		je separacionComa
		mov al, n2
		mov contenidoArchivo[si],al
		add si, 1
		cmp cantidadCaracteresNombre,2
		je separacionComa
		mov al, n3
		mov contenidoArchivo[si],al
		add si, 1
		cmp cantidadCaracteresNombre,3
		je separacionComa
		mov al, n4
		mov contenidoArchivo[si],al
		add si, 1
		cmp cantidadCaracteresNombre,4
		je separacionComa
		mov al, n5
		mov contenidoArchivo[si],al
		add si, 1
		cmp cantidadCaracteresNombre,5
		je separacionComa
		mov al, n6
		mov contenidoArchivo[si],al
		add si, 1
		cmp cantidadCaracteresNombre,6
		je separacionComa
		mov al, n7
		mov contenidoArchivo[si],al
		add si, 1
		cmp cantidadCaracteresNombre,7
		je separacionComa
		
		separacionComa:
		mov contenidoArchivo[si],44
		add si, 1
		mov al, c1
		mov contenidoArchivo[si],al
		add si, 1
		mov al, c2
		mov contenidoArchivo[si],al
		add si, 1
		mov al, c3
		mov contenidoArchivo[si],al
		add si, 1
		mov al, c4
		mov contenidoArchivo[si],al
		add si, 1
		mov contenidoArchivo[si],59
		add si, 1
		mov cantidadCaracteresArchivoUsuarios, si
		
		EliminarArchivo archivoUsuarios
		CrearArchivo archivoUsuarios
		EscribirArchivo archivoUsuarios, contenidoArchivo
		
	ret
	
	LeerContrasenaUsuario:
		LimpiarPantalla

		;PintarCaracter 1,1,sn1,blanco
		;PintarCaracter 1,2,sn2,blanco
		;PintarCaracter 1,3,sn3,blanco
		;PintarCaracter 1,4,sn4,blanco
		;PintarCaracter 1,5,sn5,blanco
		;PintarCaracter 1,6,sn6,blanco
		;PintarCaracter 1,7,sn7,blanco
		
		ImprimirCadena r6
		ImprimirCadena r3
	
		mov c1,0
		mov c2,0
		mov c3,0
		mov c4,0
		mov contadorAux,0
		
		leerContrasena:
			cmp contadorAux,0
			je leerNumeroUno
			cmp contadorAux,1
			je leerNumeroDos
			cmp contadorAux,2
			je leerNumeroTres
			cmp contadorAux,3
			je leerNumeroCuatro
			
			leerNumeroUno:
				mov ah,01h
				int 21h
				cmp al, 48
				jb caracterInvalido
				cmp al, 57
				ja caracterInvalido
				mov c1, al
				add contadorAux,1
				jmp leerContrasena
			leerNumeroDos:
				mov ah,01h
				int 21h
				cmp al, 48
				jb caracterInvalido
				cmp al, 57
				ja caracterInvalido
				mov c2, al
				add contadorAux,1
				jmp leerContrasena
			leerNumeroTres:
				mov ah,01h
				int 21h
				cmp al, 48
				jb caracterInvalido
				cmp al, 57
				ja caracterInvalido
				mov c3, al
				add contadorAux,1
				jmp leerContrasena
			leerNumeroCuatro:
				mov ah,01h
				int 21h
				cmp al, 48
				jb caracterInvalido
				cmp al, 57
				ja caracterInvalido
				mov c4, al
				add contadorAux,1
				jmp salirLeerContrasena
			
		caracterInvalido:
			mov contadorAux,0
			ImprimirCadena r4
			ImprimirCadena r3
			jmp leerContrasena
		
		salirLeerContrasena:
		
	ret
	
	ActualizarTiempo:
		
		cmp nivel,1
		je actualizarTiempoNivelUno
		cmp nivel,2
		je actualizarTiempoNivelDos
		cmp nivel,3
		je actualizarTiempoNivelTres
		
		actualizarTiempoNivelUno:
		add contadorTiempo,1
		cmp contadorTiempo,7
		jne salirActualizarTiempo
		jmp continuarActualizarTiempo
		actualizarTiempoNivelDos:
		add contadorTiempo,1
		cmp contadorTiempo,8
		jb salirActualizarTiempo
		jmp continuarActualizarTiempo
		actualizarTiempoNivelTres:
		add contadorTiempo,1
		cmp contadorTiempo,13
		jne salirActualizarTiempo
		
		continuarActualizarTiempo:
		
		mov contadorTiempo,0
		add segundosUno,1
		cmp segundosUno,10
		jne salirActualizarTiempo
		add segundosDos,1
		mov segundosUno,0
		cmp segundosDos,6
		jne salirActualizarTiempo
		add minutosUno,1
		mov segundosDos,0
		cmp minutosUno,10
		jne salirActualizarTiempo
		add minutosDos,1
		mov minutosUno,0
		cmp minutosDos,6
		jne salirActualizarTiempo
		add horasUno,1
		mov minutosDos,0
		cmp horasUno,10
		jne salirActualizarTiempo
		add horasDos,1
		mov horasUno,0
		
		salirActualizarTiempo:
		
	ret
	
	PintarExterior:
		mov cx, 13
		mov dx, 23

		cicloExterior:
		PintarPixel cx, dx, blanco
		inc cx
		cmp cx, 307
		jne cicloExterior

		mov cx, 13
		inc dx
		cmp dx, 187
		jne cicloExterior
	ret
	
	PintarInterior:
		mov cx, 15
		mov dx, 25

		cicloInterior:
		PintarPixel cx, dx, negro
		inc cx
		cmp cx, 305
		jne cicloInterior

		mov cx, 15
		inc dx
		cmp dx, 185
		jne cicloInterior
	ret
	
	ActualizarCabeza:
		mov al, direccion
		mov direccionDos,al
		cmp direccion,0
		je cicloDerecha
		cmp direccion, 1
		je cicloIzquierda
		cmp direccion, 2
		je cicloArriba
		cmp direccion, 3
		je cicloAbajo
		
		cicloDerecha:
			add sx1, 5
			cmp sx1, 305
			je cicloDerechaUno
			jmp cicloFin
			cicloDerechaUno:
			mov sx1,15
			jmp cicloFin
		
		cicloIzquierda:
			sub sx1, 5
			cmp sx1, 10
			je cicloIzquierdaUno
			jmp cicloFin
			cicloIzquierdaUno:
			mov sx1,300
			jmp cicloFin
		
		cicloArriba:
			sub sy1, 5
			cmp sy1, 20
			je cicloArribaUno
			jmp cicloFin
			cicloArribaUno:
			mov sy1,180
			jmp cicloFin
		
		cicloAbajo:
			add sy1, 5
			cmp sy1, 185
			je cicloAbajoUno
			jmp cicloFin
			cicloAbajoUno:
			mov sy1, 25
			jmp cicloFin
		
		cicloFin:
				
	ret
	
	ActualizarCuerpo:
		mov cx, sx11
		mov dx, sy11
		mov sx12, cx
		mov sy12, dx
		mov cx, sx10
		mov dx, sy10
		mov sx11, cx
		mov sy11, dx
		mov cx, sx9
		mov dx, sy9
		mov sx10, cx
		mov sy10, dx
		mov cx, sx8
		mov dx, sy8
		mov sx9, cx
		mov sy9, dx
		mov cx, sx7
		mov dx, sy7
		mov sx8, cx
		mov sy8, dx
		mov cx, sx6
		mov dx, sy6
		mov sx7, cx
		mov sy7, dx
		mov cx, sx5
		mov dx, sy5
		mov sx6, cx
		mov sy6, dx
		mov cx, sx4
		mov dx, sy4
		mov sx5, cx
		mov sy5, dx
		mov cx, sx3
		mov dx, sy3
		mov sx4, cx
		mov sy4, dx
		mov cx, sx2
		mov dx, sy2
		mov sx3, cx
		mov sy3, dx
		mov cx, sx1
		mov dx, sy1
		mov sx2, cx
		mov sy2, dx
		
	ret
	
	BorrarCola:
		cmp comida, 0
		je colaInicio
		cmp comida, 1
		je colaUno
		cmp comida, 2
		je colaDos
		cmp comida, 3
		je colaTres
		cmp comida, 4
		je colaCuatro
		cmp comida, 5
		je colaCinco
		cmp comida, 6
		je colaSeis
		cmp comida, 7
		je colaSiete
		cmp comida, 8
		je colaOcho
		cmp comida, 9
		je colaNueve
		
		colaInicio:
		PintarCirculo sx3, sy3, negro	
		jmp finCola
		colaUno:
		PintarCirculo sx4, sy4, negro	
		jmp finCola
		colaDos:
		PintarCirculo sx5, sy5, negro	
		jmp finCola
		colaTres:
		PintarCirculo sx6, sy6, negro	
		jmp finCola
		colaCuatro:
		PintarCirculo sx7, sy7, negro	
		jmp finCola
		colaCinco:
		PintarCirculo sx8, sy8, negro	
		jmp finCola
		colaSeis:
		PintarCirculo sx9, sy9, negro	
		jmp finCola
		colaSiete:
		PintarCirculo sx10, sy10, negro	
		jmp finCola
		colaOcho:
		PintarCirculo sx11, sy11, negro	
		jmp finCola
		colaNueve:
		PintarCirculo sx12, sy12, negro	
		jmp finCola
		finCola:
		
	ret
	
	PintarSerpiente:  
		cmp comida, 0
		je serpienteInico
		cmp comida, 1
		je serpienteUno
		cmp comida, 2
		je serpienteDos
		cmp comida, 3
		je serpienteTres
		cmp comida, 4
		je serpienteCuatro
		cmp comida, 5
		je serpienteCinco
		cmp comida, 6
		je serpienteSeis
		cmp comida, 7
		je serpienteSiete
		cmp comida, 8
		je serpienteOcho
		cmp comida, 9
		je serpienteNueve
		
		serpienteNueve:
		PintarCirculo sx12, sy12, verde			
		serpienteOcho:
		PintarCirculo sx11, sy11, verde			
		serpienteSiete:
		PintarCirculo sx10, sy10, verde		
		serpienteSeis:
		PintarCirculo sx9, sy9, verde				
		serpienteCinco:
		PintarCirculo sx8, sy8, verde		
		serpienteCuatro:
		PintarCirculo sx7, sy7, verde		
		serpienteTres:
		PintarCirculo sx6, sy6, verde		
		serpienteDos:
		PintarCirculo sx5, sy5, verde		
		serpienteUno:
		PintarCirculo sx4, sy4, verde				
		serpienteInico:
		PintarCirculo sx1, sy1, verde
		PintarCirculo sx2, sy2, verde
		PintarCirculo sx3, sy3, verde
	ret 
	
	PintarComida:
		cmp comida, 0
		je comidaUno
		cmp comida, 1
		je comidaDos
		cmp comida, 2
		je comidaTres
		cmp comida, 3
		je comidaCuatro
		cmp comida, 4
		je comidaCinco
		cmp comida, 5
		je comidaSeis
		cmp comida, 6
		je comidaSiete
		cmp comida, 7
		je comidaOcho
		cmp comida, 8
		je comidaNueve
		cmp comida, 9
		je comidaDiez
		
		comidaUno:
			mov x0, 40
			mov y0, 40
			jmp etiquetaComida
		comidaDos:
			mov x0, 280
			mov y0, 160
			jmp etiquetaComida
		comidaTres:
			mov x0, 40
			mov y0, 100
			jmp etiquetaComida
		comidaCuatro:
			mov x0, 180
			mov y0, 40
			jmp etiquetaComida
		comidaCinco:
			mov x0, 160
			mov y0, 105
			jmp etiquetaComida
		comidaSeis:
			mov x0, 30
			mov y0, 30
			jmp etiquetaComida
		comidaSiete:
			mov x0, 180
			mov y0, 170
			jmp etiquetaComida
		comidaOcho:
			mov x0, 280
			mov y0, 100
			jmp etiquetaComida
		comidaNueve:
			mov x0, 40
			mov y0, 160
			jmp etiquetaComida
		comidaDiez:
			mov x0, 280
			mov y0, 40
			jmp etiquetaComida
		
		etiquetaComida:
		PintarCirculo x0, y0, rojo		
	ret
	
	PintarObstaculoUno:
	
		cmp nivel, 2
		jne salirObstaculoUno
		
		mov cx, 60
		mov dx, 55

		cicloUnoObstaculoUno:
		PintarPixel cx, dx, blanco
		inc cx
		cmp cx, 260
		jne cicloUnoObstaculoUno

		mov cx, 60
		inc dx
		cmp dx, 60
		jne cicloUnoObstaculoUno
		
		mov cx, 60
		mov dx, 155

		cicloDosObstaculoUno:
		PintarPixel cx, dx, blanco
		inc cx
		cmp cx, 260
		jne cicloDosObstaculoUno

		mov cx, 60
		inc dx
		cmp dx, 160
		jne cicloDosObstaculoUno
		
		salirObstaculoUno:
		
	ret
	
	PintarObstaculoDos:
	
		cmp nivel, 3
		jne salirObstaculoDos
		
		mov cx, 60
		mov dx, 75

		cicloUnoObstaculoDos:
		PintarPixel cx, dx, blanco
		inc cx
		cmp cx, 65
		jne cicloUnoObstaculoDos

		mov cx, 60
		inc dx
		cmp dx, 135
		jne cicloUnoObstaculoDos
		
		mov cx, 255
		mov dx, 75

		cicloDosObstaculoDos:
		PintarPixel cx, dx, blanco
		inc cx
		cmp cx, 260
		jne cicloDosObstaculoDos

		mov cx, 255
		inc dx
		cmp dx, 135
		jne cicloDosObstaculoDos
		
		salirObstaculoDos:
	
	ret
	
	PintarEstadisticas:
		mov x,1
		mov y,3
		PintarCaracter x,y,n1,blanco
		mov y,4
		PintarCaracter x,y,n2,blanco
		mov y,5
		PintarCaracter x,y,n3,blanco
		mov y,6
		PintarCaracter x,y,n4,blanco
		mov y,7
		PintarCaracter x,y,n5,blanco
		mov y,8
		PintarCaracter x,y,n6,blanco
		mov y,9
		PintarCaracter x,y,n7,blanco
		
		mov y,14
		mov car,78
		PintarCaracter x,y,car,blanco
		mov y,15
		add nivel,48
		PintarCaracter x,y,nivel,blanco
		sub nivel,48
		
		mov y,22
		mov car, 48
		PintarCaracter x,y,car,blanco
		mov y,23
		add punteoDecena,48
		PintarCaracter x,y,punteoDecena,blanco
		sub punteoDecena,48
		mov y,24
		add punteoUnidad,48
		PintarCaracter x,y,punteoUnidad,blanco
		sub punteoUnidad,48
		
		mov y,29
		add horasDos,48
		PintarCaracter x,y,horasDos,blanco
		sub horasDos,48
		mov y,30
		add horasUno,48
		PintarCaracter x,y,horasUno,blanco
		sub horasUno,48
		mov y,31
		mov car, 58
		PintarCaracter x,y,car,blanco
		mov y,32
		add minutosDos,48
		PintarCaracter x,y,minutosDos,blanco
		sub minutosDos,48
		mov y,33
		add minutosUno,48
		PintarCaracter x,y,minutosUno,blanco
		sub minutosUno,48
		mov y,34
		mov car, 58
		PintarCaracter x,y,car,blanco
		mov y,35
		add segundosDos,48
		PintarCaracter x,y,segundosDos,blanco
		sub segundosDos,48
		mov y,36
		add segundosUno,48
		PintarCaracter x,y,segundosUno,blanco
		sub segundosUno,48
          
	ret
			
	LeerMovimientos:
		in al,60h
		cmp al,4Dh
		je movimientoDerecha
		cmp al,4Bh
		je movimientoIzquierda
		cmp al,48h
		je movimientoArriba
		cmp al,50h
		je movimientoAbajo
		jmp salirMovimientos
		
		movimientoDerecha:
			cmp direccionDos, 2
			je movimientoDerechaUno
			cmp direccionDos, 3
			je movimientoDerechaUno
			jmp salirMovimientos
			movimientoDerechaUno:
				mov direccion, 0
				jmp salirMovimientos
				
		movimientoIzquierda:
			cmp direccionDos, 2
			je movimientoIzquierdaUno
			cmp direccionDos, 3
			je movimientoIzquierdaUno
			jmp salirMovimientos
			movimientoIzquierdaUno:
				mov direccion, 1
				jmp salirMovimientos
		
		movimientoArriba:
			cmp direccionDos, 0
			je movimientoArribaUno
			cmp direccionDos, 1
			je movimientoArribaUno
			jmp salirMovimientos
			movimientoArribaUno:
				mov direccion, 2
				jmp salirMovimientos
		
		movimientoAbajo:
			cmp direccionDos, 0
			je movimientoAbajoUno
			cmp direccionDos, 1
			je movimientoAbajoUno
			jmp salirMovimientos
			movimientoAbajoUno:
				mov direccion, 3
				jmp salirMovimientos
		
		salirMovimientos:
		
	ret
	
	VerificarAlimentoComido:
		cmp comida, 0
		je verificarAlimentoComidoUno
		cmp comida, 1
		je verificarAlimentoComidoDos
		cmp comida, 2
		je verificarAlimentoComidoTres
		cmp comida, 3
		je verificarAlimentoComidoCuatro
		cmp comida, 4
		je verificarAlimentoComidoCinco
		cmp comida, 5
		je verificarAlimentoComidoSeis
		cmp comida, 6
		je verificarAlimentoComidoSiete
		cmp comida, 7
		je verificarAlimentoComidoOcho
		cmp comida, 8
		je verificarAlimentoComidoNueve
		cmp comida, 9
		je verificarAlimentoComidoDiez
		
		verificarAlimentoComidoUno:
			cmp sx1, 40
			jne salirVerificarAlimentoComido
			cmp sy1, 40
			jne salirVerificarAlimentoComido
			mov comida, 1
			call AumentarPunteo
			jmp salirVerificarAlimentoComido
		verificarAlimentoComidoDos:
			cmp sx1, 280
			jne salirVerificarAlimentoComido
			cmp sy1, 160
			jne salirVerificarAlimentoComido
			mov comida, 2
			call AumentarPunteo
			jmp salirVerificarAlimentoComido
		verificarAlimentoComidoTres:
			cmp sx1, 40
			jne salirVerificarAlimentoComido
			cmp sy1, 100
			jne salirVerificarAlimentoComido
			mov comida, 3
			call AumentarPunteo
			jmp salirVerificarAlimentoComido
		verificarAlimentoComidoCuatro:
			cmp sx1, 180
			jne salirVerificarAlimentoComido
			cmp sy1, 40
			jne salirVerificarAlimentoComido
			mov comida, 4
			call AumentarPunteo
			jmp salirVerificarAlimentoComido
		verificarAlimentoComidoCinco:
			cmp sx1, 160
			jne salirVerificarAlimentoComido
			cmp sy1, 105
			jne salirVerificarAlimentoComido
			mov comida, 5
			call AumentarPunteo
			jmp salirVerificarAlimentoComido
		verificarAlimentoComidoSeis:
			cmp sx1, 30
			jne salirVerificarAlimentoComido
			cmp sy1, 30
			jne salirVerificarAlimentoComido
			mov comida, 6
			call AumentarPunteo
			jmp salirVerificarAlimentoComido
		verificarAlimentoComidoSiete:
			cmp sx1, 180
			jne salirVerificarAlimentoComido
			cmp sy1, 170
			jne salirVerificarAlimentoComido
			mov comida, 7
			call AumentarPunteo
			jmp salirVerificarAlimentoComido
		verificarAlimentoComidoOcho:
			cmp sx1, 280
			jne salirVerificarAlimentoComido
			cmp sy1, 100
			jne salirVerificarAlimentoComido
			mov comida, 8
			call AumentarPunteo
			jmp salirVerificarAlimentoComido
		verificarAlimentoComidoNueve:
			cmp sx1, 40
			jne salirVerificarAlimentoComido
			cmp sy1, 160
			jne salirVerificarAlimentoComido
			mov comida, 9
			call AumentarPunteo
			jmp salirVerificarAlimentoComido
		verificarAlimentoComidoDiez:
			cmp sx1, 280
			jne salirVerificarAlimentoComido
			cmp sy1, 40
			jne salirVerificarAlimentoComido
			mov comida, 0
			call AumentarPunteo
			add nivel, 1
			cmp nivel, 4
			je terminarJuego
			PintarCirculo sx4, sy4, negro
			PintarCirculo sx5, sy5, negro
			PintarCirculo sx6, sy6, negro
			PintarCirculo sx7, sy7, negro
			PintarCirculo sx8, sy8, negro
			PintarCirculo sx9, sy9, negro
			PintarCirculo sx10, sy10, negro
			PintarCirculo sx11, sy11, negro
			PintarCirculo sx12, sy12, negro
			jmp salirVerificarAlimentoComido
			
			terminarJuego:
			mov salirJuego,1
			mov modoSalir,1
		salirVerificarAlimentoComido:
		
	ret
	
	
	AumentarPunteo:
		add punteoUnidad,1
		cmp punteoUnidad,10
		jne salirAumetarPunteo
		
		add punteoDecena,1
		mov punteoUnidad,0
		salirAumetarPunteo:
		
	ret
	
	VerificarColision:
		cmp nivel, 3
		je colisionUnoNivelTres
		cmp nivel, 2
		je colisionUnoNivelDos
		jmp colisionCuerpo
		
		colisionUnoNivelTres:
			cmp sx1,60
			jne colisionDosNivelTres
			cmp sy1,75
			jb colisionDosNivelTres
			cmp sy1,130
			ja colisionDosNivelTres
			jmp colisionTerminarJuego
			
		colisionDosNivelTres:
			cmp sx1,255
			jne colisionUnoNivelDos
			cmp sy1,75
			jb colisionUnoNivelDos
			cmp sy1,130
			ja colisionUnoNivelDos
			jmp colisionTerminarJuego
		
		colisionUnoNivelDos:
			cmp sy1,55
			jne colisionDosNivelDos
			cmp sx1,60
			jb colisionDosNivelDos
			cmp sx1,255
			ja colisionDosNivelDos
			jmp colisionTerminarJuego
		
		colisionDosNivelDos:
			cmp sy1,155
			jne colisionCuerpo
			cmp sx1,60
			jb colisionCuerpo
			cmp sx1,255
			ja colisionCuerpo
			jmp colisionTerminarJuego
		
		colisionCuerpo:
			
			colisionX:
				cmp comida,2
				je colisionXComidaDos
				cmp comida,3
				je colisionXComidaTres
				cmp comida,4
				je colisionXComidaCuatro
				cmp comida,5
				je colisionXComidaCinco
				cmp comida,6
				je colisionXComidaSeis
				cmp comida,7
				je colisionXComidaSiete
				cmp comida,8
				je colisionXComidaOcho
				cmp comida,9
				je colisionXComidaNueve
				jmp salirColision
				colisionXComidaNueve:
					mov cx,sx12
					cmp sx1,cx
					je colisionY
				colisionXComidaOcho:
					mov cx,sx11
					cmp sx1,cx
					je colisionY
				colisionXComidaSiete:
					mov cx,sx10
					cmp sx1,cx
					je colisionY
				colisionXComidaSeis:
					mov cx,sx9
					cmp sx1,cx
					je colisionY
				colisionXComidaCinco:
					mov cx,sx8
					cmp sx1,cx
					je colisionY
				colisionXComidaCuatro:
					mov cx,sx7
					cmp sx1,cx
					je colisionY
				colisionXComidaTres:
					mov cx,sx6
					cmp sx1,cx
					je colisionY
				colisionXComidaDos:
					mov cx,sx5
					cmp sx1,cx
					je colisionY
					jmp salirColision
				
			colisionY:
				cmp comida,2
				je colisionYComidaDos
				cmp comida,3
				je colisionYComidaTres
				cmp comida,4
				je colisionYComidaCuatro
				cmp comida,5
				je colisionYComidaCinco
				cmp comida,6
				je colisionYComidaSeis
				cmp comida,7
				je colisionYComidaSiete
				cmp comida,8
				je colisionYComidaOcho
				cmp comida,9
				je colisionYComidaNueve
				jmp salirColision
				colisionYComidaNueve:
					mov cx,sy12
					cmp sy1,cx
					je colisionTerminarJuego
				colisionYComidaOcho:
					mov cx,sy11
					cmp sy1,cx
					je colisionTerminarJuego
				colisionYComidaSiete:
					mov cx,sy10
					cmp sy1,cx
					je colisionTerminarJuego
				colisionYComidaSeis:
					mov cx,sy9
					cmp sy1,cx
					je colisionTerminarJuego
				colisionYComidaCinco:
					mov cx,sy8
					cmp sy1,cx
					je colisionTerminarJuego
				colisionYComidaCuatro:
					mov cx,sy7
					cmp sy1,cx
					je colisionTerminarJuego
				colisionYComidaTres:
					mov cx,sy6
					cmp sy1,cx
					je colisionTerminarJuego
				colisionYComidaDos:
					mov cx,sy5
					cmp sy1,cx
					je colisionTerminarJuego
					jmp salirColision
				
		colisionTerminarJuego:
		mov salirJuego,1
		mov modoSalir,2
		salirColision:
		
	ret
			
	VerificarTeclaEscape:
		in al,60h
		cmp al,01h
		jne etiquetaSalir
		mov salirJuego,1
		etiquetaSalir:
		
	ret
	
	Victoria:
		mov cx, 0
		mov dx, 0

		cicloVictoriaPintar:
		PintarPixel cx, dx, negro
		inc cx
		cmp cx, 320
		jne cicloVictoriaPintar

		mov cx, 0
		inc dx
		cmp dx, 200
		jne cicloVictoriaPintar
	
		mov x,11
		mov y,15
		mov car,86
		PintarCaracter x,y,car,blanco
		mov y,16
		mov car,73
		PintarCaracter x,y,car,blanco
		mov y,17
		mov car,67
		PintarCaracter x,y,car,blanco
		mov y,18
		mov car,84
		PintarCaracter x,y,car,blanco
		mov y,19
		mov car,79
		PintarCaracter x,y,car,blanco
		mov y,20
		mov car,82
		PintarCaracter x,y,car,blanco
		mov y,21
		mov car,73
		PintarCaracter x,y,car,blanco
		mov y,22
		mov car,65
		PintarCaracter x,y,car,blanco
		
		mov contadorCicloCuatro,0
		contadorCicloVictoriaDos:
			mov contadorCicloTres,0
			cicloVictoria:
				inc contadorCicloTres
				cmp contadorCicloTres, 0ffffh
				jne cicloVictoria
			inc contadorCicloCuatro
			cmp contadorCicloCuatro, 040h
			jne contadorCicloVictoriaDos
	ret
	
	Derrota:
		mov cx, 0
		mov dx, 0

		cicloDerrotaPintar:
		PintarPixel cx, dx, negro
		inc cx
		cmp cx, 320
		jne cicloDerrotaPintar

		mov cx, 0
		inc dx
		cmp dx, 200
		jne cicloDerrotaPintar
	
		mov x,11
		mov y,16
		mov car,68
		PintarCaracter x,y,car,blanco
		mov y,17
		mov car,69
		PintarCaracter x,y,car,blanco
		mov y,18
		mov car,82
		PintarCaracter x,y,car,blanco
		mov y,19
		mov car,82
		PintarCaracter x,y,car,blanco
		mov y,20
		mov car,79
		PintarCaracter x,y,car,blanco
		mov y,21
		mov car,84
		PintarCaracter x,y,car,blanco
		mov y,22
		mov car,65
		PintarCaracter x,y,car,blanco
		
		mov contadorCicloCuatro,0
		contadorCicloDerrotaDos:
			mov contadorCicloTres,0
			cicloDerrota:
				inc contadorCicloTres
				cmp contadorCicloTres, 0ffffh
				jne cicloDerrota
			inc contadorCicloCuatro
			cmp contadorCicloCuatro, 040h
			jne contadorCicloDerrotaDos
	ret
	
	Salir:
		mov ah,10h
		mov ax,0003h
		int 10h
		mov ax,4c00h
		int 21h
	ret
	
main endp
end