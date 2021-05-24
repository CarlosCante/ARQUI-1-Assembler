imprime macro cadena
	mov ax,@data
	mov ds,ax
	mov ah,09
	mov dx,offset cadena
	int 21h
endm

imprime_C macro cara 
	mov ah,0eh
	mov al,cara
	add al,30h
	int 10h
endm

Terminar macro
	mov ah,00
	mov al,03h
	int 10h
	mov ax, 4C00h
	int 21h
endm

mensajeEncabezado macro
	imprime msj0
	imprime msj1
	imprime msj2
	imprime msj3
	imprime msj4
	imprime msj5
	imprime msj6
	imprime msj7
	imprime espacio
endm

mensajeMenu macro
	imprime men0
	imprime men1
	imprime men2
	imprime men3
	imprime men4
	imprime men5
	imprime men6
	imprime men7
	imprime men8
	imprime espacio
	imprime opcion
endm

salircalcu macro
	imprime cl0
	imprime cl1
	imprime cl2
	imprime espacio
	imprime opcion
endm

mensajeOperaciones macro
	imprime ms0
	imprime ms1
	imprime ms2
	imprime ms3
	imprime ms4
	imprime ms5
	imprime ms6
	imprime ms7
	imprime espacio
	imprime opcion
endm

Pausa macro
	mov ah,01h
	int 21h
endm


limpiarPantalla macro
	mov ah,00			;Limpia pantalla
	mov al,03h
	int 10h
endm

.model small
.data
	msj0 db 0ah,0dh,'  UNIVERSIDAD DE SAN CARLOS DE GUATEMALA','$'
	msj1 db 0ah,0dh,'  FACULTAD DE INGENIERIA','$'
	msj2 db 0ah,0dh,'  ESCUELA DE CIENCIAS Y SITEMAS','$'
	msj3 db 0ah,0dh,'  ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 A','$'
	msj4 db 0ah,0dh,'  SEGUNDO SEMESTRE 2017','$'
	msj5 db 0ah,0dh,'  HAYRTON OMAR IXPATA COLOCH','$'
	msj6 db 0ah,0dh,'  201313875','$'
	msj7 db 0ah,0dh,'  SEGUNDA PRACTICA','$'
	espacio db 0ah,0dh,' ','$'
	men0 db 0ah,0dh,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%','$'
	men1 db 0ah,0dh,'%%%%%%%%%%%%%%%%%% MENU PRINCIPAL %%%%%%%%%%%%%%%%%%%%%','$'
	men2 db 0ah,0dh,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%','$'
	men3 db 0ah,0dh,'%%%%      1. Cargar Archivo                        %%%%','$'
	men4 db 0ah,0dh,'%%%%      2. Modo Calculadora                      %%%%','$'
	men5 db 0ah,0dh,'%%%%      3. Factorial                             %%%%','$'
	men6 db 0ah,0dh,'%%%%      4. Reporte                               %%%%','$'
	men7 db 0ah,0dh,'%%%%      5. Salir                                 %%%%','$'
	men8 db 0ah,0dh,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%','$'
	opcion db 0ah,0dh,' Ingrese opcion -> ','$'
	ms0 db 0ah,0dh,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%','$'
	ms1	db 0ah,0dh,'%%%%%%%%%%%%%%%%%% MENU Operaciones %%%%%%%%%%%%%%%%%%%','$'
	ms2 db 0ah,0dh,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%','$'
	ms3 db 0ah,0dh,'%%%%      1. Resultado                             %%%%','$'
	ms4 db 0ah,0dh,'%%%%      2. Notacion Prefija                      %%%%','$'
	ms5 db 0ah,0dh,'%%%%      3. Notacion Postfija                     %%%%','$'
	ms6 db 0ah,0dh,'%%%%      4. Salir                                 %%%%','$'
	ms7 db 0ah,0dh,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%','$'
	solicituRuta db 0ah,0dh,' Ingrese ruta del archivo con extencion .arq -> ','$'
	numero db 0ah,0dh,' Numero: ','$'
	operador db 0ah,0dh,' Operador aritmetico: ','$'
	result db 0ah,0dh,' Resultado: ','$'

	;variables para abrir Archivo
	ERRORA1 db 0ah,0dh,'Error al ingresar la ruta del archivo, presione ENTER para ingresar de nuevo.','$'
	ERRORARCHIVO db 0ah,0dh,'El archivo no existe, presione ENTER para continuar.','$'
	ERRORCARACTER db 0ah,0dh,'Caracter invalido.','$'
	ERRORFINA db 0ah,0dh,'El archivo no posee fin ";".','$'
	MAR1 = 100
	fil db 0
	f2 db '$$'
	handle dw ?
	buffer db 1000 dup('$')
	RA1 db MAR1 dup(0)
	ERRARCH db 0
	ERRBUFER db 0
	POSEEFIN db 0
	CaracterT db 0
	;variables Postfija
	R_temp db 0
	N_temp db 0
	resultado db 0

	;varibales modo calculadora
	cl0 db 0ah,0dh,'Desea salir de la aplicacion','$'
	cl1	db 0ah,0dh,'   1. Si','$'
	cl2 db 0ah,0dh,'   2. No','$'
	SignoMenos db '-','$'
	EsNeg db 0
	BanderaNeg db 0
	operando db 0
	Unidad db 0
	Decena db 0
	Valor_U db 0
	Valor_D db 0
	Valor_C db 0
	Valor_M db 0
	diez db 10
	N1 db 0
	N2 db 0
	ConstanteA db 0
	Negar db -1

	;variable factorial
	TXTFACTORIAL db 0ah,0dh,'Ingrese un numero, minimio 00 y maximo 08: ','$'
	TXTOPFAC db 0ah,0dh,'Operaciones: ','$'
	SIGFAC db '!','$'
	ASTERISCO db '*','$'
	IGUAL db '=','$'
	NFAC1 db 0
	NFAC2 db 0
	TXTF db 0
	RESULT_FAC db 0
	FAC_U db 0
	FAC_D db 0
	FAC_C db 0
	FAC_M db 0
	FAC_MM db 0
	RetornoCarro db 13,'      ',13,'$'
	puntoComa db 0ah,0dh,';','$'

	;variables de reporte
	nombredocreporte db 0ah,0dh,'C:\Usuers\Hayrton\Desktopo\asembler\reporte.txt','$'
	temporal dw ?
	texto dw ?

	textprueba db 0ah,0dh,'hola mundo','$'

.code
	.startup
	main:
		limpiarPantalla
		mensajeEncabezado
		mensajeMenu
		
		mov ah,01h			;inicio de la comparacion de teclado
		int 21h
		sub al,30h
		cmp al,1			;compara si en el teclado se ingresa el numero 1
		je cargar			;Si la condicion es verdadera realiza un salto a la etiqueta Cargar
		cmp al,2
		je calculadora
		cmp al,3
		je factorial
		cmp al,4
		je reporte
		cmp al,5			;compara si en el teclado se ingresa el numero 2
		je Salir			;Si la condicion es verdadera realiza un salto a la etiqueta Salir
		jmp main
;----------------------- opcion carga y lectura de archivo ----------------------
	cargar:
		mov ERRARCH,0
		mov ERRBUFER,0
		mov POSEEFIN,0
		limpiarPantalla
		call SOLICITUD_RUTA
		call CARGA_ARCHIVO
		cmp ERRARCH,1
		je cargar
		call VERIFICAR_BUFER
		cmp ERRBUFER,1
		je main
		cmp POSEEFIN,1
		jne main

		mensajeOperaciones

		mov ah,01h			;inicio de la comparacion de teclado
		int 21h
		sub al,30h
		cmp al,1			;compara si en el teclado se ingresa el numero 1
		je 	RESULTOP			;Si la condicion es verdadera realiza un salto a la etiqueta Cargar
		cmp al,2
		je NOTPRE
		cmp al,3
		je NOTPOS
		cmp al,4
		je salir
		jmp main

		RESULTOP:
		NOTPOS:
		NOTPRE:

;------------------------ opcion modo calculadora -----------------------
	calculadora:
		call PEDIR_NUMEROS

		SALIRDECALCU:
			salircalcu
			mov ah,01h
			int 21h
			sub al,30h
			cmp al,1
			je main
			cmp al,2
			je calculadora
			jmp SALIRDECALCU

;------------------------- opcion factorial ------------------------------
	factorial:
		call MOD_FACTORIAL
		Pausa
		jmp main

; ---------------------------- opcion reporte ----------------------------
	reporte:
	
	salir: .exit

;--------------------------Solicitud de Ruta--------------------------------
	SOLICITUD_RUTA proc
		INICIO_C1:
			limpiarPantalla
			imprime solicituRuta
			mov cx,MAR1
			lea si,RA1
			mov ah,01h
			int 21h
			cmp al,64d
			jne ERROR_RA1
			mov ah,01h
			int 21h
			cmp al,64d
			jne ERROR_RA1
			jmp CUERPO_R

		CUERPO_R:
			mov ah,01h
			int 21h
			cmp al,0dh					;ENTER
			je ERROR_RA1
			cmp al,32d					;espacio
			je ERROR_RA1
			cmp al,46d					;punto
			je EXTENSION
			mov [si],al
			inc si
			dec cx
			cmp cx,0
			je ERROR_RA1
			jmp CUERPO_R

		EXTENSION:
			mov [si],al					;guardamos el punto
			inc si
			dec cx
			mov ah,01h
			int 21h
			cmp al,97d					;"a" de arq
			jne ERROR_RA1
			mov [si],al
			inc si
			dec cx
			mov ah,01h
			int 21h
			cmp al,114d					;"r" de arq
			jne ERROR_RA1
			mov [si],al
			inc si
			dec cx
			mov ah,01h
			int 21h
			cmp al,113d					;"q" de arq
			jne ERROR_RA1
			mov [si],al
			inc si
			dec cx
			mov ah,01h
			int 21h
			cmp al,64d					;"@" primer arroba despues de la extension
			jne ERROR_RA1
			mov [si],al
			inc si
			dec cx
			mov ah,01h
			int 21h
			cmp al,64d					;"@" segundo arroba despues de la extension
			jne ERROR_RA1
			mov ah,01h
			int 21h
			cmp al,0dh
			je CIERRE_R1
			jmp ERROR_RA1

		CIERRE_R1:
			mov al,fil;0
			mov [si],al
			inc si
			mov al,f2;$$
			mov [si],al
			jmp FIN_SR1
	
		ERROR_RA1:
			limpiarPantalla
			imprime ERRORA1
			Pausa
			jmp INICIO_C1
	
		FIN_SR1:
			limpiarPantalla
			imprime RA1
			Pausa
			ret 

	SOLICITUD_RUTA endp

;------------------------------------ Carga de Archivo ----------------------------------------------
	CARGA_ARCHIVO proc
		mov ax,0
		mov cx,0
		mov si,0
		mov dx,0
		mov bx,0
		mov ERRARCH,0

		mov dx,offset RA1
		mov ax,3D00h
		int 21h
		jc ERRORCARGAU
		mov handle,ax
		mov ax,4200h
		int 21h
		mov si,offset buffer
		jmp INICIO_LECTURA

		INICIO_LECTURA:
			mov bx,handle
			mov cx,1
			mov dx,si
			mov ah,3fh
			int 21h
			inc si
			cmp ax,0
			jz INICIO_BUF
			jmp INICIO_LECTURA

		INICIO_BUF:
			inc si
			mov al,f2
			mov buffer[si],al
			imprime buffer
			Pausa
			mov ah,3eh
			int 21h
			jmp FIN_CARGAR

		ERRORCARGAU:
			limpiarPantalla
			imprime ERRORARCHIVO
			mov ERRARCH,1
			Pausa
			jmp FIN_CARGAR

		FIN_CARGAR:
		ret
	CARGA_ARCHIVO endp

	;---------------------------------------- verificacion de buffer --------------------------------

	VERIFICAR_BUFER proc
		INICIO_VERF_BUF:
			mov si,0
			mov cx,0
			mov POSEEFIN,0
			jmp RECORRERBF1

		RECORRERBF1:
			cmp buffer[si],32d		;espacio
			je MOVSIBF
			cmp buffer[si],36d		;";" punto y compara
			je FINBF
			cmp buffer[si],43d		;"+" signo mas
			je MOVSIBF
			cmp buffer[si],45d		;"-" signo menos
			je MOVSIBF
			cmp buffer[si],42d		;"*" signo proc
			je MOVSIBF
			cmp buffer[si],47d		;"/" signo division
			jmp RANGO1

		RANGO1:
			cmp buffer[si],48d
			jge RANGO2
			jmp CARACT_INV

		RANGO2:
			cmp buffer[si],57d
			jle MOVSIBF
			jmp FINCBF

		FINCBF:
			cmp buffer[si],59d
			jne MOVSIBF
			mov POSEEFIN,1
			jmp FINBF

		MOVSIBF:
			inc si
			inc cx
			cmp cx,1000
			je FINBF
			jmp RECORRERBF1

		CARACT_INV:
			imprime ERRORCARACTER
			mov al,buffer[si]
			sub al,30h
			mov CaracterT,al
			imprime_C CaracterT
			mov ERRBUFER,1
			Pausa
			jmp FIN_VB

		FINBF:
			cmp POSEEFIN,1
			je FIN_VB
			imprime ERRORFINA
			Pausa
			jmp FIN_VB

		FIN_VB:
		ret

	VERIFICAR_BUFER endp

	;------------------------------------ Postfija -------------------------------------
	POSTFIJA proc
		mov si,0
		mov cx,0
		mov bx,0
		mov resultado,0
		mov R_temp,0
		mov N_temp,0
		mov al,buffer[si]
	POSTFIJA endp

	;--------------------------------- modo calculadora -----------------------------------

	PEDIR_NUMEROS proc
		limpiarPantalla
		PrimerNum:
			mov EsNeg,0
			limpiarPantalla
			imprime numero
			mov ah,01h
			int 21h
			cmp al,97d
			je ANTERIOR1
			cmp al,45d
			jne COMPEN
			mov EsNeg,1
		
		ESN1:
			mov ah,01h
			int 21h

		COMPEN:
			cmp al,47d
			jle PrimerNum
			cmp al,58d
			jge PrimerNum
			sub al,30h
			mov Decena,al
			mov ah,01h	;unidades
			int 21h	
			cmp al,47d
			jle PrimerNum
			cmp al,58d
			jge PrimerNum
			sub al,30h
			mov Unidad,al
			
			mov al,Decena
			mul diez
			add al,Unidad
			mov N1,al
			cmp EsNeg,1
			jne OperadorA
			mov al,0
			sub al,N1

			mov N1,al
			jmp OperadorA

		ANTERIOR1:
			mov al,ConstanteA
			mov N1,al
			jmp OperadorA

		OperadorA:
			imprime espacio
			imprime operador
			mov ah,01h
			int 21h
			cmp al,43d
			jne SIGMEN
			mov operando,1
			jmp SEGUNDONUM

		SIGMEN:
			cmp al,45d
			jne SIGPOR
			mov operando,2
			jmp SEGUNDONUM

		SIGPOR:
			cmp al,42d
			jne SIGDIV
			mov operando,3
			jmp SEGUNDONUM

		SIGDIV:
			cmp al,47d
			jne OperadorA
			mov operando,4
			jmp SegundoNum

		SEGUNDONUM:
			mov EsNeg,0
			imprime espacio
			imprime numero
			mov ah,01h
			int 21h
			cmp al,97d ;letra aam
			je ANTERIOR2
			cmp al,45d ;negativo
			jne COMPEN2
			mov EsNeg,1

		ESN2:
			mov ah,01h
			int 21h

		COMPEN2:	
			cmp al,47d
			jle SegundoNum
			cmp al,58d
			jge SegundoNum
			sub al,30h
			mov Decena,al
			mov ah,01h	;unidades
			int 21h	
			cmp al,47d
			jle SegundoNum
			cmp al,58d
			jge SegundoNum
			sub al,30h
			mov Unidad,al
			
			mov al,Decena
			cmp al,0
			mul diez
			add al,Unidad
			mov N2,al
			cmp EsNeg,1
			jne SUMAR
			mov al,0
			sub al,N2
			;jns SUMAR
			;Imprimir TextoEsNeg
			mov N2,al
			jmp SUMAR
			
		ANTERIOR2:
			mov al,ConstanteA
			mov N2,al
			jmp SUMAR

		SUMAR:	
			cmp Operando,1
			jne	RESTAR
			mov BanderaNeg,0
			mov al,N1
			add al,N2
			jno C_1
			not al
			add al,1
			mul NEGAR
			imprime espacio
		C_1:
			mov ConstanteA,al
			mov Resultado,al
			jmp RES_OP
			
		RESTAR:
			cmp Operando,2
			jne	MULTIPLICAR
			mov BanderaNeg,0
			mov al,N1
			sub al,N2
			mov Resultado,al
			mov ConstanteA,al
			jmp RES_OP
			
		MULTIPLICAR:
			cmp Operando,3
			jne	DIVIDIR
			mov al,N1
			mul N2
			add al,0
			mov ConstanteA,al
			add al,0
			jns SOLO_GR
			not al
			add al,1
			mov BanderaNeg,1
			mov Resultado,al
			mul NEGAR
			mov ConstanteA,al
			jmp RES_OP
		SOLO_GR:
			mov Resultado,al
			mov ConstanteA,al
			;mov ConstanteA,al	
			jmp RES_OP
			
		DIVIDIR:
			mov BanderaNeg,0
		    mov al,N1
			add al,0
			jns CN2D
			not al
			add al,1
			mov N1,al
			mov BanderaNeg,1
			jmp CN2D
		CN2D:
			mov al,N2
			add al,0
			jns OPERAR_DV
			not al
			add al,1
			mov N2,al
			inc BanderaNeg
			cmp BanderaNeg,1
			je OPERAR_DV
			mov BanderaNeg,0
			jmp OPERAR_DV
			
		OPERAR_DV:
			mov al,N1
			idiv N2
			mov Resultado,al
			mov ConstanteA,al
			cmp BanderaNeg,1
			jne RES_OP
			mul NEGAR
			mov ConstanteA,al
			;mov ConstanteA,al	
			jmp RES_OP
			

		RES_OP:
			imprime espacio
			imprime result
			mov al,Resultado
			jns SEPARAR
			not al
			add al,1
			mov BanderaNeg,1 
		SEPARAR:
			aam
			mov Valor_u,al
			mov al,ah
			aam
			mov Valor_d,al
			mov al,ah
			aam
			mov Valor_c,al

			cmp BanderaNeg,1
			jne IMP_VALS
			imprime SignoMenos
		IMP_VALS:
			imprime_C Valor_C
			imprime_C Valor_D
			imprime_C Valor_U
			imprime espacio
			mov BanderaNeg,0 ;reiniciamos bandera
			jmp FIN_PNMC
			
		FIN_PNMC:
		ret
	PEDIR_NUMEROS endp

	;-------------------------------------Factorial--------------------------------------
	MOD_FACTORIAL proc
		mov si,0
		mov bx,0
		mov cx,0
		mov NFAC1,0
		mov NFAC2,0
		mov TXTF,0
		mov RESULT_FAC,0

		NUEVO_FAC:
			limpiarPantalla
			imprime TXTFACTORIAL
			mov ah,01h
			int 21h
			cmp al,48d
			jne NUEVO_FAC
			mov ah,01h
			int 21h
			cmp al,47d
			jle NUEVO_FAC
			cmp al,57d
			jge NUEVO_FAC
			sub al,30h
			mov NFAC1,al
			mov NFAC2,al

			imprime espacio
			imprime TXTOPFAC
			imprime_C NFAC1
			imprime SIGFAC
			imprime IGUAL
			imprime_C NFAC1
			mov al,NFAC1
			mov NFAC2,al
			mov al,NFAC2
			dec NFAC1
			cmp NFAC2,0
			jne ITERAR
			mov FAC_U,1

			imprime RetornoCarro
			imprime TXTOPFAC
			imprime_C NFAC2
			imprime SIGFAC
			imprime IGUAL
			imprime_C FAC_U
			imprime puntoComa
			jmp FIN_FAC2

		ITERAR:
			cmp NFAC1,0
			jle FIN_FAC
			mov al,NFAC2
			mul NFAC1
			jno CON_IT
			not al
			add al,1
			mul NEGAR

		CON_IT:
			mov NFAC2,al
			imprime ASTERISCO
			imprime_C NFAC1
			dec NFAC1
			jmp ITERAR

		FIN_FAC:
			imprime IGUAL
			mov al,NFAC2
			aam
			mov FAC_U,al
			mov al,ah
			aam
			mov FAC_D,al
			mov al,ah
			aam
			mov FAC_C,al
			mov al,ah
			aam
			mov FAC_M,al
			mov al,ah
			aam
			mov FAC_MM,al

			cmp NFAC2,208
			jne ES_SI
			mov FAC_M,0
			imprime_C FAC_M
			mov FAC_C,7
			imprime_C FAC_C
			mov FAC_D,2
			imprime_C FAC_D
			mov FAC_U,0
			imprime_C FAC_U
			imprime puntoComa
			jmp FIN_FAC2

		ES_SI:
			cmp NFAC2,176
			jne ES_MM
			mov FAC_M,5
			imprime_C FAC_M
			mov FAC_C,0
			imprime_C FAC_C
			mov FAC_D,4
			imprime_C FAC_D
			mov FAC_U,0
			imprime_C FAC_U
			imprime puntoComa
			jmp FIN_FAC2

		ES_MM:
			cmp NFAC2,128
			jne NORMAL
			mov FAC_MM,4
			imprime_C FAC_MM
			mov FAC_M,0
			imprime_C FAC_M
			mov FAC_C,3
			imprime_C FAC_C
			mov FAC_D,2
			imprime_C FAC_D
			mov FAC_U,0
			imprime_C FAC_U
			imprime puntoComa
			jmp FIN_FAC2

		NORMAL:
			imprime_C FAC_MM
			imprime_C FAC_M
			imprime_C FAC_C
			imprime_C FAC_D
			imprime_C FAC_U
			imprime puntoComa

		FIN_FAC2:
			imprime result
			imprime_C FAC_MM
			imprime_C FAC_M
			imprime_C FAC_C
			imprime_C FAC_D
			imprime_C FAC_U

		ret
	MOD_FACTORIAL endp


	CREARDOC proc
		mov ax,@data
		mov ds,ax
		mov ah,3ch
		mov cx,00
		lea dx,nombredocreporte
		int 21h
		
	CREARDOC endp

	end
	

