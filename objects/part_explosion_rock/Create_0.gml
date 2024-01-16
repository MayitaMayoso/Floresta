
event_inherited();

lifeTime = 10sec;
dir = random(360);
z=1;
zspd = random_range(1, 4);
grav = .1;
debris = true;
rspd = 4;
shadow = true;
stopOnGround = true;

debris = true;
dir = random(360);
var maxSpd = 2;
spd = random_range(1, maxSpd);

image_speed = 0;
image_index = irandom(sprite_get_number(sprite_index));

var scl = 1 - .7*spd/maxSpd;
image_xscale = scl;
image_yscale = scl;

image_blend = merge_color(c_white, c_black, random(.3));
image_angle = dir;