flex lexer.l
bison -d parser.y
gcc -o js-minifier symtab.h parser.tab.c lex.yy.c
