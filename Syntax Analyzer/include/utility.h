#ifndef UTILITY_H
#define UTILITY_H

#include <bits/stdc++.h>
using namespace std;

pair<string,int> tokenValueOfKeyword(const string &keyword);
pair<string,int> tokenValueOfAssignOperator(const string &assignOp);
pair<string,int> tokenValueOfArithmeticOperator(const string &arithmeticOperator);
pair<string,int> tokenValueOfLogicalOperator(const string &logicalOperator);
pair<string,int> tokenValueOfBitwiseOperator(const string &bitwiseOperator);
pair<string,int> tokenValueOfRelationalOperator(const string &relationalOperator);
pair<string,int> tokenValueOfUnaryOperator(const string &unaryOperator);
pair<string,int> tokenValueOfSeparator(const string &separator);

#endif
