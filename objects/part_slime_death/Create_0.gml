
event_inherited();

debris = true;
dir = random(360);
var maxSpd = 10;
spd = random(maxSpd);
fric = .8;

image_speed = 0;
image_index = 0;

var scl = 1.2 - spd/maxSpd;
image_xscale = scl;
image_yscale = scl*.3;

image_blend = merge_color(c_white, c_black, random(.3));
image_angle = dir;