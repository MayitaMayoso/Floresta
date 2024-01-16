
var explosion = instance_create_layer(x, y, "BelowInstances", obj_explosion);
explosion.damage = damage;
explosion.owner = owner;
instance_create_layer(x, y-z*PERSPECTIVE_FACTOR, "AboveTilesInstances", part_bullet_hit).scl = 75 / sprite_get_width(spr_part_bullet_hit);