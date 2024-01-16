
MoveAndCollide();

// General movement
var _dir = point_direction(0, 0, xspd, yspd);
var _spd = point_distance(0, 0, xspd, yspd);

_spd = Approach(_spd, 0, fric);

xspd = lengthdir_x(_spd, _dir);
yspd = lengthdir_y(_spd, _dir);

// Z axis
z += zspd;
image_angle += rspd;

if (z<=0) {
    zspd *= -zbounciness;
    z = 0;
} else {
    zspd -= grav;
}