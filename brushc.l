%{
#include "symboltable.h"
#include "brushc.tab.h"
%}

%option noyywrap

	/* positive numbers only */
INT						0|[1-9][0-9]*
DOUBLE					[INT]"."[0-9]+
FLOAT					[DOUBLE]"f"

%%

{INT}					yylval.i = atoi(yytext); return NUMBER;
{DOUBLE}				yylval.d = atof(yytext); return NUMBER;
{FLOAT}					yylval.f = atof(yytext); return NUMBER;

from					return FROM;
to						return TO;
by						return BY;

fill					return FILL;

circle					return CIRCLE;

\,						return COMMA;
\;						return SEMICOLON;

\>						return EXPORTER;
\<						return IMPORTER;

	/* A R I T H M E T I C S */

\+						return PLUS;
\-						return MINUS;
\*						return MUL;
\/						return DIV;
mod						return MOD;

	/* Trigonometry */
cos						return COS;
sin						return SIN;
tan						return TAN;

	/* Logarithmics */
log						return LOG;
ln						return LN;

	/* Braces */
\(						return OPENBRACE;
\)						return CLOSEBRACE;
\{						return OPENCURLYBRACE;
\}						return CLOSECURLYBRACE;

\/\/[^\n]*				;
\/\*([^*]|\*[^/])*\*+\/	;

	/* B R U S H   S P E C I F I C */

saveColor			return SAVECOLOR;
useColor			return USECOLOR;
useSize				return USESIZE;
saveBrush			return SAVEBRUSH;
useBrush			return USEBRUSH;

	/* Cut all whilespaces and linebreaks */
[[:space:]]			;

	/* S T R I N G S */

[_a-z][a-zA-Z0-9_]*	{
						yylval.n = lookup(yytext);
						if (yylval.n == NULL)
						{
							yylval.n = insert(yytext);
						}
						return ID;
					}

	/* Error state */
.					fprintf(stderr,"unexpected characted: %s\n", yytext);

%%
