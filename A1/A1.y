//Shone Pansambal
//CS19B042
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>




int count_mac=0;
struct Macros
{
  char * idf;
  char * vals;
  char * params;
  char ** arg;
  int numarg;
};


    
struct Macros M[500];



char** split(char* arg,int * num){
      if(arg==NULL)
            {*num=0;return NULL;}
     
      *num=1;
      int l=strlen(arg);
      int i=0,k=0,j=0;
      while(i<l)
      { 
        if(arg[i]==',')
         (*num)++;
        i++;
      } 
      
      char** s=(char**)malloc(((*num)+1)*sizeof(char*));
      i=0;
      while(i<(*num))
        {s[i]=(char*)malloc((l+1)*sizeof(char));
        i++;
        }
        
      i=0;
      
      
      while(i<l){
        if(arg[i]==',')
        {s[k][j]='\0';j=0;k++;i++;}
        else if(arg[i]==' ')
         i++;
        else
           { s[k][j++]=arg[i];i++;}
        
       }
       s[k][j]='\0';
       return s;
}


    
char* replace(char* idf,char* arglist){
       
        int ind,i,j,flag=0,n,pos=0,k=0;
        for(ind=0;ind<count_mac;ind++)
          {
            if(strcmp(M[ind].idf,idf)==0)
                {flag=1;break;}
                
          }
          
        int l=strlen(M[ind].vals);
       //  printf("%s %s %s\n",idf,arglist,M[ind].vals);  
        if(flag==0)
         {printf("//Failed to parse input code");exit(0);}
        
        char** arg_exp=split(arglist,&n);
        if(n!=M[ind].numarg)
          {  printf("//Failed to parse input code");exit(0);}
        
        char* ans=(char*)malloc(10000*sizeof(char));
        char *a=(char*)malloc((l+5)*sizeof(char));
        a[0]='\0';
        ans[0]='\0';
        
         
 
        
        for(int i=0;i<l;i++)
        { 
          char x=M[ind].vals[i];
          if(x<='Z' && x>='A')
           a[k++]=M[ind].vals[i];
          else if(x<='z' && x>='a')
           a[k++]=M[ind].vals[i];
          else if(x<='9' && x>='0')
           a[k++]=M[ind].vals[i];
          else if(x=='_')
           a[k++]=M[ind].vals[i];
          else
           {
            a[k]='\0';
            
            int tem=0;
                for(j=0;j<M[ind].numarg;j++){
                    if(strcmp(M[ind].arg[j],a)==0){ 
                        tem=1;
                        strcat(ans,arg_exp[j]);
                        pos=pos+strlen(arg_exp[j]);
                        a[0]='\0';
                        k=0;
                        j=n;
                        }
                    }
                if(tem==0)
                {a[k]='\0';
                strcat(ans,a);
                pos=pos+strlen(a);k=0;
                ans[pos++]=M[ind].vals[i];
                ans[pos]='\0';
                }
           }
        
        }
        strcat(ans,a);
                pos=pos+strlen(a);k=0;
                ans[pos++]=M[ind].vals[i];
                ans[pos]='\0';
        
        return ans;
}
                
void add(char* id,char* val,char* param){
	int i=0;
	//printf("%s %s %s\n",id,val,param);
	while(i<count_mac)
	{
            if(strcmp(id,M[i].idf)==0)
             {printf("//Failed to parse input code.");exit(0);}
            i++;
       }
	M[count_mac].idf=(char*)malloc(strlen(id)+1);
	strcpy(M[count_mac].idf,id);
	M[count_mac].vals=(char*)malloc(strlen(val)+1);
	strcpy(M[count_mac].vals,val);
	M[count_mac].params=(char*)malloc(strlen(param)+1);
	strcpy(M[count_mac].params,param);
	int size;
        M[count_mac].arg=split(param,&size);
        
        (M[count_mac].numarg)=size;
	count_mac++;
	
	return;
}




char* check(char* id){
	for(int i=0;i<count_mac;i++)
	 if(strcmp(M[i].idf,id)==0)
	       return M[i].vals;   
	return "notfound";
}




%}

%union {
	char* text;
}

%token <text>  EXTENDS RETURN INT BOOL IF ELSE WHILE THIS NEW HDEF 
%token <text> LENGTH TRUEVAL FALSEVAL INTEGER EQ DIV MUL ADD SUB 
%token <text> SEMICOLON LC RC LB RB LS RS COMMA QUES NOT AND OR NEQ
%token <text> LEQ DOT IDENTIFIER CLASS PUBLIC STATIC VOID MAIN STRING
%token <text>  SOP  HDEF0 HDEF1 HDEF2 HSTMT HSTMT0 HSTMT1 HSTMT2

%type <text> Goal
%type <text> MainClass
%type <text> TypeDeclaration
%type <text> MethodDeclaration
%type <text> Type
%type <text> Statement
%type <text> Expression
%type <text> PrimaryExpression
%type <text> MacroDefinition
%type <text> MacroDefStatement
%type <text> MacroDefExpression
%type <text> Identifier
%type <text> Integer
%type <text> TypeIdentifierStar 
%type <text> MethodDeclarationStar 
%type <text> STATEMENTSTAR 
%type <text> COMMATYPEIDENTIFIERSTAR 
%type <text> COMMAEXPRESSIONSTAR 
%type <text> COMMAIDENTIFIERSTAR
%type <text> MacroDefinitionStar 
%type <text> TypeDeclerationStar 

%start Goal


%%

//free($1);free($2);free($3);free($4);free($5);free($6);free($7);free($8);free($9);free($10);free($10);free($12);free($13);free($14);free($15);free($16);free($17);free($18);free($19);free($20);free($21);
//


//int n=strlen($1)+strlen($2)+strlen($3)+strlen($4)+strlen($5)+strlen($6)+strlen($7)+strlen($8)+strlen($9)+strlen($10)+strlen($11)+strlen($12)+strlen($13)+strlen($14)+strlen($15)+strlen($16)+strlen($1)+strlen($1)+strlen($1)+strlen($1)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Goal: MacroDefinitionStar MainClass TypeDeclerationStar 	{sprintf($$,"%s %s\n",$2,$3); printf("%s\n",$$);}
    
    |	MacroDefinitionStar MainClass {sprintf($$,"%s\n",$2); printf("%s\n",$$);}	
    |	MainClass TypeDeclerationStar {sprintf($$,"%s %s\n",$1,$2); printf("%s\n",$$);}
    | MainClass	{sprintf($$,"%s\n",$1); printf("%s\n",$$);}	;
	
MacroDefinitionStar: MacroDefinition MacroDefinitionStar	{sprintf($$,"%s %s",$1,$2);}
	|	MacroDefinition		{strcpy($$,$1);}		;
	
TypeDeclerationStar: TypeDeclaration TypeDeclerationStar	{sprintf($$,"%s %s",$1,$2);}
	|	TypeDeclaration		{sprintf($$,"%s",$1);}		;
	
MainClass: CLASS Identifier LC PUBLIC STATIC VOID MAIN LB STRING LS RS Identifier RB LC SOP LB Expression RB SEMICOLON RC RC		{sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21);};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

TypeDeclaration: CLASS Identifier LC TypeIdentifierStar MethodDeclarationStar RC	{sprintf($$,"%s %s %s %s %s %s",$1,$2,$3,$4,$5,$6);}
                |CLASS Identifier EXTENDS Identifier LC TypeIdentifierStar MethodDeclarationStar RC	{sprintf($$,"%s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8);}
		|	CLASS Identifier LC MethodDeclarationStar RC  {sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
		| 	CLASS Identifier LC TypeIdentifierStar RC   {sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
		|	CLASS Identifier LC RC {sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}
		|	CLASS Identifier EXTENDS Identifier LC RC	{sprintf($$,"%s %s %s %s %s %s",$1,$2,$3,$4,$5,$6);}
		|	CLASS Identifier EXTENDS Identifier LC MethodDeclarationStar RC	{sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
		|	CLASS Identifier EXTENDS Identifier LC TypeIdentifierStar RC	{sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
			;
		
TypeIdentifierStar: Type Identifier SEMICOLON 	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	Type Identifier SEMICOLON TypeIdentifierStar	{sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}		;
MethodDeclarationStar: MethodDeclaration 	{sprintf($$,"%s",$1);}
	|	MethodDeclaration MethodDeclarationStar	{sprintf($$,"%s %s",$1,$2);}		;
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MethodDeclaration: PUBLIC Type Identifier LB Type Identifier COMMATYPEIDENTIFIERSTAR RB LC STATEMENTSTAR RETURN Expression SEMICOLON RC	{sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14);}	
               |	PUBLIC Type Identifier LB Type Identifier COMMATYPEIDENTIFIERSTAR RB LC RETURN Expression SEMICOLON RC    {sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13);}

		|	PUBLIC Type Identifier LB RB LC STATEMENTSTAR RETURN Expression SEMICOLON RC	{sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11);}

		|	PUBLIC Type Identifier LB Type Identifier RB LC RETURN Expression SEMICOLON RC  {sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12);}	
	
		|	PUBLIC Type Identifier LB Type Identifier RB LC STATEMENTSTAR RETURN Expression SEMICOLON RC  {sprintf($$,"%s %s %s %s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13);}		
	
		|	PUBLIC Type Identifier LB RB LC RETURN Expression SEMICOLON RC	{sprintf($$,"%s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10);}	;
		
		
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
STATEMENTSTAR: Statement	{sprintf($$,"%s",$1);}
	|	Statement STATEMENTSTAR	{sprintf($$,"%s %s",$1,$2);}	;
COMMATYPEIDENTIFIERSTAR: COMMA Type Identifier		{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	COMMA Type Identifier COMMATYPEIDENTIFIERSTAR	{sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}	;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Type:   	INT LS RS	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	BOOL	{sprintf($$,"%s",$1);}
	|       INT   {sprintf($$,"%s",$1);}
	|	Identifier	{sprintf($$,"%s",$1);}	;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Statement:	LC STATEMENTSTAR RC	{sprintf($$,"%s %s %s",$1,$2,$3);}
        |      LC RC	{sprintf($$,"%s %s",$1,$2);}
	|	SOP LB Expression RB SEMICOLON	{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
	|	Identifier EQ Expression SEMICOLON	{sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}
	|	Identifier LS Expression RS EQ Expression SEMICOLON	{sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
	|	IF LB Expression RB Statement	{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
	|	IF LB Expression RB Statement ELSE Statement	{sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
	|	WHILE LB Expression RB Statement	{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
	| 	Type Identifier SEMICOLON	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	Identifier LB Expression COMMAEXPRESSIONSTAR RB SEMICOLON	{if(strcmp(check($1),"notfound")!=0){
char* temp=(char*)malloc(strlen($3)+strlen($4)+1);strcpy(temp,$3);strcat(temp,$4);char* stmt = (char*)malloc(1000);
strcpy(stmt,replace($1,temp));
sprintf($$,"%s",stmt);}
else{sprintf($$,"%s %s %s %s %s %s",$1,$2,$3,$4,$5,$6);}}
        |	Identifier LB Expression RB SEMICOLON	{if(strcmp(check($1),"notfound")!=0){sprintf($$,"%s",replace($1,$3));}else{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}}
	|	Identifier LB RB SEMICOLON		{if(strcmp(check($1),"notfound")!=0){sprintf($$,"%s",check($1));} else{sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}};
	
COMMAEXPRESSIONSTAR: COMMA Expression	{sprintf($$,"%s %s",$1,$2);}
	|	COMMA Expression COMMAEXPRESSIONSTAR	{sprintf($$,"%s %s %s",$1,$2,$3);}	;
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Expression:     PrimaryExpression AND PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression OR PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression NEQ PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression LEQ PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression ADD PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression SUB PrimaryExpression	{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression MUL PrimaryExpression		{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression DIV PrimaryExpression		{sprintf($$,"%s %s %s",$1,$2,$3);}
	|	PrimaryExpression LS PrimaryExpression RS	{sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}
	|	PrimaryExpression LENGTH		{sprintf($$,"%s %s",$1,$2);}
	|	PrimaryExpression		{sprintf($$,"%s",$1);}
	|	PrimaryExpression DOT Identifier LB Expression COMMAEXPRESSIONSTAR RB	  {if(strcmp(check($3),"notfound")!=0){
char* temp=(char*)malloc(strlen($5)+strlen($6)+1);strcpy(temp,$5);strcat(temp,$6);char* stmt = (char*)malloc(1000);stmt=replace($3,temp);
sprintf($$,"%s %s %s %s %s",$1,$2,$4,stmt,$7);}else{sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}}
	|	PrimaryExpression DOT Identifier LB Expression RB	{if(strcmp(check($3),"notfound")!=0){sprintf($$,"%s %s %s %s %s",$1,$2,$4,replace($3,$5),$6);}else{sprintf($$,"%s %s %s %s %s %s",$1,$2,$3,$4,$5,$6);}}
	|	PrimaryExpression DOT Identifier LB RB	{if(strcmp(check($3),"notfound")!=0){sprintf($$,"%s %s %s %s %s",$1,$2,$4,check($3),$5);}else{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}}
	|	Identifier LB Expression COMMAEXPRESSIONSTAR RB  {if(strcmp(check($1),"notfound")!=0){char* temp=(char*)malloc(strlen($3)+strlen($4)+1);strcpy(temp,$3);strcat(temp,$4);char* stmt =(char*)malloc(1000);stmt=replace($1,temp);sprintf($$,"%s %s %s",$2,stmt,$5);}else{sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}}
	|	Identifier LB Expression RB	{if(strcmp(check($1),"notfound")!=0){sprintf($$,"%s %s %s",$2,replace($1,$3),$4);}else{sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}}
	|	Identifier LB RB	{if(strcmp(check($1),"notfound")!=0){char *temp=(char*)malloc(strlen(check($1))+1);
temp=check($1);sprintf($$,"%s %s %s",$2,temp,$3);}else{sprintf($$,"%s %s %s",$1,$2,$3);}}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
PrimaryExpression: Integer	{sprintf($$,"%s",$1);}
		|	TRUEVAL	{sprintf($$,"%s",$1);}
		|	FALSEVAL	{sprintf($$,"%s",$1);}
		|	Identifier	{sprintf($$,"%s",$1);}
		|	THIS	{sprintf($$,"%s",$1);}
		|	NEW INT LS Expression RS	 {sprintf($$,"%s %s %s %s %s",$1,$2,$3,$4,$5);}
		|	NEW Identifier LB RB	 {sprintf($$,"%s %s %s %s",$1,$2,$3,$4);}
		|	NOT Expression		 {sprintf($$,"%s %s",$1,$2);}
		|	LB Expression RB	 {sprintf($$,"%s %s %s",$1,$2,$3);}	;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

MacroDefinition: MacroDefExpression	{sprintf($$,"%s",$1);}
		|	MacroDefStatement	{sprintf($$,"%s",$1);}	;


MacroDefStatement: HSTMT0 Identifier LB RB LC STATEMENTSTAR RC	{add($2,$6,"");sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}

		|   HSTMT1 Identifier LB Identifier RB LC STATEMENTSTAR RC	{add($2,$7,$4);sprintf($$,"%s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8);}
		
		|	HSTMT2 Identifier LB Identifier COMMA Identifier RB LC STATEMENTSTAR RC	{char* temp=(char*)malloc(strlen($4)+strlen($6)+2);strcpy(temp,$4);strcat(temp,$5);strcat(temp,$6);add($2,$9,temp);sprintf($$,"%s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10);}	
		
		|	HSTMT Identifier LB Identifier COMMAIDENTIFIERSTAR RB LC STATEMENTSTAR RC	{char* temp=(char*)malloc(strlen($4)+strlen($5)+1);strcpy(temp,$4);strcat(temp,$5);add($2,$8,temp);sprintf($$,"%s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9);}
		
		| HSTMT0 Identifier LB RB LC RC	{add($2,"","");sprintf($$,"%s %s %s %s %s %s",$1,$2,$3,$4,$5,$6);}

		|   HSTMT1 Identifier LB Identifier RB LC RC	{add($2,"",$4);sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}
		
		|	HSTMT2 Identifier LB Identifier COMMA Identifier RB LC RC	{char* temp=(char*)malloc(strlen($4)+strlen($6)+2);strcpy(temp,$4);strcat(temp,$5);strcat(temp,$6);add($2,"",temp);sprintf($$,"%s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9);}	
		
		|	HSTMT Identifier LB Identifier COMMAIDENTIFIERSTAR RB LC RC	{char* temp=(char*)malloc(strlen($4)+strlen($5)+1);strcpy(temp,$4);strcat(temp,$5);add($2,"",temp);sprintf($$,"%s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8);}	;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MacroDefExpression: HDEF0 Identifier LB RB LB Expression RB	{add($2,$6,""); sprintf($$,"%s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7);}

		|   HDEF1 Identifier LB Identifier RB LB Expression RB	{add($2,$7,$4); sprintf($$,"%s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8);}
		
		|	HDEF2 Identifier LB Identifier COMMA Identifier RB LB Expression RB	{char* temp=(char*)malloc(strlen($4)+strlen($6)+2);strcpy(temp,$4);strcat(temp,$5);strcat(temp,$6);add($2,$9,temp);sprintf($$,"%s %s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10);}	
		
		|	HDEF Identifier LB Identifier COMMAIDENTIFIERSTAR RB LB Expression RB	{char* temp=(char*)malloc(strlen($4)+strlen($5)+1);strcpy(temp,$4);strcat(temp,$5);add($2,$8,temp);sprintf($$,"%s %s %s %s %s %s %s %s %s",$1,$2,$3,$4,$5,$6,$7,$8,$9);}	;
		
COMMAIDENTIFIERSTAR: COMMA Identifier	{sprintf($$,"%s %s",$1,$2);}
	|	COMMA Identifier COMMAIDENTIFIERSTAR	{sprintf($$,"%s %s %s",$1,$2,$3);}	;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		

Identifier: IDENTIFIER		{strcpy($$,$1);}	;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Integer: INTEGER	{strcpy($$,$1);}	;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








 
%%




