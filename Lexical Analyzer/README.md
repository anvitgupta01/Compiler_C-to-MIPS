## Overview
Lexical analyzer for the Compiler which translates C source language code to MIPS assembly code. It is implemented using Flex (Fast Lexical Analyzer Generator) tool which takes language specifications as input and output the lexical analyzer in C language (```lex.yy.c```).
Let's get started with implementing lexical analyzer using flex tool.

## Get Started
1. Download and install mysys2 from https://www.msys2.org/
2. Mysys2 uses port of Pacman (known from Arch Linux) for package management. Pacman provides support for Lex and Flex tools. Install Flex using the below command in Mysys2 terminal.

   ```
   pacman -S flex
   ```
3. For compilation using makefile, install the make package using pacman by the following command -
   ```
   pacman -S make
   ```
4. Add Flex present in **"C\mysys64\usr\bin"** and gcc and g++ present in **"C\mysys64\ucrt64\bin"** to the user environment variables.
5. Clone the reporsitory using the below git command -
   ```
   git clone https://github.com/anvitgupta01/Compiler_C-to-MIPS/
   ```
6. Make a file named "test.c" in the working directory to test the lexical analyzer.
7. Compile the file to produce executable as -
   ```
   make
   ```
   If you don't want to use make, then compile the Lex file using Flex tool as -
   ```
   flex lex.l
   ```
   and then compile the lex.yy.c, the lexical analyzer file created by compiling lex.l file as -
   ```
   g++ lex.yy.c -o lexer
   ```
8. For running on provided test cases, update the permission of the run.sh file in git bash and then run the file in Git bash.
   ```
   chmod +x ./run.sh
   ```
   ```
   ./run.sh
   ```
9. For testing on custom test.c file. Run the executable using the command -
   ```
   .\lexer.exe test.c
   ```

## Scope of Lexical Analyzer
The lex.l file contains regular expressions and corresponding actions for recognizing various tokens in the C language. The following is a detailed breakdown -

1. Comments
   - Single-Line Comments : Fully supported and discarded (// ...).
     
   - Multi-Line Comments : Supported (/* ... */). The analyzer tracks line numbers within multi-line comments and flags unclosed multi-line comments as errors.

2. Preprocessor Directives
   - Recognition : Recognizes and tokenizes common preprocessor directives such as #define, #include, #ifdef, #ifndef, #if, #else, #elif, #endif, #undef, #pragma, #line, and #error.
     
   - Statements : Identifies complete preprocessor statements, including directives, and various valid bracket pairs that appear in preprocessor statements.

3. Literals
    - Binary Literals : Recognizes binary literals prefixed with 0b (e.g., 0b1010).
      
    - Hexadecimal Literals : Recognizes hexadecimal literals prefixed with 0x (e.g., 0xAF12).
      
    - Octal Literals : Recognizes octal literals prefixed with 0 (e.g., 0123).
      
    - Floating-Point Literals : Handles floating-point numbers (e.g., 3.14).
      
    - Integer Literals : Recognizes integer numbers.
      
    - String Literals : Recognizes string literals enclosed in double quotes ("...") and includes support for escape sequences. Flags unclosed string literals as errors.
      
       - **Supported Escape Sequences**: The STRING_CHAR indicates support for the following escape sequences within strings -
          - \0: Null character
          - \n: Newline
          - \r: Carriage return
          - \t: Horizontal tab
          - \a: Alert (bell)
          - \v: Vertical tab
          - \b: Backspace
          - \f: Form feed
          - \\: Backslash
          - \’: Single quote
          - \": Double quote
            
    - Character Literals: Recognizes character literals enclosed in single quotes (’_ ..’). It enforces that character literals must contain only one character (exlcuding ’) and flags errors for literals with more than one character or unclosed literals.
      
       - **Supported Escape Sequences** : Similar to string literals, character literals support the same escape sequences defined in the STRING_CHAR regex.
          - \0: Null character
          - \n: Newline
          - \r: Carriage return
          - \t: Horizontal tab
          - \a: Alert (bell)
          - \v: Vertical tab
          - \b: Backspace
          - \f: Form feed
          - \\: Backslash
          - \’: Single quote
          - \": Double quote


4. Keywords
   - Recognition: A comprehensive list of C keywords is recognized, including if, else, auto, break, case, char, const, continue, default, do, double, enum, extern, float, for, goto, int, long, register, return, short, signed, sizeof, static, struct, switch, typedef, union, unsigned, void, volatile, while, and until.
 
5. Operators
   - Unary Operators: ++,-
     
   - Relational Operators: <, >, <=, >=, ==, !=
     
   - Assignment Operators: =, +=,-=, *=, /=, %=
     
   - Arithmetic Operators: +,-, *, /, %
     
   - Logical Operators: &&, ||, !
     
   - Bitwise Operators: &, |, <<, >>, ~, ^

6. Identifiers
   - Recognition: Recognizes identifiers that start with a letter or underscore and are followed by letters, numbers, or underscores.
     
   - Validation: Flags identifiers that begin with a digit as invalid.

7. Braces and Delimiters
   - Recognition: Recognizes and tokenizes parentheses (), curly braces {}, square brackets [], semicolons ;, colons :, commas ,, dots ., and question marks ?.
 
8. Whitespace
   - Handling: Whitespace characters (spaces, tabs, carriage returns, form feeds) are ignored.


## Lexical Errors handled
1. **Unterminated String Literal** – A string literal that lacks a proper closing delimiter before the end of the input.
   
2. **Unterminated Character Literal** – A character literal that lacksclosing delimiter before the end of the input.
   
3. **Unterminated Multi-line Comment** – A multiline comment that is not properly closed before the end of the input.
   
4. **Token Length Exceeding Limit** – A token whose length exceeds the maximum allowed limit of 63 characters.
   
5. **Invalid Identifier Names** – Identifiers that do not conform to the syntactic rules of valid naming conventions.
    
6. **Invalid Characters** – The characters $ and @, which are not allowed in the language syntax.
    
7. **Invalid Escape Sequence** – An escape sequence that is not recognized as a valid sequence in the language syntax.

Use the flex manual for learning about flex tool - https://westes.github.io/flex/manual/
