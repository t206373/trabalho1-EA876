/*	Autores: Augusto Lourenço RA:194447 e Tony Li RA: 206373
	Data: 03/06
	Trabalho: Fazer uma calculadora em Lex-Flex/Yacc-Bison/C 
			  que a saída seja um código em Assembly que 
			  execute a expressão dada na entrada.
*/
%{
#include <stdlib.h>
void yyerror(char *);

#include "y.tab.h"

%}

%%

 /*Todos os caracteres que devemos voltar para resolver as expressões*/

[\(] {return ABRE;}
[\)] {return FECHA;}
[+] {return ADD;}
[*] {return MUL;}
[/] {return DIV;}
[\^] {return EXP;}
[0-9]+ {
	yylval = atoi(yytext);	
	return INT;}
[\n]* {return EOL;}
[[:space:]]+ ;
. {yyerror("");} ;

%%

int yywrap() {
  return 1;
}
