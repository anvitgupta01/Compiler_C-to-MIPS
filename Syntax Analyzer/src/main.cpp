#include <bits/stdc++.h>
#include <csignal>
#include "../include/ast.h"

using namespace std;

void printLexicalAnalysisOutput();
int yyparse();

extern FILE *yyin;
ofstream outputFile;
ofstream outputFileLex;

ASTNode *root;
vector<pair<int, pair<string, string>>> identifierToType;
vector<string> lexicalErrors;
vector<string> syntaxErrors;

void printSyntaxAnalysisOutput(vector<pair<int, pair<string, string>>> identifierToType)
{
    if (syntaxErrors.size())
    {
        for (auto syntaxError : syntaxErrors)
        {
            outputFile << syntaxError << endl;
        }
        outputFile << endl;
        outputFile << "Parsing failed due to above errors." << endl;
        return;
    }
    sort(identifierToType.begin(), identifierToType.end(),
         [](const auto &a, const auto &b)
         {
             if (a.first > b.first)
                 return false;
             return true;
         });

    const string lineNumber = "Line";
    const string headerToken = "Token";
    const string headerTokenType = "Token_Type";

    int lineWidth = 12;
    int tokenWidth = 48;
    int tokenTypeWidth = 48;

    auto printBorder = [&]()
    {
        outputFile << "+-"
                   << string(lineWidth, '-')
                   << "-+-"
                   << string(tokenWidth, '-')
                   << "-+-"
                   << string(tokenTypeWidth, '-')
                   << "-+\n";
    };

    printBorder();
    outputFile << "| " << left << setw(lineWidth) << lineNumber
               << " | " << left << setw(tokenWidth) << headerToken
               << " | " << left << setw(tokenTypeWidth) << headerTokenType
               << " |\n";
    printBorder();

    for (const auto &entry : identifierToType)
    {
            outputFile << "| " << left << setw(lineWidth) << entry.first
                       << " | " << left << setw(tokenWidth) << entry.second.first
                       << " | " << left << setw(tokenTypeWidth) << entry.second.second
                       << " |\n";
    }

    printBorder();
}

void handleSegmentationFault(int signum) {
    if (outputFile.is_open()) {
        outputFile << "Syntax Error detected in the program."<<endl<<endl;
        outputFile <<"Parsing terminated due to above errors."<<endl;

        outputFile.close();
    }
    if (outputFileLex.is_open()) {
        outputFileLex.close();
    }
    exit(signum);
}

int main(int argc, char *argv[])
{
    signal(SIGSEGV, handleSegmentationFault);
    string inputFile = argv[1];
    string baseName = inputFile.substr(0, inputFile.find_last_of('.'));

    yyin = fopen(inputFile.c_str(), "r");
    if (!yyin)
    {
        cerr << "Error: Cannot open input file " << inputFile << endl;
        return 1;
    }
    outputFile.open(baseName + "_output.txt");
    if (!outputFile)
    {
        cerr << "Error: Cannot open output file " << baseName << "_output.txt" << endl;
        return 1;
    }

    outputFileLex.open(baseName + "_output_lex.txt");
    if (!outputFileLex)
    {
        cerr << "Error: Cannot open lex output file " << baseName << "_output_lex.txt" << endl;
        return 1;
    }
    yyparse();
    printLexicalAnalysisOutput();
    printSyntaxAnalysisOutput(identifierToType);
    if (!syntaxErrors.size() && !lexicalErrors.size())
    {
        generateDOTFile(root, baseName);
    }
    fclose(yyin);
    outputFile.close();
    outputFileLex.close();

    return 0;
}