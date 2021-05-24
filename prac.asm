ImprimirFact macro mensaje
	push ax
	push dx
	mov ah,09h
	mov dx, offset mensaje
	int 21h
	pop dx
	pop ax
endm


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
	mov numfact[ 0 ],al
endm

.model small
.stack 
.data
.386


msg1 db 10,13,'Factorial: ','$'
msg2 db 10,13,'Resultado: ','$'
msg3 db 10,13,'Resultado: 1','$'
newline db '$'

potencias 		dd 10,1
numaux	 		db 2 dup ('0'),'$'
numstr2			db '  $'
num 			dd 0

Encabezado1  	db 10,13,'  UNIVERSIDAD DE SAN CARLOS DE GUATEMALA','$'
Encabezado2  	db 10,13,'  FACULTAD DE INGENIERIA','$'
Encabezado3  	db 10,13,'  ESCUELA DE CIENCIAS Y SISTEMAS','$'
Encabezado4  	db 10,13,'  ARQUITECTURA DE COMPUTADORAS Y ENSAMBLADORES 1 "A"','$'
Encabezado5	 	db 10,13,'  SEGUNDO SEMESTRE 2017','$'
Encabezado6	 	db 10,13,'  PRACTICA 2','$'
Encabezado7	 	db 10,13,'  Carlos Enrique Cante Lopez','$'
Encabezado8	 	db 10,13,'  2013-14448','$'
saltolinea 		db 10,13,' ','$'

car 			db 10,13,'carga ','$'
moca			db 10,13,'Calculadora','$'
facto 			db 10,13,'factorial','$'
repo 			db 10,13,'reporte','$'

msjSalir1		db 10,13,'Desea Salir al Menu Principal?','$'
msjSalir2		db 10,13,'1. Si','$'
msjSalir3		db 10,13,'2. No','$'

menu1 			db 10,13,'*****************************************************','$'
menu2 			db 10,13,'****************** MENU PRINCIPAL *******************','$'
menu3 			db 10,13,'*****************************************************','$'
menu4 			db 10,13,'**********  1. Cargar Archivo              **********','$'
menu5 			db 10,13,'**********  2. Modo Calculadora            **********','$'
menu6 			db 10,13,'**********  3. Factorial                   **********','$'
menu7 			db 10,13,'**********  4. Reporte                     **********','$'
menu8 			db 10,13,'**********  5. Salir                       **********','$'
menu9 			db 10,13,'*****************************************************','$'

menuop1 			db 10,13,'*****************************************************','$'
menuop2 			db 10,13,'***************** MENU OPERACIONES ******************','$'
menuop3 			db 10,13,'*****************************************************','$'
menuop4 			db 10,13,'**********  1. Resultado                   **********','$'
menuop5 			db 10,13,'**********  2. Notacion Perfija            **********','$'
menuop6 			db 10,13,'**********  3. Notacion Postfija           **********','$'
menuop7 			db 10,13,'**********  4. Salir                       **********','$'
menuop8 			db 10,13,'*****************************************************','$'

NotPos				db 10,13,'Notacion Postfija: ','$'


Pedir 				db 10,13,'Ingrese una opcion---------> ','$'
PedirRuta			db 10,13,'Ingrese la ruta del archivo-------->','$'
msjSatisfactorio 	db 10,13,'El proceso fue exitoso','$'
msjErrorLectura 	db 10,13,'Error en la lectura del archivo','$'
msjErrorEnCaracter 	db 10,13,'Error en caracter del archivo','$'
msjCaracterAceptado db 10,13,'Caracter Aceptado','$'



msjcalc1			db 10,13,'Ingrese el primer numero: ','$'
msjcalc2			db 10,13,'Ingrese el operador: ','$'
msjcalc3			db 10,13,'Ingrese el segundo numero: ','$'
msjcalc4			db 10,13,'El resultado es: ','$'


factmsjini  		db 10,13,'Operaciones:','$'
factmsj0			db 10,13,'		0!=1;','$'
factmsj1			db 10,13,'		1!=1;','$'
factmsj2			db 10,13,'		2!=1*2=2;','$'
factmsj3			db 10,13,'		3!=1*2*3=6;','$'
factmsj4			db 10,13,'		4!=1*2*3*4=24;','$'
factmsj5			db 10,13,'		5!=1*2*3*4*5=120;','$'
factmsj6			db 10,13,'		6!=1*2*3*4*5*6=720;','$'
factmsj7			db 10,13,'		7!=1*2*3*4*5*6*7=5040;','$'
factmsj8			db 10,13,'		8!=1*2*3*4*5*6*7*8=40320;','$'




nombrearchivo 		db 100 dup('$')



nreporte 			db 	'Reporte.txt', 0 													
bufer				db 50 dup(?)
contenido 			db 100 dup('$')
oppfija 			db 100 dup('$')

numfact				db 10 dup('$')


handle 				dw ?



.code


.startup
main proc

LimpiarPantalla

Inicio:
				LimpiarPantalla
				call MenuPrincipal
				return:
				ImprimirCadena Pedir
				CapturaTeclado

				cmp al,49 
				je Carga 

				cmp al,50 
				je Calculadora

				cmp al,51 
				je Factorial

				cmp al,52
				je Reporte

				cmp al,53
				je Salir
				
				jmp Inicio


;********************************************CODIGO DEL MODO CARGA DE ARCHIVO***********************************************

Carga:	

		ObtenerRuta:
					;----------------------Mostrar mensajes para pedir la ruta del archivo-----------------------
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

					;************************Verificar estructura de la ruta ingresada*******************************************

					VerEstructura:
								CapturaTeclado
								cmp al,35			;comparacion con #
								jne ObtenerRuta

								CapturaTeclado
								cmp al,35
								jne ObtenerRuta		;comparacion con el segundo #

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
								cmp al,97
								jne ObtenerRuta
								mov nombrearchivo[ si ], al
								inc si

								CapturaTeclado
								cmp al, 114
								jne ObtenerRuta
								mov nombrearchivo[ si ], al
								inc si

								CapturaTeclado
								cmp al, 113
								jne ObtenerRuta
								mov nombrearchivo[ si ], al
								inc si

					finarchivo:
								CapturaTeclado
								cmp al, 35
								jne ObtenerRuta

								CapturaTeclado
								cmp al, 35
								jne ObtenerRuta


					;**************************Carga del archivo a memoria cuando la ruta es correcta****************************
					VerificarExistencia:
								mov ah, 3dh
								lea dx, nombrearchivo
								mov al, 0
								int 21h
								jc ObtenerRuta
								mov handle, ax
								ImprimirCadena msjSatisfactorio
								jmp Analizar

					;***********************Lectura y giardado del archivo******************************************************
		Analizar:
					ImprimirCadena saltolinea
					xor si, si

					leercaracter:
								mov ah, 3fh
								mov bx, handle
								lea dx, bufer
								mov cx, 1
								int 21h
								jc ObtenerRuta

								cmp ax, 00
								jz ErrorLectura

								mov dl, bufer
								cmp dl, 1ah
								jz ErrorLectura

								EsNumero:
										cmp dl, 48
										je AceptarCaracter

										cmp dl, 49
										je AceptarCaracter

										cmp dl, 50
										je AceptarCaracter

										cmp dl, 51
										je AceptarCaracter

										cmp dl, 52
										je AceptarCaracter

										cmp dl, 53
										je AceptarCaracter

										cmp dl, 54
										je AceptarCaracter

										cmp dl, 55
										je AceptarCaracter

										cmp dl, 56
										je AceptarCaracter

										cmp dl, 57
										je AceptarCaracter

								EsEspacio:
										cmp dl, 32
										je AceptarCaracter

								EsSignoDeOperacion:
										cmp dl, 42
										je AceptarCaracter

										cmp dl, 43
										je AceptarCaracter

										cmp dl, 45
										je AceptarCaracter

										cmp dl, 47
										je AceptarCaracter

								EsFinaldeArchivo:
										cmp dl, 59
										je ExitoAlLeer

										jmp ErrorCaracter

								AceptarCaracter:
										mov contenido[ si ], dl
										inc si
										jmp leercaracter



		ErrorLectura:
				ImprimirCadena msjErrorLectura
				jmp Salir

		ErrorCaracter:
				ImprimirCadena msjErrorEnCaracter
				jmp Salir

		ExitoAlLeer:
				mov contenido[ si ], dl
				

				call MenuArchivo

		InicioArchivo:

				xor si,si

				ImprimirCadena Pedir

				CapturaTeclado

				cmp al,49 
				je ResultadoArchivo 

				cmp al,50 
				je PrefijaArchivo

				cmp al,51 
				je PostfijaArchivo

				cmp al,52
				je Inicio

				jmp ExitoAlLeer



				ResultadoArchivo:


							jmp Salir


				PrefijaArchivo:

							jmp Salir


				PostfijaArchivo:

						LimpiarPostFija:
								mov oppfija[ si ], 0
								inc si
								cmp si, 99
								jne LimpiarPostFija

						xor si, si ;reiniciar contador si
						xor di, di ;reiniciar contador di

						xor dx,dx
						mov dl, 36
						push dx

						PasarPfija:

						xor dx,dx
						mov dl, contenido[ si ]

									EsNumeroPfija:
										cmp dl, 48
										je IngresarNumero

										cmp dl, 49
										je IngresarNumero

										cmp dl, 50
										je IngresarNumero

										cmp dl, 51
										je IngresarNumero

										cmp dl, 52
										je IngresarNumero

										cmp dl, 53
										je IngresarNumero

										cmp dl, 54
										je IngresarNumero

										cmp dl, 55
										je IngresarNumero

										cmp dl, 56
										je IngresarNumero

										cmp dl, 57
										je IngresarNumero

										cmp dl, 32
										je IngresarEspacio

									EsOperadorPfija:
										pop ax
										cmp ax, 36
										je EstaVacia

													SiEsMayorPrecdencia:
															EsPor:

																cmp dl, 42 ;si es *
																jne EsDiv
																cmp ax, 43 ; si es +
																je IngresarSigno

																cmp ax, 45 ; si es -
																je IngresarSigno

																cmp ax, 47 ; si es /
																je CambiarOperador

																cmp ax, 42 ; si es *
																je CambiarOperador



															EsDiv:
																cmp dl, 47 ;si es /
																jne SiEsMenorPrecendencia
																cmp ax, 43 ; si es +
																je IngresarSigno

																cmp ax, 45 ; si es -
																je IngresarSigno

																cmp ax, 42 ; si es *
																je CambiarOperador

																cmp ax, 47 ;si es /
																je CambiarOperador



													SiEsMenorPrecendencia:
															EsMas:

																cmp dl, 43 ;si es +
																jne EsMenos
																cmp ax, 42 ;si es *
																je SacarSimbolos
																cmp ax, 47 ; si es /
																je SacarSimbolos

																cmp ax, 43 ; si es +
																je CambiarOperador

																cmp ax, 45 ; si es -
																je CambiarOperador

															EsMenos:

																cmp dl, 45 ;si es -
																jne EsFin
																cmp ax, 42 ;si es *
																je SacarSimbolos
																cmp ax, 47 ; si es /
																je SacarSimbolos

																cmp ax, 43 ; si es +
																je CambiarOperador

																cmp ax, 45 ; si es -
																je CambiarOperador

															EsFin:
																cmp dl, 59
																je VaciarPila


																jmp Salir

															VaciarPila:
																mov oppfija[ di ], 32
																inc di
																mov oppfija[ di ], al
																inc di
																xor ax, ax
																pop ax
																cmp ax, 36
																jne VaciarPila
																ImprimirCadena NotPos
																ImprimirCadena oppfija
																jmp InicioArchivo

										
										

						EstaVacia:
									push ax
									push dx
									inc si
									jmp PasarPfija


						IngresarNumero:
									mov oppfija[ di ], dl
									inc di
									inc si
									jmp PasarPfija

						IngresarSigno:
									push ax
									push dx
									inc si
									jmp PasarPfija

						CambiarOperador:
									mov oppfija[ di ], al
									inc di
									mov oppfija[ di ], 32
									push dx
									inc si
									inc di
									jmp PasarPfija

						SacarSimbolos:
									mov oppfija[ di ], al
									inc di
									mov oppfija[ di ], 32
									inc di
									pop ax
									cmp ax, 36
									jne SacarSimbolos
									push ax
									push dx
									inc si
									jmp PasarPfija

						IngresarEspacio:
									cmp oppfija[ di - 1 ],32
									je NoIngresarEspacio
									mov oppfija[ di ], dl
									inc di
									inc si
									jmp PasarPfija

						NoIngresarEspacio:
									inc si
									jmp PasarPfija

							jmp Salir




;*******************************************CODIGO DEL MODO CALCULADORA*******************************************************

				

Calculadora:
			ImprimirCadena msjcalc1
			call ObDig
			mov ebx, num

			ImprimirCadena msjcalc2
			CapturaTeclado



			cmp al, 43 ;suma
			je Suma

			cmp al, 45 ;resta 
			je Resta

			cmp al, 42 ;multi
			je Multiplicacion

			cmp al, 47 ; divicion
			je Divicion 

			jmp Calculadora


								Suma:
									ImprimirCadena msjcalc3
									call ObDig
									add ebx,num
									mov num,ebx
									ImprimirCadena msjcalc4
									call Res



									jmp OpSalirCalc

								Resta:
									ImprimirCadena msjcalc3
									call ObDig
									sub ebx, num
									mov num,ebx
									ImprimirCadena msjcalc4
									call Res

									jmp OpSalirCalc

								Multiplicacion:
									ImprimirCadena msjcalc3
									call ObDig
									mov eax, num
									mul ebx
									mov num,eax
									ImprimirCadena msjcalc4
									call Res

									jmp OpSalirCalc


								Divicion:
									ImprimirCadena msjcalc3
									call ObDig
									mov eax,ebx
									mov ebx,num
		
									div ebx		
									mov num, eax	
									mov ebx, edx

									ImprimirCadena msjcalc4
									call Res



									jmp OpSalirCalc






			ObDig:
				xor si, si


				L:
					mov numaux[ si ],'0'
					inc si
					cmp si, 2
					jne L


					xor si, si

				ObtenerCaracter:
					CapturaTeclado
					cmp al, 65
					je ANS
					
					mov num,0
					mov numaux[ si ], al
					inc si
					cmp si, 2
					jne ObtenerCaracter

					xor si, si
					xor di, di

					Co:
						sub EDX,EDX
						mov EAX,0
						mov al,numaux[ si ]
						sub EAX,48
						mov ecx,potencias[ di ]
						mul ecx
						add num,EAX
						inc si
						add di,4
						cmp si,2
						jne Co
						ret

				



				Res:
					mov si,0     ;convierte de numero a cadena
					mov di,0
					mov EAX,num
					Res2:
						mov EDX,0
						div potencias[ di ]
						add EAX,48
						mov numstr2[ si ],al
						mov EAX,EDX
						inc si
						add di,4
						cmp si,2
						jne Res2
		
						ImprimirCadena numstr2
						ret


				jmp Salir

				OpSalirCalc:
							ImprimirCadena msjSalir1
							ImprimirCadena msjSalir2
							ImprimirCadena msjSalir3
							ImprimirCadena Pedir
							CapturaTeclado

							cmp al, 49
							je Inicio

							cmp al, 50
							je Calculadora

							jmp OpSalirCalc

				ANS:
					CapturaTeclado
					cmp al, 78
					je ANS2

				ANS2:
					CapturaTeclado
					cmp al, 83
					je ANS3

				ANS3:
					ret












Factorial:

				ImprimirFact msg1
				ImprimirFact newline
				call IngrearNumeroenAX
				
				mov cx, ax
				mov ax, 01
				


				ack1:
					mul cx
					dec cx
					jz done
					jmp ack1
					ImprimirFact newline
				done:
				xor si, si
					cmp numfact[ si ], 48
					je Fact0
					cmp numfact[ si ], 49
					je Fact1
					cmp numfact[ si ], 50
					je Fact2
					cmp numfact[ si ], 51
					je Fact3
					cmp numfact[ si ], 52
					je Fact4
					cmp numfact[ si ], 53
					je Fact5
					cmp numfact[ si ], 54
					je Fact6
					cmp numfact[ si ], 55
					je Fact7
					cmp numfact[ si ], 56
					je Fact8
				regresar:

					ImprimirFact msg2
					call MostrarAX

					jmp return

				IngrearNumeroenAX PROC NEAR 
					push bx
					push cx
					mov cx, 10
					mov bx, 00
					xor si, si
					back:
						mov ah, 01h
						int 21h
						
						cmp al, '0'
						jb skip
						cmp al, '9'
						ja skip
						mov numfact[ si ], al
						inc si
						sub al, '0'
						push ax
						mov ax, bx
						mul cx
						mov bx, ax
						pop ax
						mov ah,00
						add bx,ax

					skip:
						mov ax, bx
						pop cx
						pop bx
						ret

				

				IngrearNumeroenAX endp

				MostrarAX PROC NEAR
					push dx
					push cx
					push bx
					push ax

					mov cx, 0
					mov bx, 10

					back1:
						mov dx, 0
						div bx
						push dx
						inc cx
						or ax, ax
						jnz back1

					back2:
						pop dx
						add dl, 30h
						mov ah, 02h
						int 21h

						loop back2
						pop ax
						pop bx
						pop cx
						pop dx
						ret
				MostrarAX endp




				jmp Salir
							Fact0:
								ImprimirFact factmsjini
								ImprimirFact factmsj0
								ImprimirFact msg3

								jmp return
							Fact1:
								ImprimirFact factmsjini
								ImprimirFact factmsj0
								ImprimirFact factmsj1
								jmp regresar
							Fact2:
								ImprimirFact factmsjini
								ImprimirFact factmsj0
								ImprimirFact factmsj1
								ImprimirFact factmsj2
								jmp regresar
							Fact3:
								ImprimirFact factmsjini
								ImprimirFact factmsj0
								ImprimirFact factmsj1
								ImprimirFact factmsj2
								ImprimirFact factmsj3
								jmp regresar
							Fact4:
								ImprimirFact factmsjini
								ImprimirFact factmsj0
								ImprimirFact factmsj1
								ImprimirFact factmsj2
								ImprimirFact factmsj3
								ImprimirFact factmsj4
								jmp regresar

							Fact5:
								ImprimirFact factmsjini
								ImprimirFact factmsj0
								ImprimirFact factmsj1
								ImprimirFact factmsj2
								ImprimirFact factmsj3
								ImprimirFact factmsj4
								ImprimirFact factmsj5
								jmp regresar
							Fact6:
								ImprimirFact factmsjini
								ImprimirFact factmsj0
								ImprimirFact factmsj1
								ImprimirFact factmsj2
								ImprimirFact factmsj3
								ImprimirFact factmsj4
								ImprimirFact factmsj5
								ImprimirFact factmsj6
								jmp regresar
							Fact7:
								ImprimirFact factmsjini
								ImprimirFact factmsj0
								ImprimirFact factmsj1
								ImprimirFact factmsj2
								ImprimirFact factmsj3
								ImprimirFact factmsj4
								ImprimirFact factmsj5
								ImprimirFact factmsj6
								ImprimirFact factmsj7
								jmp regresar
							Fact8:
								ImprimirFact factmsjini
								ImprimirFact factmsj0
								ImprimirFact factmsj1
								ImprimirFact factmsj2
								ImprimirFact factmsj3
								ImprimirFact factmsj4
								ImprimirFact factmsj5
								ImprimirFact factmsj6
								ImprimirFact factmsj7
								ImprimirFact factmsj8
								jmp regresar


				

Reporte:
				mov ax, @data										;En esta parte se crea el archivo reporte.txt
				mov ds, ax											;
				mov ah, 3ch
				mov cx, 0
				mov dx, offset nreporte
				int 21h
				jc Salir
				mov bx, ax
				mov ah, 3eh
				int 21h												; aca finaliza la creacion del archivo
				jmp Inicio

Salir:
				finalizar

MenuPrincipal:
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
				ImprimirCadena saltolinea
				ret

				finalizar

MenuArchivo:
				LimpiarPantalla
				ImprimirCadena menuop1
				ImprimirCadena menuop2
				ImprimirCadena menuop3
				ImprimirCadena menuop4
				ImprimirCadena menuop5
				ImprimirCadena menuop6
				ImprimirCadena menuop7
				ImprimirCadena menuop8
				ImprimirCadena saltolinea
				ret
				finalizar



main endp
end

