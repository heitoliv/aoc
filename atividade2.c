#include <stdio.h>
#include <stdlib.h>

int main()
{
    int hora = 0;
    int km_x;
    int km_y;
    int vx;
    int vy;

    printf("Digite a posicao do carro X:\n");
    scanf(" %d", &km_x);
    printf("Digite a posicao do carro Y:\n");
    scanf(" %d", &km_y);

    printf("Digite a velocidade do carro X:\n");
    scanf(" %d", &vx);
    printf("Digite a velocidade do carro Y:\n");
    scanf(" %d", &vy);

    if (vx > vy)
    {
        while (km_x < km_y)
        {
            hora++;
            km_x = km_x + vx;
            km_y = km_y + vy;

            printf("Hora %d: Carro X em %d e Carro Y em %d \n",hora,km_x,km_y);
        }
        printf("Carro X ultrapassou o carro Y na hora %d apos o KM %d \n",hora,km_y);
    }
    else if (vy > vx)
    {
        hora = 0;
        while (km_y < km_x)
        {
            hora++;
            km_x = km_x + vx;
            km_y = km_y + vy;

            printf("Hora %d: Carro X em %d e Carro Y em %d \n",hora,km_x,km_y);
        }
        printf("Carro Y ultrapassou o carro X na hora %d apos o KM %d \n",hora,km_x);
    }

    return 0;
}