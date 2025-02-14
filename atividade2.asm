org 100h           

LEA DX, iposX   ; carrega o endereço de iposX em DX
MOV AH, 09h     ; configura AH com 9 (função de exibir string)
INT 21h         ; chama DOS para exibir string
MOV CX, 0       ; zera CX para armazenar valor de x
CALL leEconverteASCII
MOV [x], AX     ; armazena resultado da funcao de cima (AX)

;Carregando valor de y

LEA DX, iposY   ; carrega o endereço de iposY em DX
MOV AH, 09h     ; configura AH com 9 (função de exibir string)
INT 21h         ; chama DOS para exibir string
MOV CX, 0       ; zera CX para armazenar valor de y
CALL leEconverteASCII
MOV [y], AX     ; armazena resultado da funcao de cima (AX)

;Carregando valor de z

LEA DX, iposZ   ; carrega o endereço de iposZ em DX
MOV AH, 09h     ; configura AH com 9 (função de exibir string)
INT 21h         ; chama DOS para exibir string
MOV CX, 0       ; zera CX para armazenar valor de z
CALL leEconverteASCII
MOV [z], AX     ; armazena resultado da funcao de cima (AX)

; função se forma triangulo, retorna 1 para forma 0 para nao forma
CALL formaTriangulo
CMP AX, 1
JE forma_triangulo

; caso nao forma, printa nãoformaTri e finaliza programa
LEA DX, naoformaTri
MOV AH, 09h
INT 21h
JMP fim 

; caso forme triangulo, printa formaTri
forma_triangulo:
LEA DX, formaTri
MOV AH, 09h
INT 21h

; finaliza programa
fim:
MOV AH, 4Ch
INT 21h

; função para verificar se forma triangulo, 1 para forma 0 para nao forma
formaTriangulo:
PUSH BP     ; salva o valor do base pointer da pilha
MOV BP, SP  ; carrega o topo da pilha como base pointer, (novo frame)

; verifica se x >= y + z
MOV AX, [x]
MOV BX, [y]
MOV CX, [z]

ADD BX, CX
CMP AX, BX
JGE nao_forma ; retorna 0


; verifica se y >= x + z
MOV AX, [x]
MOV BX, [y]
MOV CX, [z]

ADD AX, CX
CMP BX, AX
JGE nao_forma ; retorna 0


; verifica se z >= x + y
MOV AX, [x]
MOV BX, [y]
MOV CX, [z]

ADD AX, BX
CMP CX, AX
JGE nao_forma ; retorna 0


; se passar tudo, forma triangulo retorna 1
MOV AX, 1
JMP fim_funcao

; chama se nao forma triangulo
nao_forma:
MOV AX, 0

fim_funcao:
POP BP
RET

leEconverteASCII:    
MOV AH, 01h     
INT 21h
CMP AL, 13         ;verifica se enter foi pressionado
JE lcFIM           ;jump if equal finaliza a funcao
SUB AL, '0'        ;converte ASCII para numero 
MOV BL, AL         ; armazena num em BL
MOV AX, CX         ;move acumulador CX para AX
MOV BH, 10         
MUL BH           
MOV CX, AX         ;atualiza CX
XOR AH, AH         ;zera AH
MOV AL, BL         ;move num lido para AL
ADD CX, AX         ;soma com numero convertido
JMP leEconverteASCII 

lcFIM:
MOV AX, CX
RET         ;retorna numero convertido para AX  

x DW 0
y DW 0
z DW 0   

iposX       DB 13,10, 'Digite o valor de x: $'
iposY       DB 13,10, 'Digite o valor de y: $'
iposZ       DB 13,10, 'Digite o valor de z: $'
formaTri    DB 13,10, 'Os valores formam um triangulo.$'
naoformaTri DB 13,10, 'Os valores nao formam um triangulo.$' 

RET
