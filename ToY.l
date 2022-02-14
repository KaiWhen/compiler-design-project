import java.io.*;

class Token {
    TokenType type;
    String text;
    
    Token(String t, TokenType type) {
        this.text = t;
        this.type = type;
    }
    
    public String toString() {
        return String.format("%s %s", type, text);
    }
}

enum TokenType {
    Type_String;
    Type_Integer;
}

%%

Digit = [0 - 9]
AnyLet = [A - Za - z]
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


