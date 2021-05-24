; This program is free software: you can redistribute it 
; and/or modify it under the terms of the LGNU Lesser 
; General Public License as published by the Free Software 
; Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be 
; useful, but WITHOUT ANY WARRANTY; without even the 
; implied warranty of MERCHANTABILITY or FITNESS FOR A 
; PARTICULAR PURPOSE.  See the LGNU Lesser General Public 
; License for more details.
;
; You should have received a copy of the LGNU Lesser 
; General Public License along with this program.  If not, 
; see .
 
; Programa para desplegar una imagen tipo bitmap (mibmp.asm)

; El procedimiento mostrar_bmp carga un archivo tipo BMP 
; de Windows y la despliega en la pantalla. Recibe los 
; siguientes parametros: DS:DX que apunta a una cadena tipo 
; ASCIIZ la cual contiene la ruta donde esta guardado el 
; archivo BMP. La resolucion maxima en modo grafico es de 
; 320x200, con 256 colores disponibles. Este codigo esta 
; adaptado del codigo de Diego Escala, Miami, Florida
; y puede encontrarse en: 
; http://www.ece.msstate.edu/~reese/EE3724/labs/lab9/bitmap.asm

.model  small
.stack 128

.data
Header          label word
HeadBuff        db 54 dup('H')
palBuff         db 1024 dup('P')
ScrLine         db 320 dup(0)

BMPStart        db 'BM'

PalSize         dw ?
BMPHeight       dw ?
BMPWidth        dw ?

msgInvBMP       db "Archivo BMP invalido.",7,0Dh,0Ah,24h
msgFileErr      db "Error al abrir archivo.",7,0Dh,0Ah,24h
; El nombre del archivo debe terminar en 0
ruta            db "pez.bmp",0

.code
;.startup
  mov ax,@data
  mov ds,ax
main proc
  ; Configurar modo grafico VGA con resolucion de 320x200
  call    InitVid
  mov dx, offset ruta
  call mostrar_bmp

  ; Esperar por cualquier tecla
  mov ah,10h
  int 16h

  ; Regresar a modo texto
  mov ax,0003h
  int 10h
  
  ; Finalizar el programa
  mov ax,4c00h
  int 21h
  ret
main endp


mostrar_bmp proc
  ; Guardar los registros en la pila
  PUSH AX
  PUSH CX
  PUSH DX
  PUSH BX
  PUSH SP
  PUSH BP
  PUSH SI
  PUSH DI
  
  ; Abrir el archivo que se encuentra en la direccion 
  ; a la que esta apuntando DS:DX
  call    abrir_lectura           
  ; Error? Desplegar mensaje de error y salir
  jc      FileErr
  ; Colocar el manejador del archivo en BX
  mov     bx,ax
  ; Leer el encabezado de 54 bytes que contiene la 
  ; informacion del archivo BMP
  call    ReadHeader
  ; No es un archivo BMP valido? Desplegar mensaje de error
  ; y salir
  jc      InvalidBMP
  ; Leer la paleta del BMP y colocarla en el buffer
  call    ReadPal
  push    es
  ; Cargar la imagen y desplegarla
  call    LoadBMP
  pop     es

  ; Cerrar el archivo
  call    cerrar_archivo
  jmp     ProcDone

  FileErr:
  mov     ah,9
  mov     dx,offset msgFileErr
  int     21h
  jmp     ProcDone

  InvalidBMP:
  mov     ah,9
  mov     dx,offset msgInvBMP
  int     21h

  ProcDone:
  ; Restaurar los registros
  POP DI
  POP SI
  POP BP
  POP SP
  POP BX
  POP DX
  POP CX
  POP AX
  
  ret
mostrar_bmp endp

; =========================================================
InitVid proc
  ; Este procedimiento inicializa el modo de video y hace
  ; que el registro ES apunte a la memoria de video.
  mov     ax,13h
  ; Configurar el modo de video para: 320x200x256.
  int     10h
  mov ax, 0A000h
  ; ES = A000h (apunta al segmento de memoria de video)
  mov es, ax
  ret
InitVid endp


; ============= Abrir archivo en modo de lectura ==========
; Parametros
; DS:DX: direccion del nombre del archivo
; Retorna
; AX: si puede abrirlo contiene el manejador del archivo
abrir_lectura proc
  ; INT 21h / AH= 3Dh - abrir un archivo existente.
  ;   AL = Servicios:
  ;     mov al, 0   ; leer
  ;     mov al, 1   ; escribir
  ;     mov al, 2   ; leer/escribir 
  ;   DS:DX -> Nombre del archivo con formato ASCIZ.
  ;   Retorna:
  ;     CF Carry Flag en cero (operacion exitosa)
  ;     con AX = manejador de archivo.
  ;     CF Carry Flag en 1 (operacion fallida)
  ;     con AX = codigo de error.
  ;  nota 1: el apuntador apunta al inicio del archivo.
  ;  nota 2: el archivo debe existir.
  MOV ax,3D00h
  INT 21h
  ret
abrir_lectura endp

cerrar_archivo proc
  MOV ah,3eh     ;Peticion para salir
  INT 21h
  ret
cerrar_archivo endp


; =============== Leer Encabezado del BMP =================
; Este procedimiento revisa el encabezado del archivo para 
; asegurarse de que es un archivo tipo BMP valido
; y obtiene la informacion necesaria del mismo.
ReadHeader proc
  mov     ah,3fh
  mov     cx,54
  mov     dx,offset Header
  ; Lee encabezado y lo guarda en el buffer.
  int     21h
  ; Si no se leyeron los 54 bytes del encabezado, terminar.
  jc      RHdone

  ; Este procedimiento obtiene informacion importante del 
  ; encabezado del BMP y la coloca en las variables
  ; adecuadas
  ; AX = Desplazamiento de la direccion donde comienza
  ;      la imagen
  mov     ax,header[0Ah]
  ; Restar la longitud del encabezado de la imagen
  sub     ax,54
  ; Dividir el resultado entre 4
  shr ax,1
  shr ax,1
  ; Obtener el numero de colores del BMP
  ; (cada elemento de la paleta tiene 4 bytes de longitud)
  mov     PalSize,ax
  ; Guardar el ancho del BMP en BMPWidth
  mov     ax,header[12h]
  mov     BMPWidth,ax             
  ; Guardar la altura del BMP en BMPHeight
  mov     ax,header[16h]    
  mov     BMPHeight,ax 

  RHdone:
  ret
ReadHeader endp


; ================ Leer la paleta de video ================
ReadPal proc
  mov     ah,3fh
  ; Numero de colores de la paleta en CX
  mov     cx,PalSize
  ; Multiplicar este numero por 4 para obtener tamanio de 
  ; la paleta en bytes
  shl     cx,1
  shl     cx,1
  mov     dx,offset palBuff
  ; Poner la paleta en el buffer
  int     21h

  ; Este procedimiento recorre el buffer de la paleta y 
  ; envia informacion de la paleta a los registros de 
  ; video. Se envia un byte a traves del puerto 3C8h que 
  ; contiene el primer indice a modificar de la paleta  
  ; de colores. Despues, se envia informacion acerca de 
  ; los colores (RGB) a traves del puerto 3C9h
  
  ; SI apunta al buffer que contiene a la paleta.
  mov     si,offset palBuff
  ; Numero de colores a enviar en CX
  mov     cx,PalSize
  mov     dx,3c8h
  ; Comenzar en el color 0
  mov     al,0
  out     dx,al
  ; DX = 3C9h
  inc     dx
  sndLoop:
  ; Nota: los colores en un archivo BMP se guardan como
  ; BGR y no como RGB

  ; Obtener el valor para el rojo
  mov     al,[si+2]
  ; El maximo es 255, pero el modo de video solamente
  ; permite valores hasta 63, por lo tanto dividimos 
  ; entre 4 para obtener un valor valido
  shr     al,1
  shr     al,1
  ; Mandar el valor del rojo por el puerto 3C9h
  out     dx,al
  ; Obtener el valor para el verde
  mov     al,[si+1]
  shr     al,1
  shr     al,1
  ; Mandar el valor del verde por el puerto
  out     dx,al
  ; Obtener el valor para el azul
  mov     al,[si]
  shr     al,1
  shr     al,1
  ; Enviarlo por el puerto
  out     dx,al

  ; Apuntar al siguiente color
  ; (Hay un caracter nulo al final de cada color)
  add     si,4
  loop    sndLoop
ret
ReadPal endp


; ====================== Cargar BMP =======================
LoadBMP proc
  ; Las imagenes BMP se guardan de cabeza. Este 
  ; procedimiento lee la imagen linea por linea, y la
  ; despliega comenzando con la linea inferior hasta la 
  ; superior. La esquina superior izquierda de la imagen 
  ; se pinta en la esquina superior de la pantalla.

  ; La memoria de video es un arreglo bidimensional de 
  ; bytes que se pueden manipular individualmente. Cada 
  ; byte representa un pixel en la pantalla y contiene 
  ; el color del pixel que se va a pintar en esa posicion

  ; Numero de lineas a desplegar
  mov     cx,BMPWidth
  ShowLoop:
  push    cx
  ; Hacer una copia de CX en DI
  mov     di,cx
  ; Multiplicar CX por 64
  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1
  shl     cx,1
  ; Multiplicar DI por 256
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  shl     di,1
  ; Todo esto es equivalente a DI = CX * 320
  ; DI apunta al primer pixel de la linea deseada en 
  ; la pantalla
  add     di,cx
  
  ; Copia del archivo bmp una linea de la imagen en un
  ; buffer temporal (SrcLine).
  mov     ah,3fh
  mov     cx,BMPWidth
  mov     dx,offset ScrLine
  ; Colocar una linea de la imagen en el buffer
  int     21h

  ; Limpiar la bandera de direccion (direction flag) para
  ; usar movsb
  cld
  mov     cx,BMPWidth
  mov     si,offset ScrLine
  ; Instruccion movsb: 
  ; Mover el byte en la direccion DS:SI a la direccion 
  ; ES:DI. Despues de esto, los registros SI y DI se 
  ; incrementan o decrementan automaticamente de acuerdo
  ; con el valor que contiene la bandera de direccion
  ; (DF). Si la bandera DF esta puesta en 0, los 
  ; registros SI y DI se incrementan en 1. Si la bandera 
  ; DF esta puesta en 1, los registros SI y DI se
  ; decrementan en 1.
  
  ; Instruccion rep: repite cx times una operacion
  ; Copiar en la pantalla la linea que esta en el buffer
  l:
    mov es, ds
    mov di, si
    inc si
    inc di
    loop l



  pop     cx
  loop    ShowLoop
  ret
LoadBMP endp
end