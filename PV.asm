.model small
.stack 128
.data

.code
.startup
main proc
  ; INT 10h / AH = 0 - configurar modo de video.
  ; AL = modo de video deseado.
  ;     00h - modo texto. 40x25. 16 colores. 8 paginas.
  ;     03h - modo texto. 80x25. 16 colores. 8 paginas.
  ;     13h - modo grafico. 40x25. 256 colores. 
  ;           320x200 pixeles. 1 pagina. 
  mov ax,0013h
  int 10h
  mov ax, 0A000h
  mov ds, ax  ; DS = A000h (memoria de graficos).

  ; ============== Lineas verticales ======================
  ; Queremos pintar 256 colummas, cada una con un alto de 
  ; 200 pixeles. Podemos ejecutar 51,200 ciclos.
  ; Como la memoria de graficos es lineal, es mejor pintar
  ; una fila a la vez, cada fila tiene 320 columnas, pero
  ; solo pintamos 256. Al llegar a la columna 256 saltamos
  ; a la siguiente fila sumando 320-256 = 64
  ; Cada pixel cambia de color para dar el efecto de lineas
  ; verticales
  mov cx,0C800h ; # de pixeles
  xor dx,dx     ; contador de columnas y color
  xor di,di

  ciclo_1:
  mov [di], dx ; poner color en A000:DI
  inc di
  inc dx
  cmp dx,256
  jne sig_pix1

  add di,0040h ; saltar al inicio de siguiente fila
  xor dx,dx    ; reiniciar columnas y color
  sig_pix1:
  loop ciclo_1

  ; esperar por tecla
  mov ah,10h
  int 16h

  ; ============== Lineas horizontales ======================
  ; Queremos pintar 200 filas, cada una con un largo de 
  ; 320 pixeles. Podemos ejecutar 64,000 ciclos.
  ; Despues de pintar los 320 pixeles correspondientes a
  ; una fila, cambiamos el color para pintar la siguiente
  ; fila y dar el efecto de lineas horizontales.
  mov cx,0FA00h ; todos los pixeles de la pantalla
  xor dx,dx ; color para cada fila
  xor bx,bx ; contador de columnas
  xor di,di

  ciclo_2:
  mov [di], dx ; poner color en A000:DI
  inc di
  inc bx
  cmp bx,320
  jne sig_pix2
            ; nueva fila
  xor bx,bx ; resetear contador de columnas
  inc dx    ; cambiar color
  sig_pix2:
  loop ciclo_2

  ; esperar por tecla
  mov ah,10h
  int 16h

  ; regresar a modo texto
  mov ax,0003h
  int 10h
  
  ; finalizar el programa
  mov ax,4c00h
  int 21h
  ret
main endp
end