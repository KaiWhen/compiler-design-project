%define api.prefix {ToY}
%define api.parser.class {ToY}
%define api.parser.public
%define parse.error verbose

%code imports {
    import java.io.*;
}

%code {
    public static void main(String argv[]) throws IOException {
        Yylex yy = new Yylex(System.in);
        Yytoken t;
        while ((t = yy.yylex()) != null)
            System.out.println(t);
    }
}

%token AND OR NOT ID UNKNOWN_TOKEN

%%

prog:
  srule
;

srule   
    : srule AND crule
    | crule
;

crule
    :
    | '(' lrule OR lrule OR lrule ')'
;

lrule
    : ID
    | NOT ID
;

%%


