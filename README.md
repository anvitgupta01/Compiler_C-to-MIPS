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

Use the flex manual for learning about flex tool - https://westes.github.io/flex/manual/
