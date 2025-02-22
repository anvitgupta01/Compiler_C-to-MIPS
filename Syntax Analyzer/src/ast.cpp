#include "../include/ast.h"
#include <bits/stdc++.h>
using namespace std;

ASTNode::ASTNode() : value("") {}
ASTNode::ASTNode(const std::string &type) : type(type) {}
ASTNode::ASTNode(const int &lineno, const std::string &type, const std::string &value) : lineno(lineno), value(value), type(type) {}
ASTNode::ASTNode(const std::string &type, const std::string &value) : value(value), type(type) {}

void ASTNode::addChild(ASTNode *child)
{
    children.push_back(child);
}

void ASTNode::addChildren(const vector<ASTNode *> &newChildren)
{
    for (auto child : newChildren)
    {
        children.push_back(child);
    }
}

void ASTNode::printAST(ofstream &outputFile, int depth)
{
    for (int i = 0; i < depth; i++)
        outputFile << "  ";
    outputFile << value << std::endl;
    for (ASTNode *child : children)
    {
        child->printAST(outputFile, depth + 1);
    }
}

TokenInfo::TokenInfo(const int &lineno, const string &token, const string &value) : lineno(lineno), token(token), value(value) {}
TokenInfo::TokenInfo(const string &token, const string &value) : token(token), value(value) {}

void generateDOT(ASTNode *root, ofstream &out)
{
    static int counter = 0;
    if (!root)
        return;

    int nodeId = counter++;

    string shape = (root->type == "Terminal") ? "box" : "ellipse";
    string color = (root->type == "Terminal") ? "green" : "red";
    string escapedValue = root->value;
    out << "  node" << nodeId << " [label=\"" << escapedValue << "\\n(" << root->type << ")\", shape=" << shape << ", color=" << color << "];\n";

    for (ASTNode *child : root->children)
    {
        int childId = counter;
        generateDOT(child, out);
        out << "  node" << nodeId << " -> node" << childId << ";\n";
    }
}

void generateDOTFile(ASTNode *root, const string &baseName)
{
    ofstream dotfile(baseName+"_ast.dot");
    dotfile << "digraph AST {\n";
    dotfile << "  node [fontname=\"Arial\"];\n";
    generateDOT(root, dotfile);
    dotfile << "}\n";
    dotfile.close();
    cout << "DOT File Generated: "+baseName+"_ast.dot\n";
}