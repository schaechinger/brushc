%{
#include <stdio.h>
#include <stdlib.h>

#include "symboltable.h"

extern line;
%}

%union { int i; double d; float f; node *n; char *s; char c; }

%token <i> NUMBER <d> DOUBLE <f> FLOAT
%token <n> ID

%token COMMA SEMICOLON
%token EXPORTER IMPORTER
%token DOUBLEPOINT
%token OPENBRACE CLOSEBRACE OPENCURLYBRACE CLOSECURLYBRACE

%token PLUS MINUS MUL DIV MOD
%token EQUALS NOT
%token COS SIN TAN
%token LOG LN

%token BY FROM TO
%token FILL
%token CIRCLE
%token FLOOR

%token IF ELSE WHILE LOOP EXIT DO FOR

%token SAVECOLOR USECOLOR USESIZE
%token SAVEBRUSH USEBRUSH

%%

program:	header varlist stmtlist trailer ;
header:		{ printf("%%PS-Adobe\n"); };
trailer:	{ printf("\nshowpage\n"); };

stmtlist:	;
stmtlist:	stmtlist stmt;

varlist:	;
varlist:	varlist var SEMICOLON;

	/* boolean declarations */
bool: expr IMPORTER IMPORTER expr	{ printf("lt "); }
	| expr IMPORTER EQUALS expr		{ printf("le "); }
	| expr EXPORTER EXPORTER expr	{ printf("gt "); }
	| expr EXPORTER EQUALS expr		{ printf("ge "); }
	| expr EQUALS EQUALS expr		{ printf("eq "); }
	| expr NOT EQUALS expr			{ printf("ne "); };

stmts:	stmts stmt
	|	stmt;

block:	OPENCURLYBRACE	{ printf("1 dict begin\n"); }
		stmts
		CLOSECURLYBRACE	{ printf("end\n"); };

	/* A R I T H M E T I C S */

expr:	prod
	|	div
	|	cos
	|	sin
	|	tan
	|	ln
	|	log
	|	floor
	|	expr PLUS expr { printf("add "); }
	|	expr MINUS expr { printf("sub "); }
	|	expr MOD expr { printf("mod "); };

prod:	atom;
prod:	prod MUL atom
		{ printf("mul "); };

div:	atom DIV atom
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

floor:	FLOOR atom
		{ printf("floor "); };

atom:	NUMBER			{ printf("%d ", $1); }
	|	MINUS NUMBER	{ printf("-%d ", $2); }
	|	ID				{ printf("%s ", $1->symbol); }
	|	OPENBRACE expr CLOSEBRACE;

point:	expr COMMA expr;

	/* I D E N T I F I E R */

	/* force new declaration of a variable
		this is very useful for local variables */
var:	expr DOUBLEPOINT EXPORTER ID
		{
			printf("/%s exch def\n", $4->symbol);
			$4->isDeclared = 1;
		}

	/* stmt:	expr EXPORTER ID SEMICOLON */
var:	expr EXPORTER
		ID	{
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

stmt: var SEMICOLON;

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

	/* Conditions */

elsec:	;
elsec:	ifc
		ELSE	{ printf("\n{\n"); }
		elsec	{ printf("} ifelse"); }
	|	ifc
		ELSE	{ printf("\n{\n"); }
		block	{ printf("} ifelse"); };

ifc:	IF
		OPENBRACE bool CLOSEBRACE { printf("\n{\n"); }
		block { printf("} "); };

stmt:	elsec { printf("\n"); }
	|	ifc { printf("if\n"); }
	|	IF error { yyerror("missing '(' after 'if'"); };

stmt:	LOOP { printf("\n{\n"); }
		block { printf("} loop\n"); };

stmt:	EXIT SEMICOLON { printf("exit;\n"); };

stmt:	DO OPENBRACE NUMBER CLOSEBRACE { printf("\n/do 0 store\n{\n /do do 1 add store\ndo %d gt { exit } if\n", $3); }
		block { printf("} loop\n"); };

whilec:	WHILE OPENBRACE { printf("\n{\n"); }
		bool CLOSEBRACE { printf("{ } { exit } ifelse\n"); }
		block { printf("} loop\n"); };

forc:	FOR OPENBRACE var { printf("{\n"); }
		SEMICOLON bool SEMICOLON { printf("{ } { exit } ifelse\n"); }
		var CLOSEBRACE block { printf("} loop\n"); };

stmt: whilec
	| forc;

%%

int yyerror(char *str)
{
	fprintf(stderr,"BRUSHC: %s in line %d\n", str, line);
	return 0;
}

int main(void)
{
	yydebug = 0;
	yyparse();
	return 0;
}
