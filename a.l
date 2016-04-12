/* */
digit	[0-9]
letter	[A-Za-z]
%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
int linenum;
%}
%%

"#"	return DIEZ;
"include"	return INCLUDE;
\\n return SLARS; 
"for" return FOR;
"=" return ESIT;
\" return CIFTIRNAK;
"!" return UNLEM;

{letter}*".h"	return HEADER;
int|char|float|void yylval.string=strdup(yytext); return TYPE;
"return" return RETURN;
"<="|"||"|"<"|">"|">="|"=="|"!=" yylval.string=strdup(yytext);  return KESIT;
"(" return OPBR;
")" return CLBR;
"main" return MAIN;
"printf " return PRINTF;
"{" return OPARAN;
"}" return CPARAN;
, return VIRGUL;
; return COMA;
"&" return AMPERSAN;
"%" return PERCENTAGE;
"*" return CARPMA;
"+" return PLUS;
"-" return MINUS;
"/" return BOLME;
"else" return ELSE;
"scanf" return SCANF;
"'" return TEKTIRNAK;

"if" return IF;
{digit}* 	yylval.string=strdup(yytext); return NUMBER;
{digit}({letter}|{digit})* yylval.string=strdup(yytext); return CNTNTC;
{letter}({letter}|{digit})* yylval.string=strdup(yytext); return IDENT;	



\n	linenum++;
[ \t]+
%%


