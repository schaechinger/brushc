//
// brush.brs
// brushc test
//
// Created by Manuel Schächinger on 17.04.2013
// Copyright © 2013 Manuel Schächinger & Wolff Schetula
//

// draw a diagonal line from a to b
void diagonal(a, b)
{
	if (a >> b)
	{
		from a,a to b,b;
	}
	else
	{
		from b,b to a,a;
	}
}


func double(a)
{
	0 > b;
	if (a >> 0)
	{
		2 * a > b;
	}
	return b;
}


double(3);


// global variables
//100 > a;
0 > b;
5 > y;

from b,y to a,y;
diagonal(1,2) > a;
for (15 > i; i >> 10; i - 1 > i)
{
	y + 5 > y;
	// local variable a
	200 :> a;
	50 > b;
	from b,y to a,y;
}

y + 5 > y;

from b,y to a,y;

// save a color with a name
saveColor(0, 110, 160) > blue;

diagonal(100, 300);

// save brushes that contain colors and sizes
saveBrush(blue, 5) > blueBrush;
saveBrush(210, 0, 0, 15) > redBrush;
saveBrush(blue, 2) > thinBlueBrush;

// use the first saved brush
useBrush(blueBrush);

// draw a walls of the house
100 > a;
300 > b;
500 > c;
from b,a to b,b to c,b to c,a to b,a;

// draw the door
useBrush(thinBlueBrush);
from 425,100 by 0,50 by 25,0 by 0,-50;

// draw a circle for the roof
useBrush(redBrush);
circle 400,300 100 0 180;
