%{
#include <stdio.h>
#include <string.h>
#include <malloc.h>

int sayac=0;
extern int linenum;
extern FILE *yyin;
char regs[100][100];

char *search(char veri[100]){
	int i=0;
	while(i<sayac){
	
		if(!strcmp(veri,regs[i])){
			return ("");
		}	
		
		i++;
			}
			return ("\nFunction undefined ->");
}



%}

%union{
int number;

char * string;
int *v;
}
%token <string> IDENT
%token <string> CNTNTC
%token <string> NUMBER
%token <string> ESIT
%token <string> KESIT
%token <string> TYPE
%token <string> CNTNTN

%type <string> virgullu
%type <string> ifcompare
%type <string> veri
%type <string> artis
%type <string> assign
%type <string> comparision
%type <string> icerik
%type <string> uzanti
%type <string> process
%type <string> ifcondition2
%type <string> control
%type <string> ifcondition
%type <string> fore
%type <string> simge
%type <string> ardisik
%type <string> assingter
%type <string> reader
%type <string> idents
%type <string> returner
%type <string> comparetype
%type <string> ivirgullu
%type <string> bisey
%type <string> printer
%type <string> printer_withident
%type <string> printer_without
%token DIEZ SCANF IF INCLUDE SMALL ELSE HEADER BIG PRINTF ESIT PLUS COMA VIRGUL NOTHING OPBR CLBR CPARAN TIRNAK PERCENTAGE AMPERSAN TEKTIRNAK MINUS CIFTIRNAK OPARAN OPARAN MAIN UNLEM ESIT FOR CARPMA BOLME SLARS RETURN
%%

commands:
	include commands{}
	|main commands
	|
	;
include:
	DIEZ INCLUDE KESIT HEADER KESIT {printf("include\n");}
;



main:
	TYPE MAIN OPBR TYPE CLBR OPARAN bisey CPARAN {printf("function main\n%send main\n",$7); sayac=0; strcpy(regs[0]," "); }
	|TYPE IDENT OPBR ivirgullu CLBR OPARAN bisey returner CPARAN {printf("function %s %s\n%s\n%s=%s\nend main\n",$2,$4,$7,$2,$8); 
	sayac=0; strcpy(regs[0]," ");	
	}
;
returner:
	RETURN IDENT COMA {sprintf($$,"%s",$2);}
	;
bisey:
	
	printer bisey {sprintf($$,"%s\n%s",$1,$2);}
	|fore bisey {sprintf($$,"%s\n%s",$1,$2);}
	|idents bisey {sprintf($$,"%s%s",$1,$2);}
	|reader bisey {sprintf($$,"%s\n%s",$1,$2);}
	|assingter bisey {sprintf($$,"%s\n%s",$1,$2);}
	|ifcondition bisey { sprintf($$,"%s\n%s",$1,$2);}
	|printer {sprintf($$,"%s",$1);}
	|fore {$$=malloc(sizeof($$)); sprintf($$,"%s",$1);}
	|idents {sprintf($$,"%s",$1);}
	|reader  {sprintf($$,"%s",$1);}
	|assingter  {sprintf($$,"%s",$1);}
	|ifcondition {sprintf($$,"%s",$1);}
	
	;

ivirgullu:
	TYPE IDENT VIRGUL ivirgullu {$$=malloc(sizeof(char)*100); sprintf($$,"%s %s",$2,$4);}
	|TYPE IDENT {$$=malloc(sizeof(char)*100); sprintf($$,"%s",$2);}
	;
assingter:
	|IDENT ESIT icerik COMA {$$=malloc(sizeof(char)*100); sprintf($$,"%s %s=%s\n",search($1),$1,$3);}
	|IDENT ESIT ardisik COMA{$$=malloc(sizeof(char)*100); sprintf($$,"%s=%s\n",$1,$3);}
	|IDENT ESIT icerik OPBR virgullu CLBR COMA { sprintf($$,"%s=%s(%s)\n",$1,$3,$5);}
	;
virgullu:
	icerik VIRGUL virgullu  {$$=malloc(sizeof(char)*100); sprintf($$,"%s,%s",$1,$3);}
	|icerik  {  $$=malloc(sizeof(char)*100); sprintf($$,"%s",$1);}
	;
ardisik:
	icerik simge ardisik {$$=malloc(sizeof(char)*100);	sprintf($$,"%s %s %s",$1,$2,$3); }
	|icerik { sprintf($$,"%s",$1); }	
	;
simge:
	CARPMA {$$=malloc(sizeof(char)*10); sprintf($$,"*"); }
	|BOLME {$$=malloc(sizeof(char)*10); sprintf($$,"/"); }
	|PLUS  {$$=malloc(sizeof(char)*10); sprintf($$,"+"); }
	|MINUS {$$=malloc(sizeof(char)*10); sprintf($$,"-"); }
		
	;
	
ifcondition:
	ifcondition2  {sprintf($$,"%s\n end if",$1); }
	
	;
	
ifcondition2:
	IF OPBR ifcompare CLBR OPARAN bisey CPARAN  uzanti  {$$=malloc(sizeof(char)*101);  sprintf($$," if %s\n then\n %s %s",$3,$6,$8);  }
	|IF OPBR ifcompare CLBR OPARAN bisey CPARAN {$$=malloc(sizeof(char)*101);  sprintf($$," if %s\n then\n %s",$3,$6);  };
uzanti:
	ELSE OPARAN bisey CPARAN uzanti {$$=malloc(sizeof(char)*110); ;  sprintf($$,"else\n %s %s",$3,$5); }
	|ELSE ifcondition2 {$$=malloc(sizeof(char)*101);  sprintf($$,"\nelse %s",$2); }
	
	
	;

ifcompare:
	icerik comparetype icerik { sprintf($$,"%s%s%s",$1,$2,$3);  };

comparetype:
	KESIT { sprintf($$,"%s",$1); };
	
reader:
	SCANF OPBR CIFTIRNAK PERCENTAGE IDENT CIFTIRNAK VIRGUL veri CLBR COMA{ sprintf($$,"Read %s\n",$8);};
	
veri:
	AMPERSAN IDENT {$$=malloc(sizeof($$)); sprintf($$,"%s\n",$2);}
	|IDENT {sprintf($$,"%s\n",$1);}
	;


idents:
	TYPE IDENT COMA {strcpy(regs[sayac],$2);  sprintf($$,""); sayac++;}
	|TYPE IDENT ESIT control COMA {strcpy(regs[sayac],$2); sayac++; sprintf($$,"%s=%s\n",$2,$4);}
	|TYPE IDENT ESIT ardisik COMA{strcpy(regs[sayac],$2); sayac++; sprintf($$,"%s=%s\n",$2,$4);}
	|TYPE process COMA {sprintf($$,"%s",$2);}
	;

process:
	IDENT ESIT control VIRGUL process {strcpy(regs[sayac],$1); sayac++; sprintf($$,"%s=%s\n%s",$1,$3,$5);}
	|IDENT VIRGUL process{strcpy(regs[sayac],$1); sayac++; sprintf($$,"%s",$3);}
	|IDENT ESIT control {strcpy(regs[sayac],$1); sayac++; sprintf($$,"%s=%s\n",$1,$3);}
	|IDENT {strcpy(regs[sayac],$1); sayac++; sprintf($$," ");}
	;

control: 
	CIFTIRNAK icerik CIFTIRNAK {$$=malloc(sizeof($$));  sprintf($$,"%s",$2); }
	| icerik {sprintf($$,"%s",$1);}
	|TEKTIRNAK icerik TEKTIRNAK {$$=malloc(sizeof($$));  sprintf($$,"'%s'",$2); }
	;
	
fore:
	FOR OPBR assign comparision artis CLBR OPARAN bisey CPARAN{ sprintf($$,"  %s\n  while %s\n  %s  \n  %s  end while\n",$3,$4,$8,$5); };

artis:
	IDENT PLUS PLUS {$$=malloc(sizeof($$)); sprintf($$,"%s=%s+1\n",$1,$1);}
	|IDENT MINUS MINUS {$$=malloc(sizeof($$)); sprintf($$,"%s=%s-1\n",$1,$1);}
	|MINUS MINUS IDENT {$$=malloc(sizeof($$)); sprintf($$,"--%s\n",$3);}
	|PLUS PLUS IDENT {$$=malloc(sizeof($$)); sprintf($$,"++%s\n",$3);}
	|IDENT ESIT IDENT simge icerik  {$$=malloc(sizeof($$)); sprintf($$,"%s=%s%s%s\n",$1,$3,$4,$5);} 
	;

assign:
	icerik ESIT icerik COMA {sprintf($$,"%s=%s",$1,$3);};

comparision:
	icerik KESIT icerik COMA {sprintf($$,"%s%s%s",$1,$2,$3);};

	
printer:
	printer_withident  {sprintf($$,"%s",$1);}
	|
	printer_without	{sprintf($$,"%s",$1);}
	
	;

printer_withident:	
	PRINTF OPBR  CIFTIRNAK PERCENTAGE IDENT CIFTIRNAK VIRGUL IDENT CLBR COMA
		{
			sprintf($$,"Print %s\n",$8);
		}
	|PRINTF OPBR  CIFTIRNAK PERCENTAGE IDENT SLARS CIFTIRNAK VIRGUL IDENT CLBR COMA
	{
			sprintf($$,"Print %s\n",$9);
		}
	
;
	

printer_without:
	PRINTF OPBR CIFTIRNAK icerik CIFTIRNAK CLBR COMA{
		sprintf($$,"Print %s\n",$4);
	};
/*her turlu icerik döner */
icerik:
	MINUS NUMBER{$$=malloc(sizeof($$)); sprintf($$,"-%s",$2);}
	| IDENT {$$=malloc(sizeof($$));  sprintf($$,"%s",$1);}
	|NUMBER {$$=malloc(sizeof($$));  sprintf($$,"%s",$1);}
	|CNTNTC {$$=malloc(sizeof($$));  sprintf($$,"%s",$1);}
	;



/*	 
function:
	TYPE IDENT OPBR TYPE CLBR OPARAN commands CPARAN{ printf("function %s\n",$2);};
	

command:
	TYPE_IDENT
	|
	TYPE_IDENT_EQUAL
	|
	TYPE_IDENT_EQUAL_TIRNAK
	;


TYPE_IDENT:
	TYPE IDENT COMA{ printf(""); };
TYPE_IDENT_EQUAL:
	TYPE IDENT EQUAL CNTNT COMA{ printf("%s=%s;\n",$2,$4); };
TYPE_IDENT_EQUAL_TIRNAK://IDENT DEGİL CNTNTC olmasi gerek yapamadık
	TYPE IDENT EQUAL CNTNTC COMA { printf("%s=%s;\n",$2,$4); };

	*/
%%
void yyerror(char *s){
	fprintf(stderr, "%s\nerror occurs on line %d\n", s,linenum);
}
int yywrap(){
	return 1;
}
int main(int argc, char *argv[])
{
	
    /* Call the lexer, then quit. */
    yyin=fopen(argv[1],"r");
    yyparse();
    fclose(yyin);
    return 0;
}
