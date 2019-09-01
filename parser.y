%{
    #include "symtab.c"
    #include "randomString.c"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    extern FILE *yyin;
    extern FILE *yyout;
    extern int lineno;
    extern int yylex();
    void yyerror();
%}

/* token definition */
%token VAR IF ELSE DO WHILE FOR CONTINUE BREAK FUNCTION RETURN 
%token ADDOP SUBOP MULOP DIVOP INCR DECR OROP ANDOP NOTOP EQUOP NEQUOP IDOP NIDOP GROP LSOP GREOP LSEOP
%token LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE COLON SEMI DOT COMMA ASSIGN
%token ID ICONST FCONST STRING

%left LPAREN RPAREN LBRACK RBRACK
%right NOTOP INCR DECR
%left MULOP DIVOP
%left ADDOP SUBOP
%left EQUOP NEQUOP IDOP NIDOP
%left OROP 
%left ANDOP 
%right ASSIGN 
%left COMMA 

%start program

%%

program: statements;

statements: statements statement | statement;

statement:
    if_statement | for_statement | do_while_statement | while_statement | assigment SEMI | declaration SEMI |
    CONTINUE SEMI | BREAK SEMI | returns | function_call | function_declaration | variable pre_post_operation SEMI | pre_post_operation variable SEMI 
;

returns: RETURN SEMI | RETURN variable SEMI;

variable: ID | ID array_position | ID object_property;

declaration: VAR ID assign_tail;

array_position: LBRACK ICONST RBRACK | LBRACK ID RBRACK;

assigment: variable assign_tail;

assign_tail: ASSIGN expression | /* empty */;

if_statement: IF LPAREN expression RPAREN tail else_if_part else_part;

else_if_part: 
    else_if_part ELSE IF LPAREN expression RPAREN tail |
    ELSE IF LPAREN expression RPAREN tail  |
    /* empty */
; 

else_part: ELSE tail | /* empty */ ; 

for_statement: FOR LPAREN assigment SEMI expression SEMI expression RPAREN tail ;

while_statement: WHILE LPAREN expression RPAREN tail ;

do_while_statement: DO tail WHILE RPAREN expression RPAREN ;

tail: statement SEMI | LBRACE statements RBRACE ;

expression:
    expression operation expression |
    expression pre_post_operation |
    pre_post_operation expression |
    LPAREN expression RPAREN |
    array | 
    variable |
    object |
    sign constant 
;

operation: ADDOP | SUBOP | MULOP | DIVOP | OROP | ANDOP | equality_operation | relation_operation; 

equality_operation: EQUOP | NEQUOP | IDOP | NIDOP;

relation_operation: GROP | LSOP | GREOP | LSEOP;

pre_post_operation: INCR | DECR ;

array: LBRACK expressions RBRACK ;

expressions: expressions COMMA expression | expression | /* empty */;

sign: SUBOP | /* empty */;

constant: ICONST | FCONST | STRING;

function_declaration: FUNCTION ID LPAREN ids RPAREN tail;

ids: ids COMMA ID | ID | /* empty */ ;

function_call: ID LPAREN expressions RPAREN SEMI;

object: LBRACE kvps RBRACE;

object_property: object_property DOT ID | DOT ID;

kvps: kvps COMMA kvp | kvp | /* empty */;

kvp: ID COLON expression

%%

void yyerror ()
{
  fprintf(stderr, "Syntax error at line %d\n", lineno);
  exit(1);
}

int main (int argc, char *argv[]){
    #ifdef YYDEBUG
    if(argv[2]){
        yydebug= abs(strcmp( argv[2], "-d "));
    }
    #endif
    init_hash_table();
    yyout = fopen("minified.js", "w");

    int flag;
    yyin = fopen(argv[1], "r");
    flag = yyparse();
    fclose(yyin);

    fclose(yyout);
    
    return flag;
}