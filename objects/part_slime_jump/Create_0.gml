
event_inherited();

dir = random(360);
spd = 1+random(3);
fric = .7;

debris = true;
shadow = false;

image_speed = 0;
image_index = choose(1, 2);

var scl = .5*(1-spd/6);
image_xscale = scl;
image_yscale = scl;

image_blend = merge_color(c_white, c_black, random(.1));