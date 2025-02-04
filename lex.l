%{
#include <bits/stdc++.h>
using namespace std;

// Flag for error
int error = 0;

// Symbol Table output
int width_of_column[3] = {14,32,42};
int headerPrint = 0;
int line_number = 1;

ofstream file;

void printBorder() {
    cout << "+";
    for (int i=0;i<width_of_column[0];i++) {
        cout << "-";
    }
    cout << "+";
    for (int i=0;i<width_of_column[1];i++) {
        cout << "-";
    }
    cout << "+";
    for (int i=0;i<width_of_column[2];i++) {
        cout << "-";
    }
    cout << "+" << endl;
}

void printEntry(int line_no, string& token_type, string& lexeme) {
    if (!headerPrint) {
        printBorder();
    
        std::cout << "| " << std::left << std::setw(width_of_column[0]-2) << "Line_Number"
              << " | " << std::left << std::setw(width_of_column[1]-2) << "Token_Type" 
              << " | " << std::left << std::setw(width_of_column[2]-2) << "Lexeme" 
              << " |" << std::endl;

        printBorder();
        headerPrint = 1;
    }

     std::cout << "| " << std::left << std::setw(width_of_column[0]-2) << line_no 
              << " | " << std::left << std::setw(width_of_column[1]-2) << token_type 
              << " | " << std::left << std::setw(width_of_column[2]-2) << lexeme 
              << " |" << std::endl;
}

int countNewLine(string comment) {
    int lineCount = 1;
    string ptr = comment;
    for (char ch : ptr) {
        if (ch == '\n') lineCount++;
    }
    return lineCount;
}

%}

SINGLE_LINE_COMMENTS "//"[ ]*[^\n]*
MULTI_LINE_COMMENTS  "/*"([^*]|\*+[^*/])*\*+"/"
OPEN_MULTI_LINE_COMMENT "/*"

PREPROCESSOR_DIRECTIVES #define|#include|#ifdef|#ifndef|#if|#else|#elif|#endif|#undef|#pragma|#line|#error
PREPROCESSOR_STATEMENTS {PREPROCESSOR_DIRECTIVES}[a-zA-Z <>.]*

HEXA [0-9A-Fa-f]
BINARY [0-1]
OCTAL [0-7]
DIGIT [0-9]

KEYWORD if|else|auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while|until

SEMICOLON ";"
COLON ":"
DOT "."
COMMA ","
QUESTION_MARK "?"

OPEN_NORM_BRACE "("
CLOSE_NORM_BRACE ")"
OPEN_CURVE_BRACE "{"
CLOSE_CURVE_BRACE "}"
OPEN_SQ_BRACE "["
CLOSE_SQ_BRACE "]"

STRING_CHAR [^\"\\]|[\\.]|[ ]

ID [a-zA-Z0-9_]*

UNARY_OPERATOR "++"|"--"
RELATIONAL_OPERATOR "<"|">"|"<="|">="|"=="|"!="
ASSIGNMENT_OPERATOR "="|"+="|"-="|"*="|"/="|"%="
ARITHMETIC_OPERATOR "+"|"-"|"*"|"/"|"%"
LOGICAL_OPERATOR "&&"|"||"|"!"
BITWISE_OPERATOR "&"|"|"|"<<"|">>"|"~"|"^"

%%

{SINGLE_LINE_COMMENTS}

{MULTI_LINE_COMMENTS} {int lines = countNewLine(yytext); line_number += lines - 1; }

{OPEN_MULTI_LINE_COMMENT} {
    error = 1;
    cout << "Error : Unclosed comment starting on line " << line_number << endl;
}

{PREPROCESSOR_STATEMENTS} {file <<  line_number << endl; file << "PREPROCESSOR_STATEMENT" << endl; file << yytext << endl;}

[0][b]{BINARY}+ {file <<  line_number << endl; file << "BINARY_LITERAL" << endl; file << yytext << endl;}

[0][x]{HEXA}+ {file <<  line_number << endl; file << "HEXADECIMAL_LITERAL" << endl; file << yytext << endl;}

[0]{OCTAL}+  {file <<  line_number << endl; file << "OCTAL_LITERAL" << endl; file << yytext << endl;}

(({DIGIT}*"."{DIGIT}+)|({DIGIT}+"."{DIGIT}*))[eE]{DIGIT}+ {file <<  line_number << endl; file << "FLOAT_LITERAL" << endl; file << yytext << endl;}

{DIGIT}+[eE]{DIGIT}+ { file <<  line_number << endl; file << "INTEGER_LITERAL" << endl; file << yytext << endl;}

({DIGIT}*"."{DIGIT}+)|({DIGIT}+"."{DIGIT}*)  {file <<  line_number << endl; file << "FLOAT_LITERAL" << endl; file << yytext << endl;}

{DIGIT}+   { file <<  line_number << endl; file << "INTEGER_LITERAL" << endl; file << yytext << endl;}

{KEYWORD}  { file <<  line_number << endl; file << "KEYWORD" << endl; file << yytext << endl;}

{SEMICOLON} {file <<  line_number << endl; file << "SEMICOLON" << endl; file << yytext << endl;}
{COLON} {file <<  line_number << endl; file << "COLON" << endl; file << yytext << endl;}
{COMMA} {file <<  line_number << endl; file << "COMMA" << endl; file << yytext << endl;}
{DOT} {file <<  line_number << endl; file << "DOT_OPERATOR" << endl; file << yytext << endl;}
{QUESTION_MARK} {file << line_number << endl; file << "QUESTION_MARK" << endl; file << yytext << endl;}

{ID}  {
    if (yytext[0]>='0' && yytext[0]<='9') {
        error = 1;
        cout << "Invalid Identifier at line number " << line_number << endl;
    } else {
        file <<  line_number << endl; file << "IDENTIFIER" << endl; file << yytext << endl;
    }
}

{OPEN_NORM_BRACE} {
    file <<  line_number << endl; file << "OPEN_BRACKETS" << endl; file << yytext << endl;
}

{CLOSE_NORM_BRACE} {
    file <<  line_number << endl; file << "CLOSING_BRACKETS" << endl; file << yytext << endl;
}

{OPEN_CURVE_BRACE} {
    file <<  line_number << endl; file << "OPEN_CURVE_BRACKETS" << endl; file << yytext << endl;
}

{CLOSE_CURVE_BRACE} {
    file <<  line_number << endl; file << "CLOSING_CURVE_BRACKETS" << endl; file << yytext << endl;
}

{OPEN_SQ_BRACE} {
    file <<  line_number << endl; file << "OPENING_SQAURE_BRACKETS" << endl; file << yytext << endl;
}

{CLOSE_SQ_BRACE} {
    file <<  line_number << endl; file << "CLOSING_SQUARE_BRACKETS" << endl; file << yytext << endl;
}

\"{STRING_CHAR}*\"  {
    file <<  line_number << endl; file << "STRING_LITERAL" << endl; file << yytext << endl;
}

\" {
    error = 1;
    cout << "Error: Unclosed string literal starting on line " << line_number << endl;
}

\'(.|\\.)\' {
    file << line_number << endl; file << "CHARACTER_LITERAL" << endl; file << yytext << endl;
}

\' {
    error = 1;
    cout << "Error: Unclosed character literal starting on line " << line_number << endl;
}

{UNARY_OPERATOR}  {file <<  line_number << endl; file << "UNARY_OPERATOR" << endl; file << yytext << endl;}
{RELATIONAL_OPERATOR}  {file <<  line_number << endl; file << "RELATIONAL_OPERATOR" << endl; file << yytext << endl;}
{ASSIGNMENT_OPERATOR}  { file <<  line_number << endl; file << "ASSIGNMENT_OPERATOR" << endl; file << yytext << endl;}
{ARITHMETIC_OPERATOR}  {file <<  line_number << endl; file << "ARITHMETIC_OPERATOR" << endl; file << yytext << endl;}
{LOGICAL_OPERATOR}  {file <<  line_number << endl; file << "LOGICAL_OPERATOR" << endl; file << yytext << endl;}
{BITWISE_OPERATOR}  {file <<  line_number << endl; file << "BITWISE_OPERATOR" << endl; file << yytext << endl;}

[ \t\r\f]+   /* eat up whitespaces, tabs or new line */

\n {line_number++;}

. {
    error = 1;
    cout << "Error : Unknown Character " << yytext << " present in line number " << line_number << endl;
}

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char **argv) {
    ++argv, argc--;
    if (argc > 0) {
        yyin = fopen(argv[0],"r");
    } else {
        yyin = stdin;
        cout << "Enter the code : \n\n";
    }
    
    file.open("example.txt");
    
    if (!file) {
        cout << "Error opening file for writing.\n";
        return 1;
    }

    yylex();

    file.close();

    if (error == 1) { 
        cout << "\nError : Program Terminated due to above errors." << endl;
        return 1;
    } else {
        ifstream filein;
        filein.open("example.txt");

        if (!filein) {
            cout << "Error opening file for reading." << endl;
        }

        string line, line2, line3;
        
        while(getline(filein, line)) {
            getline(filein, line2);
            getline(filein, line3);
            printEntry(stoi(line), line2, line3);
        }

        printBorder();
        
        remove("example.txt");
    }

    return 0;
}