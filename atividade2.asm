;para Giraldeli,
;no label racha(corrida) usamos JMP racha para fazer a repeticao, pois incrementando CX (as horas)
;enquanto se usassemos LOOP ele iria decrementar CX.

org 100h  
 
LEA DX, iposX    ;le
MOV AH, 09h      ;mensagem de
INT 21h          ;iposX
MOV CX, 0        ;zera CX para armazenar numero digitado
CALL leEconverteASCII
MOV [kmx], AX    ;armazena resultado da funcao acima

LEA DX, ivelX   
MOV AH, 09h     
INT 21h         
MOV CX, 0       
CALL leEconverteASCII
MOV [vx], AX 

LEA DX, iposY   
MOV AH, 09h      
INT 21h        
MOV CX, 0      
CALL leEconverteASCII
MOV [kmy], AX  

LEA DX, ivelY   
MOV AH, 09h      
INT 21h          
MOV CX, 0        
CALL leEconverteASCII
MOV [vy], AX  

LEA DX, hora0    ;le
MOV AH, 09h      ;mensagem de
INT 21h          ;hora0
MOV AX, [kmx]    ;carrega valor de kmx
CALL printnum    ;printa o numero
LEA DX, 1e       ;le
MOV AH, 09h      ;literalmente
INT 21h          ;1 "e"
MOV AX, [kmy]    ;carrega valor de kmy
CALL printnum    ;printa o numero

XOR CX,CX        ;zera CX para contar as horas
racha:   
INC CX           ; CX++ | CX += 1
MOV AX, [vx]     ;carrega valor de vx
MUL CX           ;multiplica pela hora
ADD AX, [kmx]    ;soma com kmx
MOV [kmxAtual], AX   ;armazena nova posicao

MOV AX, [vy]     ;repete o mesmo processo
MUL CX           ;acima para carro Y
ADD AX, [kmy]
MOV [kmyAtual], AX

LEA DX, horaAtual;le  
MOV AH, 09h      ;tempo
INT 21h          ;atual
MOV AX, CX       ;
CALL printnum    ;
LEA DX, carroX   ;exibe posicao do carro x
MOV AH, 09h
INT 21h
MOV AX, [kmxAtual]
CALL printnum
LEA DX, carroY   ;exibe posicao do carro y
MOV AH, 09h
INT 21h
MOV AX, [kmyAtual]     
CALL printnum       

MOV AX, [kmxAtual] ;verifica se os carros
CMP AX, [kmyAtual] ;se encontraram
JE ultrapassou     ;caso igual, pula para ultrapassou

MOV AX, [kmx]      ;Se X comecou na frente, verifica se Y ultrapassou
CMP AX, [kmy]      ;verifica se Y ultrapassou X
JG ve_se_y_passou  ;jump if greater (pule se maior, se nao me engano)

MOV AX, [kmxAtual] ;Se X estava atras e passou Y
CMP AX, [kmyAtual]
JG Xpassou         ;Se X passou Y, vai pro print de Xpassou
JMP racha          ;caso contrario repete loop

ultrapassou:       ;se os carros se encontraram
MOV AX, [kmxAtual] ;verifica quem passou quem
CMP AX, [kmyAtual]
JG Xpassou
JMP Ypassou

ve_se_y_passou:
MOV AX, [kmyAtual]
CMP AX, [kmxAtual]
JG Ypassou
JMP racha

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
MOV AX, CX         ;retorna numero convertido para AX
RET 

;nao usamos o PRINT_NUM do emu8086.inc, pois como e um
;procedimento, o qual e avaliado na atividade 3, fizemos
;uma label para essa funcao
printnum:
PUSH AX     ;pilha
PUSH BX     ;pilha
PUSH CX     ;pilha
PUSH DX     ;pilha
MOV BX, 10  ;BX = 10 pra dividir e extrair os digitos
XOR CX, CX  

printnum_loop:
XOR DX, DX  ;gantia que DX esteja zerado
DIV BX      ;divisao
PUSH DX     ;empilha o ultimo digito
INC CX
CMP AX, 0   ; verifica se ha mais digitos
JNE printnum_loop  ;jump if not equal

numNaTela:
POP DX      ; recupera um digito da pilha (de tras para frente)
ADD DL, '0' ;Converte o valor numerico para um caractere ASCII
MOV AH, 02h
INT 21h
LOOP numNaTela ;ate que CX seja 0
POP DX
POP CX
POP BX
POP AX
RET

Xpassou:
LEA DX, printX
JMP print_final 

Ypassou:
LEA DX, printY

print_final:
MOV AH, 09h
INT 21h
MOV AX, CX
CALL printnum
LEA DX, depoisDe
MOV AH, 09h
INT 21h
MOV AX, [kmyAtual]
CALL printnum
MOV AH, 02h  ; :D
MOV DL, 07h
INT 21h

fim:
MOV AH, 4Ch
INT 21h

kmx DW 0
kmy DW 0  
vx DW 0
vy DW 0
kmxAtual DW 0
kmyAtual DW 0

iposX       DB 13,10, 'Posicao do carro X: $'
iposY       DB 13,10, 'Posicao do carro Y: $'
ivelX       DB 13,10, 'Velocidade do carro X: $'
ivelY       DB 13,10, 'Velocidade do carro Y: $'
hora0       DB 13,10, 'Hora 0: Carros em $' 
horaAtual   DB 13,10, 'Hora $'
carroX      DB ': Carro X em $'
carroY      DB ' e Carro Y em $'  
1e          DB ' e $'  
printX      DB 13, 10, 'Carro X ultrapassou o carro Y na hora $'
printY      DB 13, 10, 'Carro Y ultrapassou o carro X na hora $'
depoisDE    DB ' apos o KM $'

ret
