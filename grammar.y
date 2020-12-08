%{
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <math.h>

/* Flex functions */
extern int yylex(void);
extern void yyterminate();
void yyerror(const char *s);
extern FILE* yyin;
void yy_scan_string(const char *str);
%}

%union {
	int index;
	int num;
}

%token<num> NUMBER
%token<num> PLUS
%token<num> MINUS
%token<num> TIMES
%token<num> DIV

%token<num> L_EOF

%token<num> LEFT_P
%token<num> RIGHT_P

%token<num> SQRT

%type<num> expr
%type<num> calcul

/* Associativity */
%left PLUS
%left MINUS
%left DIV
%left TIMES

/* Grammar HERE */
%%

main: 
    | main calcul
    ;

calcul: expr
    | calcul L_EOF { printf(" => %i\n",$1); }
;

expr: NUMBER { $$ = $1; /* printf("NUMBER: %i\n", $1); */}
    | expr PLUS expr { $$ = $1 + $3; }
    | expr MINUS expr { $$ = $1 - $3; }
    | expr DIV expr { $$ = $1 / $3; }
    | expr TIMES expr { $$ = $1 * $3; }
    | LEFT_P expr RIGHT_P { $$ = ( $2 ); }
    | SQRT LEFT_P expr RIGHT_P { $$ = (int)sqrt((int)$3); }
    ;

%%
int main(void)
{
    char *line = NULL;
    size_t size = 0;

    for (;;)
    {
        printf("CALC> ");

        if (getline(&line, &size, stdin) != -1)
        {
            yy_scan_string(line);
            yyparse();
        }
        else
            break;
    }
    printf("\n");
    return 0;
}

void yyerror(const char *s)
{
	printf("YYERROR: %s\n", s);
}