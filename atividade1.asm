;Problema: Verificacao de Ano Bissexto 

;Escreva um programa que receba um ano como entrada e determine se ele eh bissexto. Um ano eh bissexto se:
;For divisivel por 4, mas nao por 100, ou
;For divisivel por 400.
;O programa deve exibir "Ano bissexto" ou "Ano nao bissexto" com base na verificacao

ORG 100h    

LEA DX, input  ;imprime input
MOV AH, 09h
INT 21h

;le e converte ASCII pra numero  EX:2024              
MOV AH, 01h
INT 21h 
SUB AL, '0' ;2 
MOV BL, AL  
MOV AL, BL
MOV AH, 10  
MUL AH      ;20

MOV AH, 01h
INT 21h
SUB AL, '0' ;0
MOV BH, AL   
ADD AL, BH  ;2
MOV AH, 10
MUL AH      ;200

MOV AH, 01h
INT 21h
SUB AL, '0' ;2
MOV CL, AL  
ADD AL, CL  ;202
MOV AH, 10
MUL AH      ;2020

MOV AH, 01h
INT 21h
SUB AL, '0' ;4
MOV CH, AL  
ADD AL, CH  ;2024
MOV CX, AX  

MOV AX, CX
MOV DX, 0
MOV BX, 4
DIV BX
CMP DX, 0
JNZ nao_bissexto

MOV AX, CX
MOV DX, 0
MOV BX, 100
DIV BX
CMP DX, 0
JNZ bissexto      

MOV AX, CX
MOV DX, 0
MOV BX, 400
DIV BX
CMP DX, 0
JZ bissexto  
JMP nao_bissexto    
    
nao_bissexto:
LEA DX, naobissexto
MOV AH, 09h
INT 21h
JMP fim

bissexto:
LEA DX, ehbissexto
MOV AH, 09h
INT 21h

fim:
MOV AH, 4Ch
INT 21h

input           DB 13,10, 'Digite o ano: $'
ehbissexto      DB 13,10, 'Ano bissexto$'
naobissexto     DB 13,10, 'Ano nao bissexto$'    
