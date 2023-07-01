/* A Bison parser, made by GNU Bison 2.4.2.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2006, 2009-2010 Free Software
   Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     CHAR = 258,
     INT = 259,
     DOUBLE = 260,
     IF = 261,
     ELSE = 262,
     WHILE = 263,
     FOR = 264,
     CONTINUE = 265,
     BREAK = 266,
     VOID = 267,
     RETURN = 268,
     ADDOP = 269,
     SUBOP = 270,
     MULOP = 271,
     DIVOP = 272,
     INCR = 273,
     DECR = 274,
     OROP = 275,
     ANDOP = 276,
     NOTOP = 277,
     EQUOP = 278,
     NEQUOP = 279,
     GTEQ = 280,
     GT = 281,
     LTEQ = 282,
     LT = 283,
     LPAREN = 284,
     RPAREN = 285,
     LBRACE = 286,
     RBRACE = 287,
     SEMI = 288,
     ASSIGN = 289,
     COMMA = 290,
     ID = 291,
     ICONST = 292,
     FCONST = 293,
     CCONST = 294,
     STRING = 295
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1685 of yacc.c  */
#line 11 "parser.y"

    char str_val[100];
    int int_val;



/* Line 1685 of yacc.c  */
#line 98 "parser.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


