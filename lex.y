%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token A B END

%%

start:
    seq_b { printf("Valid string.\n"); }
    ;

seq_b:
      a_seq B { if ($1 >= 5) printf("Valid string.\n"); else yyerror("Invalid string: not enough 'a's"); }
    ;

a_seq:
    A A A A A { $$ = 5; }
    | A a_seq { $$ = 1 + $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
    exit(1);
}

int main() {
    yyparse();
    return 0;
}