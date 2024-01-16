
event_inherited();

var cx = Camera.view.x;
var cy = Camera.view.y;
var mx = lerp(x, x, .25);
var my = lerp(y, y, .25);
var tx = mx + lengthdir_x(100, controls.gunDirection);
var ty = my + lengthdir_y(100, controls.gunDirection);
var newX = lerp(mx, tx, .8);
var newY = lerp(my, ty, .8);

if (cameraFollow = true)
	Camera.Position(lerp(cx, newX, .1), lerp(cy, newY, .1));