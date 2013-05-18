%{
#include <string>
#include <stdio.h>
#include "parser.hpp"

inline int strToken( int token ){
    yylval.string = new std::string( yytext, yyleng );
    printf("STR TOKEN %s\n", yytext);
    return token;
}

inline int numToken( int token ){
    yylval.token = token;
    return token;
}

%}

%%
[ \t\n] ;
[a-zA-Z_][a-zA-Z0-9_]*  return strToken(T_IDENTIFIER);
[+|-]?[0-9]+\.[0-9]*    return strToken(T_NUM_DOUBLE);
[+|-]?[0-9]+            return strToken(T_NUM_INTEGER);
"="                     return numToken(T_EQUAL);
"=="                    return numToken(T_CMP_EQ);
"!="                    return numToken(T_CMP_NE);
"<"                     return numToken(T_CMP_LT);
"<="                    return numToken(T_CMP_LE);
">"                     return numToken(T_CMP_GT);
">="                    return numToken(T_CMP_GE);
"("                     return numToken(T_LPAREN);
")"                     return numToken(T_RPAREN);
"{"                     return numToken(T_LBRACE);
"}"                     return numToken(T_RBRACE);
";"                     return numToken(T_SEMI);
"+"                     return numToken(T_PLUS);
"-"                     return numToken(T_MINUS);
"/"                     return numToken(T_DIV);
"*"                     return numToken(T_MUL);
.                       printf("Unkown token!\n"); yyterminate();
%%

int yywrap()
{
    return 1;
}