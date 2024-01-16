
event_inherited();

// Public variables. Change this on children objects
bullet = obj_bullet;
shootSpeed = 5; /// Bullets per second
accuracy = 0;

holdHeight = 7;
recoilOffset = 7;
recoilAngle = 20;
recoilDuration = .2sec;

bulletXSpawn = 18;
bulletYSpawn = -4;

// Private variables
owner = noone;
showFire = 0;
shadowPrecise = true;
preciseCollisions = true;

shootTimer = 0;
recoil = 1;
recoilOffsetCurve = animcurve_get_channel(curve_recoil, "offset");
recoilAngleCurve = animcurve_get_channel(curve_recoil, "angle");
recoilCurrentAngle = 0;
recoilCurrentOffset = 0;

wielded = true;

// Physics
grav = .2;
acc = .05;
bounciness = 1;

Shoot = function() {
    if (Time.frame > shootTimer) {
        var shootDir = image_angle + recoilCurrentAngle;
        var bullX = x + bulletXSpawn*dcos(shootDir) + image_yscale*bulletYSpawn*dsin(shootDir);
        var bullY = y + image_yscale*bulletYSpawn*dcos(-shootDir) + bulletXSpawn*dsin(-shootDir);
        
        var bull = instance_create_layer(bullX, bullY, "Instances", bullet, { image_angle: shootDir + random_range(-accuracy/2, accuracy/2) });
        bull.z = holdHeight + owner.z;
		bull.owner = owner;
        shootTimer = Time.frame + 1sec / shootSpeed;
        
        // Juice        
        showFire = .025sec; recoil = 0; Camera.Shake(1);
        with (instance_create_layer(x, y, choose("AboveInstances"), part_bullet_shell, {parDir : image_angle+180})) {
            z = other.holdHeight+other.owner.z;
        }
    }
}

Throw = function(dir, strength = 0) {
    x = owner.x;
    y = owner.y;
    z = holdHeight + owner.z;
    
    xspd = lengthdir_x(strength, dir);
    yspd = lengthdir_y(strength, dir);
    zspd = 4;
    rspd = -strength*2*image_yscale;
    
    // owner.gun = noone;
    owner = noone;
}
