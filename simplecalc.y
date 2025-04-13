%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
 void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }

float variables[26];

%}

%token COMMENT FLOAT INT ASSIGN INUM FNUM ID PRINT
%token PLUS MINUS MULTIPLIED DIVIDED

%left PLUS MINUS
%left MULTIPLIED DIVIDED


%%

program:
        statement_list;


statement_list:
        statement_list statement 
        | statement;


statement:
        COMMENT
        |FLOAT ID                { variables[$2] = 0.0; } 
        |INT ID                  { variables[$2] = 0.0; } 
        |ID ASSIGN expression    { variables[$1] = $3; printf("%c = %f\n", $1 + 'a', $3); }
        |PRINT ID                { printf("PRINT %c = %f\n", $2 + 'a', variables[$2]); };


expression: 
        expression PLUS expression            { $$ = $1 + $3;}
        |expression MINUS expression          { $$ = $1 - $3;}
        |expression MULTIPLIED expression     { $$ = $1 * $3;}
        |expression DIVIDED expression        { if($3 == 0){
                                                yyerror("Error división por cero");
                                                exit(1);}
                                                else{
                                                $$ = $1 / $3;}
                                              }
        |INUM                                 { $$ = $1; }
        |FNUM                                 { $$ = $1; }
        |ID                                   { $$ = variables[$1]; }
 ;

%%

int main(){
        yyparse();
        return 0;
}