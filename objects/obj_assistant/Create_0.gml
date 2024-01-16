event_inherited();

grav = 0;
z = 50;
minDistToPlayer = 30;
maxDistToPlayer = 100;

orbitRadius = 100;
orbitAngle = 0;

collide = false;

shadowScale = .5;

// Gun management
gunSystem = new GunSystem(id);


fsm.CreateState("main", {
    sprite_index : [spr_assistant_right, spr_assistant_left],
    image_speed : 0	
});

fsm.CreateState("orbit", {
    sprite_index : [spr_assistant_right, spr_assistant_left],
    image_speed : 0,
	
	FixedStepEvent : function() {
		var dist2Player = DistanceToObject(owner);
		orbitAngle += .1;

		var xoff = lengthdir_x(orbitRadius, orbitAngle);
		var yoff = lengthdir_y(orbitRadius, orbitAngle);
		var xpos = owner.x + xoff;
		var ypos = owner.y + yoff;
	
		var ac = .05;
		SetForce((xpos - x)*ac, (ypos - y)*ac);
	}
});

fsm.SetState("orbit");

