#include <stdio.h>

int main() {
    int x = 10;
    int y = 20;
    int z = x @ y;  // ❌ `@` is not a valid operator in C

    printf("Result: %d\n", z);
    return 0;
}
