#
#  makefile
#  brushc
#
#  Created by Manuel Schächinger on 17.04.2013.
#  Copyright (c) 2013 Delivery Studios. All rights reserved.
#

all: brushc brush.ps
	open brush.ps &

test: brushc test.ps
	open test.ps &

lex.yy.c: brushc.l
	flex brushc.l

brushc.tab.c: brushc.y
	bison -d brushc.y

brushc.tab.h: brushc.y
	bison -d brushc.y

brushc: lex.yy.c brushc.tab.h brushc.tab.c symboltable.h symboltable.c
	gcc lex.yy.c brushc.tab.c symboltable.c -o brushc

brush.ps: brush.brs brushc
	./brushc < brush.brs > brush.ps

test.ps: test.brs brushc
	./brushc <test.brs > test.ps

clean:
	rm -f lex.yy.c brushc.tab.* brushc *.ps
