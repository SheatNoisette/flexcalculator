CFLAGS = -W -Wall -std=c99
LDFLAGS = -lm

LEXER_FILE = lexer.l
LEXER_C = lexer_flex.c

PARSER_FILE = grammar.y
PARSER_C = parser_bison.c
PARSER_HEADER = parser_bison.h


SRC = $(PARSER_C) $(LEXER_C)

# This is not used because make can't locate SRC after generation
OBJ = $(SRC:.c=.o)
BIN = calc

all: lexer parser calc

# Fixme: use OBJs
calc:
	gcc $(SRC) $(LDFLAGS) -o $(BIN)


lexer:
	flex -o $(LEXER_C) $(LEXER_FILE)

parser:
	bison -o $(PARSER_C) -d $(PARSER_FILE)

clean:
	$(RM) $(BIN) *.o
	$(RM) $(LEXER_C) $(PARSER_C) $(PARSER_HEADER)