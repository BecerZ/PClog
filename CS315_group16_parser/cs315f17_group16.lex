
alphabetic                   [A-Za-z]
digit                        [0-9]
sign                         [+-]
alphanumeric                 ({alphabetic}|{digit}|{space})*
int_val                      ({sign}?{digit}+)
comment			     #([^\n])*
newline                      \n
%%
if                           { return IF;}
else                         { return ELSE ;}
for                          { return FOR ;}
while                        { return WHILE ;}
do                           { return DO ;}
return                       { return RETURN ;}
int                          { return INTEGER_VAR ;}
boolean                      { return BOOLEAN_VAR ;}
true                         { return TRUE ;}
false                        { return FALSE ;}
read			     { return INPUT ;}
write           	     { return OUTPUT ;}
const                        { return CONST ;}
predicate                    { return PREDICATE; }
function		     { return FUNCTION; }
arg			     { return ARGUMENT; }
{comment}		     { }
\:			     { return COLON; }	
\,                           { return COMMA ;}
\;                           { return SEMICOLON ;}
\{	                         { return LBRACE ;}
\}	                         { return RBRACE ;}
\(		                       { return LP ;}
\)		                       { return RP ;}
\[			     { return LBRACKET; }
\]			     { return RBRACKET; }
\+                           { return ADDITION_OPERATOR ;}
\-                           { return SUBTRACTION_OPERATOR ;}
\*                           { return MULTIPLICATION_OPERATOR ;}
\/                           { return DIVISION_OPERATOR ;}
\-\-\>                       { return LOGICAL_IMPLIES_OPERATOR ;}
\=		                       { return ASSIGNMENT_OPERATOR ;}
\=\=	        	             { return EQUALITY_OPERATOR ;}
\!\=                         { return NOT_EQUALITY_OPERATOR ;}
\<			                     { return LESS_THAN_OPERATOR ;}
\>                			     { return GREATER_THAN_OPERATOR ;}
\<\=	              		     { return LESS_THAN_OR_EQUAL_OPERATOR ;}
\>\=			                   { return GREATER_THAN_OR_EQUAL_OPERATOR ;}
\|\|              			     { return LOGICAL_OR_OPERATOR ;}
\&\&			                   { return LOGICAL_AND_OPERATOR ;}
\!                			     { return NOT_OPERATOR ;}
{newline}          			     { extern int lineno; lineno++; return NEW_LINE ;}
{int_val}                    {sscanf(yytext, "%d", &yylval.integer); return INTEGER_VAL ;}
{alphabetic}+                { return IDENTIFIER ;}

%%
int yywrap()                 { return 1; }
