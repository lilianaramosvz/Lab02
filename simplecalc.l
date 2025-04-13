%{
#include "y.tab.h"
#include <stdlib.h>

extern int yylval;

%}

%option noyywrap


%%
"comment"              { return COMMENT; }
"f"                    { return FLOAT; }
"i"                    { return INT; }
"p"                    { return PRINT; }

"+"                    { return PLUS;}
"-"                    { return MINUS; }
"*"                    { return MULTIPLIED; }
"/"                    { return DIVIDED; }
"="                    { return ASSIGN; }

[a-z]                  { yylval = yytext[0] - 'a'; return ID; }
[0-9]+\.[0-9]+         { yylval = atof(yytext); return FNUM; }
[0-9]+                 { yylval = atoi(yytext); return INUM; }

[ \t] ;                /* ignore whitespace */
\n ;           /* ignore jumps */
. return yytext[0];


%%