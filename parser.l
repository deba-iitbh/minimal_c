%{
	#include<stdio.h>
	#include "syntax.h"
	void count();
%}

D	[0-9]
L	[a-zA-Z_]
H	[a-fA-F0-9]
E	[Ee][+-]?{D}+
FS	(f|F|l|L)

%option noyywrap

%%
"const"		{ count(); return(CONST); }
"void"		{ count(); return(VOID); }
"int"		{ count(); return(INT); }
"long"		{ count(); return(LONG); }
"char"		{ count(); return(CHAR); }
"float"		{ count(); return(FLOAT); }
"double"	{ count(); return(DOUBLE); }
"if"		{ count(); return(IF); }
"else"		{ count(); return(ELSE); }
"for"		{ count(); return(FOR); }
"while"		{ count(); return(WHILE); }
"break"		{ count(); return(BREAK); }
"continue"	{ count(); return(CONTINUE); }
"return"	{ count(); return(RETURN); }

{L}({L}|{D})*		{ count(); return(IDENTIFIER); }
0[xX]{H}+		{ count(); return(CONSTANT); } /* hexadecimal */
0{D}+			{ count(); return(CONSTANT); } /* octal */
{D}+			{ count(); return(CONSTANT); } /* decimal */
{D}+{E}{FS}?		{ count(); return(CONSTANT); } /* exponent */
{D}*"."{D}+({E})?{FS}?	{ count(); return(CONSTANT); } /* exponent - precision */
{D}+"."{D}*({E})?{FS}?	{ count(); return(CONSTANT); } /* exponent - precision */

"++"		{ count(); return(INC_OP); }
"--"		{ count(); return(DEC_OP); }
";"		{ count(); return(';'); }
"{"		{ count(); return('{'); }
"}"		{ count(); return('}'); }
","		{ count(); return(','); }
"="		{ count(); return('='); }
"("		{ count(); return('('); }
")"		{ count(); return(')'); }
"!"		{ count(); return('!'); }
"-"		{ count(); return('-'); }
"+"		{ count(); return('+'); }
"*"		{ count(); return('*'); }
"/"		{ count(); return('/'); }

"//".*" "*	{}
"/*"([^*]|(\*+[^*/]))*\*+\/	{}
[ \t\v\n\f]	{  count();/* escape all spaces */ }
.		{ /* ignore bad characters */ }

%%

int column = 0;
void count()
{
	int i;
	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;

	ECHO;
}
