/*** Definition section ***/

%{
/* C code to be copied verbatim */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parser_bison.h"
%}

/* This tells flex to read only one input file */
%option noyywrap
%option nounput

%%
    /*** Rules section ***/

    /* [0-9]+ matches a string of one or more digits */
[0-9]+  {
            yylval.num = atof(yytext);
            return NUMBER;
        }

    /* + */
\+     {
            return PLUS;
       }
\-     {
            return MINUS;
       }
\*     {
           return TIMES;
       }
\/     {
           return DIV;
       }
\(     {
           return LEFT_P;
       }
\)     {
           return RIGHT_P;
       }

"sqrt" {
           return SQRT;
       }

\n     {   
            return L_EOF;  
       }

%%