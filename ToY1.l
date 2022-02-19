package scanner;


%%
/* options */

%class Lexer 
%unicode
%type Token


%{
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
    /*
    private Token token(int type){
        return new Token(type);
    }

    private Token token(int type, Object value){
        return new Token(type, value);
    }
    
    public String toString() {
        if(this.value != null)
            return "Token{"
                + "Type" + scanner.sym.terminalNames[this.sym]
                + ", Value="+ this.value + "}";
        else 
            return "Token{"
                + "Type=" + scanner.sym.terminalNames[this.sym] + "}";
    }
    */
%}


/* Regular Definition */
LineTermination = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTermination} | [ \t|f]
Letter = [A-Za-z]
Digit = [0-9]
Id = {Letter}({Letter}|{Digit})*
Num = {Digit}+

%%

/* Lexical Rules */

<YYINITIAL> {
    /* keywords */
    "if" { System.out.print("VALID"); }
    "else" { System.out.print("VALID"); }
    "then" { System.out.print("VALID"); }

    /* identifiers */
    {Id} { System.out.print("VALID"); }

    /* literals*/
    {Num} { System.out.print("VALID"); }

    /* operators */
    "<" { System.out.print("VALID"); }
    "<=" { System.out.print("VALID"); }
    ">" { System.out.print("VALID"); }
    ">=" { System.out.print("VALID"); }
    "==" { System.out.print("VALID"); }
    "!=" { System.out.print("VALID"); }

    /* Whitespace */
    {WhiteSpace} { /* Remove */ }

}

. {
throw new Error("Illegal character <"+yytext()+">");
}



    

