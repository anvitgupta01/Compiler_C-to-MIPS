#include <stdio.h>

int main() {
    int num = 100  // ❌ Missing semicolon
    if (num > 50) {
        printf("Large number\n");
    }
    return 0;
}
