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
    list_t* current_id = NULL;
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
 
"//".*                  { /* printf("Eat up comment at line %d\n", lineno); */ }
 
"/*"                    { /* printf("Eat up comment from line %d ", lineno); */ BEGIN(ML_COMMENT); }
<ML_COMMENT>"*/"        { /* printf("to line %d\n", lineno); */ BEGIN(INITIAL); }
<ML_COMMENT>[^*\n]+    
<ML_COMMENT>"*"        
<ML_COMMENT>"\n"        { lineno += 1; }
 
 
"var"|"VAR"             { fprintf(yyout, "var "); return VAR; }
"if"|"IF"               { fprintf(yyout, "if"); return IF; }
"else"|"ELSE"           { fprintf(yyout, "else "); return ELSE; }
"while"|"WHILE"         { fprintf(yyout, "while"); return WHILE; }
"for"|"FOR"             { fprintf(yyout, "for"); return FOR; }
"continue"|"CONTINUE"   { fprintf(yyout, "continue"); return CONTINUE; }
"break"|"BREAK"         { fprintf(yyout, "break"); return BREAK; }
"function"|"FUNCTION"   { fprintf(yyout, "function "); return FUNCTION; }
"return"|"RETURN"       { fprintf(yyout, "return "); return RETURN; }
"do"|"DO"               { fprintf(yyout, "do"); return DO; }
 
"+"                     { fprintf(yyout, "+"); return ADDOP; }
"-"                     { fprintf(yyout, "-"); return SUBOP; }
"*"                     { fprintf(yyout, "*"); return MULOP; }
"/"                     { fprintf(yyout, "/"); return DIVOP; }
"++"                    { fprintf(yyout, "++"); return INCR; }
"--"                    { fprintf(yyout, "--"); return DECR; }
"||"                    { fprintf(yyout, "||"); return OROP; }
"&&"                    { fprintf(yyout, "&&"); return ANDOP; }
"!"                     { fprintf(yyout, "!"); return NOTOP; }
"=="                    { fprintf(yyout, "=="); return EQUOP; }
"!="                    { fprintf(yyout, "!="); return NEQUOP; }
"==="                   { fprintf(yyout, "==="); return IDOP; }
"!=="                   { fprintf(yyout, "!=="); return NIDOP; }
">"                     { fprintf(yyout, ">"); return GROP; }
"<"                     { fprintf(yyout, "<"); return LSOP; }
">="                    { fprintf(yyout, ">="); return GREOP; }
"<="                    { fprintf(yyout, "<="); return LSEOP; }
 
 
"("             { fprintf(yyout, "("); return LPAREN; }
")"             { fprintf(yyout, ")"); return RPAREN; }
"["             { fprintf(yyout, "["); return LBRACK; }
"]"             { fprintf(yyout, "]"); return RBRACK; }
"{"             { fprintf(yyout, "{"); return LBRACE; }
"}"             { fprintf(yyout, "}"); return RBRACE; }
";"             { fprintf(yyout, ";"); return SEMI; }
":"             { fprintf(yyout, ":"); return COLON; }
"."             { fprintf(yyout, "."); return DOT; }
","             { fprintf(yyout, ","); return COMMA; }
"="             { fprintf(yyout, "="); return ASSIGN; }
 
 
{ID}            {
                    insert(yytext, strlen(yytext), UNDEF, lineno);
                    current_id = lookup(yytext);
                    fprintf(yyout, "%s%s", "v", current_id->new_name);
                    return ID;
                } 
{ICONST}        { fprintf(yyout, "%s", yytext); return ICONST; }
{FCONST}        { fprintf(yyout, "%s", yytext); return FCONST; }
{STRING}        { fprintf(yyout, "%s", yytext); return STRING; }

"\n"            { lineno += 1; }
[ \t\r\f]+          /* eat up whitespace */
 
.               { yyerror("Unrecognized character"); }
 
%%