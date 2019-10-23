%{
%}
%%
[0-9]   {printf("%s (digit).\n", yytext);}
.       {printf("\n");}
\n      {return 0;}
%%
int yywrap() {}
int main()
{
    yylex();
    return 0;
}
