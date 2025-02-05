LEX = flex
CXX = g++

LEX_FILE = lex.l
LEX_GEN_C = lex.yy.c
EXECUTABLE = lexer

all: $(EXECUTABLE)

$(LEX_GEN_C): $(LEX_FILE)
	$(LEX) $(LEX_FILE)

$(EXECUTABLE): $(LEX_GEN_C)
	$(CXX) $(LEX_GEN_C) -o $(EXECUTABLE)


clean:
	rm -f $(LEX_GEN_C) $(EXECUTABLE)
