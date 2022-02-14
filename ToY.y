%define <Definitions>

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

%%

<Grammar rules>

%%

<Additional Java code>
