bison -d parser.y --debug
flex lexer.l
gcc -o js-minifier randomString.h symtab.h parser.tab.c lex.yy.c
