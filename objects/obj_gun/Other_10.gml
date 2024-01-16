
event_inherited();

if (instance_exists(owner)) {
    // Facing of the gun
    var facing = 1 - 2 * (abs(angle_difference(owner.controls.gunDirection, 0)) > 90);
	
	// Movement of the gun
    if (wielded) {
        x = owner.x;
        y = owner.y + 1;
		
        image_yscale = facing;
        image_angle = Wrap(image_angle+angle_difference(owner.controls.gunDirection,image_angle) * 0.3, 0, 360);
    } else {
        // Move the gun
        x = owner.x - 7*facing;
        y = owner.y - 2;
        
        image_yscale = -facing;
        image_angle = Wrap(image_angle+angle_difference(90 + 45*facing,image_angle) * 0.3, 0, 360);
    }
	
	// Recoil and other juice stuff
    recoilCurrentOffset = -recoilOffset*animcurve_channel_evaluate(recoilOffsetCurve, recoil);
    recoilCurrentAngle = -recoilAngle*animcurve_channel_evaluate(recoilAngleCurve, recoil)*image_yscale;
    
    showFire--;
    recoil += 1 / recoilDuration;
} else {
	// Stop rotating when throw
    if (z==0) {
        rspd = Approach(rspd, 0, .1);
    }
}
