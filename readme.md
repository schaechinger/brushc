# BRUSH

> version 0.1

Brush is a compiler for a simple language named brush to render figures in
postscript that was created during an university course.

## Syntax

### Numbers
* Integer

		0
		1234
		
* Double

		0.0
		1234.56
	
* Float

		0.0f
		1234.56f

### Colors
* Save color
	> Save a color with it’s `rgb` values and a `name`.
	
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

		x + y
* sub

		x - y
* mul

		x * y
* div

		x / y
* sin

		sin x
		sin (x + y)
* cos

		cos x
		cos (x - y)
* tan

		tan x
		tan (x * y)
* mod

		x % y
* ln

		ln x
		ln (x  / y)
* log

		log x
		log (x + y)

### Identifiers
> Identifiers have to start case letter or an underscore and may contain letters, underscores and dashes afterwards.
	
	identifier
	_identifier
	myIdentifier
	my_identifier
	
> Defining an identifier is like editing the current value. The identifier is defined the first time it is used.
	
	5 > id;
	5 * id > id;
	
> To force the initialization of a new variable you can type the following statement. This is very useful if you want to declare a local variable that is called like a global variable.

	5 :> id;

### Control structures

* if
	> code gets only executed if the bool is true
	
		if (bool)
		{
			statement;
		}
		else if (bool)
		{
			statement;
		}
		else
		{
			statement;
		}

* do
	> loops x times
	
		do (5)
		{
			statement;
		}
	
* while
	> repeat the code while the condicion is valid
	
		while (bool)
		{
			statement;
		}
	
* for
	> repeat the code until the condition is invalid
	
		for (0 > i; 5 << i; i + 1 > i)
		{
			statement;
		}	

### Procedures
> procedures allow you to run the same code with different values for the variables

	void procedureName(a, b, c)
	{
		statement;
	}

> call a procedure by typing it's name and the parameters

	procedureName(1, 2, 3);

### Methods
> coming soon

## Future features

* sqrt

		sqrt x
		sqrt (x - y)

* exp
	> Calculate the exponent of x^y
	
		exp (x, y)