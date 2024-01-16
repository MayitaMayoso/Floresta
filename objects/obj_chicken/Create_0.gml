
// Inherit the parent event
event_inherited();

wanderDir = 0;

fsm.CreateState("idle", {
    sprite_index : [spr_chicken_right, spr_chicken_left],
	
	StepEvent : function() {
		if (Speed()>0)
			fsm.spriteDirection = abs(angle_difference(Direction(), 0)) > 90;	
	},
	
	FixedStepEvent : function() {
		if (fsm.fixedFramesInState > 120) {
			fsm.SetState("walk");
		}
	}
});

fsm.CreateState("knockback", {
    sprite_index : [spr_chicken_right, spr_chicken_left]
});

fsm.CreateState("walk", {
    sprite_index : [spr_chicken_right, spr_chicken_left],
	
	StateBeginEvent : function() {
		wanderDir = random(360);
	},
	
	StepEvent : function() {
		fsm.spriteDirection = abs(angle_difference(wanderDir, 0)) > 90;	
	},
	
	FixedStepEvent : function() {
		MovePolar(.3, wanderDir);
		if (fsm.fixedFramesInState > 200) {
			fsm.SetState("idle");
		}
	}
});