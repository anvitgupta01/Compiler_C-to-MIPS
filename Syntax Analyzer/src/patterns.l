%{
#include <bits/stdc++.h>
#include "parser.tab.h" 
#include "../include/utility.h"
#include "../include/ast.h"

using namespace std;

extern ofstream outputFileLex;
extern ofstream outputFile;

int error = 0;
int width_of_column[3] = {14,32,66};
int headerPrint = 0;

vector<string> output;
extern vector<string> lexicalErrors;

void printBorder() {
    outputFileLex << "+";
    for (int i=0;i<width_of_column[0];i++) {
        outputFileLex << "-";
    }
    outputFileLex << "+";
    for (int i=0;i<width_of_column[1];i++) {
        outputFileLex << "-";
    }
    outputFileLex << "+";
    for (int i=0;i<width_of_column[2];i++) {
        outputFileLex << "-";
    }
    outputFileLex << "+" << endl;
}

void printEntry(string& line_no, string& token_type, string& lexeme) {
    if (!headerPrint) {
        printBorder();
    
        outputFileLex << "| " << std::left << std::setw(width_of_column[0]-2) << "Line Number"
              << " | " << std::left << std::setw(width_of_column[1]-2) << "Token_Type" 
              << " | " << std::left << std::setw(width_of_column[2]-2) << "Lexeme" 
              << " |" << std::endl;

        printBorder();
        headerPrint = 1;
    }

     outputFileLex << "| " << std::left << std::setw(width_of_column[0]-2) << line_no 
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

D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
FS			(f|F|l|L)
IS			(u|U|l|L)*

SINGLE_LINE_COMMENTS "//"[ ]*[^\n]*
MULTI_LINE_COMMENTS  "/*"([^*]|\*+[^*/])*\*+"/"
OPEN_MULTI_LINE_COMMENT "/*"

PREPROCESSOR_DIRECTIVES #define|#include|#ifdef|#ifndef|#if|#else|#elif|#endif|#undef|#pragma|#line|#error
PREPROCESSOR_STATEMENTS {PREPROCESSOR_DIRECTIVES}([a-zA-Z0-9!, <>.\\(\\)]|[\\{\\}]|[\\[\\]])*

KEYWORD auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|until|void|volatile|while

SEPARATOR ";"|":"|"."|","|"?"|"("|")"|"{"|"}"|"["|"]"

STRING_CHAR (\\[0nrtavbf\\'"]|[^\\"])

ID [a-zA-Z0-9_]*

UNARY_OPERATOR "++"|"--"
RELATIONAL_OPERATOR "<"|">"|"<="|">="|"=="|"!="
ASSIGNMENT_OPERATOR "="|"+="|"-="|"*="|"/="|"%="|">>="|"<<="|"&="|"|="|"^="
ARITHMETIC_OPERATOR "+"|"-"|"*"|"/"|"%"
LOGICAL_OPERATOR "&&"|"||"|"!"
BITWISE_OPERATOR "&"|"|"|"<<"|">>"|"~"|"^"

ELLIPSIS "..."
PTR_OP "->"

%%

{SINGLE_LINE_COMMENTS} 

{MULTI_LINE_COMMENTS} {int lines = countNewLine(yytext); yylineno += lines - 1; }

{OPEN_MULTI_LINE_COMMENT} {
    lexicalErrors.push_back("Error : Unclosed comment starting on line "+ to_string(yylineno) + "\n");
}

{PREPROCESSOR_STATEMENTS} {
    if (yyleng > 63) {
        lexicalErrors.push_back("Error: Excedding length of token at line number " + to_string(yylineno) + "\n");
    } else {
        output.push_back( to_string(yylineno) ); 
        output.push_back( "PREPROCESSOR_STATEMENT" ); 
        output.push_back( yytext );
    }
}

{KEYWORD}  { 
    yylval.tokenInfo = new TokenInfo(yylineno, "KEYWORD", yytext);
    output.push_back(  to_string(yylineno) ); 
    output.push_back( tokenValueOfKeyword(yytext).first ); 
    output.push_back( yytext );
    // cout<<yytext<<endl;
    return tokenValueOfKeyword(yytext).second;
}

{ELLIPSIS} {
    yylval.tokenInfo = new TokenInfo(yylineno, "ELLIPSIS", yytext);  
    output.push_back(  to_string(yylineno) ); 
    output.push_back( "ELLIPSIS" ); 
    output.push_back( yytext ); 
    // cout<<yytext<<endl;
    return ELLIPSIS;
}

{PTR_OP} {
    yylval.tokenInfo = new TokenInfo(yylineno, "PTR_OP", yytext);
    output.push_back(  to_string(yylineno) ); 
    output.push_back( "PTR_OP" ); 
    output.push_back( yytext );
    // cout<<yytext<<endl; 
    return PTR_OP;
}

0[xX]{H}+{IS}?  {   
        if (yyleng > 63) {
        lexicalErrors.push_back("Error: Excedding length of token at line number " + to_string(yylineno) + "\n");
        return 0;
        }
        yylval.tokenInfo = new TokenInfo(yylineno, "CONSTANT", yytext);
        output.push_back( to_string(yylineno) ); 
        output.push_back( "CONSTANT" ); 
        output.push_back( yytext );
        // cout<<yytext<<endl; 
        return(CONSTANT); 
}

0{D}+{IS}?   {   
        if (yyleng > 63) {
        lexicalErrors.push_back("Error: Excedding length of token at line number " + to_string(yylineno) + "\n");
        return 0;
        }
        yylval.tokenInfo = new TokenInfo(yylineno, "CONSTANT", yytext);
        output.push_back( to_string(yylineno) ); 
        output.push_back( "CONSTANT" ); 
        output.push_back( yytext );
        // cout<<yytext<<endl; 
        return(CONSTANT); 
}

{D}+{IS}?    {   
        if (yyleng > 63) {
        lexicalErrors.push_back("Error: Excedding length of token at line number " + to_string(yylineno) + "\n");
        return 0;
        }
        yylval.tokenInfo = new TokenInfo(yylineno, "CONSTANT", yytext);
        output.push_back( to_string(yylineno) ); 
        output.push_back( "CONSTANT" ); 
        output.push_back( yytext );
        // cout<<yytext<<endl; 
        return(CONSTANT); 
}

L?'(\\.|[^\\'])+'    {   
        if (yyleng > 63) {
        lexicalErrors.push_back("Error: Excedding length of token at line number " + to_string(yylineno) + "\n");
        return 0;
        }
        yylval.tokenInfo = new TokenInfo(yylineno, "CONSTANT", yytext);
        output.push_back( to_string(yylineno) ); 
        output.push_back( "CONSTANT" ); 
        output.push_back( yytext );
        // cout<<yytext<<endl; 
        return(CONSTANT); 
}

{D}+{E}{FS}?     {   
        if (yyleng > 63) {
        lexicalErrors.push_back("Error: Excedding length of token at line number " + to_string(yylineno) + "\n");
        return 0;
        }
        yylval.tokenInfo = new TokenInfo(yylineno, "CONSTANT", yytext);
        output.push_back( to_string(yylineno) ); 
        output.push_back( "CONSTANT" ); 
        output.push_back( yytext );
        // cout<<yytext<<endl; 
        return(CONSTANT); 
}

{D}*"."{D}+({E})?{FS}?   {   
        if (yyleng > 63) {
        lexicalErrors.push_back("Error: Excedding length of token at line number " + to_string(yylineno) + "\n");
        return 0;
        }
        yylval.tokenInfo = new TokenInfo(yylineno, "CONSTANT", yytext);
        output.push_back( to_string(yylineno) ); 
        output.push_back( "CONSTANT" ); 
        output.push_back( yytext );
        // cout<<yytext<<endl; 
        return(CONSTANT); 
}

{D}+"."{D}*({E})?{FS}?   {   
        if (yyleng > 63) {
        lexicalErrors.push_back("Error: Excedding length of token at line number " + to_string(yylineno) + "\n");
        return 0;
        }
        yylval.tokenInfo = new TokenInfo(yylineno, "CONSTANT", yytext);
        output.push_back( to_string(yylineno) ); 
        output.push_back( "CONSTANT" ); 
        output.push_back( yytext );
        // cout<<yytext<<endl; 
        return(CONSTANT); 
}

L?\"(\\.|[^\\"])*\"  {   
        if (yyleng > 63) {
        lexicalErrors.push_back("Error: Excedding length of token at line number " + to_string(yylineno) + "\n");
        return 0;
        }
        yylval.tokenInfo = new TokenInfo(yylineno, "STRING_LITERAL", string(yytext).substr(1, yyleng-2));
        output.push_back( to_string(yylineno) ); 
        output.push_back( "STRING_LITERAL" ); 
        output.push_back( yytext );
        // cout<<yytext<<endl; 
        return(STRING_LITERAL); 
}

{ID}  {
    if (yytext[0]>='0' && yytext[0]<='9') {
        lexicalErrors.push_back("Error: Invalid Identifier at line number " + to_string(yylineno)+"\n");
        return 0;
    } 
    if (yyleng > 63) {
        lexicalErrors.push_back("Error: Excedding length of token at line number " + to_string(yylineno) + "\n");
        return 0;
    }
    yylval.tokenInfo = new TokenInfo(yylineno, "IDENTIFIER", yytext);
    output.push_back( to_string(yylineno) ); 
    output.push_back( "IDENTIFIER" ); 
    output.push_back( yytext );
    // cout<<yytext<<endl;
    return IDENTIFIER;
}

{SEPARATOR} {
    yylval.tokenInfo = new TokenInfo(yylineno, "SEPARATOR", yytext);
    output.push_back(  to_string(yylineno) ); 
    output.push_back( tokenValueOfSeparator(yytext).first ); 
    output.push_back( yytext );
    // cout<<yytext<<endl;  
    return tokenValueOfSeparator(yytext).second;
}

\" {
    lexicalErrors.push_back("Error: Unclosed string literal starting on line " + to_string(yylineno)+"\n");
}

'(\\[0nrtavbf\\'"]|[^\\'])*' {
    lexicalErrors.push_back("Error: Character Literal can have only one character. Line " + to_string(yylineno) + "\n");
}

\' {
    lexicalErrors.push_back("Error: Unclosed character literal starting on line " + to_string(yylineno)+"\n");
}

{UNARY_OPERATOR}  {
    yylval.tokenInfo = new TokenInfo(yylineno, "UNARY_OPERATOR", yytext);
    output.push_back(  to_string(yylineno) ); 
    output.push_back( tokenValueOfUnaryOperator(yytext).first ); 
    output.push_back( yytext );  
    // cout<<yytext<<endl;
    return tokenValueOfUnaryOperator(yytext).second;
}

{RELATIONAL_OPERATOR}  {
    yylval.tokenInfo = new TokenInfo(yylineno, "RELATIONAL_OPERATOR", yytext);
    output.push_back(  to_string(yylineno) ); 
    output.push_back( tokenValueOfRelationalOperator(yytext).first ); 
    output.push_back( yytext ); 
    // cout<<yytext<<endl;
    return tokenValueOfRelationalOperator(yytext).second;
}

{ASSIGNMENT_OPERATOR}  { 
    yylval.tokenInfo = new TokenInfo(yylineno, "ASSIGNMENT_OPERATOR", yytext);
    output.push_back(  to_string(yylineno) ); 
    output.push_back( tokenValueOfAssignOperator(yytext).first ); 
    output.push_back( yytext );
    // cout<<yytext<<endl; 
    return tokenValueOfAssignOperator(yytext).second;
}

{ARITHMETIC_OPERATOR}  {
    yylval.tokenInfo = new TokenInfo(yylineno, "ARITHMETIC_OPERATOR", yytext);
    output.push_back(  to_string(yylineno) ); 
    output.push_back( tokenValueOfArithmeticOperator(yytext).first ); 
    output.push_back( yytext ); 
    // cout<<yytext<<endl;
    return tokenValueOfArithmeticOperator(yytext).second;
}

{LOGICAL_OPERATOR}  {
    yylval.tokenInfo = new TokenInfo(yylineno, "LOGICAL_OPERATOR", yytext);
    output.push_back(  to_string(yylineno) ); 
    output.push_back( tokenValueOfLogicalOperator(yytext).first ); 
    output.push_back( yytext ); 
    // cout<<yytext<<endl;
    return tokenValueOfLogicalOperator(yytext).second;
}

{BITWISE_OPERATOR}  {
    yylval.tokenInfo = new TokenInfo(yylineno, "BITWISE_OPERATOR", yytext);
    output.push_back(  to_string(yylineno) ); 
    output.push_back( tokenValueOfBitwiseOperator(yytext).first ); 
    output.push_back( yytext ); 
    // cout<<yytext<<endl;
    return tokenValueOfBitwiseOperator(yytext).second;
}

[ \t\v\f\r]+
\n {yylineno++;}

. {
    lexicalErrors.push_back("Error : Unknown Character " + string(yytext) + " present in line number " + to_string(yylineno) + "\n");
}

%%

int yywrap(void) {
    return 1;
}

void printLexicalAnalysisOutput(){
    if (lexicalErrors.size()) { 
        lexicalErrors.push_back("\nTokenization failed due to above errors.");
        for(auto &error : lexicalErrors){ 
            outputFileLex<<error;
        }
        return;
    }
    for(int i=0;i<output.size();i+=3){
        printEntry(output[i], output[i+1], output[i+2]);
    }
    printBorder();
}