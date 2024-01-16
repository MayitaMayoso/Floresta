
if (!done) {
	//Print(owner);
    with(obj_character) {
        if (id!=other.owner && collide && point_distance(x, y, other.x, other.y) < other.radius + hitRadius) {
            GetDamage(other.damage);
            SetKnockback(id, 2, point_direction(other.x, other.y, x, y));
        }
    }
    repeat(10)
        instance_create_layer(x, y, "AboveInstances", part_explosion_rock);
    done = true;
}