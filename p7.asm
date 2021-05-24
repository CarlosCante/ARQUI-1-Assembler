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
	mov ax, 4c00h
	int 21h
endm

CapturaTeclado macro
	mov ah, 01h
	int 21h
endm

EscribirArchivo macro cadena, man
	LOCAL tamanocadena
	LOCAL escr
	LOCAL nuevo

	xor si, si
	inc si
	tamanocadena:
			cmp cadena[ si ],36
			je escr
			cmp cadena[ si ],0
			je escr
			inc si
			jmp tamanocadena


	escr:
			mov    cx,1
	nuevo:   
			push   cx
         	mov    ah,40h
        	mov    bx,man
        	mov    cx,si
         	lea    dx,cadena
         	int    21h
         	pop    cx
         	loop   nuevo
endm




.model small
.stack 
.data
.386

Encabezado1  	db 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA','$'						;39
Encabezado2  	db 10,13,'FACULTAD DE INGENIERIA','$'								;25
Encabezado3  	db 10,13,'ESCUELA DE CIENCIAS Y SISTEMAS','$'						;33
Encabezado4  	db 10,13,'ARQUITECTURA DE COMPUTADORAS Y ENSAMBLADORES 1 "A"','$'	;53
Encabezado5	 	db 10,13,'SEGUNDO SEMESTRE 2017','$'								;24
Encabezado6	 	db 10,13,'PRACTICA 4','$'											;13
Encabezado7	 	db 10,13,'Carlos Enrique Cante Lopez','$'							;29
Encabezado8	 	db 10,13,'2013-14448','$'											;13
saltolinea 		db 10,13,'$'

menu1 			db 10,13,'*****************************************************','$'
menu2 			db 10,13,'****************** MENU PRINCIPAL *******************','$'
menu3 			db 10,13,'*****************************************************','$'
menu4 			db 10,13,'**********  1. Imagen BMP                  **********','$'
menu5 			db 10,13,'**********  2. Salir                       **********','$'
menu6			db 10,13,'*****************************************************','$'

menuimagen1 			db 10,13,'*****************************************************','$'
menuimagen2 			db 10,13,'******************** MENU IMAGEN ********************','$'
menuimagen3 			db 10,13,'*****************************************************','$'
menuimagen4 			db 10,13,'**********  1. Ver Imagen                  **********','$'
menuimagen5 			db 10,13,'**********  2. Girar                       **********','$'
menuimagen6 			db 10,13,'**********  3. Voltear                     **********','$'
menuimagen7 			db 10,13,'**********  4. Escala de Grises            **********','$'
menuimagen8 			db 10,13,'**********  5. Brillo                      **********','$'
menuimagen9 			db 10,13,'**********  6. Negativo                    **********','$'
menuimagen10 			db 10,13,'**********  7. Reporte                     **********','$'
menuimagen11 			db 10,13,'**********  8. Regresar                    **********','$'
menuimagen12			db 10,13,'*****************************************************','$'

menugirar1  			db 10,13,'*****************************************************','$'
menugirar2  			db 10,13,'*******************  MENU GIRAR  ********************','$'
menugirar3  			db 10,13,'*****************************************************','$'
menugirar4  			db 10,13,'**********  1. 90 grados derecha           **********','$'
menugirar5  			db 10,13,'**********  2. 90 grados izquiera          **********','$'
menugirar6  			db 10,13,'**********  3. 180 grados                  **********','$'
menugirar7  			db 10,13,'*****************************************************','$'
menugirar8  			db 10,13,'Si desea volver al menu anterior precione la tecla G ','$'
menugirar9  			db 10,13,'*****************************************************','$'


menuvoltear1  			db 10,13,'*****************************************************','$'
menuvoltear2  			db 10,13,'******************  MENU VOLTEAR  *******************','$'
menuvoltear3  			db 10,13,'*****************************************************','$'
menuvoltear4  			db 10,13,'**********  1. Voletar Horizontalmente     **********','$'
menuvoltear5  			db 10,13,'**********  2. Voltear Verticalmente       **********','$'
menuvoltear6  			db 10,13,'*****************************************************','$'
menuvoltear7  			db 10,13,'Si desea volver al menu anterior precione la tecla V ','$'
menuvoltear8  			db 10,13,'*****************************************************','$'



reportepractican4 db 10,13,'REPORTE PRACTICA NO.4','$'
msjnombreimagen db 10,13,'Nombre de la Imagen: ','$'
msjAncho		db 10,13,'Ancho de la Imagen: ','$'
msjAlto			db 10,13,'Alto de la Imagen: ','$'
msjTamano		db 10,13,'Tamaño de la Imagen: ','$'
reporteexitoso db 10,13,'Se ha generado el reporte con exito!!!!','$'

msjbytes db ' Bytes','$'
msjPexeles db ' Pixeles','$'

msjHora	db 'Hora: ','$'
msjFecha db 'Fecha: ','$'
HoraActual db '00:00:00','$'
FechaActual db '00/00/0000','$'



PedirOpcion 		db 10,13,'Ingrese una opcion---------> ','$'
PedirRuta			db 10,13,'Ingrese la ruta de la imagen .bmp-------->','$'


n db 0
h dw ?

nombrearchivo 		db 100 dup('$')
nombre 			db 		'REPORTE.TXT',0

HeadBuff        	db 54 dup('H')
palBuff         	db 1024 dup('P')

Encabezado          label word
TamPaleta			dw ?
Ancho       		dw ?
Altura        		dw ?
tamanioimagen		dw ?
tamanioDecimal		db 10 dup('$')
AnchoDecimal 		db 10 dup('$')
AlturaDecimal 		db 10 dup('$')


anchomj db 48

maneja   		dw     ?

Linea         	db 320 dup(0)

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
				je MenuImagen

				cmp al,50 
				je Salir
				
				jmp MenuInicial


MenuImagen:
		call ObtenerRuta
		
		;---------------------------Abrir Archivo-------------------------
		mov dx, offset nombrearchivo
		mov ax, 3d00h
  		int 21h
  		jc  Salir ;Error Al abriri el archivo

  	contImg:

  		LimpiarPantalla

  		call ImprimirMenuImagen

  		CapturaTeclado

  		cmp al, 49
  		je VerImagen
  		cmp al, 50
  		je Girar
  		cmp al, 51
  		je Voltear
  		cmp al, 52
  		je Grises
  		cmp al,53
  		je Brillo
  		cmp al, 54
  		je Negativo
  		cmp al, 55
  		je Reporte
  		cmp al, 56
  		je Regresar
  		jmp contImg

  	VerImagen:

		call video


		mov dx, offset nombrearchivo
		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

  		MOV ax,3D00h
  		INT 21h

  		mov     bx,ax

  		call EncavezadoNormal
  		jc      Salir

  		call PaletaNormal

  		push    es

  		call CargarNormal

  		pop     es

  		MOV ah,3eh
  		INT 21h

  		POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX


  		vi:

  		CapturaTeclado
  		cmp al,118
  		jne vi


  		mov ax,0003h
  		int 10h

  		jmp contImg

  	Girar:
  		LimpiarPantalla
  		call ImprimirMenuGirar
  		CapturaTeclado
  		cmp al, 49
  		je NoventaDerecha
  		cmp al, 50
  		je NoventaIzquierda
  		cmp al, 51
  		je CienOchenta 
  		cmp al, 103
  		je contImg
  		jmp Girar

  	NoventaDerecha:
  		call video


		mov dx, offset nombrearchivo
		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

  		MOV ax,3D00h
  		INT 21h

  		mov     bx,ax
  		mov 	h,ax

  		call EncavezadoNormal

  		; No es un archivo BMP valido? Desplegar mensaje de error
  		; y salir
  		jc      Salir

  		call PaletaNormal

  		push    es

  		call CargaNoventaDer

  		pop     es

  		MOV ah,3eh     ;Peticion para salir
  		INT 21h

  		POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX

  		CapturaTeclado

  		; Regresar a modo texto
  		mov ax,0003h
  		int 10h
  
  		; Finalizar el programa
  		jmp Girar

  	NoventaIzquierda:

  		call video


		mov dx, offset nombrearchivo
		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

  		MOV ax,3D00h
  		INT 21h

  		mov     bx,ax
  		mov h, ax

  		call EncavezadoNormal

  		; No es un archivo BMP valido? Desplegar mensaje de error
  		; y salir
  		jc      Salir

  		call PaletaNormal

  		push    es

  		call CargaNoventaIzq

  		pop     es

  		MOV ah,3eh     ;Peticion para salir
  		INT 21h

  		POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX

  		CapturaTeclado

  		; Regresar a modo texto
  		mov ax,0003h
  		int 10h
  
  		; Finalizar el programa
  		jmp Girar

  	CienOchenta:
  		call video


		mov dx, offset nombrearchivo
		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

  		MOV ax,3D00h
  		INT 21h

  		mov     bx,ax

  		call EncavezadoNormal

  		; No es un archivo BMP valido? Desplegar mensaje de error
  		; y salir
  		jc      Salir

  		call PaletaNormal

  		push    es

  		call CargaCienOchenta

  		pop     es

  		MOV ah,3eh     ;Peticion para salir
  		INT 21h

  		POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX

  		CapturaTeclado

  		; Regresar a modo texto
  		mov ax,0003h
  		int 10h
  
  		; Finalizar el programa
  		jmp Girar

  	Voltear:
  		LimpiarPantalla
  		call ImprimirMenuVoltear
  		CapturaTeclado
  		cmp al, 49
  		je Horizontal 
  		cmp al, 50 
  		je Veritcal 
  		cmp al, 118
  		je contImg
  		jmp Voltear
  	Horizontal:
  		call video


		mov dx, offset nombrearchivo
		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

  		MOV ax,3D00h
  		INT 21h

  		mov     bx,ax

  		call EncavezadoNormal

  		; No es un archivo BMP valido? Desplegar mensaje de error
  		; y salir
  		jc      Salir

  		call PaletaNormal

  		push    es

  		call CargarVoltH

  		pop     es

  		MOV ah,3eh     ;Peticion para salir
  		INT 21h

  		POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX

  		CapturaTeclado

  		; Regresar a modo texto
  		mov ax,0003h
  		int 10h
  
  		; Finalizar el programa
  		jmp Voltear
  	Veritcal:
  		call video


		mov dx, offset nombrearchivo
		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

  		MOV ax,3D00h
  		INT 21h

  		mov     bx,ax

  		call EncavezadoNormal

  		jc      Salir

  		call PaletaNormal

  		push    es

  		call CargarVoltV

  		pop     es

  		MOV ah,3eh 
  		INT 21h

  		POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX

  		CapturaTeclado
  		mov ax,0003h
  		int 10h
  		jmp Voltear

  	Grises:
  		call video


		mov dx, offset nombrearchivo
		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

  		MOV ax,3D00h
  		INT 21h

  		mov     bx,ax

  		call EncavezadoNormal

  		jc      Salir

  		call PaletaGrises

  		push    es

  		call CargarNormal

  		pop     es

  		MOV ah,3eh
  		INT 21h

  		POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX

  		eg:
  		CapturaTeclado
  		cmp al, 101
  		jne eg

  		mov ax,0003h
  		int 10h
  

  		jmp contImg

  	Brillo:
  		call video


		mov dx, offset nombrearchivo
		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

  		MOV ax,3D00h
  		INT 21h

  		mov     bx,ax

  		call EncavezadoNormal

  		jc      Salir

  		call PaletaBrillo

  		push    es

  		call CargarNormal

  		pop     es

  		MOV ah,3eh 
  		INT 21h

  		POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX

  		br:
  		CapturaTeclado
  		cmp al, 98
  		jne br

  		mov ax,0003h
  		int 10h

  		jmp contImg

  	Negativo:
  		call video


		mov dx, offset nombrearchivo
		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

  		MOV ax,3D00h
  		INT 21h

  		mov     bx,ax

  		call EncavezadoNormal

  		; No es un archivo BMP valido? Desplegar mensaje de error
  		; y salir
  		jc      Salir

  		call PaletaNegativo

  		push    es

  		call CargarNormal

  		pop     es

  		MOV ah,3eh     ;Peticion para salir
  		INT 21h

  		POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX

  		CapturaTeclado

  		; Regresar a modo texto
  		mov ax,0003h
  		int 10h
  
  		; Finalizar el programa

  		jmp contImg

  	Reporte:
  		mov    ax,@data
    	mov    ds,ax
    	mov    ah,3ch
    	mov    cx,00
    	lea    dx,nombre
    	int    21h
    	jc     salir
    	mov    maneja,ax

    	EscribirArchivo Encabezado1, maneja
    	EscribirArchivo Encabezado2, maneja
    	EscribirArchivo Encabezado3, maneja
    	EscribirArchivo Encabezado4, maneja
    	EscribirArchivo Encabezado5, maneja
    	EscribirArchivo Encabezado6, maneja
    	EscribirArchivo Encabezado7, maneja
    	EscribirArchivo Encabezado8, maneja

    	EscribirArchivo saltolinea, maneja
    	EscribirArchivo saltolinea, maneja

    	EscribirArchivo reportepractican4, maneja

    	EscribirArchivo saltolinea, maneja
    	EscribirArchivo saltolinea, maneja

    	call Fecha
    	EscribirArchivo msjFecha, maneja
    	EscribirArchivo FechaActual, maneja
    	EscribirArchivo saltolinea, maneja

    	call Hora
    	EscribirArchivo msjHora, maneja
    	EscribirArchivo HoraActual, maneja
    	EscribirArchivo saltolinea, maneja
    	

    	EscribirArchivo msjnombreimagen, maneja
    	EscribirArchivo nombrearchivo, maneja
    	EscribirArchivo saltolinea, maneja

    	EscribirArchivo msjAncho, maneja
    	call ConvertirAncho
    	EscribirArchivo AnchoDecimal, maneja
    	EscribirArchivo msjPexeles, maneja
    	EscribirArchivo saltolinea, maneja

    	EscribirArchivo msjAlto, maneja
    	call ConvertirAltura
    	EscribirArchivo AlturaDecimal, maneja
    	EscribirArchivo msjPexeles, maneja
    	EscribirArchivo saltolinea, maneja

    	EscribirArchivo msjTamano, maneja
    	call ConvertirTamanio
    	EscribirArchivo tamanioDecimal, maneja
    	EscribirArchivo msjbytes, maneja
    	EscribirArchivo saltolinea, maneja


    	mov    ah,3eh
    	mov    bx,maneja
    	int    21h

    	ImprimirCadena reporteexitoso
    	CapturaTeclado
		jmp contImg

  	Regresar:

  		jmp MenuInicial

ErrorAbriendo:

CargarNormal:
  mov     cx,Altura

  ShowLoop:
  push    cx

  mov     di,cx

  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1

  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1

  add     di,cx

  mov     ah,3fh
  mov     cx,Ancho
  mov     dx,offset Linea
  int     21h

  cld
  mov     cx,Ancho
  mov     si,offset Linea

  rep     movsb

  pop     cx
  loop    ShowLoop
  ret

CargarVoltV:
  mov     cx,Altura
  sub cx, 1

  ShowLoopVV:
  push    cx
  push ax
  mov ax, Altura
  sub ax, 1
  sub ax, cx
  mov cx, ax
  pop ax

  mov     di,cx

  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1

  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1

  add     di,cx
  
  mov     ah,3fh
  mov     cx,Ancho
  mov     dx,offset Linea
  int     21h

  cld
  mov     cx,Ancho
  mov     si,offset Linea

  rep     movsb

  pop     cx
  loop    ShowLoopVV
  ret

CargarVoltH:
  mov     cx,Altura

  ShowLoopH:
  push    cx
  mov     di,cx

  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1

  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1

  add     di,cx
  

  mov     ah,3fh
  mov     cx,Ancho
  mov     dx,offset Linea
  int     21h

  cld
  mov     cx,Ancho
  mov     si,offset Linea

  add di, Ancho
  decrem:

         movsb
         sub di,2

         loop decrem

  pop     cx
  loop    ShowLoopH
  ret

CargaNoventaDer:
	;Número de líneas a mostrar
  ;mov cx,altoImagen
  mov cx,Ancho
  mov bx,0
  mov di,0
  cicloMostrar9:
  push cx

  ;Di = Cx * 320
  ; DI apunta al primer pixel de la linea deseada en 
  ; la pantalla
  
  mov di,bx
  push bx ;Meto bx a pila para guardar el valor
  
  ;Se copia del archivo BMP una línea de la imagen
  ;en un buffer temporarl(SrcLine)
  mov ah,3fh
  mov cx,Ancho
  mov bx,h ;Paso a bx el HANDLE del archivo
  mov dx,offset Linea
  int 21h ;Pone una línea de la imagen en el buffer

  ;Limpiar la bandera de dirección(direction flag) para poder usar movsb
  cld ;CLear Direction flag, lo pone a cero (0)
  mov cx,Ancho
  ;mov cx,altoImagen

  mov si,offset Linea
  ;Movsb Mueve un byte que está en la dirección DS:SI a la dirección ES:DI
  ; Despues de esto, los registros SI y DI se 
  ; incrementan o decrementan automaticamente de acuerdo
  ; con el valor que contiene la bandera de direccion
  ; (DF). Si la bandera DF esta puesta en 0, los 
  ; registros SI y DI se incrementan en 1. Si la bandera 
  ; DF esta puesta en 1, los registros SI y DI se
  ; decrementan en 1.
  ;rep movsb
  voltear20:
    movsb
    add di,319
    loop voltear20

  pop bx
  inc bx
  pop cx
  loop cicloMostrar9
  ret

CargaNoventaIzq:

  mov cx,Ancho
  MOV BX,Ancho
  dec bx
  cicloMostrar10:
  push cx
  
  mov di,bx
  push bx ;Meto bx a pila para guardar el valor
  
  ;Se copia del archivo BMP una línea de la imagen
  ;en un buffer temporarl(SrcLine)
  mov ah,3fh
  mov cx,Ancho
  mov bx,h ;Paso a bx el HANDLE del archivo
  mov dx,offset Linea
  int 21h ;Pone una línea de la imagen en el buffer

  ;Limpiar la bandera de dirección(direction flag) para poder usar movsb
  cld ;CLear Direction flag, lo pone a cero (0)
  mov cx,Ancho

  mov si,offset Linea
  ;add si,319 ;Corro si para empezar a mostrarlo de derecha a izquierda
  add si,Altura
  ;Movsb Mueve un byte que está en la dirección DS:SI a la dirección ES:DI
  ; Despues de esto, los registros SI y DI se 
  ; incrementan o decrementan automaticamente de acuerdo
  ; con el valor que contiene la bandera de direccion
  ; (DF). Si la bandera DF esta puesta en 0, los 
  ; registros SI y DI se incrementan en 1. Si la bandera 
  ; DF esta puesta en 1, los registros SI y DI se
  ; decrementan en 1.
  ;rep movsb
  voltear21:
    movsb
    sub si,2 ;Le resto 2 porque la Instruccion movsb le suma 1
    ;y yo le quiero restar para mostrarlo de izquierda a derecha
    add di,319
    loop voltear21

  pop bx
  dec bx
  ;inc bx
  pop cx
  loop cicloMostrar10
  ret

CargaCienOchenta:
  mov     cx,Altura

  ShowLoopCO:
  push    cx
  push ax
  mov ax, Altura
  sub ax, cx
  mov cx, ax
  pop ax

  mov     di,cx

  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1

  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1

  add     di,cx
  
  mov     ah,3fh
  mov     cx,Ancho
  mov     dx,offset Linea
  int     21h

  cld
  mov     cx,Ancho
  mov     si,offset Linea

  add di, Ancho
  decremCO:

         movsb
         sub di,2

         loop decremCO


  pop     cx
  loop    ShowLoopCO
  ret
		
EncavezadoNormal:
	mov     ah,3fh
  	mov     cx,54
  	mov     dx,offset Encabezado
  	int     21h
  	jc      RHdone

 
  	mov     ax,Encabezado[ 0Ah ]
  	sub     ax, 54
  	shr ax,1
  	shr ax,1
  	mov     TamPaleta,ax
  	mov     ax, Encabezado[ 12h ]
  	mov     Ancho,ax             
  	mov     ax, Encabezado[ 16h ]    
  	mov     Altura,ax 
  	mov 	ax, Encabezado[ 22h ]
  	mov 	tamanioimagen, ax


  	RHdone:
  	ret

PaletaNormal:
  mov     ah,3fh
  mov     cx,TamPaleta
  shl     cx,1
  shl     cx,1
  mov     dx,offset palBuff
  int     21h

  mov     si,offset palBuff
  mov     cx,TamPaleta
  mov     dx,3c8h
  mov     al,0
  out     dx,al
  inc     dx

  sndLoop:
  mov     al,[si+2]
  shr     al,1
  shr     al,1

  out     dx,al

  mov     al,[si+1]
  shr     al,1
  shr     al,1

  out     dx,al
 
  mov     al,[ si ]
  shr     al,1
  shr     al,1

  out     dx,al

  add     si,4
  loop    sndLoop
  ret

PaletaNegativo:
  mov     ah,3fh
  mov     cx,TamPaleta
  shl     cx,1
  shl     cx,1
  mov     dx,offset palBuff
  int     21h

  mov     si,offset palBuff
  mov     cx,TamPaleta
  mov     dx,3c8h
  mov     al,0

  out     dx,al
  inc     dx

  sndLoopN:
  mov     al,[si+2]
  mov ah, 255
  sub ah, al 
  mov al, ah 
  shr     al,1
  shr     al,1

  out     dx,al

  mov     al,[si+1]
  mov ah, 255
  sub ah, al 
  mov al, ah 
  shr     al,1
  shr     al,1

  out     dx,al

  mov     al,[ si ]
  mov ah, 255
  sub ah, al 
  mov al, ah 
  shr     al,1
  shr     al,1

  out     dx,al
  add     si,4
  loop    sndLoopN
  ret

PaletaGrises:
  mov     ah,3fh
  mov     cx,TamPaleta
  shl     cx,1
  shl     cx,1
  mov     dx,offset palBuff
  int     21h

  mov     si,offset palBuff
  mov     cx,TamPaleta
  mov     dx,3c8h
  mov     al,0
  out     dx,al
  inc     dx

  sndLoopG:
  push dx
  push di
  call luminosidad
  pop di
  pop dx
 
  shr     al,1
  shr     al,1

  out     dx,al
  
  out     dx,al
  
  out     dx,al

  add     si,4
  loop    sndLoopG
  ret

PaletaBrillo:
  mov     ah,3fh
  mov     cx,TamPaleta

  shl     cx,1
  shl     cx,1

  mov     dx,offset palBuff
  int     21h

  mov     si,offset palBuff
  mov     cx,TamPaleta
  mov     dx,3c8h
 
  mov     al,0
  out     dx,al
 
  inc     dx
  sndLoopBR:
  
  mov     al,[si+2]
  add al,50
  cmp al, 255
  jb seguirR
  mov al,254

  seguirR:
  
  shr     al,1
  shr     al,1
  
  out     dx,al
 
  mov     al,[si+1]

  add al,50
  cmp al,255
  jb seguirV
  mov al,254
  seguirV:
  shr     al,1
  shr     al,1
 
  out     dx,al
  
  mov     al,[ si ]

  add al,50
  cmp al,255
  jb seguirA
  mov al,254
  seguirA:
  shr     al,1
  shr     al,1
  
  out     dx,al

  add     si,4
  loop    sndLoopBR
  ret

video:
 	mov     ax,13h
  	int     10h
  	mov ax, 0A000h
  	mov es, ax
  	ret

luminosidad:
	push bx
  	push dx

  	mov ax, 0
    mov al,[si+2]
    mov bx, ax

    mov ax, 0
   	mov al,[si+1]
    add bx, ax

    mov ax, 0
    mov al, [si]
    add bx, ax

    mov dx, 0
    mov ax, bx
    mov bx, 3
    div bx

    pop dx
    pop bx 

    ret

ObtenerRuta:
		ImprimirCadena saltolinea
		ImprimirCadena PedirRuta
		mov si,0


		;*************************Limpiar el vector donde se guarda la ruta del archivo******************************
		limpiarruta:
			mov nombrearchivo[ si ],0
			inc si
			cmp si, 99
			jne limpiarruta

		mov si,0

		RutaIntermedia:

			CapturaTeclado
			cmp al,46
			je VerificarExtencion

			mov nombrearchivo[ si ], al
			inc si
			jmp RutaIntermedia

			VerificarExtencion:
				mov nombrearchivo[ si ], al
				inc si

				CapturaTeclado
				cmp al,98
				jne ObtenerRuta
				mov nombrearchivo[ si ], al
				inc si

				CapturaTeclado
				cmp al, 109
				jne ObtenerRuta
				mov nombrearchivo[ si ], al
				inc si

				CapturaTeclado
				cmp al, 112
				jne ObtenerRuta
				mov nombrearchivo[ si ], al
				
		ret

ConvertirAltura:

		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

		mov ax, @data
		mov ds, ax
		mov ax, Altura
		lea si, AlturaDecimal
		mov cx,0
		mov bx,10
		Ciclo1:
			mov dx, 0
			div bx
			add dl, 30h 
			push dx
			inc cx
			cmp ax, 9
			jg Ciclo1

			add al, 30h 
			mov [ si ], al 
		Ciclo2:
		    pop ax 
		    inc si
		    mov [ si ], al 
		    loop Ciclo2


		 POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX

  		ret

ConvertirAncho:

		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

		mov ax, @data
		mov ds, ax
		mov ax, Ancho
		lea si, AnchoDecimal
		mov cx,0
		mov bx,10
		Ciclo1A:
			mov dx, 0
			div bx
			add dl, 30h 
			push dx
			inc cx
			cmp ax, 9
			jg Ciclo1A

			add al, 30h 
			mov [ si ], al 
		Ciclo2A:
		    pop ax 
		    inc si
		    mov [ si ], al 
		    loop Ciclo2A


		 POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX

  		ret

ConvertirTamanio:
		PUSH AX
  		PUSH CX
  		PUSH DX
  		PUSH BX
  		PUSH SP
  		PUSH BP
  		PUSH SI
  		PUSH DI

		mov ax, @data
		mov ds, ax
		mov ax, tamanioimagen
		lea si, tamanioDecimal
		mov cx,0
		mov bx,10
		Ciclo1AB:
			mov dx, 0
			div bx
			add dl, 30h 
			push dx
			inc cx
			cmp ax, 9
			jg Ciclo1AB

			add al, 30h 
			mov [ si ], al 
		Ciclo2AB:
		    pop ax 
		    inc si
		    mov [ si ], al 
		    loop Ciclo2AB


		 POP DI
  		POP SI
  		POP BP
  		POP SP
  		POP BX
  		POP DX
  		POP CX
  		POP AX

  		ret

Hora:
    lea bx, HoraActual
    mov ah, 2ch
    int 21h

    mov al, ch 
    call assciii
    mov [ bx ], ax
    mov al, cl 
    call assciii
    mov [ bx + 3 ], ax

    mov al, dh 
    call assciii
    mov [ bx + 6 ], ax

     ret

fecha:
	lea bx, FechaActual
	mov ah, 2ah
	int 21h

	mov al, dl
	call assciii
	mov [ bx ], ax
	mov al, dh 
	call assciii
	mov [ bx + 3 ], ax
	mov al, 100
	xchg ax, cx
	div cl
	mov ch, ah
	call assciii
	mov [ bx + 6 ], ax
	mov al, ch
	call assciii
	mov [ bx + 8 ], ax
	ret

assciii:
	mov ah, 0
	mov dl, 10
	div dl
	or ax, 3030h
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
				ImprimirCadena saltolinea
				ret 

ImprimirMenuImagen:

				ImprimirCadena menuimagen1
				ImprimirCadena menuimagen2
				ImprimirCadena menuimagen3
				ImprimirCadena menuimagen4
				ImprimirCadena menuimagen5
				ImprimirCadena menuimagen6
				ImprimirCadena menuimagen7
				ImprimirCadena menuimagen8
				ImprimirCadena menuimagen9
				ImprimirCadena menuimagen10
				ImprimirCadena menuimagen11
				ImprimirCadena menuimagen12
				ImprimirCadena saltolinea
				ImprimirCadena PedirOpcion
				ret 

ImprimirMenuVoltear:
					
				ImprimirCadena menuvoltear1
				ImprimirCadena menuvoltear2
				ImprimirCadena menuvoltear3
				ImprimirCadena menuvoltear4
				ImprimirCadena menuvoltear5
				ImprimirCadena menuvoltear6
				ImprimirCadena menuvoltear7
				ImprimirCadena menuvoltear8
				ImprimirCadena saltolinea
				ImprimirCadena PedirOpcion
				ret 

ImprimirMenuGirar:
				ImprimirCadena menugirar1
				ImprimirCadena menugirar2
				ImprimirCadena menugirar3
				ImprimirCadena menugirar4
				ImprimirCadena menugirar5
				ImprimirCadena menugirar6
				ImprimirCadena menugirar7
				ImprimirCadena menugirar8
				ImprimirCadena menugirar9
				ImprimirCadena saltolinea
				ImprimirCadena PedirOpcion
				ret 

Salir:
				finalizar

main endp
end