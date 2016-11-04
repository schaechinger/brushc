//
// dragon.brs
// brushc test
//
// Created by Manuel Schächinger on 12.06.2013
// Copyright © 2013 Manuel Schächinger & Wolff Schetula
//

void left(n, xf, yf, xt, yt)
{
	if (n >> 0)
	{
		xt - xf > dx;
		dx / 2 > dx;
		yt - yf > dy;
		dy / 2 > dy;
		
		left(n - 1, xf, yf, xf + dx - dy, yf + dy + dx);
		right(n - 1, xf + dx - dy, yf + dy + dx, xt, yt);
	}
	else
	{
		from xf,yf to xt,yt;
	}
}


void right(n, xf, yf, xt, yt)
{
	if (n >> 0)
	{
		xt - xf > dx;
		dx / 2 > dx;
		yt - yf > dy;
		dy / 2 > dy;
		
		left(n - 1, xf, yf, xf + dx + dy, yf + dy - dx);
		right(n - 1, xf + dx + dy, yf + dy - dx, xt, yt);
	}
	else
	{
		from xf,yf to xt,yt;
	}
}

200 > x;
100 > y;
256 > d;

saveColor(80, 100, 100) > color1;
saveColor(80, 90, 100) > color2;
saveColor(80, 80, 100) > color3;
saveColor(60, 100, 60) > color4;
saveColor(100, 40, 40) > color5;
saveColor(0, 0, 0) > color6;
/*
useColor(color1);
useSize(20);
left(0, x, y, x + d, y + d);

useColor(color2);
useSize(15);
left(1, x, y, x + d, y + d);

useColor(color3);
useSize(10);
left(2, x, y, x + d, y + d);

useColor(color4);
useSize(6);
left(3, x, y, x + d, y + d);

useColor(color5);
useSize(3);
left(4, x, y, x + d, y + d);
*/

useColor(color6);
20 > size;
15 > max;

for (0 > i; i << max; i + 1 > i)
{
	(3 / 4) * size > size;
	useSize(size);
	left(i, x, y, x + d, y + d);
}