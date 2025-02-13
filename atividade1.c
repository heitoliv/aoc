#include <stdio.h>
#include <stdlib.h>

/*
Verificação de Ano Bissexto
Escreva um programa que receba um ano como entrada e determine se ele é bissexto. Um ano é bissexto se:

For divisível por 4, mas não por 100, ou

For divisível por 400.

O programa deve exibir "Ano bissexto" ou "Ano não bissexto" com base na verificação
*/

int main()
{
    int ano;

    printf("Digite um ano:\n");
    scanf("%d", &ano);

    if ((ano % 4 == 0 && ano % 100 != 0) || ano % 400 == 0)
    {
        printf("Ano bissexto.\n");
    }
    else{
        printf("Ano nao bissexto.\n");
    }

    return 0;
}