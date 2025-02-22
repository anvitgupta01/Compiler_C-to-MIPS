CXX = g++
BISON = bison -Wnone
FLEX = flex
DOT = dot

EXECUTABLE = executable

LEX_FILE = patterns.l
YACC_FILE = parser.y

AST_FILE = ast.cpp
MAIN_FILE = main.cpp
UTILITY_FILE = utility.cpp

YACC_HEADER = parser.tab.h
YACC_SOURCE = parser.tab.c
LEX_SOURCE = lex.yy.c

TEST_DIR = ../tests
SRC_FILE = ../source.c

all: $(EXECUTABLE)

$(EXECUTABLE): $(YACC_SOURCE) $(LEX_SOURCE) $(MAIN_FILE) $(UTILITY_FILE)
	$(CXX) -o $(EXECUTABLE) $(MAIN_FILE) $(YACC_SOURCE) $(LEX_SOURCE) $(UTILITY_FILE) $(AST_FILE)

$(YACC_SOURCE): $(YACC_FILE)
	$(BISON) -d $(YACC_FILE)

$(LEX_SOURCE): $(LEX_FILE)
	$(FLEX) $(LEX_FILE)

run: $(EXECUTABLE)
	@for file in $(TEST_DIR)/*.c; do \
		base_name=$$(basename $$file .c); \
		echo "Processing: $$file"; \
		./$(EXECUTABLE) $$file $(FLAGS); \
		if [ -f "$(TEST_DIR)/$${base_name}_ast.dot" ]; then \
			echo "Generating AST PNG for $${base_name}_ast.dot"; \
			$(DOT) -Tpng $(TEST_DIR)/$${base_name}_ast.dot -o $(TEST_DIR)/$${base_name}_ast.png; \
		fi; \
	done

SRC_FILE = ../source.c

run_single: $(EXECUTABLE)
	@echo "Processing: $(SRC_FILE)"; \
	./$(EXECUTABLE) $(SRC_FILE); \
	base_name=$$(basename $(SRC_FILE) .c); \
	if [ -f "../$${base_name}_ast.dot" ]; then \
		echo "Generating AST PNG for $${base_name}_ast.dot"; \
		$(DOT) -Tpng ../$${base_name}_ast.dot -o ../$${base_name}_ast.png; \
	fi;


clean:
	rm -f $(EXECUTABLE) $(YACC_SOURCE) $(YACC_HEADER) $(LEX_SOURCE) \
	$(TEST_DIR)/*_output.txt $(TEST_DIR)/*_output_lex.txt $(TEST_DIR)/*.dot $(TEST_DIR)/*_ast.png \
	../source_output.txt ../source_output_lex.txt ../source_ast.dot ../source_ast.png
