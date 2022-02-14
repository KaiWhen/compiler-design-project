%%

Digit = [0 - 9]
ID = [A - Za - z]+
Others = [0 - 9 & .]
WhiteSp = [\040\ n]

%type Token

%class Lexer

%%

{Digit}+ {
    return new Token(yytext());
}

. {
throw new Error("Illegal character <"+yytext()+">");
}


