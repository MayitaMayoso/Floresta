/// @description 

GetDamage(other.damage);
var knockback = .5;
AddForce(lengthdir_x(knockback, other.image_angle), lengthdir_y(knockback, other.image_angle));
instance_destroy(other);