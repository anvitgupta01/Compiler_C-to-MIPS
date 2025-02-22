# Overview
Syntax analyzer for the Compiler which translates C source language code to MIPS assembly code. It is implemented using bison tool which takes grammar specifications of the language as input and output the syntax analyzer in C language (parser.tab.c). This C code (parser) can then be used to convert tokens from lexical analyzer to Abstract Syntax Tree (AST). Let's get started with implementing syntax analyzer using bison tool.

# Get Started

1. Install Windows Subsystem For Linux (WSL)

   a. Open Windows powershell or terminal and type the below command
   
      ```
      wsl --install
      ```

   b. Restart your device
   
   c. To activate Ubuntu, open terminal and type the below command

      ```
      wsl.exe -d ubuntu
      ```

   d. Update and upgrade all the APT packages by below command
   
      ```
      sudo apt update && sudo apt upgrade
      ```
  
2. Install g++ compiler, Flex, bison, make and graphviz (is required for making PNG images of AST from .dot file)
   ```
   sudo apt install g++
   ```
   ```
   sudo apt install flex
   ```
   ```
   sudo apt install bison
   ```
   ```
   sudo apt install make
   ```
   ```
   sudo apt install graphviz
   ```

3. Move to the src directory of the Syntax Analyzer. To run all the test files present in the `tests` directory, use the following commands -
   
   ```
   make 
   ```
   ```
   make run
   ```

4. To run you code or any particular C source program, first paste that program to `source.c` file and then run the following command while in the `src` directory.
   ```
   make run_single
   ```

Read about bison from here - https://www.gnu.org/software/bison/manual/bison.html

Can also refer to this book for Flex and Bison - https://web.iitd.ac.in/~sumeet/flex__bison.pdf
