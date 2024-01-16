
if (collide) {
	// Move away from other enemies
	var fixXpos = 0;
	var fixYpos = 0;
	
	var inst = InstanceNearest(obj_character);
	if (inst!=noone) {
	    var instDist = point_distance(x, y, inst.x, inst.y);
	    if (instDist<avoidRadius+inst.avoidRadius) {
	        if (instDist<1) {
	            fixXpos = random(4)-2;
	            fixYpos = random(4)-2;
	        } else {
	            var instDir = point_direction(inst.x, inst.y, x, y);
	            fixXpos = lengthdir_x(.2, instDir);
	            fixYpos = lengthdir_y(.2, instDir);
	        }
	    }
	}

	Move(fixXpos, fixYpos);
}

fsm.FixedStepEvent();
event_inherited();
juice = lerp(juice, 0, 0.05);