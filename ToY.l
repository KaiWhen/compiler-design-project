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
    Type_String,
    Type_Integer
}


%%

Digit = [0 - 9]
ID = [_a-zA-Z][_a-zA-Z0-9]
String = \"([^\\\"]|\\.)*\"
Others = [0 - 9 & .]
WhiteSp = [\040\ n]
Comment = \^\/\/.*|##.*

%type Token

%class Lexer

%%

{Digit}+ {
    System.out.print("VALID");
}

{ID}+ {
    System.out.print("VALID");
}

{String} {
    System.out.print("VALID");
}

{WhiteSp} {
    System.out.print("VALID");
}

{Comment} {
    System.out.print("VALID");
}

. {
throw new Error("Illegal character <"+yytext()+">");
}


