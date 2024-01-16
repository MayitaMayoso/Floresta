
if (!initialised && xspd==0 && yspd==0 && spd!=0) {
    SetForcePolar(spd, dir);
    initialised = true;
}

event_inherited();

if (stopOnGround && z<=0) {
    SetForce(0, 0);
    rspd = 0;
    layer = layer_get_id("BelowInstances");
}

if (!showWait) {
    life++;
    if (alphaDecay) image_alpha = 1-life/lifeTime;
}

showWait--;