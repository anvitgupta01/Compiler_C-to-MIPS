%{
#include <bits/stdc++.h>
using namespace std;

// Flag for error
int error = 0;

// Symbol Table output
int width_of_column[3] = {14,32,66};
int headerPrint = 0;
int line_number = 1;

ofstream file;
vector<string> output;
vector<string> errors;

void printBorder() {
    file << "+";
    for (int i=0;i<width_of_column[0];i++) {
        file << "-";
    }
    file << "+";
    for (int i=0;i<width_of_column[1];i++) {
        file << "-";
    }
    file << "+";
    for (int i=0;i<width_of_column[2];i++) {
        file << "-";
    }
    file << "+" << endl;
}

void printEntry(string& line_no, string& token_type, string& lexeme) {
    if (!headerPrint) {
        printBorder();
    
        file << "| " << std::left << std::setw(width_of_column[0]-2) << "Line Number"
              << " | " << std::left << std::setw(width_of_column[1]-2) << "Token_Type" 
              << " | " << std::left << std::setw(width_of_column[2]-2) << "Lexeme" 
              << " |" << std::endl;

        printBorder();
        headerPrint = 1;
    }

     file << "| " << std::left << std::setw(width_of_column[0]-2) << line_no 
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

void handleExceddingLengthofTokens() {
    
}

%}

SINGLE_LINE_COMMENTS "//"[ ]*[^\n]*
MULTI_LINE_COMMENTS  "/*"([^*]|\*+[^*/])*\*+"/"
OPEN_MULTI_LINE_COMMENT "/*"

OPEN_NORM_BRACE "("
CLOSE_NORM_BRACE ")"
OPEN_CURVE_BRACE "{"
CLOSE_CURVE_BRACE "}"
OPEN_SQ_BRACE "["
CLOSE_SQ_BRACE "]"

PREPROCESSOR_DIRECTIVES #define|#include|#ifdef|#ifndef|#if|#else|#elif|#endif|#undef|#pragma|#line|#error
PREPROCESSOR_STATEMENTS {PREPROCESSOR_DIRECTIVES}([a-zA-Z0-9!, <>.\\(\\)]|[\\{\\}]|[\\[\\]])*

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

STRING_CHAR (\\[0nrtavbf\\'"]|[^\\"])

ID [a-zA-Z0-9_]*

UNARY_OPERATOR "++"|"--"
RELATIONAL_OPERATOR "<"|">"|"<="|">="|"=="|"!="
ASSIGNMENT_OPERATOR "="|"+="|"-="|"*="|"/="|"%="
ARITHMETIC_OPERATOR "+"|"-"|"*"|"/"|"%"
LOGICAL_OPERATOR "&&"|"||"|"!"
BITWISE_OPERATOR "&"|"|"|"<<"|">>"|"~"|"^"


%%

{SINGLE_LINE_COMMENTS}

{MULTI_LINE_COMMENTS} {int lines = countNewLine(yytext); to_string(line_number) += lines - 1; }

{OPEN_MULTI_LINE_COMMENT} {
    errors.push_back("Error : Unclosed comment starting on line "+ to_string(line_number) + "\n");
}

{PREPROCESSOR_STATEMENTS} {
    if (yyleng > 63) {
        errors.push_back("Error: Excedding length of token at line number " + to_string(line_number) + "\n");
    } else {
        output.push_back( to_string(line_number) ); 
        output.push_back( "PREPROCESSOR_STATEMENT" ); 
        output.push_back( yytext );
    }
}

[0][b]{BINARY}+ {
    if (yyleng > 63) {
        errors.push_back("Error: Excedding length of token at line number " + to_string(line_number) + "\n");
    } else {
        output.push_back( to_string(line_number) ); 
        output.push_back( "BINARY_LITERAL" ); 
        output.push_back( yytext );
    }
}

[0][x]{HEXA}+ {
    if (yyleng > 63) {
        errors.push_back("Error: Excedding length of token at line number " + to_string(line_number) + "\n");
    } else {
        output.push_back( to_string(line_number) ); 
        output.push_back( "HEXADECIMAL_LITERAL" ); 
        output.push_back( yytext );
    }
}
[0]{OCTAL}+  {
    if (yyleng > 63) {
        errors.push_back("Error: Excedding length of token at line number " + to_string(line_number) + "\n");
    } else {
        output.push_back( to_string(line_number) ); 
        output.push_back( "OCTAL_LITERAL" ); 
        output.push_back( yytext );
    }
}

(({DIGIT}*"."{DIGIT}+)|({DIGIT}+"."{DIGIT}*))[eE]{DIGIT}+ {
    if (yyleng > 63) {
        errors.push_back("Error: Excedding length of token at line number " + to_string(line_number) + "\n");
    } else {
        output.push_back( to_string(line_number) ); 
        output.push_back( "FLOAT_LITERAL" ); 
        output.push_back( yytext );
    }
}

{DIGIT}+[eE]{DIGIT}+ { 
    if (yyleng > 63) {
        errors.push_back("Error: Excedding length of token at line number " + to_string(line_number) + "\n");
    } else {
        output.push_back( to_string(line_number) ); 
        output.push_back( "INTEGER_LITERAL" ); 
        output.push_back( yytext );
    }
}

({DIGIT}*"."{DIGIT}+)|({DIGIT}+"."{DIGIT}*)  {
    if (yyleng > 63) {
        errors.push_back("Error: Excedding length of token at line number " + to_string(line_number) + "\n");
    } else {
        output.push_back( to_string(line_number) ); 
        output.push_back( "FLOAT_LITERAL" ); 
        output.push_back( yytext );
    }
}

{DIGIT}+   { 
    if (yyleng > 63) {
        errors.push_back("Error: Excedding length of token at line number " + to_string(line_number) + "\n");
    } else {
        output.push_back( to_string(line_number) ); 
        output.push_back( "INTEGER_LITERAL" ); 
        output.push_back( yytext );
    }
}

{KEYWORD}  { output.push_back(  to_string(line_number) ); output.push_back( "KEYWORD" ); output.push_back( yytext );}

{SEMICOLON} {output.push_back(  to_string(line_number) ); output.push_back( "SEMICOLON" ); output.push_back( yytext );}
{COLON} {output.push_back(  to_string(line_number) ); output.push_back( "COLON" ); output.push_back( yytext );}
{COMMA} {output.push_back(  to_string(line_number) ); output.push_back( "COMMA" ); output.push_back( yytext );}
{DOT} {output.push_back(  to_string(line_number) ); output.push_back( "DOT_OPERATOR" ); output.push_back( yytext );}
{QUESTION_MARK} {output.push_back( to_string(line_number) ); output.push_back( "QUESTION_MARK" ); output.push_back( yytext );}

{ID}  {
    if (yytext[0]>='0' && yytext[0]<='9') {
        errors.push_back("Error: Invalid Identifier at line number " + to_string(line_number)+"\n");
    } else if (yyleng > 63) {
        errors.push_back("Error: Excedding length of token at line number " + to_string(line_number) + "\n");
    } else {
        output.push_back( to_string(line_number) ); 
        output.push_back( "BINARY_LITERAL" ); 
        output.push_back( yytext );
    }
}

{OPEN_NORM_BRACE} {
    output.push_back(  to_string(line_number) ); output.push_back( "OPEN_BRACKETS" ); output.push_back( yytext );
}

{CLOSE_NORM_BRACE} {
    output.push_back(  to_string(line_number) ); output.push_back( "CLOSING_BRACKETS" ); output.push_back( yytext );
}

{OPEN_CURVE_BRACE} {
    output.push_back(  to_string(line_number) ); output.push_back( "OPEN_CURVE_BRACKETS" ); output.push_back( yytext );
}

{CLOSE_CURVE_BRACE} {
    output.push_back(  to_string(line_number) ); output.push_back( "CLOSING_CURVE_BRACKETS" ); output.push_back( yytext );
}

{OPEN_SQ_BRACE} {
    output.push_back(  to_string(line_number) ); output.push_back( "OPENING_SQAURE_BRACKETS" ); output.push_back( yytext );
}

{CLOSE_SQ_BRACE} {
    output.push_back(  to_string(line_number) ); output.push_back( "CLOSING_SQUARE_BRACKETS" ); output.push_back( yytext );
}

\"{STRING_CHAR}*\"  {
    if (yyleng > 63) {
        errors.push_back("Error: Excedding length of token at line number " + to_string(line_number) + "\n");
    } else {
        output.push_back( to_string(line_number) ); 
        output.push_back( "STRING_LITERAL" ); 
        output.push_back( yytext );
    }
}

\" {
    errors.push_back("Error: Unclosed string literal starting on line " + to_string(line_number)+"\n");
}

'(\\[0nrtavbf\\'"]|[^\\'])' {
    output.push_back( to_string(line_number) ); output.push_back( "CHARACTER_LITERAL" ); output.push_back( yytext );
}

'(\\[0nrtavbf\\'"]|[^\\'])*' {
    errors.push_back("Error: Character Literal can have only one character. Line " + to_string(line_number) + "\n");
}

\' {
    errors.push_back("Error: Unclosed character literal starting on line " + to_string(line_number)+"\n");
}

{UNARY_OPERATOR}  {output.push_back(  to_string(line_number) ); output.push_back( "UNARY_OPERATOR" ); output.push_back( yytext );}
{RELATIONAL_OPERATOR}  {output.push_back(  to_string(line_number) ); output.push_back( "RELATIONAL_OPERATOR" ); output.push_back( yytext );}
{ASSIGNMENT_OPERATOR}  { output.push_back(  to_string(line_number) ); output.push_back( "ASSIGNMENT_OPERATOR" ); output.push_back( yytext );}
{ARITHMETIC_OPERATOR}  {output.push_back(  to_string(line_number) ); output.push_back( "ARITHMETIC_OPERATOR" ); output.push_back( yytext );}
{LOGICAL_OPERATOR}  {output.push_back(  to_string(line_number) ); output.push_back( "LOGICAL_OPERATOR" ); output.push_back( yytext );}
{BITWISE_OPERATOR}  {output.push_back(  to_string(line_number) ); output.push_back( "BITWISE_OPERATOR" ); output.push_back( yytext );}

[ \t\r\f]+   /* eat up whitespaces, tabs or new line */

\n {line_number++;}

. {
    errors.push_back("Error : Unknown Character " + string(yytext) + " present in line number " + to_string(line_number) + "\n");
}

%%

int yywrap(void) {
    handleExceddingLengthofTokens();
    return 1;
}

void remove_last_char(const char *source, string &dest, string terminator) {
    int length = strlen(source);
    dest = (length > 0)? string(source, length - 2): "";
    dest += terminator;
}

int main(int argc, char **argv) {
    ++argv, argc--;
    char *fileName=argv[0];
    cout<<fileName<<endl;
    if (argc > 0) {
        yyin = fopen(fileName,"r");
    }
    string newFileName;
    yylex();
    if (errors.size()) { 
        remove_last_char(fileName,newFileName, "_errors.txt");
        file.open(newFileName);
        if (!file) {
            cout << "Error opening file for writing.\n";
            return 1;
        }
        errors.push_back("\nError : Program Terminated due to above errors.");
        for(auto &error : errors) file<<error;
        return 1;
    } else {
        remove_last_char(fileName,newFileName, "_output.txt");
        file.open(newFileName);
        if (!file) {
            cout << "Error opening file for writing.\n";
            return 1;
        }
        for(int i=0;i<output.size();i+=3){
            printEntry(output[i], output[i+1], output[i+2]);
        }
        printBorder();
        file.close();
    }

    return 0;
}