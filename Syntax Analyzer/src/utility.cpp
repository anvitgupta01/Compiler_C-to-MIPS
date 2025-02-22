#include <bits/stdc++.h>
#include "../include/utility.h"
#include "parser.tab.h"

using namespace std;

pair<string, int> tokenValueOfKeyword(const string &keyword)
{
    if (keyword == "auto") return {"AUTO", AUTO};
    else if (keyword == "break") return {"BREAK", BREAK};
    else if (keyword == "case") return {"CASE", CASE};
    else if (keyword == "char") return {"CHAR", CHAR};
    else if (keyword == "const") return {"CONST", CONST};
    else if (keyword == "continue") return {"CONTINUE", CONTINUE};
    else if (keyword == "default") return {"DEFAULT", DEFAULT};
    else if (keyword == "do") return {"DO", DO};
    else if (keyword == "double") return {"DOUBLE", DOUBLE};
    else if (keyword == "else") return {"ELSE", ELSE};
    else if (keyword == "enum") return {"ENUM", ENUM};
    else if (keyword == "extern") return {"EXTERN", EXTERN};
    else if (keyword == "float") return {"FLOAT", FLOAT};
    else if (keyword == "for") return {"FOR", FOR};
    else if (keyword == "goto") return {"GOTO", GOTO};
    else if (keyword == "if") return {"IF", IF};
    else if (keyword == "int") return {"INT", INT};
    else if (keyword == "long") return {"LONG", LONG};
    else if (keyword == "register") return {"REGISTER", REGISTER};
    else if (keyword == "return") return {"RETURN", RETURN};
    else if (keyword == "short") return {"SHORT", SHORT};
    else if (keyword == "signed") return {"SIGNED", SIGNED};
    else if (keyword == "sizeof") return {"SIZEOF", SIZEOF};
    else if (keyword == "static") return {"STATIC", STATIC};
    else if (keyword == "struct") return {"STRUCT", STRUCT};
    else if (keyword == "switch") return {"SWITCH", SWITCH};
    else if (keyword == "typedef") return {"TYPEDEF", TYPEDEF};
    else if (keyword == "union") return {"UNION", UNION};
    else if (keyword == "unsigned") return {"UNSIGNED", UNSIGNED};
    else if (keyword == "until") return {"UNTIL", UNTIL};
    else if (keyword == "void") return {"VOID", VOID};
    else if (keyword == "volatile") return {"VOLATILE", VOLATILE};
    else if (keyword == "while") return {"WHILE", WHILE};
    else return {"Error", YYerror};
}

pair<string, int> tokenValueOfSeparator(const string &separator)
{
    if (separator == ";") return {"SEMI_COLON", SEMI_COLON};
    else if (separator == ",") return {"COMMA", COMMA};
    else if (separator == ":") return {"COLON", COLON};
    else if (separator == ".") return {"DOT", DOT};
    else if (separator == "?") return {"QUESTION", QUESTION};
    else if (separator == "{" || separator == "<%") return {"LCURLY", LCURLY};
    else if (separator == "}" || separator == "%>") return {"RCURLY", RCURLY};
    else if (separator == "[" || separator == "<:") return {"LSQUARE", LSQUARE};
    else if (separator == "]" || separator == ":>") return {"RSQUARE", RSQUARE};
    else if (separator == "(") return {"LPAREN", LPAREN};
    else if (separator == ")") return {"RPAREN", RPAREN};
    else return {"Error", YYerror};
}

pair<string, int> tokenValueOfAssignOperator(const string &keyword)
{
    if (keyword == "=")
        return {"ASSIGN", ASSIGN};
    else if (keyword == ">>=")
        return {"RIGHT_ASSIGN", RIGHT_ASSIGN};
    else if (keyword == "<<=")
        return {"LEFT_ASSIGN", LEFT_ASSIGN};
    else if (keyword == "+=")
        return {"ADD_ASSIGN", ADD_ASSIGN};
    else if (keyword == "-=")
        return {"SUB_ASSIGN", SUB_ASSIGN};
    else if (keyword == "*=")
        return {"MUL_ASSIGN", MUL_ASSIGN};
    else if (keyword == "/=")
        return {"DIV_ASSIGN", DIV_ASSIGN};
    else if (keyword == "%=")
        return {"MOD_ASSIGN", MOD_ASSIGN};
    else if (keyword == "&=")
        return {"AND_ASSIGN", AND_ASSIGN};
    else if (keyword == "^=")
        return {"XOR_ASSIGN", XOR_ASSIGN};
    else if (keyword == "|=")
        return {"OR_ASSIGN", OR_ASSIGN};
    else
        return {"Error", YYerror};
}

pair<string, int> tokenValueOfArithmeticOperator(const string &keyword)
{
    if (keyword == "+")
        return {"PLUS", PLUS};
    else if (keyword == "-")
        return {"MINUS", MINUS};
    else if (keyword == "*")
        return {"STAR", STAR};
    else if (keyword == "/")
        return {"DIVIDE", DIVIDE};
    else if (keyword == "%")
        return {"MOD", MOD};
    else
        return {"Error", YYerror};
}

pair<string, int> tokenValueOfLogicalOperator(const string &keyword)
{
    if (keyword == "&&")
        return {"AND_OP", AND_OP};
    else if (keyword == "||")
        return {"OR_OP", OR_OP};
    else if (keyword == "!")
        return {"NOT_OP", NOT_OP};
    else
        return {"Error", YYerror};
}

pair<string, int> tokenValueOfBitwiseOperator(const string &keyword)
{
    if (keyword == "&")
        return {"BIT_AND", BIT_AND};
    else if (keyword == "|")
        return {"BIT_OR", BIT_OR};
    else if (keyword == "<<")
        return {"LEFT_OP", LEFT_OP};
    else if (keyword == ">>")
        return {"RIGHT_OP", RIGHT_OP};
    else if (keyword == "~")
        return {"BIT_NOT", BIT_NOT};
    else if (keyword == "^")
        return {"XOR", XOR};
    else
        return {"Error", YYerror};
}

pair<string, int> tokenValueOfRelationalOperator(const string &keyword)
{
    if (keyword == "<")
        return {"LESSER_OP", LESSER_OP};
    else if (keyword == ">")
        return {"GREATER_OP", GREATER_OP};
    else if (keyword == "<=")
        return {"LE_OP", LE_OP};
    else if (keyword == ">=")
        return {"GE_OP", GE_OP};
    else if (keyword == "==")
        return {"EQ_OP", EQ_OP};
    else if (keyword == "!=")
        return {"NE_OP", NE_OP};
    else
        return {"Error", YYerror};
}

pair<string, int> tokenValueOfUnaryOperator(const string &keyword)
{
    if (keyword == "++")
        return {"INC_OP", INC_OP};
    else if (keyword == "--")
        return {"DEC_OP", DEC_OP};
    else
        return {"Error", YYerror};
}