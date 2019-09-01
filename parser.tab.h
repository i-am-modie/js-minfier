/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    VAR = 258,
    IF = 259,
    ELSE = 260,
    DO = 261,
    WHILE = 262,
    FOR = 263,
    CONTINUE = 264,
    BREAK = 265,
    FUNCTION = 266,
    RETURN = 267,
    ADDOP = 268,
    SUBOP = 269,
    MULOP = 270,
    DIVOP = 271,
    INCR = 272,
    DECR = 273,
    OROP = 274,
    ANDOP = 275,
    NOTOP = 276,
    EQUOP = 277,
    NEQUOP = 278,
    IDOP = 279,
    NIDOP = 280,
    GROP = 281,
    LSOP = 282,
    GREOP = 283,
    LSEOP = 284,
    LPAREN = 285,
    RPAREN = 286,
    LBRACK = 287,
    RBRACK = 288,
    LBRACE = 289,
    RBRACE = 290,
    COLON = 291,
    SEMI = 292,
    DOT = 293,
    COMMA = 294,
    ASSIGN = 295,
    ID = 296,
    ICONST = 297,
    FCONST = 298,
    STRING = 299
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
