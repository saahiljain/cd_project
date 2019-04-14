%{
	#include"y.tab.h"
	int i=0,c=0,m=0,t=0,ms=0 ;
	char prog[1000]="";
%}
nl [\n]
multispace [\t' ']+
multiline [\n]+
inc "#include"[ ]?
sym1 [<][ ]?
sym2 [>]
sym3 ["]
lfil "stdio.h"[ ]?|"string.h"[ ]?|"stdlib.h"[ ]?|"math.h"[ ]?
ret "return"[ ]*[0-9]*[ ]*
ufil [a-zA-Z0-9_]+(".h"|".c")
comment [\/\/]([^\n])+[\n]
mcom \/\*(.\n)*.*\*\/
type_m "void "|""
type_i "int "
type_c "char "
type_f "float "
main "main"
par1 "("[ ]?
par2 ")"[ ]?[\n]?
flo1 "{"[ ]?[\n]*
flo2 "}"[\n]*
ac "int argc,"
av "char* argv[]"
prtf "printf"
lter ";"[\n]*

num [0-9]+
asop [ ]?"="[ ]?
oper ["+"|"-"]
while "while"[ ]?
relop [ >= | <= ]
if "if"[ ]?
else "else"{nl}
id [a-zA-Z][a-zA-Z0-9_]*
literal \"(.*)\"
%%
{nl} {fprintf(yyout,yytext);return NL;}
{multispace} {ms++;}
{multiline} {fprintf(yyout,"\n");return ML;}
{sym2} {fprintf(yyout,yytext);return T_SYM2;}
{sym1} {fprintf(yyout,yytext);return T_SYM1;}

{comment} {c++;}
{mcom} {m++;}
{if} {fprintf(yyout,yytext);return T_IF;}
{else} {fprintf(yyout,yytext);return T_ELSE;}
{while} {fprintf(yyout,yytext);return T_WHILE;}

{inc} {fprintf(yyout,yytext);return T_HEADER;}
{relop} {fprintf(yyout,yytext);return T_RELOP;}
{prtf} {fprintf(yyout,yytext);return T_PRINTF;}
{lfil} {fprintf(yyout,yytext);return T_LFILE;}
{sym3} {fprintf(yyout,yytext);return T_SYM3;}
{ret} {fprintf(yyout,yytext);return T_RET;}
{ufil} {fprintf(yyout,yytext);return T_UFILE;}


{type_m} {fprintf(yyout,yytext);return T_TYPE;}
{type_i} {fprintf(yyout,yytext);yylval="int";return T_TYPE;}
{type_c} {fprintf(yyout,yytext);return T_TYPE;}
{type_f} {fprintf(yyout,yytext);return T_TYPE;}
{main} {fprintf(yyout,yytext);return T_MAF;}
{par1} {fprintf(yyout,yytext);return T_PAR1;}
{par2} {fprintf(yyout,yytext);return T_PAR2;}
{flo1} {fprintf(yyout,"{\n");return T_FLO1;}
{flo2} {fprintf(yyout,"}\n");return T_FLO2;}
{ac} {fprintf(yyout,yytext);return T_AC;}
{av} {fprintf(yyout,yytext);return T_AV;}

{lter} {fprintf(yyout,";\n");return T_LTER;}
{id} {fprintf(yyout,yytext);yylval=yytext;return T_ID;}
{num} {fprintf(yyout,yytext);yylval=yytext;return T_NUM;}
{asop} {fprintf(yyout,yytext);return T_ASOP;}
{oper} {fprintf(yyout,yytext);return T_OPER;}


{literal} {fprintf(yyout,yytext);return T_LITERAL;}
. return 0;
%%

