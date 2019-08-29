%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    extern FILE *yyin;
    extern int lineno;
    extern int yylex();
    void yyerror();
%}

/* token definition */
%token VAR IF ELSE DO WHILE FOR CONTINUE BREAK FUNCTION RETURN 
%token ADDOP MULOP DIVOP INCR OROP ANDOP NOTOP EQUOP IDOP RELOP
%token LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE SEMI DOT COMMA ASSIGN 
%token ID ICONST FCONST STRING 

%start program

%%

program: statements;

statements: statements statement | statement;

statement:
    if_statement | for_statement | do_while_statement | while_statement | assigment | declaration |
    CONTINUE SEMI | BREAK SEMI | RETURN SEMI
;

declaration: initialization ID SEMI;

assigment: initialization ID ASSIGN expression SEMI;

initialization: VAR | /* empty */;

if_statement: IF LPAREN expression RPAREN tail else_if_part else_part;

else_if_part: 
    else_if_part ELSE IF LPAREN expression RPAREN tail |
    ELSE IF LPAREN expression RPAREN tail  |
    /* empty */
; 

else_part: ELSE tail | /* empty */ ; 

for_statement: FOR LPAREN expression SEMI expression SEMI expression RPAREN tail ;

while_statement: WHILE LPAREN expression RPAREN tail ;

do_while_statement: DO tail WHILE RPAREN expression RPAREN ;

tail: statement SEMI | LBRACE statements RBRACE ;

expression:
    expression ADDOP expression |
    expression MULOP expression |
    expression DIVOP expression |
    expression INCR |
    INCR expression |
    expression OROP expression |
    expression ANDOP expression |
    NOTOP expression |
    expression EQUOP expression |
    expression RELOP expression |
    expression IDOP expression |
    LPAREN expression RPAREN |
    ID |
    sign constant
;

sign: ADDOP | /* empty */;

constant: ICONST | FCONST | STRING

%%

void yyerror ()
{
  fprintf(stderr, "Syntax error at line %d\n", lineno);
  exit(1);
}

int main (int argc, char *argv[]){

    int flag;
    yyin = fopen(argv[1], "r");
    flag = yyparse();
    fclose(yyin);
    
    return flag;
}