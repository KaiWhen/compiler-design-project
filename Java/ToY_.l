import java.io.*;
//import java.nio.charset.StandardCharsets;

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
    
    public static void main(String args[]) throws IOException {
    try {
         Reader input =
            args.length > 0 ?
               new FileReader(args[0]) :
               new InputStreamReader(System.in);
         ToY scanner = new ToY(input);
         Token token;
         do {
            token = scanner.yylex();
            System.out.println(token + "VALID");
         }
         while (token != null);
      } catch (IOException e) {
         System.err.println(e);
      }
    }
}

enum TokenType {
    type_String,
    type_Integer
}
//String = \"([^\"])*\"

%%

Digit = [0 - 9]
ID = [_a-zA-Z][_a-zA-Z0-9]
String = \"([^\"])*\"
WhiteSp = \s
Comment = \^\/\/.*|##.*

%type Token
%unicode
%class ToY
%eofclose

%init{
    yybegin(YYINITIAL);
%init}


%%
<YYINITIAL> {
    /* keywords */
    "if" { return new Token(yytext(), TokenType.type_String); }
    "else" { return new Token(yytext(), TokenType.type_String); }
    "then" { return new Token(yytext(), TokenType.type_String); }
    "bool" { return new Token(yytext(), TokenType.type_String); }
    "int" { return new Token(yytext(), TokenType.type_String); }
    "true" { return new Token(yytext(), TokenType.type_String); }
    "false" { return new Token(yytext(), TokenType.type_String); }
    "void" { return new Token(yytext(), TokenType.type_String); }
    "printf" { return new Token(yytext(), TokenType.type_String); }
    "string" { return new Token(yytext(), TokenType.type_String); }
    "struct" { return new Token(yytext(), TokenType.type_String); }
    "for" { return new Token(yytext(), TokenType.type_String); }
    "return" { return new Token(yytext(), TokenType.type_String); }
    
    /* operators */
    "<" { return new Token(yytext(), TokenType.type_String); }
    "<=" { return new Token(yytext(), TokenType.type_String); }
    ">" { return new Token(yytext(), TokenType.type_String); }
    ">=" { return new Token(yytext(), TokenType.type_String); }
    "==" { return new Token(yytext(), TokenType.type_String); }
    "!=" { return new Token(yytext(), TokenType.type_String); }
    "{" { return new Token(yytext(), TokenType.type_String); }
    "}" { return new Token(yytext(), TokenType.type_String); }
    ";" { return new Token(yytext(), TokenType.type_String); }
    "!" { return new Token(yytext(), TokenType.type_String); }
    "(" { return new Token(yytext(), TokenType.type_String); }
    ")" { return new Token(yytext(), TokenType.type_String); }
    "+" { return new Token(yytext(), TokenType.type_String); }
    "-" { return new Token(yytext(), TokenType.type_String); }
    "." { return new Token(yytext(), TokenType.type_String); }
    "=" { return new Token(yytext(), TokenType.type_String); }
    "mod" { return new Token(yytext(), TokenType.type_String); }
    "and" { return new Token(yytext(), TokenType.type_String); }
    "or" { return new Token(yytext(), TokenType.type_String); }
    "not" { return new Token(yytext(), TokenType.type_String); }

    /* identifiers */
    {ID}+ { return new Token(yytext(), TokenType.type_String); }
    
    /* literals*/
    {Digit}+ { return new Token(yytext(), TokenType.type_Integer); }
    {String} { return new Token(yytext(), TokenType.type_String); }

    /* Whitespace */
    {WhiteSp} { /* Ignore */ }

    /* Comments */
    {Comment} { return new Token(yytext(), TokenType.type_String); }

    <<EOF>> { return null; }
}



[^] {
throw new Error("Illegal character <"+yytext()+">");
}


