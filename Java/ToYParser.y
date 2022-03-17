%language "Java"

%define api.parser.class {ToYParser}
%define api.parser.public
%define parse.error verbose

%code imports {
    import java.io.IOException;
    import java.io.InputStream;
    import java.io.InputStreamReader;
    import java.io.Reader;
    import java.io.StreamTokenizer
}

%code {
    public static void main(String[] args) throws IOException {
    Reader input =
            args.length > 0 ?
               new FileReader(args[0]) :
               new InputStreamReader(System.in);
        ToYLexer l = new ToYLexer(input);
        ToYParser p = new ToYParser(l);
        if (!p.parse()) System.out.println("INVALID");
    }
}

/* Bison Declarations */
%token <Integer> NUM
%type exp

%%

input: line | input line;

line: '\n'
| exp '\n' { System.out.println($exp); }
| error '\n'
;

exp:
    NUM { $$ = $1; }
| exp '=' exp { if ($1.intValue() != $3.intValue()) yyerror("calc: error: " + $1 + " != " + $3); }
| exp '+' exp { $$ = $1 + $3; }
| exp '-' exp { $$ = $1 - $3; }
| exp '*' exp { $$ = $1 * $3; }
| exp '/' exp { $$ = $1 / $3; }
| '-' exp %prec NEG { $$ = -$2; }
| exp '^' exp { $$ = (int) Math.pow($1, $3); }
| '(' exp ')' { $$ = $2; }
| '(' error ')' { $$ = 1111; }
| '!' { $$ = 0; return YYERROR; }
| '-' error { $$ = 0; return YYERROR; }
;

%%

class ToYLexer implements ToY.Lexer {
    InputStreamReader it;
    Yylex yylex;
        
    public ToYLexer(InputStream is){
        it = new InputStreamReader(is);
        yylex = new Yylex(it);
    }

    @Override
    public void yyerror (String s){
        System.err.println(s);
    }

    ParserToken yylval;
    @Override
    public Object getLVal() {
        // Returns the semantic value of the last token that yylex returned.
        return yylval;
    }

    @Override
    public int yylex () throws IOException{
        // Returns the next token. Here we get the next Token from the Lexer
        return yylex.yylex();
    }
}
