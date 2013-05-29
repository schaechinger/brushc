//
// star.brs
// brushc test
//
// Created by Manuel Schächinger on 17.04.2013
// Copyright © 2013 Delivery Studios. All rights reserved.
//

100 > r;
15 > c;
360 / c > angle;
400 > x;
400 > y;
0 > current;

saveColor(0, 110, 160) > blue;
saveColor(178, 23, 0) > red;
saveColor(0, 250, 0) > green;
saveColor(0, 250, 250) > yellow;

useColor(red);

for (current > i; c >> i; i + 1 > i)
{
	x > tempX;
	y > tempY;
	
	if (i <= c / 2)
	{
		useColor(blue);
	}
	else if (i == c - 1)
	{
		useColor(green);
	}
	else
	{
		useColor(red);
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
