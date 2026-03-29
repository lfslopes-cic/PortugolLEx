%{
#include <stdio.h>
#include "tokens.hpp"

int linha = 1;
%}

%option outfile="pl.yy.c"

num [+-]?[0-9]+(\.[0-9]+)?
id  [A-Za-z]([A-Za-z]|[0-9]|_)*
ws  [ \t]
string \"[^\"]*\" 
op (\+|\-|\*|\/)

%%
se           return IF;
entao        return THEN;
senao        return ELSE;
fimse        return ENDIF;
escolha      return SWITCH;
caso         return CASE;
fimescolha   return ENDSWITCH;

ler          return SCAN;
escrever     return PRINT;

caracter     return CHAR;
real         return FLOAT;

{ws}                          {/* Ignorado */}                     
"\n"                          {linha++; return LN;}

{num}        return NUM;
{id}         return ID;
{string}     return STRING;
"="          return EQUAL;
{op}         return OP;
"<-"         return ATT;
"("          return LP;
")"          return RP;
","          return V;

.            printf("Erro\n");
%%

int yywrap(){return 1;}

int main(){
    FILE* input;
    input = fopen("programa.txt", "r");
    int res;
    FILE* saida;
    saida = fopen("tokens.txt", "w");
    int linha_atual = linha;
    
    fprintf(saida, "%d: ", linha);
    do{
        res = yylex();
        if(linha_atual < linha){
            linha_atual++;
            fprintf(saida, "\n");
            fprintf(saida, "%d: ", linha);
        }
        if (res == LN)
            fprintf(saida, "");
        else
            fprintf(saida, "<%d, %s>\t", res, yytext);
    } while(res != 0);

    fclose(input);
    return 0;
}