%option noyywrap
 
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "symtab.h"
    #include "parser.tab.h"
    extern FILE *yyin;
    extern FILE *yyout;
   
    int lineno = 1; // initialize to 1
    void ret_print(char *token_type);
    void yyerror();
%}
 
%x ML_COMMENT
 
alpha       [a-zA-Z]
digit       [0-9]
alnum       {alpha}|{digit}
print       [ -~]
 
ID          {alpha}+{alnum}*
ICONST      "0"|[0-9]{digit}*
FCONST      "0"|{digit}*"."{digit}+
STRING      (\"{print}*\")|(\'{print}*\')
 
%%
 
"//".*                  { printf("Eat up comment at line %d\n", lineno); }
 
"/*"                    { printf("Eat up comment from line %d ", lineno); BEGIN(ML_COMMENT); }
<ML_COMMENT>"*/"        { printf("to line %d\n", lineno); BEGIN(INITIAL); }
<ML_COMMENT>[^*\n]+    
<ML_COMMENT>"*"        
<ML_COMMENT>"\n"        { lineno += 1; }
 
 
"var"|"VAR"           { return VAR; }
"if"|"IF"               { return IF; }
"else"|"ELSE"           { return ELSE; }
"while"|"WHILE"         { return WHILE; }
"for"|"FOR"             { return FOR; }
"continue"|"CONTINUE"   { return CONTINUE; }
"break"|"BREAK"         { return BREAK; }
"function"|"FUNCTION"   { return FUNCTION; }
"return"|"RETURN"       { return RETURN; }
"do"|"DO"               { return DO; }
 
 
"+"|"-"                 { return ADDOP; }
"*"                     { return MULOP; }
"/"                     { return DIVOP; }
"++"|"--"               { return INCR; }
"||"                    { return OROP; }
"&&"                    { return ANDOP; }
"!"                     { return NOTOP; }
"=="|"!="               { return EQUOP; }
"==="|"!=="               { return IDOP; }
">"|"<"|">="|"<="       { return RELOP; }
 
 
"("             { return LPAREN; }
")"             { return RPAREN; }
"]"             { return LBRACK; }
"["             { return RBRACK; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
";"             { return SEMI; }
"."             { return DOT; }
","             { return COMMA; }
"="             { return ASSIGN; }
 
 
{ID}            {
                    insert(yytext, strlen(yytext), UNDEF, lineno);
                    return ID;
                } 
{ICONST}        { return ICONST; }
{FCONST}        { return FCONST; }
{STRING}        { return STRING; }

"\n"            { lineno += 1; }
[ \t\r\f]+          /* eat up whitespace */
 
.               { yyerror("Unrecognized character"); }
 
%%