#!/bin/bash

# Define the test directory
TEST_DIR="Tests"

# Ensure lexer.exe exists
if [ ! -f "./lexer.exe" ]; then
    echo "Error: lexer.exe not found!"
    exit 1
fi

# Loop through each set (Set 1, Set 2, Set 3)
for SET in "$TEST_DIR"/Set*; do
    if [ -d "$SET" ]; then
        echo "Processing $SET..."

        # Loop through all `.c` files in the set directory
        for INPUT_FILE in "$SET"/*.c; do
            if [ -f "$INPUT_FILE" ]; then
                # Get the filename without the extension
                FILENAME=$(basename "$INPUT_FILE" .c)
                
                # Define output file path
                OUTPUT_FILE="$SET/${FILENAME}_output.txt"

                echo "Running lexer on $INPUT_FILE..."

                # Run lexer and store output
                ./lexer.exe "$INPUT_FILE"
                
                echo "Output saved to $OUTPUT_FILE"
            fi
        done
    fi
done

echo "All test cases executed."
