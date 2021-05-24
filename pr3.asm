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

pixel macro coox, cooy, color  
	mov ecx, coox
	mov edx, cooy
	mov ah, 0ch
	mov al, color
	int 10h
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

hayfuncion dd 0


;-----------------------------------------------COEFICIENTES DE LA FUNCION ORIGINAL--------------------------------------------------
coeficiente0	db 43,48,'$'
coeficiente1	db 43,48,'$' ;45 negativo
coeficiente2	db 43,48,'$'
coeficiente3	db 43,48,'$'
coeficiente4	db 43,48,'$'

num0 			dd 0
num1 			dd 0
num2 			dd 0
num3 			dd 0
num4 			dd 0

numGrafica4		dd 0
numGrafica3		dd 0
numGrafica2		dd 0
numGrafica1		dd 0
numGrafica0		dd 0

signoGrafica4   db 43
signoGrafica3   db 43
signoGrafica2   db 43
signoGrafica1   db 43
signoGrafica0   db 43

foriginal db 50 dup('$')


;------------------------------------------------COEFICIENTES DE LA DERIVADA----------------------------------------------------------

coefDerivada1	db 43,48,'$'
coefDerivada2	db 43,48,'$'
coefDerivada3	db 43,48,'$'
coefDerivada0	db 43,48,'$'

numDerivada1	dd 0
numDerivada2	dd 0
numDerivada3	dd 0
numDerivada0	dd 0


;------------------------------------------------COEFICIENTES DE LA INTEGRAL----------------------------------------------------------

coefIntegral0	db 43,48,'\',48,'$'
coefIntegral1	db 43,48,'\',48,'$'
coefIntegral2	db 43,48,'\',48,'$'
coefIntegral3	db 43,48,'\',48,'$'
coefIntegral4	db 43,48,'\',48,'$'
coefIntegral5	db 43,48,'\',48,'$'

numIntegral0	dd 0
numIntegral1	dd 0
numIntegral2	dd 0
numIntegral3	dd 0
numIntegral4	dd 0
numIntegral5	dd 0


;------------------------------------------------MENSAJES DE USO GENERAL--------------------------------------------------------------

Encabezado1  	db 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA','$'						;39
Encabezado2  	db 10,13,'FACULTAD DE INGENIERIA','$'								;25
Encabezado3  	db 10,13,'ESCUELA DE CIENCIAS Y SISTEMAS','$'						;33
Encabezado4  	db 10,13,'ARQUITECTURA DE COMPUTADORAS Y ENSAMBLADORES 1 "A"','$'	;53
Encabezado5	 	db 10,13,'SEGUNDO SEMESTRE 2017','$'								;24
Encabezado6	 	db 10,13,'PRACTICA 3','$'											;13
Encabezado7	 	db 10,13,'Carlos Enrique Cante Lopez','$'							;29
Encabezado8	 	db 10,13,'2013-14448','$'											;13
saltolinea 		db 10,13,'$'

menu1 			db 10,13,'*****************************************************','$'
menu2 			db 10,13,'****************** MENU PRINCIPAL *******************','$'
menu3 			db 10,13,'*****************************************************','$'
menu4 			db 10,13,'**********  1. Ingresar Funcion f(x)       **********','$'
menu5 			db 10,13,'**********  2. Funcion en Memoria          **********','$'
menu6 			db 10,13,'**********  3. Derivada f', 39 ,'(x)              **********','$'
menu7 			db 10,13,'**********  4. Integral F(x)               **********','$'
menu8 			db 10,13,'**********  5. Graficar Funciones          **********','$'
menu9 			db 10,13,'**********  6. Reporte                     **********','$'
menu10 			db 10,13,'**********  7. Salir                       **********','$'
menu11			db 10,13,'*****************************************************','$'

msjingreso0		db 10,13,'Coeficiente de x0: ','$'
msjingreso1		db 10,13,'Coeficiente de x1: ','$'
msjingreso2		db 10,13,'Coeficiente de x2: ','$'
msjingreso3		db 10,13,'Coeficiente de x3: ','$'
msjingreso4		db 10,13,'Coeficiente de x4: ','$'

msjfx			db 10,13,'f(x) = ','$'
msjfpx 			db 10,13,'f', 39 ,'(x) = ','$'
msjfix			db 10,13,'F(x) = ','$'

menugraficador1 			db 10,13,'*****************************************************','$'
menugraficador2 			db 10,13,'****************** MENU GRAFICADOR ******************','$'
menugraficador3 			db 10,13,'*****************************************************','$'
menugraficador4 			db 10,13,'**********  1. Graficar Original f(x)      **********','$'
menugraficador5 			db 10,13,'**********  2. Graficar Derivada f', 39 ,'(x)     **********','$'
menugraficador6 			db 10,13,'**********  3. Graficar Integral F(x)      **********','$'
menugraficador7 			db 10,13,'**********  4. Regresar                    **********','$'
menugraficador8				db 10,13,'*****************************************************','$'

msjintervaloinicial	db 10,13,'Ingrese el valor incial del intervalo: ','$'
msjintervalofinal	db 10,13,'Ingrese el valor final del intervalo: ','$'

PedirOpcion 		db 10,13,'Ingrese una opcion---------> ','$'

exito 			db 10,13,'El proceso ha sido exitoso','$'

msjIngresoFallido db 10,13,'El Valor Ingresado no es un Numero o le falta el signo','$'
msjregresar		db 10,13,'Percione cualquier tecla para regresar al menu principal','$'
msjNohayFuncion db 10,13,'Aun no se ha ingresado una funcion f(x)','$'

msjfmfx			db 'f(x) = ','$'
msjfmx5			db '*x5','$'
msjfmx4			db '*x4','$'
msjfmx3			db '*x3','$'
msjfmx2			db '*x2','$'
msjfmx1			db '*x','$'

constanteintergral db '+ c','$'


reportepractican3 db 10,13,'REPORTE PRACTICA NO.3','$'
funcionoriginal db 10,13,'Funcion Original','$'
funcionderivada db 10,13,'Funcion Derivada','$'
funcionintergral db 10,13,'Funcion Integral','$'
reporteexitoso db 10,13,'Se ha generado el reporte con exito!!!!'


espacio			db ' ','$'

valor 			dd 0
numx			dd 0

x  				dd 0
y 				dd 0

nombre 			db 		'REPORTE.TXT',0
archFuncionOriginal db 'ORIGINAL.TXT',0
archFuncionDerivada db 'DERIVADA.TXT',0
archFuncionIntergral db 'INTEGRAL.TXT',0
maneja   		dw     ?

.code

.startup
main proc

LimpiarPantalla
mov hayfuncion, 0

MenuInicial:
		LimpiarPantalla
		call ImprimirMenuInicial

		return:
				ImprimirCadena PedirOpcion
				CapturaTeclado

				cmp al,49 
				je IngresarFuncion

				cmp al,50 
				je FuncionEnMemoria

				cmp al,51 
				je Derivada

				cmp al,52
				je Integral

				cmp al,53
				je GraficarFunciones

				cmp al,54
				je Reporte

				cmp al,55
				je Salir
				
				jmp MenuInicial

IngresarFuncion:
		mov hayfuncion, 1
		xor si, si
		LimpiarCoef:
				mov coeficiente4[ si ],0
				mov coeficiente3[ si ],0
				mov coeficiente2[ si ],0
				mov coeficiente1[ si ],0
				mov coeficiente0[ si ],0
				inc si
				cmp si, 2
				je con
				jmp LimpiarCoef

				con:
				ImprimirCadena msjingreso4
				CapturaTeclado
				cmp al, 43
				je SaveCoeficiente4
				cmp al, 45
				je SaveCoeficiente4
				cmp al, 48
				je cof40

				ImprimirCadena msjIngresoFallido

				jmp IngresarFuncion

				SaveCoeficiente4:

					mov coeficiente4[ 0 ], al
					CapturaTeclado
					cmp al, 48
					je GuardarNumero4 
					cmp al, 49
					je GuardarNumero4
					cmp al, 50
					je GuardarNumero4
					cmp al, 51
					je GuardarNumero4
					cmp al, 52
					je GuardarNumero4
					cmp al, 53
					je GuardarNumero4
					cmp al, 54
					je GuardarNumero4
					cmp al, 55
					je GuardarNumero4
					cmp al, 56
					je GuardarNumero4
					cmp al, 57
					je GuardarNumero4

					ImprimirCadena msjIngresoFallido

					jmp IngresarFuncion


					GuardarNumero4:

						mov coeficiente4[ 1 ], al
						sub EDX, EDX
						mov EAX, 0
						mov al, coeficiente4[ 1 ]
						sub EAX, 48
						mov num4, 0
						add num4, EAX

						jmp SaveCoeficiente3

					cof40:
						mov coeficiente4[ 1 ], al
						mov num4, 0
						jmp SaveCoeficiente3


				SaveCoeficiente3: 
					ImprimirCadena msjingreso3
					CapturaTeclado
					cmp al, 43
					je cof3
					cmp al, 45
					je cof3
					cmp al, 48
					je cof30

					ImprimirCadena msjIngresoFallido

					jmp SaveCoeficiente3

					cof3:

						mov coeficiente3[ 0 ], al
						CapturaTeclado
						cmp al, 48
						je GuardarNumero3 
						cmp al, 49
						je GuardarNumero3
						cmp al, 50
						je GuardarNumero3
						cmp al, 51
						je GuardarNumero3
						cmp al, 52
						je GuardarNumero3
						cmp al, 53
						je GuardarNumero3
						cmp al, 54
						je GuardarNumero3
						cmp al, 55
						je GuardarNumero3
						cmp al, 56
						je GuardarNumero3
						cmp al, 57
						je GuardarNumero3

						ImprimirCadena msjIngresoFallido

						jmp SaveCoeficiente3

						GuardarNumero3:

							mov coeficiente3[ 1 ], al
							sub EDX, EDX
							mov EAX, 0
							mov al, coeficiente3[ 1 ]
							sub EAX, 48
							mov num3, 0
							add num3, EAX

							jmp SaveCoeficiente2

					cof30:
						mov coeficiente3[ 1 ], al
						mov num3, 0
						jmp SaveCoeficiente2

				SaveCoeficiente2:
					ImprimirCadena msjingreso2
					CapturaTeclado
					cmp al, 43
					je cof2
					cmp al, 45
					je cof2
					cmp al, 48
					je cof20

					ImprimirCadena msjIngresoFallido

					jmp SaveCoeficiente2

					cof2:

						mov coeficiente2[ 0 ], al
						CapturaTeclado
						cmp al, 48
						je GuardarNumero2 
						cmp al, 49
						je GuardarNumero2
						cmp al, 50
						je GuardarNumero2
						cmp al, 51
						je GuardarNumero2
						cmp al, 52
						je GuardarNumero2
						cmp al, 53
						je GuardarNumero2
						cmp al, 54
						je GuardarNumero2
						cmp al, 55
						je GuardarNumero2
						cmp al, 56
						je GuardarNumero2
						cmp al, 57
						je GuardarNumero2

						ImprimirCadena msjIngresoFallido

						jmp SaveCoeficiente2

						GuardarNumero2:

							mov coeficiente2[ 1 ], al
							sub EDX, EDX
							mov EAX, 0
							mov al, coeficiente2[ 1 ]
							sub EAX, 48
							mov num2, 0
							add num2, EAX

							jmp SaveCoeficiente1

					cof20:
						mov coeficiente2[ 1 ], al
						mov num2, 0
						jmp SaveCoeficiente1
						

				SaveCoeficiente1:
					ImprimirCadena msjingreso1
					CapturaTeclado
					cmp al, 43
					je cof1
					cmp al, 45
					je cof1
					cmp al, 48
					je cof10

					ImprimirCadena msjIngresoFallido

					jmp SaveCoeficiente1

					cof1:

						mov coeficiente1[ 0 ], al
						CapturaTeclado
						cmp al, 48
						je GuardarNumero1 
						cmp al, 49
						je GuardarNumero1
						cmp al, 50
						je GuardarNumero1
						cmp al, 51
						je GuardarNumero1
						cmp al, 52
						je GuardarNumero1
						cmp al, 53
						je GuardarNumero1
						cmp al, 54
						je GuardarNumero1
						cmp al, 55
						je GuardarNumero1
						cmp al, 56
						je GuardarNumero1
						cmp al, 57
						je GuardarNumero1

						ImprimirCadena msjIngresoFallido

						jmp SaveCoeficiente1

						GuardarNumero1:				
							mov coeficiente1[ 1 ], al
							sub EDX, EDX
							mov EAX, 0
							mov al, coeficiente1[ 1 ]
							sub EAX, 48
							mov num1, 0
							add num1, EAX
							jmp SaveCoeficiente0

					cof10:
						mov coeficiente1[ 1 ], al
						mov num1, 0
						jmp SaveCoeficiente0


				SaveCoeficiente0:
					ImprimirCadena msjingreso0
					CapturaTeclado
					cmp al, 43
					je cof0
					cmp al, 45
					je cof0
					cmp al, 48
					je cof00

					ImprimirCadena msjIngresoFallido

					jmp SaveCoeficiente0

					cof0:

						mov coeficiente0[ 0 ], al
						CapturaTeclado
						cmp al, 48
						je GuardarNumero0
						cmp al, 49
						je GuardarNumero0
						cmp al, 50
						je GuardarNumero0
						cmp al, 51
						je GuardarNumero0
						cmp al, 52
						je GuardarNumero0
						cmp al, 53
						je GuardarNumero0
						cmp al, 54
						je GuardarNumero0
						cmp al, 55
						je GuardarNumero0
						cmp al, 56
						je GuardarNumero0
						cmp al, 57
						je GuardarNumero0

						ImprimirCadena msjIngresoFallido

						jmp SaveCoeficiente0

						GuardarNumero0:		
							mov coeficiente0[ 1 ], al
							sub EDX, EDX
							mov EAX, 0
							mov al, coeficiente0[ 1 ]
							sub EAX, 48
							mov num0, 0
							add num0, EAX
							jmp FinIngresoCoeficientes

					cof00:
						mov coeficiente0[ 1 ], al
						mov num0, 0
						jmp FinIngresoCoeficientes

				FinIngresoCoeficientes:
					ImprimirCadena exito
					ImprimirCadena msjregresar
					CapturaTeclado
					jmp MenuInicial
				jmp Salir

FuncionEnMemoria:
	cmp hayfuncion, 0
	je NoHayFuncion
				ImprimirCadena saltolinea
				ImprimirCadena msjfmfx

				cmp coeficiente4[ 1 ], 48
				je cont3
				ImprimirCadena coeficiente4
				ImprimirCadena msjfmx4
				ImprimirCadena espacio

				cont3:
				cmp coeficiente3[ 1 ], 48
				je cont2
				ImprimirCadena coeficiente3
				ImprimirCadena msjfmx3
				ImprimirCadena espacio

				cont2:
				cmp coeficiente2[ 1 ], 48
				je cont1
				ImprimirCadena coeficiente2
				ImprimirCadena msjfmx2
				ImprimirCadena espacio

				cont1:
				cmp coeficiente1[ 1 ], 48
				je cont0
				ImprimirCadena coeficiente1
				ImprimirCadena msjfmx1
				ImprimirCadena espacio

				cont0:				
				cmp coeficiente0[ 1 ], 48
				je return
				ImprimirCadena coeficiente0
				ImprimirCadena espacio

				jmp return

Derivada:
				cmp hayfuncion, 0
				je NoHayFuncion
				call HacerDerivada

				ImprimirCadena saltolinea
				ImprimirCadena msjfpx

				cmp coefDerivada3[ 1 ], 0
				je contder2
				ImprimirCadena coefDerivada3
				ImprimirCadena msjfmx3
				ImprimirCadena espacio

				contder2:
				cmp coefDerivada2[ 1 ], 0
				je contder1
				ImprimirCadena coefDerivada2
				ImprimirCadena msjfmx2
				ImprimirCadena espacio

				contder1:
				cmp coefDerivada1[ 1 ], 0
				je contder0
				ImprimirCadena coefDerivada1
				ImprimirCadena msjfmx1
				ImprimirCadena espacio

				contder0:
				cmp coefDerivada0[ 1 ], 0
				je return
				ImprimirCadena coefDerivada0



				jmp return



				jmp Salir

Integral:
		cmp hayfuncion, 0
		je NoHayFuncion

		call HacerIntegral

		ImprimirCadena saltolinea
		ImprimirCadena msjfix

		cmp coefIntegral5[ 1 ],0
		je contint4
		ImprimirCadena coefIntegral5
		ImprimirCadena msjfmx5
		ImprimirCadena espacio

		contint4:
		cmp coefIntegral4[ 1 ],0
		je contint3
		ImprimirCadena coefIntegral4
		ImprimirCadena msjfmx4
		ImprimirCadena espacio


		contint3:
		cmp coefIntegral3[ 1 ],0
		je contint2
		ImprimirCadena coefIntegral3
		ImprimirCadena msjfmx3
		ImprimirCadena espacio

		contint2:
		cmp coefIntegral2[ 1 ],0
		je contint1
		ImprimirCadena coefIntegral2
		ImprimirCadena msjfmx2
		ImprimirCadena espacio

		contint1:
		cmp coefIntegral1[ 1 ],0
		je contint0
		ImprimirCadena coefIntegral1
		ImprimirCadena msjfmx1
		ImprimirCadena espacio

		contint0:
		ImprimirCadena constanteintergral
		ImprimirCadena espacio



		jmp return

GraficarFunciones:
	cmp hayfuncion, 0
	je NoHayFuncion


	retrunGraficas:
		LimpiarPantalla
		call ImprimirMenuGraficas

		MenuGraficas:
			ImprimirCadena PedirOpcion
			CapturaTeclado

			cmp al,49 
			je GraficarOriginal

			cmp al,50 
			je GraficarDerivada

			cmp al,51 
			je GraficarIntegral

			cmp al,52
			je MenuInicial

			jmp MenuGraficas

			GraficarOriginal:
				;Iniciacion de modo video  
				mov ax, 0013h  
				int 10h 

 				call DibujarEjes

 				mov numx, 100
 				

 				ValuarFuncion: ;Prueba de -25 a 25
 					;parte negativa
 					

 					Negativa:
 						mov valor, 0
 						mulx4:
 							cmp num4, 0
 							je mulx3

 							Elevar4:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX
 								mul EBX
 								mul EBX

 								mov EBX, num4

 								mul EBX

 								cmp coeficiente4[ 0 ], 43
 								jne sumar4

 								add valor, EAX
 								jmp mulx3

 								sumar4:
 								sub valor, EAX



 						mulx3:
 							cmp num3, 0
							je mulx2
 							Elevar3:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX
 								mul EBX

 								mov EBX, num3

 								mul EBX

 								cmp coeficiente3[ 0 ], 43
 								jne restar3

 								sub valor, EAX
 								jmp mulx2

 								restar3:
 								add valor, EAX

 						mulx2:
 							cmp num2, 0
 							je mulx1
 							Elevar2:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX

 								mov EBX, EAX
 								mov EAX, num2

 								mul EBX

 								cmp coeficiente2[ 0 ], 43
 								jne restar2

 								add valor, EAX
 								jmp mulx1

 								restar2:
 								sub valor, EAX


 						mulx1:
 							cmp num1, 0
 							je SumarConstante

 								mov EAX, numx
 								mov EBX, num1

 								mul EBX

 								cmp coeficiente1[ 0 ], 43
 								jne sumar1

 								sub valor, EAX
 								jmp SumarConstante

 								sumar1: 

 								add valor, EAX


 						SumarConstante:
 								cmp num0, 0
 								je continuargraf

 								mov EAX, num0

 								cmp coeficiente0[ 0 ], 43
 								jne restarc

 								add valor, EAX
 								jmp continuargraf

 								restarc:
 								sub valor, EAX

 						continuargraf:
 								mov EAX,0
 								mov EBX,0
 								mov ECX,0
 								mov EDX,0

 								mov ECX, 100
 								mov EBX, numx
 								sub ECX, EBX
 								mov EAX, 1
 								mul ECX
 								mov x, EAX

 								cmp valor, 0
 								ja	grafpos		;positivo
 								jb 	grafneg		;negativo
 								je  co

 								grafpos:

 									
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp co

 								grafneg:
 									not valor
 									add valor, 1
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp co


 								co:
 								cmp y,0
 								jb	nocon
 								je gr
 								cmp y,200
 								ja nocon

 								gr:
 								add x, 60

 								pixel x, y, 15

 								nocon:

 								dec numx
 								cmp numx, 0
 								jne Negativa


 					mov numx, 1
 					mov EAX,0
 					mov EBX,0
 					mov ECX,0
 					mov EDX,0
 					Positiva:
 						mov valor, 0
 						mulx4p:
 							cmp num4, 0
 							je mulx3p

 							Elevar4p:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX
 								mul EBX
 								mul EBX

 								mov EBX, num4

 								mul EBX

 								cmp coeficiente4[ 0 ], 43
 								jne sumar4p

 								add valor, EAX
 								jmp mulx3p

 								sumar4p:
 								sub valor, EAX



 						mulx3p:
 							cmp num3, 0
							je mulx2p
 							Elevar3p:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX
 								mul EBX

 								mov EBX, num3

 								mul EBX

 								cmp coeficiente3[ 0 ], 43
 								jne restar3p

 								add valor, EAX
 								jmp mulx2p

 								restar3p:
 								sub valor, EAX

 						mulx2p:
 							cmp num2, 0
 							je mulx1p
 							Elevar2p:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX

 								mov EBX, EAX
 								mov EAX, num2

 								mul EBX

 								cmp coeficiente2[ 0 ], 43
 								jne restar2p

 								add valor, EAX
 								jmp mulx1p

 								restar2p:
 								sub valor, EAX


 						mulx1p:
 							cmp num1, 0
 							je SumarConstantep

 								mov EAX, numx
 								mov EBX, num1

 								mul EBX

 								cmp coeficiente1[ 0 ], 43
 								jne sumar1p

 								add valor, EAX
 								jmp SumarConstantep

 								sumar1p: 

 								sub valor, EAX


 						SumarConstantep:
 								cmp num0, 0
 								je continuargrafp

 								mov EAX, num0

 								cmp coeficiente0[ 0 ], 43
 								jne restarcp

 								add valor, EAX
 								jmp continuargrafp

 								restarcp:
 								sub valor, EAX

 						continuargrafp:
 								mov EAX,0
 								mov EBX,0
 								mov ECX,0
 								mov EDX,0

 								mov ECX, 100
 								mov EBX, numx
 								add ECX, EBX
 								mov EAX, 1
 								mul ECX
 								mov x, EAX

 								cmp valor, 0
 								ja	grafposp		;positivo
 								jb 	grafnegp		;negativo
 								je  cop

 								grafposp:

 									
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp cop

 								grafnegp:
 									
 									not valor
 									add valor, 1
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp cop


 								cop:
 								cmp y,0
 								jb	noconp
 								je grp
 								cmp y,200
 								ja noconp

 								grp:
 								add x, 60

 								pixel x, y, 15

 								noconp:

 								inc numx
 								cmp numx, 100
 								jne Positiva




 				auxiliar:
 				;Presiona una tecla para salir    
 				mov ah,10h    
 				int 16h  
 
 				;Regresar a modo texto  
 				mov ax,0003h    
 				int 10h 
 
 				;Salir del programa  mov ah,4ch  int 21h
				jmp retrunGraficas

			GraficarDerivada:
				call HacerDerivada
				mov ax, 0013h  
				int 10h 

 				call DibujarEjes

 				mov numx, 100
 				mov EAX,0
 				mov EBX,0
 				mov ECX,0
 				mov EDX,0

 				ValuarFuncionD: ;Prueba de -25 a 25
 					;parte negativa
 					

 					NegativaD:
 						mov valor, 0
 						
 						mulx3D:
 							cmp numDerivada3, 0
							je mulx2D
 							Elevar3D:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX
 								mul EBX

 								mov EBX, numDerivada3

 								mul EBX

 								cmp coefDerivada3[ 0 ], 43
 								jne restar3D

 								sub valor, EAX
 								jmp mulx2D

 								restar3D:
 								add valor, EAX

 						mulx2D:
 							cmp numDerivada2, 0
 							je mulx1D
 							Elevar2D:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX

 								mov EBX, EAX
 								mov EAX, numDerivada2

 								mul EBX

 								cmp coefDerivada2[ 0 ], 43
 								jne restar2D

 								add valor, EAX
 								jmp mulx1D

 								restar2D:
 								sub valor, EAX


 						mulx1D:
 							cmp numDerivada1, 0
 							je SumarConstanteD

 								mov EAX, numx
 								mov EBX, numDerivada1

 								mul EBX

 								cmp coefDerivada1[ 0 ], 43
 								jne sumar1D

 								sub valor, EAX
 								jmp SumarConstanteD

 								sumar1D: 

 								add valor, EAX


 						SumarConstanteD:
 								cmp numDerivada0, 0
 								je continuargrafD

 								mov EAX, numDerivada0

 								cmp coefDerivada0[ 0 ], 43
 								jne restarcD

 								add valor, EAX
 								jmp continuargrafD

 								restarcD:
 								sub valor, EAX

 						continuargrafD:
 								mov EAX,0
 								mov EBX,0
 								mov ECX,0
 								mov EDX,0

 								mov ECX, 100
 								mov EBX, numx
 								sub ECX, EBX
 								mov EAX, 1
 								mul ECX
 								mov x, EAX

 								cmp valor, 0
 								ja	grafposD		;positivo
 								jb 	grafnegD		;negativo
 								je  coD

 								grafposD:

 									
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp coD

 								grafnegD:
 									not valor
 									add valor, 1
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp coD


 								coD:
 								cmp y,0
 								jb	noconD
 								je grD
 								cmp y,200
 								ja noconD

 								grD:
 								add x, 60

 								pixel x, y, 15

 								noconD:

 								dec numx
 								cmp numx, 0
 								jne NegativaD


 					mov numx, 1
 					mov EAX,0
 					mov EBX,0
 					mov ECX,0
 					mov EDX,0
 					PositivaD:
 						mov valor, 0
 						
 						mulx3pD:
 							cmp numDerivada3, 0
							je mulx2pD
 							Elevar3pD:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX
 								mul EBX

 								mov EBX, numDerivada3

 								mul EBX

 								cmp coefDerivada3[ 0 ], 43
 								jne restar3pD

 								add valor, EAX
 								jmp mulx2pD

 								restar3pD:
 								sub valor, EAX

 						mulx2pD:
 							cmp numDerivada2, 0
 							je mulx1pD
 							Elevar2pD:
 								mov EAX, numx
 								mov EBX, numx

 								mul EBX

 								mov EBX, EAX
 								mov EAX, numDerivada2

 								mul EBX

 								cmp coefDerivada2[ 0 ], 43
 								jne restar2pD

 								add valor, EAX
 								jmp mulx1pD

 								restar2pD:
 								sub valor, EAX


 						mulx1pD:
 							cmp numDerivada1, 0
 							je SumarConstantepD

 								mov EAX, numx
 								mov EBX, numDerivada1

 								mul EBX

 								cmp coefDerivada1[ 0 ], 43
 								jne sumar1pD

 								add valor, EAX
 								jmp SumarConstantepD

 								sumar1pD: 

 								sub valor, EAX


 						SumarConstantepD:
 								cmp numDerivada0, 0
 								je continuargrafpD

 								mov EAX, numDerivada0

 								cmp coefDerivada0[ 0 ], 43
 								jne restarcpD

 								add valor, EAX
 								jmp continuargrafpD

 								restarcpD:
 								sub valor, EAX

 						continuargrafpD:
 								mov EAX,0
 								mov EBX,0
 								mov ECX,0
 								mov EDX,0

 								mov ECX, 100
 								mov EBX, numx
 								add ECX, EBX
 								mov EAX, 1
 								mul ECX
 								mov x, EAX

 								cmp valor, 0
 								ja	grafpospD		;positivo
 								jb 	grafnegpD		;negativo
 								je  copD

 								grafpospD:

 									
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp copD

 								grafnegpD:
 									
 									not valor
 									add valor, 1
 									mov EBX, 1
 									mov EAX, valor

 									mul EBX

 									mov EBX, 100
 									sub EBX, EAX
 									mov y, EBX

 									jmp copD


 								copD:
 								cmp y,0
 								jb	noconpD
 								je grpD
 								cmp y,200
 								ja noconpD

 								grpD:
 								add x, 60

 								pixel x, y, 15

 								noconpD:

 								inc numx
 								cmp numx, 100
 								jne PositivaD




 				auxiliarD:
 				;Presiona una tecla para salir    
 				mov ah,10h    
 				int 16h  
 
 				;Regresar a modo texto  
 				mov ax,0003h    
 				int 10h 

 				


				jmp retrunGraficas

			GraficarIntegral:
				jmp retrunGraficas




				jmp Salir

Reporte:
	cmp hayfuncion, 0
	je NoHayFuncion

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

    EscribirArchivo reportepractican3, maneja

    EscribirArchivo saltolinea, maneja
    EscribirArchivo saltolinea, maneja

    EscribirArchivo funcionoriginal, maneja

    EscribirArchivo msjfx, maneja

    			cmp coeficiente4[ 1 ], 48
				je cont3r
				EscribirArchivo coeficiente4, maneja
				EscribirArchivo msjfmx4, maneja
				EscribirArchivo espacio, maneja

				cont3r:
				cmp coeficiente3[ 1 ], 48
				je cont2r
				EscribirArchivo coeficiente3, maneja
				EscribirArchivo msjfmx3, maneja
				EscribirArchivo espacio, maneja

				cont2r:
				cmp coeficiente2[ 1 ], 48
				je cont1r
				EscribirArchivo coeficiente2, maneja
				EscribirArchivo msjfmx2, maneja
				EscribirArchivo espacio, maneja

				cont1r:
				cmp coeficiente1[ 1 ], 48
				je cont0r
				EscribirArchivo coeficiente1, maneja
				EscribirArchivo msjfmx1, maneja
				EscribirArchivo espacio, maneja

				cont0r:				
				cmp coeficiente0[ 1 ], 48
				je repcontder
				EscribirArchivo coeficiente0, maneja
				EscribirArchivo espacio, maneja

		repcontder:

		EscribirArchivo saltolinea, maneja

		EscribirArchivo funcionderivada, maneja
		EscribirArchivo msjfpx, maneja

				call HacerDerivada

				cmp coefDerivada3[ 1 ], 0
				je contder2r
				EscribirArchivo coefDerivada3, maneja
				EscribirArchivo msjfmx3, maneja
				EscribirArchivo espacio, maneja

				contder2r:
				cmp coefDerivada2[ 1 ], 0
				je contder1r
				EscribirArchivo coefDerivada2, maneja
				EscribirArchivo msjfmx2, maneja
				EscribirArchivo espacio, maneja

				contder1r:
				cmp coefDerivada1[ 1 ], 0
				je contder0r
				EscribirArchivo coefDerivada1, maneja
				EscribirArchivo msjfmx1, maneja
				EscribirArchivo espacio, maneja

				contder0r:
				cmp coefDerivada0[ 1 ], 0
				je repcontinter
				EscribirArchivo coefDerivada0, maneja

		repcontinter:

		EscribirArchivo saltolinea, maneja

		EscribirArchivo funcionintergral, maneja
		EscribirArchivo msjfix, maneja

				call HacerIntegral

				cmp coefIntegral5[ 1 ],0
				je contint4r
				EscribirArchivo coefIntegral5, maneja
				EscribirArchivo msjfmx5, maneja
				EscribirArchivo espacio, maneja

				contint4r:
				cmp coefIntegral4[ 1 ],0
				je contint3r
				EscribirArchivo coefIntegral4, maneja
				EscribirArchivo msjfmx4, maneja
				EscribirArchivo espacio, maneja


				contint3r:
				cmp coefIntegral3[ 1 ],0
				je contint2r
				EscribirArchivo coefIntegral3, maneja
				EscribirArchivo msjfmx3, maneja
				EscribirArchivo espacio, maneja

				contint2r:
				cmp coefIntegral2[ 1 ],0
				je contint1r
				EscribirArchivo coefIntegral2, maneja
				EscribirArchivo msjfmx2, maneja
				EscribirArchivo espacio, maneja

				contint1r:
				cmp coefIntegral1[ 1 ],0
				je contint0r
				EscribirArchivo coefIntegral1, maneja
				EscribirArchivo msjfmx1, maneja
				EscribirArchivo espacio, maneja

				contint0r:
				EscribirArchivo constanteintergral, maneja
				EscribirArchivo espacio, maneja




    mov    ah,3eh
    mov    bx,maneja
    int    21h

    ImprimirCadena reporteexitoso
    CapturaTeclado
	jmp return

slinea:
		mov    cx,1

		n:
			push   cx
         	mov    ah,40h
        	mov    bx,maneja
        	mov    cx,2
         	lea    dx,saltolinea
         	int    21h
         	pop    cx
         	loop   n
		ret

Salir:
				finalizar
	
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
				ImprimirCadena menu8
				ImprimirCadena menu9
				ImprimirCadena menu10
				ImprimirCadena menu11
				ImprimirCadena saltolinea
				ret 

ImprimirMenuGraficas:
	ImprimirCadena menugraficador1
	ImprimirCadena menugraficador2
	ImprimirCadena menugraficador3
	ImprimirCadena menugraficador4
	ImprimirCadena menugraficador5
	ImprimirCadena menugraficador6
	ImprimirCadena menugraficador7
	ImprimirCadena menugraficador8
	ImprimirCadena saltolinea
	ret

;-----------------------------------------------SEGMENTO ENCARGADO DE HACER LA DERIVADA DE LA FUNCION ORIGINAL-------------------------------------------------
HacerDerivada:
		mov coefDerivada3[ 0 ],43
		mov coefDerivada2[ 0 ],43
		mov coefDerivada1[ 0 ],43
		mov coefDerivada0[ 0 ],43

		mov coefDerivada3[ 1 ],0
		mov coefDerivada2[ 1 ],0
		mov coefDerivada1[ 1 ],0
		mov coefDerivada0[ 1 ],0

		mov numDerivada3, 0
		mov numDerivada2, 0
		mov numDerivada1, 0
		mov numDerivada0, 0


		Derivar4:
			cmp num4, 0
			je Derivar3
			mov EAX, num4
			mov EBX, 4
			mul EBX

			mov numDerivada3, EAX
			add EAX, 48
			mov coefDerivada3[ 1 ], al
			mov al, coeficiente4[ 0 ]
			mov coefDerivada3[ 0 ], al

		Derivar3:
			cmp num3, 0
			je Derivar2

			mov EAX, num3
			mov EBX, 3
			mul EBX

			mov numDerivada2, EAX
			add EAX, 48
			mov coefDerivada2[ 1 ], al
			mov al, coeficiente3[ 0 ]
			mov coefDerivada2[ 0 ], al

		Derivar2:
			cmp num2, 0
			je Derivar1

			mov EAX, num2
			mov EBX, 2
			mul EBX

			mov numDerivada1, EAX
			add EAX, 48
			mov coefDerivada1[ 1 ], al
			mov al, coeficiente2[ 0 ]
			mov coefDerivada1[ 0 ], al

		Derivar1:
			cmp num1, 0
			je FinDrivacion

			mov EAX, num1
			mov EBX, 1
			mul EBX

			mov numDerivada0, EAX
			add EAX, 48
			mov coefDerivada0[ 1 ], al
			mov al, coeficiente1[ 0 ]
			mov coefDerivada0[ 0 ], al

		FinDrivacion:
			ret 

HacerIntegral:
		mov coefIntegral5[ 0 ], 43
		mov coefIntegral4[ 0 ], 43
		mov coefIntegral3[ 0 ], 43
		mov coefIntegral2[ 0 ], 43
		mov coefIntegral1[ 0 ], 43
		mov coefIntegral0[ 0 ], 43

		mov coefIntegral5[ 1 ], 0
		mov coefIntegral4[ 1 ], 0
		mov coefIntegral3[ 1 ], 0
		mov coefIntegral2[ 1 ], 0
		mov coefIntegral1[ 1 ], 0
		mov coefIntegral0[ 1 ], 0

		mov coefIntegral5[ 3 ], 0
		mov coefIntegral4[ 3 ], 0
		mov coefIntegral3[ 3 ], 0
		mov coefIntegral2[ 3 ], 0
		mov coefIntegral1[ 3 ], 0
		mov coefIntegral0[ 3 ], 0

		mov numIntegral5, 0
		mov numIntegral4, 0
		mov numIntegral3, 0
		mov numIntegral2, 0
		mov numIntegral1, 0
		mov numIntegral0, 0

		Integrar4:
			cmp num4,0
			je Integrar3

			mov al,coeficiente4[ 0 ]
			mov coefIntegral5[ 0 ], al

			mov al,coeficiente4[ 1 ]
			mov coefIntegral5[ 1 ],al
			mov coefIntegral5[ 3 ],53

			;xor EAX, EAX
			;xor EBX, EBX

			;mov EAX, num4
			;mov EBX, 5

			;div EBX

			;mov numIntegral5, EAX

		Integrar3:
			cmp num3,0
			je Integrar2

			mov al,coeficiente3[ 0 ]
			mov coefIntegral4[ 0 ], al

			mov al,coeficiente3[ 1 ]
			mov coefIntegral4[ 1 ],al
			mov coefIntegral4[ 3 ],52

			;mov EAX, num3
			;mov EBX, 4

			;div EBX

			;mov numIntegral4, EAX

		Integrar2:
			cmp num2,0
			je Integrar1

			mov al,coeficiente2[ 0 ]
			mov coefIntegral3[ 0 ], al

			mov al,coeficiente2[ 1 ]
			mov coefIntegral3[ 1 ],al
			mov coefIntegral3[ 3 ],51

			;mov EAX, num2
			;mov EBX, 3

			;div EBX

			;mov numIntegral3, EAX

		Integrar1:
			cmp num1,0
			je Integrar0

			mov al,coeficiente1[ 0 ]
			mov coefIntegral2[ 0 ], al

			mov al,coeficiente1[ 1 ]
			mov coefIntegral2[ 1 ],al
			mov coefIntegral2[ 3 ],50

			;mov EAX, num1
			;mov EBX, 2

			;div EBX

			;mov numIntegral2, EAX

		Integrar0:
			cmp num0,0
			je FinIntegracion

			mov al,coeficiente0[ 0 ]
			mov coefIntegral1[ 0 ], al

			mov al,coeficiente0[ 1 ]
			mov coefIntegral1[ 1 ],al
			mov coefIntegral1[ 3 ],49

			;mov EAX, num0
			;mov EBX, 1

			;div EBX

			;mov numIntegral1, EAX

		FinIntegracion:

		ret

DibujarEjes:
	mov ecx, 0
	mov edx, 100

	ejex:
		pixel ecx, edx, 4fh
		inc ecx
		cmp ecx, 320
		jne ejex

	mov ecx, 160
	mov edx, 0

	ejey:
		pixel ecx, edx, 4fh
		inc edx
		cmp edx, 200
		jne ejey


 	ret

NoHayFuncion:
		ImprimirCadena msjNohayFuncion
		jmp return

main endp
end