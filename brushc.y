%{
#include <stdio.h>
#include <stdlib.h>
%}

%token NUMBER ID

%token COMMA SEMICOLON
%token EXPORTER IMPORTER
%token OPENBRACE CLOSEBRACE OPENCURLYBRACE CLOSECURLYBRACE

%token PLUS MINUS MUL DIV MOD
%token COS SIN TAN
%token LOG LN

%token BY FROM TO
%token FILL
%token CIRCLE

%token SAVECOLOR USECOLOR USESIZE
%token SAVEBRUSH USEBRUSH

%%

program: { printf("%%PS Adobe\n"); } stmtlist { printf("\nshowpage\n"); } ;
stmtlist:;
stmtlist: stmtlist stmt;

	/* A R I T H M E T I C S */

expr:	prod
	|	div
	|	cos
	|	sin
	|	tan
	|	ln
	|	log;
expr:	expr PLUS div	{ printf("add "); }
	|	expr PLUS prod	{ printf("add "); }
	|	expr PLUS cos	{ printf("add "); }
	|	expr PLUS sin	{ printf("add "); }
	|	expr PLUS tan	{ printf("add "); }
	|	expr PLUS ln	{ printf("add "); }
	|	expr PLUS log	{ printf("add "); };
expr:	expr MINUS div	{ printf("sub "); }
	|	expr MINUS prod	{ printf("sub "); }
	|	expr MINUS cos	{ printf("sub "); }
	|	expr MINUS sin	{ printf("sub "); }
	|	expr MINUS tan	{ printf("sub "); }
	|	expr MINUS ln	{ printf("sub "); }
	|	expr MINUS log	{ printf("sub "); };

prod:	number;
prod:	prod MUL number
		{ printf("mul "); };

div:	number;
div:	div DIV number
		{ printf("div "); };

cos:	COS number
		{ printf("cos "); };

sin:	SIN number
		{ printf("sin "); };

tan:	TAN number
		{ printf("tan "); };

ln:		LN number
		{ printf("ln "); };

log:	LOG number
		{ printf("log "); };

number:	NUMBER			{ printf("%d ", $1); }
	|	MINUS NUMBER	{ printf("-%d ", $2); }
	|	OPENBRACE expr CLOSEBRACE;

point:	expr COMMA expr;

	/* C O L O R */

stmt:	SAVECOLOR OPENBRACE
		NUMBER COMMA NUMBER COMMA NUMBER CLOSEBRACE
		EXPORTER NUMBER SEMICOLON
		{ printf("/color%d { %f %f %f setrgbcolor } def\n", $10, $3 / 255.0, $5 / 255.0, $7 / 255.0); };

stmt:	USECOLOR OPENBRACE
		NUMBER COMMA NUMBER COMMA NUMBER CLOSEBRACE SEMICOLON
		{ printf("%f %f %f setrgbcolor\n", $3 / 255.0, $5 / 255.0, $7 / 255.0); };

stmt:	USECOLOR OPENBRACE NUMBER CLOSEBRACE SEMICOLON
		{ printf("color%d\n", $3); };

	/* S I Z E */

stmt:	USESIZE OPENBRACE NUMBER CLOSEBRACE SEMICOLON
		{ printf("%d setlinewidth\n", $3); };

	/* B R U S H */

stmt:	SAVEBRUSH OPENBRACE
		NUMBER COMMA NUMBER COMMA NUMBER COMMA NUMBER CLOSEBRACE
		EXPORTER NUMBER SEMICOLON
		{ printf("/brush%d { %f %f %f setrgbcolor\n%d setlinewidth } def\n", $12, $3 / 255.0, $5 / 255.0, $7 / 255.0, $9); };

stmt:	SAVEBRUSH OPENBRACE
		NUMBER COMMA NUMBER CLOSEBRACE
		EXPORTER NUMBER SEMICOLON
		{ printf("/brush%d { color%d\n%d setlinewidth } def\n", $8, $3, $5); };

stmt:	USEBRUSH OPENBRACE NUMBER CLOSEBRACE SEMICOLON
		{ printf("brush%d\n", $3); };

	/* D R A W */

stmt: 	FROM { printf("newpath\n"); }
		point { printf(" moveto\n"); }

stmt:	FILL SEMICOLON
		{ printf(" fill\n"); };

	/* Absolute values */
stmt:	TO point { printf("lineto\n"); }
		SEMICOLON { printf("stroke\n"); };

stmt:	TO point { printf("lineto\n"); };

	/* Relative values */
stmt:	BY point SEMICOLON
		{ printf(" rlineto\nstroke\n"); };

stmt:	BY point
		{ printf(" rlineto\n"); };

	/* Circles */
circle:	CIRCLE point NUMBER NUMBER NUMBER
		{ printf(" %d %d %d arc", $3, $4, $5); };

stmt:	circle SEMICOLON
		{ printf(" stroke\n"); };

	/* Ability to fill the circle */
stmt:	circle;

%%

int yyerror(char *str)
{
	fprintf(stderr,"BISON ERROR: %s\n",str);
	return 0;
}

int main(void)
{
	yyparse();
	return 0;
}
