
if (life>lifeTime || stopOnGround && z<=0) {
    if (debris) Debris.DrawObject(id);
    instance_destroy();
}