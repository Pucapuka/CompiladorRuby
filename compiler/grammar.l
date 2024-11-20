%{
	#include <string.h>
	#include "grammar.tab.h"
	#define stack_size 100
	#define DEBUG 1
	
	int yycolumn = 1;
	int startFlag = 1;
	
	#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno; 		\
    yylloc.first_column = yycolumn; yylloc.last_column = yycolumn + yyleng - 1; 	\
    yycolumn += yyleng;												
    
 	static int sp=0, stack [stack_size];
 	
 	static void debug(const char *X)
 	{
 		#ifdef DEBUG
 		if(startFlag)
 		{
 			printf("---------------------------------Sequência de Tokens--------------------------\n1 ");
 			startFlag=0;
 		}
 		
 		if(strcmp(X, "NL")==0)
 		{
 			printf("T_%s\n%d ", X, yylineno);
 		}
		else
		{
			printf("T_%s ", X);	
		}
 		#endif
 	}
 	static void push (int i) 
 	{
   		if (++sp<stack_size) stack[sp]= i;
   		else {printf ("error: stack overflow\n"); exit(1);}
 	}
 	
 	int pop () 
 	{
   		if (sp>-1) return stack[sp--];
   		else {printf ("error: stack underflow\n"); exit(1);}
 	}
 	
 	int top()
 	{
 		if(sp>-1) return stack[sp];
 		else return 1;
 	}
 	
 	static int indent_depth(const char *K)
	{
		int len = strlen(K), i, tab_count=1;
		for(i=0; i< len ; i++)
		{
			if(K[i]=='\t')
			{
				tab_count++;
			}
			else
			{
				printf("Nope");
				break;
			}	
		}
		return tab_count;
	}	
 	int depth = 1;
 		
%}
%option yylineno
whitespace [ ]
Multiline_comment =begin.+=end
%%

[\t]*		{
			depth = indent_depth(yytext);
//			printf("Depth : %d ",  depth);
			if(depth < top())
			{
				while (depth < top()) pop();
				yylval.depth = depth;
				debug("DD");
				return DD;
			}
			
			if(depth == top())
			{
				debug("ND");
				yylval.depth = depth;
				return ND;				
			}
			if(depth > top())
			{
				push(depth);
				debug("ID");
				yylval.depth = depth;
				return ID;
			}
			
		}
"end" { debug("End"); return T_End; }
"do" { debug("Do"); return T_Do; }
"rescue" { debug("Rescue"); return T_Rescue; }
"retry" { debug("Retry"); return T_Retry; }
"ensure" { debug("Ensure"); return T_Ensure; }
"begin" { debug("Begin"); return T_Begin; }
"case" { debug("Case"); return T_Case; }
"when" { debug("When"); return T_When; }
"then" { debug("Then"); return T_Then; }
"require" { debug("Require"); return T_Require; }
"puts" { debug("Puts"); return T_Puts; }
"pass" { debug("Pass"); return T_Pass; }
"if" { debug("If"); return T_If; }
"in" { debug("In"); return T_In; }
"while" { debug("While"); return T_While; }
"break" { debug("Break"); return T_Break; }
"and" { debug("And"); return T_And; }
"or" { debug("Or"); return T_Or; }
"not" { debug("Not"); return T_Not; }
"elsif" { debug("Elsif"); return T_Elsif; }
"else" { debug("Else"); return T_Else; }
"def" { debug("Def"); return T_Def; }
"return" { debug("Return"); return T_Return; }
":" { debug("Cln"); return T_Cln; }
">" { debug("GT"); return T_GT; }
"<" { debug("LT"); return T_LT; }
">=" { debug("EGT"); return T_EGT; }
"<=" { debug("ELT"); return T_ELT; }
"==" { debug("EQ"); return T_EQ; }
"!=" { debug("NEQ"); return T_NEQ; }
"true" { debug("True"); return T_True; }
"false" { debug("False"); return T_False; }
"+" { debug("PL"); return T_PL; }
"-" { debug("MN"); return T_MN; }
"*" { debug("ML"); return T_ML; }
"/" { debug("DV"); return T_DV; }
"(" { debug("OP"); return T_OP; }
")" { debug("CP"); return T_CP; }
"[" { debug("OB"); return T_OB; }
"]" { debug("CB"); return T_CB; }
"," { debug("Comma"); return T_Comma; }
"=" { debug("EQL"); return T_EQL; }
[0-9]+ { yylval.text = strdup(yytext); debug(yylval.text); return T_Number; }
[_a-zA-Z][_a-zA-Z0-9]* { yylval.text = strdup(yytext); debug(yylval.text); return T_ID; }
\"([^\"\\n])*\" { yylval.text = strdup(yytext); debug(yylval.text); return T_String; }
\'([^\'\\n])*\' { yylval.text = strdup(yytext); debug(yylval.text); return T_String; }
"#"([^\"\\n])* { /* Comentário, ignora o conteúdo */ }
{whitespace} {}
"\n" { yycolumn = 1; debug("NL"); return T_NL; }
<<EOF>> { debug("EOF"); return T_EndOfFile; }

%%