#include <stdio.h>

int main() {
    printf("Hello World\n");
    printf("This is an unterminated string...);  // ❌ Lexical Error: Missing closing quote
    int @value = 50;  // ❌ Lexical Error: '@' is not a valid character

    return 0;
}
