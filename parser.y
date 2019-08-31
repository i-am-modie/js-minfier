%{
    #include "symtab.c"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    extern FILE *yyin;
    extern FILE *yyout;
    extern int lineno;
    extern int yylex();
    void yyerror(char const *s);
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
    if_statement | for_statement | do_while_statement | while_statement | assigment SEMI | declaration SEMI |
    CONTINUE SEMI | BREAK SEMI | returns | function_call | function_declaration
;

returns: RETURN SEMI | RETURN variable SEMI;

variable: ID | ID array_position;

declaration: initialization ID assign;

initialization: VAR | /* empty */;

array_position: LBRACK ICONST RBRACK | LBRACK ID RBRACK;

assigment: variable assign;

assign: ASSIGN expression | /* empty */;

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
    assigment |
    sign constant |
    variable |
    array
;

array: LBRACK expressions RBRACK ;

expressions: expressions COMMA expression | expression | /* empty */;

sign: ADDOP | /* empty */;

constant: ICONST | FCONST | STRING;

function_declaration: FUNCTION ID LPAREN ids RPAREN tail;

ids: ids COMMA ID | ID | /* empty */ ;

function_call: ID LPAREN expressions RPAREN SEMI;
%%

void yyerror (char const *s)
{
  fprintf(stderr, "Syntax error at line %d\n", lineno);
  fprintf (stderr, "%s\n", s);
  exit(1);
}

int main (int argc, char *argv[]){

    init_hash_table();

    int flag;
    yyin = fopen(argv[1], "r");
    flag = yyparse();
    fclose(yyin);

    yyout = fopen("symtab_dump.out", "w");
    symtab_dump(yyout);
    fclose(yyout);
    
    return flag;
}