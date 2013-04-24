# BRUSH
> Brush version 0.1

> Created by Manuel Schächinger & Wolff Schetula

## Syntax

### Colors
* Save color
	> Save a color with it’s `rgb` values and a `name` (currently the name must be an integer).
	
		saveColor(red, green, blue) > name;
		
* Use color
	> Set the `color` of the brush using a rgb color.
	
		useColor(red, green, blue);
	> Or use a previously saved color by `name`.
	
		useColor(name);

### Brushs
* Size
	> Set the `size` of the brush in pixels.
	
		useSize(size);
* Save brush
	> Save a brush with a (saved)`color` and `size` and a `name`.
	
		saveBrush(red, green, blue, size) > name;
		saveBrush(color, size) > name;
* Use saved brush
	> Activate a previously saved brush with the given `name`.
	
		useBrush(name);

### Draw
* Modes
	> The default mode to draw a line is stroke. To fill the structure write `fill;` at the end of the command.
* Lines
	> Draw a simple line to the screen.

		from x1,y1 to x2,y2;
	> Or draw the line relatively to the start point.
	
		from x1,y1 by x2,y2;
* Polygons
	> Draw a polygon to the screen.
	
		from x1,y2 to x2,y2 to ... to xn,yn;
* Circles
	> Draw a circle at a given `center position` x,y with a `radius` and the `start angle` and the `end angle`. The start angle draws a circle counterclockwise from the right, the end angle draws it clockwise from the right.
	
		circle x,y radius start end;

### Arithmetics
* add
* sub
* mul
* div
* sin
* cos
* tan
* ln
* log

Future features
* sqrt
* mod
* exp