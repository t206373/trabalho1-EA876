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

int b, c, a=1, d;
int resultado=1, var1;
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
	ABRE E EXP E FECHA {	printf("MOV A, %d\nMOV B, %d\nMOV C, 1\nMOV D, A\nloop:\nCMP B, 1\nJBE fim\nMUL C\nDEC B\nJMP loop\nfim:\n", $2, $4);
			b = $2;
			c = $4;			
			d=b;
			while (c > 1){
				d=d*b;
				c=c-1;
				a=d;}	
			$$ = a;
			resultado = resultado + $$;
			}
	|ABRE E MUL E FECHA {
			printf("MOV A, %d\nMOV B, %d\nMUL A\n", $2, $4);
			$$=$2*$4;
			resultado = resultado + $$;
			}
	|ABRE E DIV E FECHA {	printf("MOV A, %d\nMOV B, %d\nDIV A\n", $2, $4);
			$$=$2/$4;
			resultado = resultado + $$;
			}
	|ABRE E ADD E FECHA {	
			printf("MOV A, %d\nMOV B, %d\nADD A, B\n", $2, $4);
			$$=$2+$4;
			resultado = resultado + $$;
			}
	|ABRE E FECHA {$$ = $2;}
	|E EXP E {	printf("MOV A, %d\nMOV B, %d\nMOV C, 1\nMOV D, A\nloop:\nCMP B, 1\nJBE fim\nMUL C\nDEC B\nJMP loop\nfim:\n", $1, $3);
			b = $1;
			c = $3;			
			d=b;
			while (c > 1){
				d=d*b;
				c=c-1;
				a=d;}	
			$$ = a;
			resultado = resultado + $$;
			}
	|E MUL E {
			printf("MOV A, %d\nMOV B, %d\nMUL A\n", $1, $3);
			$$=$1*$3;
			resultado = resultado + $$;
			}
	|E DIV E {	printf("MOV A, %d\nMOV B, %d\nDIV A\n", $1, $3);
			$$=$1/$3;
			resultado = resultado + $$;
			}
	|E ADD E {	
			printf("MOV A, %d\nMOV B, %d\nADD A, B\n", $1, $3);
			$$=$1+$3;
			resultado = resultado + $$;
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
