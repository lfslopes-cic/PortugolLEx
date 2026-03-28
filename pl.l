#include <iostream>
#include "tokens.hpp"

/*                  DEFINIÇÃO REGULAR DOS TOKENS
/*  se -> IF
/*  então -> THEN
/*  senao -> ELSE
/*  fimse -> ENDIF
/*  real -> FLOAT
/*  caracter -> CHAR
/*  escrever -> PRINT
/*  ler -> SCAN
/*  escolha -> SWITCH
/*  caso -> CASE
/*  fimescolha -> ENDSWITCH
/*  ( -> LP
/*  ) -> RP
/*  (+|-|*|/) -> OP
/*  \".*\" -> STRING
/*  (<-) -> ATT
/*  (=) -> EQUAL
/*  (\s|\t) ->  
/*  \n -> LN
/*  [+-]?[0-9]+(\.[0-9]+)? -> NUM
/*  [A-Za-z]([A-Za-z]|[0-9]|_)* -> ID

%option outfile = "pl.cpp"

%%
 |\t                                   ;
\n                            return LN;

[+-]?[0-9]+(\.[0-9]+)?        return NUM;
[A-Za-z]([A-Za-z]|[0-9]|_)*   return ID;
\".[^\"]*\"                   return STRING;
=                             return EQUAL;
(\+|\-|\*|\/)                 return OP;
<-                            return ATT;
\(                            return LP;
\)                            return RP;

se                            return IF;
entao                         return THEN;
senao                         return ELSE;
fimse                         return ENDIF;
escolha                       return SWITCH;
caso                          return CASE;
fimescolha                    return ENDSWITCH;

ler                           return SCAN;
escrever                      return PRINT;

caracter                      return CHAR;
real                          return FLOAT;

%%