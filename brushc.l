%{
	#include "symboltable.h"
	#include "brushc.tab.h"

	int line = 1;
	int column = 1;
%}

%option noyywrap

	/* positive numbers only */
INT						0|[1-9][0-9]*
DOUBLE					[INT]"."[0-9]+
FLOAT					[DOUBLE]"f"


%%


	/* Numbers */
{INT}					yylval.i = atoi(yytext); return NUMBER;
{DOUBLE}				yylval.d = atof(yytext); return NUMBER;
{FLOAT}					yylval.f = atof(yytext); return NUMBER;

	/* Draw */
from					return FROM;
to						return TO;
by						return BY;
fill					return FILL;
circle					return CIRCLE;

\,						return COMMA;
\;						return SEMICOLON;

	/* Assignments */
\>						return EXPORTER;
\<						return IMPORTER;

\:						return DOUBLEPOINT;

	/* Comparators */
\=						return EQUALS;
\!						return NOT;

	/* Methods */
void					return PROC;
func					return FUNC;
return					return RETURN;


	/* A R I T H M E T I C S */


\+						return PLUS;
\-						return MINUS;
\*						return MUL;
\/						return DIV;
\%						return MOD;

	/* Trigonometry */
cos						return COS;
sin						return SIN;
tan						return TAN;

	/* Round */
floor					return FLOOR;

	/* Logarithmics */
log						return LOG;
ln						return LN;

	/* Conditions */
if						return IF;
else					return ELSE;
while					return WHILE;
loop					return LOOP;
exit					return EXIT;
do						return DO;
for						return FOR;

	/* Braces */
\(						return OPENBRACE;
\)						return CLOSEBRACE;
	/* Enter a new scope */
\{						{
							openScope();
							return OPENCURLYBRACE;
						};
	/* leave the current scope and
	   clear local variables */
\}						{
							closeScope();
							return CLOSECURLYBRACE;
						};

\/\/[^\n]*				;
\/\*([^*]|\*[^/])*\*+\/	;


	/* B R U S H   S P E C I F I C */


	/* Color */
saveColor				return SAVECOLOR;
useColor				return USECOLOR;
	/* Brush size */
useSize					return USESIZE;
	/* Brush */
saveBrush				return SAVEBRUSH;
useBrush				return USEBRUSH;
	/* Font and size */
useFont					return USEFONT;
	/* Draw text */
drawText				return DRAWTEXT;

	/* Update the linenumber to show
	   better error information */
\n						{
							line++;
							column = 1;
						}

	/* Cut all whilespaces and linebreaks */
[[:space:]]				;


	/* S T R I N G S */


[_a-z][a-zA-Z0-9_]*		{
							yylval.n = lookup(yytext);
							if (yylval.n == NULL)
							{
								yylval.n = insert(yytext);
							}
							return ID;
						}

	/* Error state */
.						{
							fprintf(stderr,"unexpected characted: %s at %d:%d\n",
								yytext, line, column);
						}


%%

