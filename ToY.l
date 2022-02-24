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
    
    enum TokenType {
        Type_String,
        Type_Integer
    }
}

class Main {
    public static void main(String argv[]) throws IOException {
        Lexer yy = new Lexer(System.in); /* input stream, expects a reader */
        Yytoken t;
        while ((t = yy.Lexer()) != null)
            System.out.println(t);
    }
}

%%

Digit = [0 - 9]
ID = [_a-zA-Z][_a-zA-Z0-9]
String = \"([^\\\"]|\\.)*\"
WhiteSp = [\040\ n]
Comment = \^\/\/.*|##.*

%type Token
%unicode
%class Lexer

%%
<YYINITIAL> {
    /* keywords */
    "if" { System.out.print("VALID"); }
    "else" { System.out.print("VALID"); }
    "then" { System.out.print("VALID"); }
    "bool" { System.out.print("VALID"); }
    "int" { System.out.print("VALID"); }
    "true" { System.out.print("VALID"); }
    "false" { System.out.print("VALID"); }
    "void" { System.out.print("VALID"); }
    "printf" { System.out.print("VALID"); }
    "string" { System.out.print("VALID"); }
    "struct" { System.out.print("VALID"); }
    "for" { System.out.print("VALID"); }
    "return" { System.out.print("VALID"); }
    
    /* operators */
    "<" { System.out.print("VALID"); }
    "<=" { System.out.print("VALID"); }
    ">" { System.out.print("VALID"); }
    ">=" { System.out.print("VALID"); }
    "==" { System.out.print("VALID"); }
    "!=" { System.out.print("VALID"); }
    "{" { System.out.print("VALID"); }
    "}" System.out.print("VALID"); }
    ";" { System.out.print("VALID"); }
    "!" { System.out.print("VALID"); }
    "(" { System.out.print("VALID"); }
    ")" { System.out.print("VALID"); }
    "+" { System.out.print("VALID"); }
    "-" { System.out.print("VALID"); }
    "." { System.out.print("VALID"); }
    "=" { System.out.print("VALID"); }
    "mod" { System.out.print("VALID"); }
    "and" { System.out.print("VALID"); }
    "or" { System.out.print("VALID"); }
    "not" { System.out.print("VALID"); }

    /* identifiers */
    {ID}+ { System.out.print("VALID"); }
    
    /* literals*/
    {Digit}+ { System.out.print("VALID"); }
    {String} { System.out.print("VALID"); }

    /* Whitespace */
    {WhiteSp} { /* Ignore */ }

    /* Comments */
    {Comment} { System.out.print("VALID"); }

}

. {
throw new Error("Illegal character <"+Lexer()+">");
}


