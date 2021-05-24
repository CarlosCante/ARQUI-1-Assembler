LimpiarPantalla macro
	mov ah,0
	mov al,3h 
	int 10h 
endm
ImprimirCadena macro texto
	mov dx, offset texto
	mov ah, 9
	int 21h
endm
ImprimirCaracter macro caracter
	mov ah, 02h 
	mov dl, caracter
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
PintarPixel macro coordenadaX, coordenadaY, color
	mov cx, coordenadaX
	mov dx, coordenadaY
	mov ah, 0ch
	mov al, color
	int 10h
endm
PintarPunto macro coordenadaX, coordenadaY, color
	PintarPixel coordenadaX, coordenadaY, color
	inc coordenadaX
	PintarPixel coordenadaX, coordenadaY, color
	inc coordenadaY
	PintarPixel coordenadaX, coordenadaY, color
	dec coordenadaX
	PintarPixel coordenadaX, coordenadaY, color
endm
.model small
.stack 
.data
p1  db 10,13,'-------------------------------------------------------------------------------','$'
p2  db 10,13,'  UNIVERSIDAD DE SAN CARLOS DE GUATEMALA','$'
p3  db 10,13,'  FACULTAD DE INGENIERIA','$'
p4  db 10,13,'  ESCUELA DE CIENCIAS Y SISTEMAS','$'
p5  db 10,13,'  ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 "A"','$'
p6	db 10,13,'  PRIMER SEMESTRE 2017','$'
p7	db 10,13,'  PRACTICA 5','$'
p8	db 10,13,'                         Brayan Ezequiel Santiago Brito','$'
p9	db 10,13,'                                  201114566','$'
p10 db 10,13,'-------------------------------------------------------------------------------','$'
p11 db 10,13,'                               MENU PRINCIPAL','$'
p12 db 10,13,'  1. Cargar archivo','$'
p13 db 10,13,'  2. Modo calculadora','$'
p14 db 10,13,'  3. Factorial','$'
p15 db 10,13,'  4. Graficador','$'
p16 db 10,13,'  5. Salir','$'
p17 db 10,13,'  Elija una Opcion:','$'

nl  db 10,13,'  ','$'
de  db '  ','$'

ca1  db 10,13,'                              CARGA DE ARCHIVO','$'
ca2  db 10,13,'  Ingrese la ruta del archivo (Extension ".arq" | Formato ##<ruta>##):','$'
ca3  db 10,13,'  Patron correcto!','$'
ca4  db 10,13,'  Patron incorrecto!','$'
ca5  db 10,13,'  Error al abrir el archivo!','$'
ca6  db 10,13,'  Caracter invalido:','$'
ca7  db 10,13,'                                 GRAFICADOR','$'
ca8  db 10,13,'                              MODO CALCULADORA','$'
ca9  db 10,13,'  Numero:','$'
ca10 db 10,13,'  Operador aritmetico:','$'
ca11 db 10,13,'  Resultado:','$'
ca12 db 10,13,'  Numero invalido!','$'
ca13 db 10,13,'  Operador invalido','$'
ca14 db 10,13,'  ¿Desea regresar al menu principal?','$'
ca15 db 10,13,'  1. Si','$'
ca16 db 10,13,'  2. No','$'

na1 db 100 dup('$')
la1 db 100 dup('$')
han dw ?

num dw 0
x   dw 0
y   dw 0
ver db 50
bla db 15

nu1 dw 0
nu2 dw 0
res dw 0
sig db 0
op  db 0
aux dw 1

.code
.startup
main proc
		
	MenuPrincipal:
		call IrMenuPrincipal
		
		mov ah,08 
		int 21h
		cmp al,49 
		je CargarArchivo 
		cmp al,50 
		je ModoCalculadora
		cmp al,51 
		je Factorial
		cmp al,52
		je Graficador
		cmp al,53
		je Salir
		jmp MenuPrincipal
		
	CargarArchivo:
		call IrMenuCargarArchivo
		jmp MenuPrincipal
	ModoCalculadora:
		call irMenuModoCalculadora
		jmp MenuPrincipal
	Factorial:
		jmp MenuPrincipal
	Graficador:
		call IrMenuGraficador
		jmp MenuPrincipal
	Salir:
		call SalirAplicacion 

	IrMenuPrincipal:
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
		ImprimirCadena p15
		ImprimirCadena p16
		ImprimirCadena p17
		ImprimirCadena nl
	ret
	
	IrMenuCargarArchivo:
		LimpiarPantalla
		ImprimirCadena p1
		ImprimirCadena ca1
		ImprimirCadena p1
		ImprimirCadena nl
		call LeerRuta
	ret
	
	irMenuModoCalculadora:
		ImprimirMenuCalculadora:
			LimpiarPantalla
			ImprimirCadena p1
			ImprimirCadena ca8
			ImprimirCadena p1
			ImprimirCadena nl
		
			PrimerNumero:
				ImprimirCadena ca9
				ImprimirCadena de
					mov ah,01h
					int 21h
					cmp al,45
					je LeerSignoUno
					cmp al,48
					jb NumeroIncorrectoUno
					cmp al,57
					ja NumeroIncorrectoUno
					jmp LeerPrimerDigitoUno
					LeerSignoUno:
						mov sig,1
						
						mov ah,01h
						int 21h
						cmp al,48
						jb NumeroIncorrectoUno
						cmp al,57
						ja NumeroIncorrectoUno
						jmp LeerPrimerDigitoUno
					LeerPrimerDigitoUno:
						mov nu1,ax
						sub nu1,48
					
						mov ah,01h
						int 21h
						cmp al,48
						jb NumeroIncorrectoUno
						cmp al,57
						ja NumeroIncorrectoUno
						jmp LeerSegundoDigitoUno
					LeerSegundoDigitoUno:
						mov ax,nu1
						mov cl,10
						mul cl
						mov nu1, ax
						mov dx,ax
						sub dx,48
						add nu1,dx
						jmp LeerOperador
					
					NumeroIncorrectoUno:
						ImprimirCadena ca12
						ImprimirCadena nl
						jmp PrimerNumero
						
			LeerOperador:
				ImprimirCadena ca10
				ImprimirCadena de
				mov ah,01h
				int 21h
				cmp al,42
				je AlmacenarOperador
				cmp al,43
				je AlmacenarOperador
				cmp al,45
				je AlmacenarOperador
				cmp al,47
				je AlmacenarOperador
				
				OperadorIncorrecto:
					ImprimirCadena ca13
					ImprimirCadena nl
					jmp LeerOperador
					
				AlmacenarOperador:
					mov op, al
					jmp SegundoNumero
						
			SegundoNumero:
				ImprimirCadena ca9
				ImprimirCadena de
					mov ah,01h
					int 21h
					cmp al,45
					je LeerSignoDos
					cmp al,48
					jb NumeroIncorrectoDos
					cmp al,57
					ja NumeroIncorrectoDos
					jmp LeerPrimerDigitoDos
					LeerSignoDos:
						mov sig,1
						
						mov ah,01h
						int 21h
						cmp al,48
						jb NumeroIncorrectoDos
						cmp al,57
						ja NumeroIncorrectoDos
						jmp LeerPrimerDigitoDos
					LeerPrimerDigitoDos:
						mov nu2,ax
						sub nu2,48
					
						mov ah,01h
						int 21h
						cmp al,48
						jb NumeroIncorrectoDos
						cmp al,57
						ja NumeroIncorrectoDos
						jmp LeerSegundoDigitoDos
					LeerSegundoDigitoDos:
						mov ax,nu2
						mov cl,10
						mul cl
						mov nu2, ax
						mov dx,ax
						sub dx,48
						add nu2,dx
						jmp Operar
					
					NumeroIncorrectoDos:
						ImprimirCadena ca12
						ImprimirCadena nl
						jmp SegundoNumero
						
			Operar:
				cmp op,42
				je Multiplicacion
				cmp op,43
				je Suma
				cmp op,45
				je Resta
				cmp op,47
				je Division 
				jmp SalirCalculadora
				Suma:
					mov ax, nu2
					add nu1,ax
					mov ax, nu1
					mov res,ax
					jmp ImprimirResultado
				Resta:
					mov ax, nu2
					sub nu1,ax
					mov ax, nu1
					mov res,ax
					jmp ImprimirResultado
				Multiplicacion:
					mov ax,nu1
					mov cx,nu2
					mul cx
					mov res, ax
					jmp ImprimirResultado
				Division:
					mov ax,nu1
					mov cx,nu2
					div cx
					mov res, ax
					jmp ImprimirResultado
					
			ImprimirResultado:
			
				ImprimirCadena ca11
				ImprimirCadena de
				
				ObtenerMayor:
					mov ax, aux
					cmp res,ax
					jb ObtenerDigitos
					mov cl, 10
					mul cl
					mov aux,ax
					jmp ObtenerMayor
				
				ObtenerDigitos:
					mov ax, aux
					mov cl, 10
					div cl
					mov aux, ax
					
					VerificarSiEsUno:
						mov ax,res
						mov cx,aux
						div cx
						ImprimirCaracter cl
						mov res,ax
					
						cmp aux,1
						je SalirCalculadora
						mov ax, aux
						mov cx,10
						div cx
						mov aux,cx
						jmp VerificarSiEsUno
					
		SalirCalculadora:
			mov ah,01h
			int 21h
			cmp al,0dh
			jne SalirCalculadora
		
	ret
	
	IrMenuGraficador:
		LimpiarPantalla
		ImprimirCadena p1
		ImprimirCadena ca7
		ImprimirCadena p1
		ImprimirCadena nl
		call LeerRuta
		call LeerContenidoGraficador
		mov ah,01h
		int 21h
		cmp al,0dh
		jne SalirLeerRuta
	ret
	
	LeerRuta:
		InicioLectura:
			ImprimirCadena ca2
			ImprimirCadena nl
			mov si, 0
			LimpiarVector:
				mov na1[si],0
				inc si
				cmp si,99
				jne LimpiarVector
			mov si, 0
			IniciarPatron:
				mov ah,01h
				int 21h
				cmp al,35
				jne RutaIncorrecta
				mov ah,01h
				int 21h
				cmp al,35
				jne RutaIncorrecta
			LeerProximoCaracter:
				mov ah,01h
				int 21h
				cmp al,35
				je SeguirPatron
				AgregarCaracter:
					mov na1[si],al
					inc si
					jmp LeerProximoCaracter
			SeguirPatron:
				mov ah,01h
				int 21h
				cmp al,35
				je RutaCorrecta		
		RutaIncorrecta:
			ImprimirCadena ca4
			ImprimirCadena de
			ImprimirCadena na1
			jmp InicioLectura
		RutaCorrecta:
			ImprimirCadena ca3
			ImprimirCadena de
			ImprimirCadena na1
			ImprimirCadena nl
			
			LeerArchivo:
				mov ah,3dh 
				mov al,00 
				lea dx,offset na1 
				int 21h
				jc ErrorAlAbrir
				
				mov han,ax
			
				mov ah,3fh
				mov bx,han
				mov cx,100
				lea dx,la1
				int 21h
				jmp SalirLeerRuta
				
				ErrorAlAbrir:
					ImprimirCadena ca5
					ImprimirCadena nl
					jmp InicioLectura
			
		SalirLeerRuta:
			mov ah,01h
			int 21h
			cmp al,0dh
			jne SalirLeerRuta
	ret
	
	LeerContenidoGraficador:
		mov ax,0013h
		int 10h
		mov si,0
		call GraficarEjes
		SiguienteCaracter:
			cmp la1[si],44
			je EsComa
			cmp la1[si],59
			je EsPuntoYComa
			cmp la1[si],48
			jb CaracterIncorrecto
			cmp la1[si],57
			ja CaracterIncorrecto
			
			EsNumero:
				mov ax,num
				mov cl,10
				mul cl
				mov num, ax
				mov al, la1[si]
				sub ax, 48
				add num, ax
				jmp Avanzar
			
			EsComa:
				mov ax, num
				mov y, ax
				mov cl, 2
				mul cl
				mov y, ax
				mov ax,190
				sub ax,y
				mov y, ax
				PintarPunto x,y,ver
				add x,2
				mov num,0
				jmp Avanzar
				
			EsPuntoYComa:
				mov ax, num
				mov y, ax
				mov cl, 2
				mul cl
				mov y, ax
				mov ax,190
				sub ax,y
				mov y, ax
				PintarPunto x,y,ver
				mov x,0
				mov num,0
				jmp SalirLecturaGraficador
			
			Avanzar:
				inc si
				jmp SiguienteCaracter
			
		CaracterIncorrecto:
			mov ax,0003h
			int 10h
			ImprimirCadena ca6
			ImprimirCadena de
			ImprimirCaracter la1[si]
		
		SalirLecturaGraficador:
		
	ret
	
	GraficarEjes:
		mov cx, 0
		mov dx, 190

		CicloX:
		PintarPixel cx, dx, bla
		inc cx
		cmp cx, 320
		jne CicloX

		mov cx, 0
		inc dx
		cmp dx, 192
		jne CicloX
		
		
		mov cx, 10
		mov dx, 0

		CicloY:
		PintarPixel cx, dx, bla
		inc cx
		cmp cx, 12
		jne CicloY

		mov cx, 10
		inc dx
		cmp dx, 200
		jne CicloY
	ret
	
	SalirAplicacion:
		int 10h
		mov ax,4c00h
		int 21h
	ret

main endp
end