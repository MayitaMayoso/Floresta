
event_inherited();

if (x==0 || x==room_width || y==0 || y==room_height || tile_meeting_precise(x, y)) instance_destroy();

var nearest = instance_nearest(x, y, obj_character);
var dist = point_distance(x, y, nearest.x, nearest.y);

if (nearest!=owner && dist<nearest.hitRadius) {
	with(nearest) {
		GetDamage(other.damage);
		var knockback = .5;
		AddForce(lengthdir_x(knockback, other.image_angle), lengthdir_y(knockback, other.image_angle));
		instance_destroy(other);
	}
}