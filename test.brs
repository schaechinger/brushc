//
// star.brs
// brushc test
//
// Created by Manuel Schächinger on 17.04.2013
// Copyright © 2013 Delivery Studios. All rights reserved.
//

57 > r;
11 > c;
360 / c > angle;
400 > x;
400 > y;
0 > current;

saveColor(0, 110, 160) > blue;
saveColor(178, 23, 0) > red;
saveColor(0, 250, 0) > green;
saveColor(250, 250, 0) > yellow;

useColor(red);

for (current > i; c >> i; i + 1 > i)
{
	x > tempX;
	y > tempY;
	
	// switch colors
	if (0 == 0)
	{
		useColor(red);
	}
	else if (i % 4 == 1)
	{
		useColor(green);
	}
	else if (i % 4 == 2)
	{
		useColor(yellow);
	}
	else
	{
		useColor(blue);
	}
	
	floor(c / 2) > temp;
	current + temp > current;
	
	(360 / c) * current > angle;
	
	cos(angle) > temp;
	x + (temp * r) > x;
	
	sin(angle) > temp;
	y + (temp * r) > y;
	
	from tempX,tempY to x,y;
}
