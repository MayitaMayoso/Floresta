
if (instance_exists(owner)) {
    // Draw the gun
    var recoilX = lengthdir_x(recoilCurrentOffset, image_angle);
    var recoilY = lengthdir_y(recoilCurrentOffset, image_angle);
    draw_sprite_ext(sprite_index, image_index, x+recoilX, y+recoilY-2 - (!wielded)*10 - (owner.z+holdHeight)*PERSPECTIVE_FACTOR, image_xscale, image_yscale, image_angle+recoilCurrentAngle, image_blend, image_alpha);
    
    // Draw the fire
    if (showFire) {
        var shootDir = image_angle+recoilCurrentAngle;
        var xOff = 18;
        var yOff = sign(image_yscale);
        var bullX = x+recoilX + xOff*dcos(shootDir) + yOff*dsin(shootDir);
        var bullY =  y+recoilY-2 + yOff*dcos(-shootDir) + xOff*dsin(-shootDir) - holdHeight - owner.z*PERSPECTIVE_FACTOR;
        draw_sprite_ext(spr_weapon_fire, 0, bullX, bullY, 1.5, 1.5, shootDir, c_white, 1);
    }
} else {
    event_inherited();
}