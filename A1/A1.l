

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>



#include "A1.tab.h" // the output of bison on adder.y

%}

%%


"="				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return EQ;
				}
"/"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return DIV; 
				}
"*"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return MUL;  
				}
"+"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return ADD;
				}
"-"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return SUB;
				}
";"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return SEMICOLON;
				}
","				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return COMMA;
				}
"?"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return QUES;
				}
"!"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return NOT;
				}
"."				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return DOT;
				}

"("				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return LB;
				}
")"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return RB;
				}
"{"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return LC;
				}
"}"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return RC;
				}
"["				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return LS;
				}
"]"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return RS;
				}

"class"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return CLASS;
				}

"public"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return PUBLIC;
				}
"static"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return STATIC;
				}
"void"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return VOID;
				}
"main"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return MAIN;
				}

"String"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return STRING;
				}

"System.out.println"		{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return SOP;
				}

"extends"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return EXTENDS;
				}
"return"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return RETURN;
				}
"int"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return INT;
				}
"boolean"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return BOOL;
				}
"if"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return IF;
				}
"else"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return ELSE;
				}
"while"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+3);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return WHILE;
				}
"&&"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return AND;
				}
"||"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return OR;
				}
"!="				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return NEQ;
				}
"<="				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return LEQ;
				}
".length"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+3);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return LENGTH;
				}
"true"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return TRUEVAL;
				}
"false"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return FALSEVAL;
				}
"this"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return THIS;
				}
"new"				{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return NEW;
				}
"#defineExpr0"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return HDEF0;
				}
"#defineExpr1"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return HDEF1;
				}
"#defineExpr2"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return HDEF2;
				}
"#defineExpr"			{	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return HDEF;
				}
"#defineStmt0"                   {	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return HSTMT0;
				}
"#defineStmt1"                   {	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return HSTMT1;
				}
"#defineStmt2"                   {	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return HSTMT2;
				}
"#defineStmt"                   {	int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return HSTMT;
				}
[ \t\n\r\f]+		;		//do nothing on whitespace
                             
<<EOF>>				 {return 0;}
"//".*		;                      //do nothing on comment

[a-zA-Z_][a-zA-Z0-9_]*   	{

					int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+5);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					return IDENTIFIER;
					}

[0-9]+			{ 
					
					int n=0;
                                       n=strlen(yytext);
                                       yylval.text = (char*)malloc(strlen(yytext)+1);
					//yylval.text[0]='\0';
					strcpy(yylval.text,yytext);
					
					return INTEGER; 
				}

.				{printf("//Failed to parse input code");return 1;}

%%

void yyerror(char* str) { printf("//Failed to parse input code"); exit(0);}



int main(void) {
	yyparse();	
}
