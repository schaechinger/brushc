//
// brush.brs
// brushc test
//
// Created by Manuel Schächinger on 17.04.2013
// Copyright © 2013 Delivery Studios. All rights reserved.
//

// set the size of the brush
//useBrushSize(5);

// save a color with a name
saveColor(0, 110, 160) > 1;
// save brushes that contain colors and sizes
saveBrush(1, 5) > 1;
saveBrush(210, 0, 0, 15) > 2;
saveBrush(1, 2) > 3;

// use the first saved brush
useBrush(1);

// draw a walls of the house
from 300,100 to 300,300 to 500,300 to 500,100 to 300,100;

// draw the door
useBrush(3);
from 425,100 by 0,50 by 25,0 by 0,-50;

// draw a circle for the roof
useBrush(2);
circle 400,300 100 0 180;
