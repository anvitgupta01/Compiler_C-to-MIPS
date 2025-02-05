## Overview
Lexical analyzer for the Compiler which translates C source language code to MIPS assembly code. It is implemented using Flex (Fast Lexical Analyzer Generator) tool which takes language specifications as input and output the lexical analyzer in C language (```lex.yy.c```).
Let's get started with implementing lexical analyzer using flex tool.

## Get Started
1. Download and install mysys2 from https://www.msys2.org/
2. Mysys2 uses port of Pacman (known from Arch Linux) for package management. Pacman provides support for Lex and Flex tools. Install Flex using the below command in Mysys2 terminal.

   ```
   pacman -S flex
   ```
4. Add Flex present in **"C\mysys64\usr\bin"** and gcc and g++ present in **"C\mysys64\ucrt64\bin"** to the user environment variables.
5. Clone the reporsitory using the below git command -

   ```
   git clone https://github.com/anvitgupta01/Compiler_C-to-MIPS/
   ```
6. Make a file named "test.c" in the working directory to test the lexical analyzer.
7. Compile the Lex file using Flex tool as -

   ```
   flex lex.l
   ```
8. Compile the lex.yy.c, the lexical analyzer file created by compiling lex.l file as -

   ```
   g++ lex.yy.c
   ```
9. Run the executable using the command -

   ```
   .\a.exe test.c
   ```
Use the flex manual for learning about flex tool - https://westes.github.io/flex/manual/
