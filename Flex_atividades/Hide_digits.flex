%{
    #undef yywrap
    #define yywrap() 1
%}
    
%%
    
[0-9]+  printf("?");
.       ECHO;

%%

main ()
{
    yylex();
    return 0;
}
