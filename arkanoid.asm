LimpiarPantalla macro 																					;Macro para limpiar panytalla
	mov ah,0
	mov al,3h
	int 10h
endm

ImprimirCadena macro cadena	
	mov dx, offset cadena
	mov ah, 09
	int 21h
endm

finalizar macro
	MOV AH, 00H ; Set video mode
    MOV AL, 03H ; Mode 03h
    INT 10H ; Enter 80x25x16 mode
	mov ax, 4c00h
	int 21h
endm

CapturaTeclado macro
	mov ah, 01h
	int 21h
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

PintarPixel macro coordenadaX, coordenadaY, color
	mov cx, coordenadaX
	mov dx, coordenadaY
	mov ah, 0ch
	mov al, color
	int 10h
endm

.model small
.stack 
.data

CT dw 0
CTDestino dw 5
Velocidad dw 25000



pausajugo db 0

tamBarra dw 40

BarraY dw 180
BarraX dw 160

pos_x_pelota dw 160
pos_y_pelota dw 100
pelota1_activa dw 1

pos_x_pelota2 dw 160
pos_y_pelota2 dw 100
pelota2_activa dw 0

pos_x_pelota3 dw 160
pos_y_pelota3 dw 100
pelota3_activa dw 0

centro_x dw 100
centro_y dw 75

tam_x_pelota dw 1
tam_y_pelota dw 1

tam_x_pelota2 dw 1
tam_y_pelota2 dw 1

tam_x_pelota3 dw 1
tam_y_pelota3 dw 1

limitesuperior dw 12
limiteinferior dw 186

limiteizquierdo dw 14
limitederecho dw 306

screen_width    dw  320

Bloque1_activo db 1

Bloque2_activo db 1

Bloque3_activo db 1

Bloque4_activo db 1

Bloque5_activo db 1

Bloque6_activo db 1

Bloque7_activo db 1

Bloque8_activo db 1

Bloque9_activo db 1

Bloque10_activo db 1

Bloque11_activo db 0

Bloque12_activo db 0

Bloque13_activo db 0

Bloque14_activo db 0

Bloque15_activo db 0

Bloque16_activo db 0

Bloque17_activo db 0

Bloque18_activo db 0

Bloque19_activo db 0

Bloque20_activo db 0


contadorCicloUno dw 0
contadorCicloDos dw 0
contadorCicloTres dw 0
contadorCicloCuatro dw 0

contadorTiempo db 0
segundosUno db 0
segundosDos db 0
minutosUno db 0
minutosDos db 0
horasUno db 0
horasDos db 0

LargoBloque dw 52

BloquesDestruidos db 0
Nivel db 1


Encabezado1  	db 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA','$'						;39
Encabezado2  	db 10,13,'FACULTAD DE INGENIERIA','$'								;25
Encabezado3  	db 10,13,'ESCUELA DE CIENCIAS Y SISTEMAS','$'						;33
Encabezado4  	db 10,13,'ARQUITECTURA DE COMPUTADORAS Y ENSAMBLADORES 1 "A"','$'	;53
Encabezado5	 	db 10,13,'SEGUNDO SEMESTRE 2017','$'								;24
Encabezado6	 	db 10,13,'PROYECTO 2','$'											;13
Encabezado7	 	db 10,13,'Carlos Enrique Cante Lopez','$'							;29
Encabezado8	 	db 10,13,'2013-14448','$'											;13
saltolinea 		db 10,13,'$'

menu1 			db 10,13,'*****************************************************','$'
menu2 			db 10,13,'****************** MENU PRINCIPAL *******************','$'
menu3 			db 10,13,'*****************************************************','$'
menu4 			db 10,13,'**********  1. Ingresar                    **********','$'
menu5 			db 10,13,'**********  2. Registrar                   **********','$'
menu6 			db 10,13,'**********  3. Salir                       **********','$'
menu7			db 10,13,'*****************************************************','$'

msjHora	db 'Hora: ','$'
msjFecha db 'Fecha: ','$'
HoraActual db '00:00:00','$'
FechaActual db '00/00/0000','$'

x db 0
y db 0

blanco db 15
negro db 0


punteoUnidad db 0
punteoDecena db 0
car db 0
n1 db 32
n2 db 32
n3 db 32
n4 db 32
n5 db 32
n6 db 32
n7 db 32

salirJuego db 0

UsuarioActual db 7 dup('$')
ContrasenaActuaal db 4 dup('$')

Usuario1 db 7 dup('$')
Contrasena1 db 4 dup('$')

Usuario2 db 7 dup('$')
Contrasena2 db 4 dup('$')

Usuario3 db 7 dup('$')
Contrasena3 db 4 dup('$')

Usuario4 db 7 dup('$')
Contrasena4 db 4 dup('$')



Admin db 'admin','$'
Pass db '1234','$'

msjUsuarioInexistente db 10,13,'El usuario no esta registrado','$'
msjContrasenaIncorrecta db 10,13,'La contrasena es incorrecta','$'

msjUsuario db 10,13,'Ingrese su nombre de usuario: ','$'
msjContrasena db 10,13,'Ingrese su contrasena: ','$'

msjIngresarUsuario db 10,13,'Ingrese un nombre de usuario (Maximo 7 caracteres): ','$'
msjIngresarContrasena db 10,13,'Ingrese una contrasena (Maximo 4 numeros): ','$'

PedirOpcion 		db 10,13,'Ingrese una opcion---------> ','$'

.code
.startup
main proc

LimpiarPantalla

MenuInicial:
		LimpiarPantalla
		call ImprimirMenuInicial

		return:
				ImprimirCadena PedirOpcion
				CapturaTeclado

				cmp al,49 
				je Ingresar

				cmp al,50 
				je Registrar

				cmp al,51
				je Salir

				cmp al, 52
				je Prueba
				
				jmp MenuInicial

Prueba:
		mov ah, 1h
    	xor al,al
    	int 16h
    	cmp al, 37
    	je Salir
    	jmp Prueba

Ingresar:
		ImprimirCadena msjUsuario
		CapturaTeclado
		xor si, si

		cmp UsuarioActual[si],al
		jne UsuarioInexistente

		CapturaTeclado
		cmp al, 13
		je finusuario
		inc si
		cmp UsuarioActual[si],al
		jne UsuarioInexistente

		CapturaTeclado
		cmp al, 13
		je finusuario
		inc si
		cmp UsuarioActual[si],al
		jne UsuarioInexistente

		CapturaTeclado
		cmp al, 13
		je finusuario
		inc si
		cmp UsuarioActual[si],al
		jne UsuarioInexistente

		CapturaTeclado
		cmp al, 13
		je finusuario
		inc si
		cmp UsuarioActual[si],al
		jne UsuarioInexistente

		CapturaTeclado
		cmp al, 13
		je finusuario
		inc si
		cmp UsuarioActual[si],al
		jne UsuarioInexistente

		CapturaTeclado
		cmp al, 13
		je finusuario
		inc si
		cmp UsuarioActual[si],al
		jne UsuarioInexistente

		finusuario:
			inc si
			cmp UsuarioActual[si],0
			jne UsuarioInexistente

		IngresoContra:
			xor si, si
			ImprimirCadena msjContrasena

			CapturaTeclado
			cmp ContrasenaActuaal, al
			jne ContrasenaIncorrecta

			CapturaTeclado
			cmp al, 13
			je fincontrasena
			inc si
			cmp ContrasenaActuaal[si],al
			jne ContrasenaIncorrecta

			CapturaTeclado
			cmp al, 13
			je fincontrasena
			inc si
			cmp ContrasenaActuaal[si],al
			jne ContrasenaIncorrecta

			CapturaTeclado
			cmp al, 13
			je fincontrasena
			inc si
			cmp ContrasenaActuaal[si],al
			jne ContrasenaIncorrecta

		fincontrasena:
			inc si
			cmp ContrasenaActuaal[si],0
			jne ContrasenaIncorrecta

		jmp Juego


		UsuarioInexistente:
			ImprimirCadena msjUsuarioInexistente
			CapturaTeclado
			jmp MenuInicial

		ContrasenaIncorrecta:
			ImprimirCadena msjContrasenaIncorrecta
			CapturaTeclado
			jmp MenuInicial

Registrar:
	
		ImprimirCadena msjIngresarUsuario

		xor si, si
		limpiar1:
				mov UsuarioActual[ si ],0
				inc si
				cmp si, 8
				jne limpiar1

		xor si, si

		CapturaTeclado
		mov UsuarioActual[si], al
		mov n1, al

		CapturaTeclado 
		cmp al, 13
		je finingreso
		inc si
		mov UsuarioActual[si], al
		mov n2, al

		CapturaTeclado 
		cmp al, 13
		je finingreso
		inc si
		mov UsuarioActual[si], al
		mov n3, al

		CapturaTeclado 
		cmp al, 13
		je finingreso
		inc si
		mov UsuarioActual[si], al
		mov n4, al

		CapturaTeclado 
		cmp al, 13
		je finingreso
		inc si
		mov UsuarioActual[si], al
		mov n5, al

		CapturaTeclado 
		cmp al, 13
		je finingreso
		inc si
		mov UsuarioActual[si], al
		mov n6, al

		CapturaTeclado 
		cmp al, 13
		je finingreso
		inc si
		mov UsuarioActual[si], al
		mov n7, al

		finingreso:

		ImprimirCadena msjIngresarContrasena
		xor si, si

		limpiar2:
				mov ContrasenaActuaal[si], 0
				inc si
				cmp si, 5
				jne limpiar2

		xor si, si

		CapturaTeclado
		mov ContrasenaActuaal, al

		CapturaTeclado 
		cmp al, 13
		je fincontra
		inc si
		mov ContrasenaActuaal[si], al

		CapturaTeclado 
		cmp al, 13
		je fincontra
		inc si
		mov ContrasenaActuaal[si], al

		CapturaTeclado 
		cmp al, 13
		je fincontra
		inc si
		mov ContrasenaActuaal[si], al

		fincontra:
			xor si, si
			jmp MenuInicial

Juego:
	call IniciarVideo
	call PintarExterior
	call PintarInterior


    game_loop:
    	cmp pelota1_activa, 0
    	je Nopelota1
    	call MovimientoPelota1
    	call PintarPelota

    	Nopelota1:
    	cmp pelota2_activa, 0
    	je Nopelota2
    	call MovimientoPelota2
    	call PintarPelota2

    	Nopelota2:
    	cmp pelota3_activa, 0
    	je Nopelota3
    	call MovimientoPelota3
    	call PintarPelota3

    	Nopelota3:

    	call MoverBarra
    	call PintarBarra
    	call ActualizarBloques
    	call VerificarTeclaEscape
    	call VerifiarFinJuego
    	call VerificarNivel
    	call ActualizarTiempo
    	call PintarEstadisticas


    	mov cx,0000h ; tiempo del delay
    	mov dx, Velocidad ; tiempo del delay
    	call Delay
    	call VerificarPelotas
    
    	jmp game_loop

VerificarTeclaEscape:
		push ax

		in al,60h
		cmp al,3bh
		jne etiquetaSalir

		C1:
			in al,60h
			cmp al,39h
			je VoveraMenu
			cmp al,01h
			jne C1


		etiquetaSalir:
		
		pop ax
		ret

VerificarNivel:
		PUSH AX 
    	PUSH BX 
    	PUSH CX 
    	PUSH DX

		cmp [Nivel],1
		je Nivel1
		cmp [Nivel],2
		je Nivel2
		cmp [Nivel],3
		je Nivel3

		Nivel1:
			cmp [BloquesDestruidos],10
			jne finn
			mov [BloquesDestruidos],0
			mov Velocidad,15000
			mov CTDestino, 6
			inc Nivel
			Call ActivarNiverl2
			jmp finn 

		Nivel2:
			cmp [BloquesDestruidos],15
			jne finn
			mov [BloquesDestruidos],0
			mov Velocidad,7000
			mov CTDestino, 7
			inc Nivel
			Call ActivarNiverl3
			jmp finn


		Nivel3:
			cmp [BloquesDestruidos],20
			jne finn
			mov [BloquesDestruidos],0
			mov Velocidad,25000
			mov Nivel,1
			Call ActivarNiverl1
			call JuegoGanado
			jmp FinRegresar
			jmp finn

			;59307408

		FinRegresar:
		pop dx
		pop cx
		pop bx
		pop ax
		jmp VoveraMenu


		finn:
		pop dx
		pop cx
		pop bx
		pop ax
		ret

ActivarNiverl2:
		mov Bloque1_activo,1
		mov Bloque2_activo,1
		mov Bloque3_activo,1
		mov Bloque4_activo,1
		mov Bloque5_activo,1
		mov Bloque6_activo,1
		mov Bloque7_activo,1
		mov Bloque8_activo,1
		mov Bloque9_activo,1
		mov Bloque10_activo,1
		mov Bloque11_activo,1
		mov Bloque12_activo,1
		mov Bloque13_activo,1
		mov Bloque14_activo,1
		mov Bloque15_activo,1
		ret

ActivarNiverl3:
		mov pelota2_activa,0
		mov pelota1_activa,1
		mov pos_y_pelota,100
		mov pos_x_pelota,160
		mov pos_y_pelota2,100
		mov pos_x_pelota2,160
		mov [Bloque1_activo],1
		mov [Bloque2_activo],1
		mov [Bloque3_activo],1
		mov [Bloque4_activo],1
		mov [Bloque5_activo],1
		mov [Bloque6_activo],1
		mov [Bloque7_activo],1
		mov [Bloque8_activo],1
		mov [Bloque9_activo],1
		mov [Bloque10_activo],1
		mov [Bloque11_activo],1
		mov [Bloque12_activo],1
		mov [Bloque13_activo],1
		mov [Bloque14_activo],1
		mov [Bloque15_activo],1
		mov [Bloque16_activo],1
		mov [Bloque17_activo],1
		mov [Bloque18_activo],1
		mov [Bloque19_activo],1
		mov [Bloque20_activo],1
		ret

ActivarNiverl1:
		mov [Bloque1_activo],1
		mov [Bloque2_activo],1
		mov [Bloque3_activo],1
		mov [Bloque4_activo],1
		mov [Bloque5_activo],1
		mov [Bloque6_activo],1
		mov [Bloque7_activo],1
		mov [Bloque8_activo],1
		mov [Bloque9_activo],1
		mov [Bloque10_activo],1
		ret		

PintarBarra:
	push bx
	push cx
	push dx

	mov ax, BarraY
	mov bx, BarraX
	mov cx, tamBarra
	mov dl, 15

    LoopBarra:
        call put_pixel
        inc bx
        loop LoopBarra

    	xor dl, dl ; dl = 0
    	call    put_pixel
    	MOV CX, [tamBarra]
    	ADD CX, 1
    	SUB BX, CX
    	call    put_pixel

   	pop dx
   	pop cx
   	pop bx

    ret

PintarPelota:
	push ax
	push bx
	push dx

	mov ax, pos_y_pelota
    mov bx, pos_x_pelota
    mov dl, 55
    call draw_ball

    pop dx
    pop bx
    pop ax

	ret

PintarPelota2:
	push ax
	push bx
	push dx

	mov ax, pos_y_pelota2
    mov bx, pos_x_pelota2
    mov dl, 55
    call draw_ball

    pop dx
    pop bx
    pop ax

	ret

PintarPelota3:
	push ax
	push bx
	push dx

	mov ax, pos_y_pelota3
    mov bx, pos_x_pelota3
    mov dl, 55
    call draw_ball

    pop dx
    pop bx
    pop ax

	ret

MoverBarra:
		push ax 
		push bx 
		push cx 
		push dx

		in al,60h
		cmp al,4Dh
		je movimientoDerecha
		cmp al,4Bh
		je movimientoIzquierda
		jmp salirMovimientos

		movimientoDerecha:
			inc BarraX
			mov bx, BarraX
			add bx, tamBarra
			cmp bx, limitederecho
			je tododer
			jmp salirMovimientos
		tododer:
			dec BarraX
			jmp salirMovimientos

		movimientoIzquierda:
			dec BarraX
			mov bx, BarraX
			cmp bx, limiteizquierdo
			je todoizq
			jmp salirMovimientos

		todoizq:
			inc BarraX
			jmp salirMovimientos

		salirMovimientos:
        pop dx 
        pop cx 
        pop bx 
        pop ax
		ret

VerificarPelotas:
	cmp Nivel,1
	je ni1
	cmp Nivel,2
	je ni2 
	cmp Nivel,3
	je ni3
	jmp finVP

	ni1:
		jmp finVP

	ni2:
		cmp BloquesDestruidos, 7
		jne finVP
		mov pelota2_activa, 1
		jmp finVP

	ni3:
		cmp BloquesDestruidos, 7
		jne ni3s
		mov pelota2_activa, 1
		ni3s:
		cmp BloquesDestruidos, 14
		jne finVP
		mov pelota3_activa, 1
		jmp finVP


	finVP:
	ret

MovimientoPelota1:
	PUSH AX 
    PUSH BX 
    PUSH CX 
    PUSH DX


    ;******************Borramos la pelota anterior***********
    
    mov ax, pos_y_pelota
    mov bx, pos_x_pelota
    call BorrarPelota
    ;******************Verificamos si toa en izq o derecha********
    add bx, tam_x_pelota
    call ColicionPelotaLados
    ;******************Verificamos si toca arriba o con la barra*********
    add ax, tam_y_pelota
    call ColicionArriba
    call ColicionBarranuevo


    mov cx, tam_y_pelota
    call ColicionBloqueAbajoN1
    mov tam_y_pelota, cx

    mov pos_y_pelota, ax
    mov pos_x_pelota, bx
    


    POP DX
    POP CX
    POP BX
    POP AX
    ret

MovimientoPelota2:
	PUSH AX 
    PUSH BX 
    PUSH CX 
    PUSH DX


    ;******************Borramos la pelota anterior***********
    
    mov ax, pos_y_pelota2
    mov bx, pos_x_pelota2
    call BorrarPelota
    ;******************Verificamos si toa en izq o derecha********
    add bx, tam_x_pelota2
    call ColicionPelotaLados2
    ;******************Verificamos si toca arriba o con la barra*********
    add ax, tam_y_pelota2
    call ColicionArriba2
    call ColicionBarranuevo2


    mov cx, tam_y_pelota2
    call ColicionBloqueAbajoN1
    mov tam_y_pelota2, cx

    mov pos_y_pelota2, ax
    mov pos_x_pelota2, bx
    


    POP DX
    POP CX
    POP BX
    POP AX
    ret

MovimientoPelota3:
	PUSH AX 
    PUSH BX 
    PUSH CX 
    PUSH DX


    ;******************Borramos la pelota anterior***********
    
    mov ax, pos_y_pelota3
    mov bx, pos_x_pelota3
    call BorrarPelota
    ;******************Verificamos si toa en izq o derecha********
    add bx, tam_x_pelota3
    call ColicionPelotaLados3
    ;******************Verificamos si toca arriba o con la barra*********
    add ax, tam_y_pelota3
    call ColicionArriba3
    call ColicionBarranuevo3


    mov cx, tam_y_pelota3
    call ColicionBloqueAbajoN1
    mov tam_y_pelota3, cx

    mov pos_y_pelota3, ax
    mov pos_x_pelota3, bx
    


    POP DX
    POP CX
    POP BX
    POP AX
    ret

ColicionBloqueAbajoN1:
	;ax = pos_y_pelota
	;bx = pos_x_pelota
	;cx = tam_y_pelota
	PUSH AX 
    PUSH BX 
    PUSH DX

	cmp ax, 24
	je fila1
	cmp ax, 36
	je fila2
	cmp ax, 48
	je fila3
	cmp ax, 60
	je fila4
	jmp finbloques

	fila1:
		B1:
			cmp Bloque1_activo, 1
			jne B2
			cmp bx, 18
			jna finbloques
			cmp bx, 70
			jnb B2
			mov Bloque1_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 24
			mov bx, 18
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B2:
			cmp Bloque2_activo, 1
			jne B3
			cmp bx, 76
			jna finbloques
			cmp bx, 128
			jnb B3
			mov Bloque2_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 24
			mov bx, 76
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B3:
			cmp Bloque3_activo, 1
			jne B4
			cmp bx, 134
			jna finbloques
			cmp bx, 186
			jnb B4
			mov Bloque3_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 24
			mov bx, 134
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B4:
			cmp Bloque4_activo, 1
			jne B5
			cmp bx, 192
			jna finbloques
			cmp bx, 244
			jnb B5
			mov Bloque4_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 24
			mov bx, 192
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B5:
			cmp Bloque5_activo, 1
			jne finbloques
			cmp bx, 250
			jna finbloques
			cmp bx, 302
			jnb finbloques
			mov Bloque5_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 24
			mov bx, 250
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques

	fila2:
		B6:
			cmp Bloque6_activo, 1
			jne B7
			cmp bx, 18
			jna finbloques
			cmp bx, 70
			jnb B7
			mov Bloque6_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 36
			mov bx, 18
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B7:
			cmp Bloque7_activo, 1
			jne B8
			cmp bx, 76
			jna finbloques
			cmp bx, 128
			jnb B8
			mov Bloque7_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 36
			mov bx, 76
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B8:
			cmp Bloque8_activo, 1
			jne B9
			cmp bx, 134
			jna finbloques
			cmp bx, 186
			jnb B9
			mov Bloque8_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 36
			mov bx, 134
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B9:
			cmp Bloque9_activo, 1
			jne B10
			cmp bx, 192
			jna finbloques
			cmp bx, 244
			jnb B10
			mov Bloque9_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 36
			mov bx, 192
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B10:
			cmp Bloque10_activo, 1
			jne finbloques
			cmp bx, 250
			jna finbloques
			cmp bx, 302
			jnb finbloques
			mov Bloque10_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 36
			mov bx, 250
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques

	fila3:
		B11:
			cmp Bloque11_activo, 1
			jne B12
			cmp bx, 18
			jna finbloques
			cmp bx, 70
			jnb B12
			mov Bloque11_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 48
			mov bx, 18
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B12:
			cmp Bloque12_activo, 1
			jne B13
			cmp bx, 76
			jna finbloques
			cmp bx, 128
			jnb B13
			mov Bloque12_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 48
			mov bx, 76
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B13:
			cmp Bloque13_activo, 1
			jne B14
			cmp bx, 134
			jna finbloques
			cmp bx, 186
			jnb B14
			mov Bloque13_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 48
			mov bx, 134
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B14:
			cmp Bloque14_activo, 1
			jne B15
			cmp bx, 192
			jna finbloques
			cmp bx, 244
			jnb B15
			mov Bloque14_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 48
			mov bx, 192
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B15:
			cmp Bloque15_activo, 1
			jne finbloques
			cmp bx, 250
			jna finbloques
			cmp bx, 302
			jnb finbloques
			mov Bloque15_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 48
			mov bx, 250
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques

	fila4:
		B16:
			cmp Bloque16_activo, 1
			jne B17
			cmp bx, 18
			jna finbloques
			cmp bx, 70
			jnb B17
			mov Bloque16_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 60
			mov bx, 18
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B17:
			cmp Bloque17_activo, 1
			jne B18
			cmp bx, 76
			jna finbloques
			cmp bx, 128
			jnb B18
			mov Bloque17_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 60
			mov bx, 76
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B18:
			cmp Bloque18_activo, 1
			jne B19
			cmp bx, 134
			jna finbloques
			cmp bx, 186
			jnb B19
			mov Bloque18_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 60
			mov bx, 134
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B19:
			cmp Bloque19_activo, 1
			jne B20
			cmp bx, 192
			jna finbloques
			cmp bx, 244
			jnb B20
			mov Bloque19_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 60
			mov bx, 192
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques
		B20:
			cmp Bloque20_activo, 1
			jne finbloques
			cmp bx, 250
			jna finbloques
			cmp bx, 302
			jnb finbloques
			mov Bloque20_activo, 0
			neg cx
			inc BloquesDestruidos
			call AumentarPunteo

			push ax
			push bx
			push cx

			mov ax, 60
			mov bx, 250
			call BorraBloque

			pop cx
			pop bx
			pop ax

			jmp finbloques


	finbloques:
		POP DX
    	POP BX
    	POP AX

		ret

BorraBloque:
		;mov ax, [Bloque1_abajo]
    	;mov bx, [Bloque1_izq]
    	xor si, si
    	xor dl, dl

    	ciclo2:
    		call put_pixel
    		inc bx
    		inc si
    		cmp si, LargoBloque
    		jne ciclo2

		ret

ColicionBarranuevo:
	push cx
	cmp ax, 180
	ja FinJuego
	jne fincolicionbarra
	cmp bx, BarraX
	jna FinJuego
	mov cx, BarraX
	add cx, tamBarra
	cmp bx, cx
	jnb FinJuego
	neg tam_y_pelota
	jmp fincolicionbarra


	FinJuego:
	mov pelota1_activa, 0

	fincolicionbarra:
		pop cx
		ret

ColicionBarranuevo2:
	push cx
	cmp ax, 180
	ja FinJuego2
	jne fincolicionbarra2
	cmp bx, BarraX
	jna FinJuego2
	mov cx, BarraX
	add cx, tamBarra
	cmp bx, cx
	jnb FinJuego2
	neg tam_y_pelota2
	jmp fincolicionbarra2


	FinJuego2:
	mov pelota2_activa, 0

	fincolicionbarra2:
		pop cx
		ret

ColicionBarranuevo3:
	push cx
	cmp ax, 180
	ja FinJuego3
	jne fincolicionbarra3
	cmp bx, BarraX
	jna FinJuego3
	mov cx, BarraX
	add cx, tamBarra
	cmp bx, cx
	jnb FinJuego3
	neg tam_y_pelota3
	jmp fincolicionbarra3


	FinJuego3:
	mov pelota3_activa, 0

	fincolicionbarra3:
		pop cx
		ret

ColicionPelotaLados:
	cmp bx, limitederecho
	jne NoDerecha
	neg tam_x_pelota
	jmp fincolicionLados

	NoDerecha:
		cmp bx, limiteizquierdo
		jne fincolicionLados
		neg tam_x_pelota

	fincolicionLados:
		ret

ColicionPelotaLados2:
	cmp bx, limitederecho
	jne NoDerecha2
	neg tam_x_pelota2
	jmp fincolicionLados2

	NoDerecha2:
		cmp bx, limiteizquierdo
		jne fincolicionLados2
		neg tam_x_pelota2

	fincolicionLados2:
		ret

ColicionPelotaLados3:
	cmp bx, limitederecho
	jne NoDerecha3
	neg tam_x_pelota3
	jmp fincolicionLados3

	NoDerecha3:
		cmp bx, limiteizquierdo
		jne fincolicionLados3
		neg tam_x_pelota3

	fincolicionLados3:
		ret

ColicionArriba:
	cmp ax, limitesuperior
	jne fincolicionArriba
	neg tam_y_pelota
	fincolicionArriba:
		ret

ColicionArriba2:
	cmp ax, limitesuperior
	jne fincolicionArriba2
	neg tam_y_pelota2
	fincolicionArriba2:
		ret

ColicionArriba3:
	cmp ax, limitesuperior
	jne fincolicionArriba3
	neg tam_y_pelota3
	fincolicionArriba3:
		ret

BorrarPelota:
	push ax 
    push bx
    xor dl, dl
    call put_pixel
    inc ax
    call put_pixel
    dec ax
    inc bx
    call put_pixel
    inc ax
    call put_pixel
    pop bx 
    pop ax
	ret

ActualizarBloques:
	push ax
	push bx
	push dx

	cmp [Bloque1_activo],1
	jne PB2

	mov ax, 24
    mov bx, 18
    mov dl, 60
    call	PintarBloquesN1

    PB2:
    cmp [Bloque2_activo],1
    jne PB3

    mov ax, 24
    mov bx, 76
    mov dl, 60
    call	PintarBloquesN1

    PB3:
    cmp [Bloque3_activo],1
    jne PB4

    mov ax, 24
    mov bx, 134
    mov dl, 60
    call	PintarBloquesN1

    PB4:
    cmp [Bloque4_activo],1
    jne PB5

    mov ax, 24
    mov bx, 192
    mov dl, 60
    call	PintarBloquesN1

    PB5:
    cmp [Bloque5_activo],1
    jne PB6

    mov ax, 24
    mov bx, 250
    mov dl, 60
    call	PintarBloquesN1

    PB6:
    cmp [Bloque6_activo],1
    jne PB7

    mov ax, 36
    mov bx, 18
    mov dl, 120
    call	PintarBloquesN1

    PB7:
    cmp [Bloque7_activo],1
    jne PB8

    mov ax, 36
    mov bx, 76
    mov dl, 120
    call	PintarBloquesN1

    PB8:
    cmp [Bloque8_activo],1
    jne PB9

    mov ax, 36
    mov bx, 134
    mov dl, 120
    call	PintarBloquesN1

    PB9:
    cmp [Bloque9_activo],1
    jne PB10

    mov ax, 36
    mov bx, 192
    mov dl, 120
    call	PintarBloquesN1

    PB10:
    cmp [Bloque10_activo],1
    jne PB11

    mov ax, 36
    mov bx, 250
    mov dl, 120
    call	PintarBloquesN1


    PB11:
    cmp [Bloque11_activo],1
    jne PB12

    mov ax, 48
    mov bx, 18
    mov dl, 60
    call	PintarBloquesN1

    PB12:
    cmp [Bloque12_activo],1
    jne PB13

    mov ax, 48
    mov bx, 76
    mov dl, 60
    call	PintarBloquesN1

    PB13:
    cmp [Bloque13_activo],1
    jne PB14

    mov ax, 48
    mov bx, 134
    mov dl, 60
    call	PintarBloquesN1

    PB14:
    cmp [Bloque14_activo],1
    jne PB15

    mov ax, 48
    mov bx, 192
    mov dl, 60
    call	PintarBloquesN1

    PB15:
    cmp [Bloque15_activo],1
    jne PB16

    mov ax, 48
    mov bx, 250
    mov dl, 120
    call	PintarBloquesN1

    PB16:
    cmp [Bloque16_activo],1
    jne PB17

    mov ax, 60
    mov bx, 18
    mov dl, 120
    call	PintarBloquesN1

    PB17:
    cmp [Bloque17_activo],1
    jne PB18

    mov ax, 60
    mov bx, 76
    mov dl, 120
    call	PintarBloquesN1

    PB18:
    cmp [Bloque18_activo],1
    jne PB19

    mov ax, 60
    mov bx, 134
    mov dl, 120
    call	PintarBloquesN1

    PB19:
    cmp [Bloque19_activo],1
    jne PB20

    mov ax, 60
    mov bx, 192
    mov dl, 120
    call	PintarBloquesN1

    PB20:

    cmp [Bloque20_activo],1
    jne FinaPintarB
	
	mov ax, 60
    mov bx, 250
    mov dl, 120
    call	PintarBloquesN1

    FinaPintarB:

    pop dx
    pop bx
    pop ax

    ret

PintarBloquesN1:
	push cx

	MOV CX, [LargoBloque]
   loop_pinarBloque:
        call    put_pixel
        inc bx
        loop    loop_pinarBloque

    	xor dl, dl ; dl = 0
    	call    put_pixel
    	MOV CX, [LargoBloque]
    	ADD CX, 1
    	SUB BX, CX
    	call    put_pixel

    	pop cx
    ret

AumentarPunteo:

		inc punteoUnidad
		cmp punteoUnidad,10
		jne salirAumetarPunteo
		
		inc punteoDecena
		mov punteoUnidad,0
		salirAumetarPunteo:


		
		ret

PintarEstadisticas:
		push ax
		push bx
		push cx
		push dx

		mov x,0
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
		PintarCaracter x,y,Nivel,blanco
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


        pop dx
        pop cx
        pop bx
        pop ax

		ret

ActualizarTiempo:
		push ax
		xor ax, ax
		mov ax, CT
		cmp ax, CTDestino
		jb salirActualizarTiempo
		
		mov ax, 00h

		cmp Nivel,1
		je actualizarTiempoNivelUno
		cmp Nivel,2
		je actualizarTiempoNivelDos
		cmp Nivel,3
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


		inc ax
		mov CT, ax
		pop ax

		
		ret

JuegoGanado:
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

VerifiarFinJuego:
	cmp pelota1_activa,1
	je finVFJ

	VERP2P3:
	cmp pelota2_activa,1
	je finVFJ

	VERP3:
	cmp pelota3_activa,1
	je finVFJ

	call JuegoPerdido
	jmp finreg


	finreg:
		jmp VoveraMenu

	finVFJ:
	ret

JuegoPerdido:
	mov cx, 0
		mov dx, 0

		cicloVictoriaPintarD:
		PintarPixel cx, dx, negro
		inc cx
		cmp cx, 320
		jne cicloVictoriaPintarD

		mov cx, 0
		inc dx
		cmp dx, 200
		jne cicloVictoriaPintarD
	
		mov x,11
		mov y,15
		mov car,68
		PintarCaracter x,y,car,blanco
		mov y,16
		mov car,69
		PintarCaracter x,y,car,blanco
		mov y,17
		mov car,82
		PintarCaracter x,y,car,blanco
		mov y,18
		mov car,82
		PintarCaracter x,y,car,blanco
		mov y,19
		mov car,79
		PintarCaracter x,y,car,blanco
		mov y,20
		mov car,84
		PintarCaracter x,y,car,blanco
		mov y,21
		mov car,65
		PintarCaracter x,y,car,blanco
		
		mov contadorCicloCuatro,0
		contadorCicloVictoriaDosD:
			mov contadorCicloTres,0
			cicloVictoriaD:
				inc contadorCicloTres
				cmp contadorCicloTres, 0ffffh
				jne cicloVictoriaD
			inc contadorCicloCuatro
			cmp contadorCicloCuatro, 040h
			jne contadorCicloVictoriaDosD
		ret

Delay:

    mov ah , 86h
     int 15h
     ret    

draw_ball:
	push ax 
    push bx
    call put_pixel
    inc ax
    call put_pixel
    dec ax
    inc bx
    call put_pixel
    inc ax
    call put_pixel
    
    pop bx 
    pop ax
	ret

put_pixel:
    PUSH AX 
    PUSH BX 
    PUSH DX
    MUL [screen_width]
    ADD BX, AX
    POP DX
    MOV ES:[BX], DL
    POP BX 
    POP AX
	RET

IniciarVideo:
    push ax 
    push bx 
    push cx 
    push dx

    mov ax, 0A000h
    mov es, ax
    mov ah, 00h
    mov al, 13h
    int 10h
    
    xor al, al
    mov dx, 3c8h
    out dx, al

    inc dx
    mov al, 11
    out dx, al
    out dx, al
    out dx, al
    
    

    pop dx 
    pop cx 
    pop bx 
    pop ax
	ret

PintarExterior:
		mov cx, 10
		mov dx, 10

		cicloExterior:
		PintarPixel cx, dx, 15
		inc cx
		cmp cx, 310
		jne cicloExterior

		mov cx, 10
		inc dx
		cmp dx, 190
		jne cicloExterior
		ret
	
PintarInterior:
		mov cx, 12
		mov dx, 12

		cicloInterior:
		PintarPixel cx, dx, 0
		inc cx
		cmp cx, 308
		jne cicloInterior

		mov cx, 12
		inc dx
		cmp dx, 188
		jne cicloInterior
		ret

ImprimirMenuInicial:

				ImprimirCadena Encabezado1
				ImprimirCadena Encabezado2
				ImprimirCadena Encabezado3
				ImprimirCadena Encabezado4
				ImprimirCadena Encabezado5
				ImprimirCadena Encabezado6
				ImprimirCadena Encabezado7
				ImprimirCadena Encabezado8
				ImprimirCadena saltolinea
				ImprimirCadena menu1
				ImprimirCadena menu2
				ImprimirCadena menu3
				ImprimirCadena menu4
				ImprimirCadena menu5
				ImprimirCadena menu6
				ImprimirCadena menu7
				ImprimirCadena saltolinea
				ret 

VoveraMenu:
	MOV AH, 00H ; Set video mode
    MOV AL, 03H ; Mode 03h
    INT 10H ; Enter 80x25x16 mode
    jmp MenuInicial

Salir:
				finalizar

main endp
end