/*	Autores: Augusto Lourenço RA:194447 e Tony Li RA: 206373
	Data: 03/06
	Trabalho: Fazer uma calculadora em Lex-Flex/Yacc-Bison/C 
			  que a saída seja um código em Assembly que 
			  execute a expressão dada na entrada.
			  
	Comentários: Utilizamos uma estrutura semelhante a
		     calculadora feita como exemplo no youtube,
	             utilizamos S como "sentença", E como "expressão",
	             INT como numerais, ABRE e FECHA para parenteses.
		     Iriamos juntar todas as operações em uma flag "OP",
		     porém tivemos prblemas na impressão, por isso E 
		     abrange todos os casos possíveis, respeitando as
		     ordens da expressão.
*/
%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char *c);
int yylex(void);

int a, b, c;
%}

%token ABRE FECHA ADD MUL DIV EXP INT EOL
%left ADD
%left MUL DIV
%left EXP 
%left ABRE FECHA

%%

S:
	S E EOL
	|
	;

E: 
	ABRE E EXP E FECHA {	printf("MOV A, %d\nMOV B, %d\nCMP B, 0\nJE special\nMOV C, A\nloop:\nCMP B, 1\nJE fim\nMUL C\nDEC B\nJMP loop\nspecial:\nMOV A, 1\nfim:\n", $2, $4);
			a = $2;
			b = $4;			
			c = a;
			while (b > 1){
				a = a*c;
				b = b-1;
				}
			if (b == 0){
				a = 1;
				}	
			$$ = a;
			}
	|ABRE E MUL E FECHA {
			printf("MOV A, %d\nMOV B, %d\nMUL A\n", $2, $4);
			$$=$2*$4;
			}
	|ABRE E DIV E FECHA {	printf("MOV A, %d\nMOV B, %d\nDIV A\n", $2, $4);
			$$=$2/$4;
			}
	|ABRE E ADD E FECHA {	
			printf("MOV A, %d\nMOV B, %d\nADD A, B\n", $2, $4);
			$$=$2+$4;
			}
	|ABRE E FECHA {$$ = $2;}
	|E EXP E {	printf("MOV A, %d\nMOV B, %d\nCMP B, 0\nJE special\nMOV C, A\nloop:\nCMP B, 1\nJE fim\nMUL C\nDEC B\nJMP loop\nspecial:\nMOV A, 1\nfim:\n", $1, $3);
			a = $1;
			b = $3;			
			c = a;
			while (b > 1){
				a = a*c;
				b = b-1;
				}
			if (b == 0){
				a = 1;
				}
			$$ = a;
			}
	|E MUL E {
			printf("MOV A, %d\nMOV B, %d\nMUL A\n", $1, $3);
			$$=$1*$3;
			}
	|E DIV E {	printf("MOV A, %d\nMOV B, %d\nDIV A\n", $1, $3);
			$$=$1/$3;
			}
	|E ADD E {	
			printf("MOV A, %d\nMOV B, %d\nADD A, B\n", $1, $3);
			$$=$1+$3;
			}
	|INT
	;


%%

void yyerror(char *s) {
	exit(1);
}

int main() {
  yyparse();
    return 0;

}
