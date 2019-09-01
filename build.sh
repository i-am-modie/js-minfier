bison -d parser.y --debug
flex lexer.l
gcc -o js-minifier symtab.h parser.tab.c lex.yy.c
