#ifndef ASTNODE_H
#define ASTNODE_H

#include <bits/stdc++.h>
using namespace std;

struct ASTNode
{
    string value;
    string type;
    int lineno;
    vector<ASTNode *> children;

public:
    ASTNode();
    ASTNode(const string &type);
    ASTNode(const string &type, const string &value);
    ASTNode(const int &lineno, const string &type, const string &value);
    void addChild(ASTNode *child);
    void addChildren(const vector<ASTNode *> &newChildren);
    void printAST(ofstream &outputFile, int depth = 0);
};

struct TokenInfo
{
    string token;
    string value;
    int lineno;
    TokenInfo(const int &lineno, const string &token, const string &value);
    TokenInfo(const string &token, const string &value = "");
};

void generateDOT(ASTNode *root, ofstream &out);
void generateDOTFile(ASTNode *root, const string &baseName);

#endif