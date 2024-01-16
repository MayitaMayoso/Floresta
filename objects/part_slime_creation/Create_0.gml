
event_inherited();

lifeTime = random_range(100, 120);
alphaDecay = true;

dir = random(360);
spd = random_range(1, 2.3);
fric = .05;

rspd = random_range(-5, 5);
zspd = 1.5;
grav = 0;

image_speed = 0;
image_index = choose(0, 1, 2);

var scl = .3 + 2*spd/2.3;
image_xscale = scl;
image_yscale = scl;

image_blend = merge_color(c_white, c_black, random(.3));