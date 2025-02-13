#include <stdio.h>

int formaTriangulo(int x, int y, int z) {
    if (x >= y + z || y >= x + z || z >= x + y) {
        return 0; 
    }
    return 1; 
}

int main() {
    int x, y, z;

    printf("Digite os valores dos segmentos de reta x, y e z:\n");
    scanf("%d %d %d", &x, &y, &z);

    if (formaTriangulo(x, y, z))
    {
        printf("%d, %d e %d formam um triangulo\n", x, y, z);
    } 
    else 
    {
        printf("%d, %d e %d não formam um triangulo\n", x, y, z);
    }

    return 0;
}
