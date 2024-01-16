#macro YSPEED_FACTOR .8

function AddForce(_xspd, _yspd, _zspd=0) {
    xspd += _xspd;
    yspd += _yspd;
    zspd += _zspd;
}

function SetForce(_xspd, _yspd, _zspd=zspd) {
    xspd = _xspd;
    yspd = _yspd;
    zspd = _zspd;
}

function ApproachForce(_xspd, _yspd, _zspd=zspd) {
    xspd = Approach(xspd, _xspd, acc+fric);
    yspd = Approach(yspd, _yspd, acc+fric);
    zspd = Approach(zspd, _zspd, acc+fric);
}

function AddForcePolar(_spd, _dir) {
    xspd += lengthdir_x(_spd, _dir);
    yspd += lengthdir_y(_spd, _dir);
}

function SetForcePolar(_spd, _dir) {
    xspd = lengthdir_x(_spd, _dir);
    yspd = lengthdir_y(_spd, _dir);
}

function ApproachForcePolar(_spd, _dir) {
    var _xspd = lengthdir_x(_spd, _dir);
    var _yspd = lengthdir_y(_spd, _dir);
	Print(_xspd, _yspd, acc+fric, xspd, yspd);
    xspd = Approach(xspd, _xspd, acc+fric);
    yspd = Approach(yspd, _yspd, acc+fric);
}

function MovePolar(_spd, _dir) {
    x += lengthdir_x(_spd, _dir);
    y += lengthdir_y(_spd, _dir);
}

function Move(_xspd, _yspd) {
    x += _xspd;
    y += _yspd;
}

function MoveAndCollidePrecise() {
    // Horizontal movement
    if (tile_meeting_precise(x+xspd, y)) {
        while(!tile_meeting_precise(x+sign(xspd), y) && abs(xspd)>1) {
            x += sign(xspd);
        }
        xspd = -xspd*bounciness;
    }
    
    // Vertical movement
    var fixedYspd = yspd*YSPEED_FACTOR
    if (tile_meeting_precise(x, y+fixedYspd)) {
        while(!tile_meeting_precise(x, y+sign(fixedYspd)) && abs(fixedYspd)>1) {
            y += sign(fixedYspd);
        }
        yspd = -yspd*bounciness;
    }
    
    x += xspd;
    y += yspd*YSPEED_FACTOR;
    
    FixPosition();
}

function MoveAndCollideNotPrecise() {
    // Horizontal movement
    if (tile_meeting(x+xspd, y)) {
        while(!tile_meeting(x+sign(xspd), y) && abs(xspd)>1) {
            x += sign(xspd);
        }
        xspd *= -bounciness;
    }
    
    // Vertical movement
    if (tile_meeting(x, y+yspd*YSPEED_FACTOR)) {
        while(!tile_meeting(x, y+sign(yspd)) && abs(yspd*YSPEED_FACTOR)>1) {
            y += sign(yspd);
        }
        yspd *= -bounciness;
    }
    
    x += xspd;
    y += yspd*YSPEED_FACTOR;
}

function FixPosition() {
    // Fix position if stuck on the wall
    if (tile_meeting_precise(x, y) ) {
    	var checking_direction = 0;
    	var checking_precission = 45;
    	var checking_distance = 1;
    	var check_x = x;
    	var check_y = y;
    	var max_iter = 300;
    	var current_iter = 0;
    	
    	// While our current position is stuck in a wall
    	while (tile_meeting_precise(check_x, check_y) && current_iter<max_iter) {
    		// Check in a circle which is the closest free position
    		// If there is no free position in the circle increase the circle radius
    		checking_direction = (checking_direction+checking_precission)%360;
    		checking_distance++;
    		current_iter++;
    	
    		// Calculate the new checking positions
    		check_x = x+lengthdir_x(checking_distance, checking_direction);
    		check_y = y+lengthdir_y(checking_distance, checking_direction);
    	}
    
    	x += sign(check_x-x);
    	y += sign(check_y-y);
    }
}

function MoveAndCollide() {
    if (collide) {
        if (preciseCollisions) MoveAndCollidePrecise();
        else MoveAndCollideNotPrecise();
    } else {
        Move(xspd, yspd*YSPEED_FACTOR);
    }
    
    x = clamp(x, 0, room_width);
    y = clamp(y, 0, room_height);
}

function Speed(inst = self) {
    return point_distance(0, 0, inst.xspd, inst.yspd);
}

function Direction(inst = self) {
    return point_direction(0, 0, inst.xspd, inst.yspd);
}

function SetKnockback(_inst, _spd, _dir, _jump=5) {
    with(_inst) {
        zspd = _jump;
        SetForcePolar(_spd, _dir);
        fsm.SetState("knockback");
    }
}