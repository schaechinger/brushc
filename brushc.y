%{
#include <stdio.h>
#include <stdlib.h>

#include "symboltable.h"
%}

%union { int i; double d; float f; node *n; char *s; char c; }

%token <i> NUMBER <d> DOUBLE <f> FLOAT
%token <n> ID

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

prod:	atom;
prod:	prod MUL atom
		{ printf("mul "); };

div:	atom;
div:	div DIV atom
		{ printf("div "); };

cos:	COS atom
		{ printf("cos "); };

sin:	SIN atom
		{ printf("sin "); };

tan:	TAN atom
		{ printf("tan "); };

ln:		LN atom
		{ printf("ln "); };

log:	LOG atom
		{ printf("log "); };

atom:	NUMBER			{ printf("%d ", $1); }
	|	MINUS NUMBER	{ printf("-%d ", $2); }
	|	ID				{ printf("%s ", $1->symbol); }
	|	OPENBRACE expr CLOSEBRACE;

point:	expr COMMA expr;

	/* I D E N T I F I E R */

	/* stmt:	expr EXPORTER ID SEMICOLON */
stmt:	expr EXPORTER
		ID SEMICOLON {
						if ($3->isDeclared == 1)
						{
							printf("/%s exch store\n", $3->symbol);
						}
						else
						{
							printf("/%s exch def\n", $3->symbol);
							$3->isDeclared = 1;
						}
					};

	/* C O L O R */

stmt:	SAVECOLOR OPENBRACE
		NUMBER COMMA NUMBER COMMA NUMBER CLOSEBRACE
		EXPORTER ID SEMICOLON
		{ printf("/%s { %f %f %f setrgbcolor } def\n", $10->symbol, $3 / 255.0, $5 / 255.0, $7 / 255.0); };

stmt:	USECOLOR OPENBRACE
		NUMBER COMMA NUMBER COMMA NUMBER CLOSEBRACE SEMICOLON
		{ printf("%f %f %f setrgbcolor\n", $3 / 255.0, $5 / 255.0, $7 / 255.0); };

stmt:	USECOLOR OPENBRACE ID CLOSEBRACE SEMICOLON
		{ printf("%s\n", $3->symbol); };

	/* S I Z E */

stmt:	USESIZE OPENBRACE NUMBER CLOSEBRACE SEMICOLON
		{ printf("%d setlinewidth\n", $3); };

	/* B R U S H */

stmt:	SAVEBRUSH OPENBRACE
		NUMBER COMMA NUMBER COMMA NUMBER COMMA NUMBER CLOSEBRACE
		EXPORTER ID SEMICOLON
		{ printf("/%s { %f %f %f setrgbcolor\n%d setlinewidth } def\n", $12->symbol, $3 / 255.0, $5 / 255.0, $7 / 255.0, $9); };

stmt:	SAVEBRUSH OPENBRACE
		ID COMMA NUMBER CLOSEBRACE
		EXPORTER ID SEMICOLON
		{ printf("/%s { %s\n%d setlinewidth } def\n", $8->symbol, $3->symbol, $5); };

stmt:	USEBRUSH OPENBRACE ID CLOSEBRACE SEMICOLON
		{ printf("%s\n", $3->symbol); };

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
