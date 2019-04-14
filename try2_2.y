%{
	#include<stdio.h>
	#include<stdlib.h>
	#include"my_sym2.c"
%}
%token T_TYPE T_MAF T_PAR1 T_PAR2 T_FLO1 T_FLO2 T_AC T_AV T_RET T_LTER T_ID T_NUM T_ASOP T_OPER T_WHILE T_RELOP T_IF T_ELSE T_HEADER T_LFILE T_UFILE T_SYM1 T_SYM2 T_SYM3 NL ML T_PRINTF T_LITERAL

%%

start : var30 start_program {printf("Valid\n");display();exit(0);};
var30 : T_HEADER var31 var34;
var31 : T_SYM1 var32 T_SYM2
	| T_SYM3 var32 T_SYM3
	| T_SYM3 var33 T_SYM3
	;
var32 : T_LFILE;
var33 : T_UFILE;
var34 : ML var30
	|NL var30
	| NL
	| ML
	;

start_program : var 
	|
	;
var : T_TYPE T_MAF var1 var2;			//main function
var1 :T_PAR1 var9
	;
var2 : T_FLO1 var5 var4; 
var3 : T_AC T_AV;					//(int argc,char* argv[])
var4 : T_RET T_LTER T_FLO2			//return value for main(in most cases)
	| T_FLO2;
var5 : T_TYPE T_ID {insert($1,$2,0);} var12			//variable definition or declarations (some corrections) 
	| T_ID T_ASOP var7 var8			//variable assignment (some corrections)  operations
	| T_ID T_OPER T_OPER T_LTER var5		//Increment and decrement here T_OPER contains +,-,*,/ it could give wrong meaning in increment and decrement (some corrections) 
	| loop					//while loop
	| condition1				//if condition
	| var6 
	| 
	;
var6: T_PRINTF T_PAR1 var16 T_PAR2 T_LTER var5
	;
var7 : T_ID | T_NUM;
var8 : T_LTER var5
	| T_OPER var7 T_LTER var5
	;
var9 : T_PAR2
	| var3 T_PAR2;
loop : T_WHILE T_PAR1 var10 var13;
var10 : T_PAR2
	| var11 T_PAR2;
var11 : T_ID T_RELOP var7
	| T_ID T_SYM1 var7
	| T_ID T_SYM2 var7
	| T_ID
	;
var12 : T_ASOP var7 var8
	| T_LTER var5;

var13 : T_FLO1 var5 T_FLO2 var5;
var14 : T_FLO1 var5 T_FLO2;


condition1 : T_IF T_PAR1 var10 var14 condition2;	//else condition
condition2 : T_ELSE var13
		| var5
		;

var16 : T_LITERAL
	;
%%
int yyerror(char *msg)
{
	printf("Invalid\n");
	exit(0);
}
int main(int argc,char *argv[])
{
	extern FILE *yyin,*yyout;
	if(argc > 1)
		yyin = fopen(argv[1],"r+");
	yyout = fopen("out2_2.txt","w");
	yyparse();
}
