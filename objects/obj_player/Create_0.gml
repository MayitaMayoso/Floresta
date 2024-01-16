
// General stuff
event_inherited();

InitCamera = function() {
	Cinema.Follow(id);
	Cinema.mode = CAMERAMODE.STATIC;
	Camera.Scale(1.75);
	cameraFollow = true;
}
InitCamera();
hp = 100000;

assistant = noone//instance_create_layer(x+20, y+20, layer, obj_assistant, { owner:id });
gunSystem = new GunSystem();

#region Physics

    preciseCollisions = true;
    
    walkingSpd = 1;
    
    groundFric = fric;
    airFric = fric/2;
    
    rollingSpd = 2.5;
    rollCooldown = .1sec;
    rollingDuration = .6sec;
    
    rollTimer = 0;
    
    jumpForce = 6;
    grav = .2;

#endregion

#region Controls

    // Player controller
    playerController = ["Gamepad0", "Keyboard"];
    
    ControlsUpdate = function() {
        Input.SetConfiguration(playerController);
        controls.xdir = Input.CheckValue("Right") - Input.CheckValue("Left");
        controls.ydir = Input.CheckValue("Down") - Input.CheckValue("Up");
        
        // Normalizing the movement on 1
        var dir = point_direction(0, 0, controls.xdir, controls.ydir);
        var dist = point_distance(0, 0, controls.xdir, controls.ydir);
        if (dist!=0) {
            controls.xdir = lengthdir_x(min(dist, 1), dir);
            controls.ydir = lengthdir_y(min(dist, 1), dir);
        }
        
        controls.roll = Input.CheckPressed("Roll");
        controls.gunThrow = Input.CheckPressed("GunThrow");
        controls.grab = Input.CheckPressed("Grab");
        controls.swapGun = Input.CheckPressed("SwapGun");
        controls.shoot = Input.Check("Shoot");
        
        if (keyboard_or_gamepad) {
            var gunX = Input.CheckValue("GunRight") - Input.CheckValue("GunLeft");
            var gunY = Input.CheckValue("GunDown") - Input.CheckValue("GunUp");
            var gunDist = point_distance(0, 0, gunX, gunY);
            if (gunDist)
                controls.gunDirection = point_direction(0, 0, gunX, gunY);
        } else {
            controls.gunDirection = point_direction(x, y - gunSystem.firstGun.holdHeight, mouse_x, mouse_y);
        }
    }

#endregion

#region FINITE STATE MACHINE
    
    // ===========================-------- Basic states parent
    fsm.CreateState("main", {
        TransitionEvent : function() {
            if (!controls.shoot || gunSystem.firstGun==noone) {
                if (abs(controls.xdir) || abs(controls.ydir)) fsm.SetState("walk");
                else fsm.SetState("idle");
            } else {
                if (abs(controls.xdir) || abs(controls.ydir)) fsm.SetState("shootWalk");
                else fsm.SetState("shootIdle");
            }
            
            // Jump
            if (controls.roll && Time.frame>rollTimer && point_distance(0, 0, controls.xdir, controls.ydir))
                fsm.SetState("jump");
        },
        
        StepEvent : function() {            
            fsm.spriteDirection = abs(angle_difference(controls.gunDirection, 0)) > 90;
			
			if (controls.gunThrow) gunSystem.ThrowGun();
			if (controls.swapGun) gunSystem.SwapGun();
			if (controls.grab) gunSystem.GrabGun();
        }
    });
    
    // =========================== Idle state ===========================
    fsm.CreateState("idle", {
        parent : "main",
        sprite_index : [spr_player1_idle_right, spr_player1_idle_left]
    });

    // =========================== Walk state ===========================
    fsm.CreateState("walk",  {
        parent : "main",
        sprite_index : [spr_player1_walk_right, spr_player1_walk_left],
    
        FixedStepEvent : function() {
            ApproachForce(controls.xdir*walkingSpd, controls.ydir*walkingSpd);
        }
    });
    
    // =========================== Shooting state ===========================
    fsm.CreateState("shootIdle", {
        parent : "main",
        sprite_index : [spr_player1_idle_right, spr_player1_idle_left],
    
        TransitionEvent : function() {
            if (!controls.shoot)
                fsm.SetState("main");
        },
        
        FixedStepEvent : function() {
			gunSystem.Shoot();
			if (assistant!=noone)
				assistant.gunSystem.Shoot();
        }
    });
    
    // ========================== Shoot walk state ==========================
    fsm.CreateState("shootWalk", {
        parent : "main",
        sprite_index : [spr_player1_walk_right, spr_player1_walk_left],
        image_speed : .5,
    
        TransitionEvent : function() {
            if (!controls.shoot)
                fsm.SetState("main"); 
        },
        
        FixedStepEvent : function() {
			gunSystem.Shoot();
			if (assistant!=noone)
				assistant.gunSystem.Shoot();
            ApproachForce(controls.xdir*walkingSpd, controls.ydir*walkingSpd);
        }
    });
    
    // =========================== Roll state ===========================
    fsm.CreateState("roll", {
        sprite_index : spr_player1_placeholder,
    
        StateBeginEvent : function() {
            var rollDir = point_direction(0, 0, controls.xdir, controls.ydir);
            SetForce(lengthdir_x(rollingSpd, rollDir), lengthdir_y(rollingSpd, rollDir));
        },
        
        FixedStepEvent : function() {
            if (fsm.fixedFramesInState >= rollingDuration-1) fsm.SetState("main");
        },
        
        StateEndEvent : function() {
            rollTimer = Time.frame + rollCooldown;
        }
    });
    
    // =========================== Jump state ===========================
    fsm.CreateState("jump", {
        sprite_index : spr_player1_placeholder,
    
        StateBeginEvent : function() {
            var rollDir = point_direction(0, 0, controls.xdir, controls.ydir);
            SetForce(lengthdir_x(rollingSpd, rollDir), lengthdir_y(rollingSpd, rollDir), jumpForce);
        },
        
        FixedStepEvent : function() {
            if (fsm.fixedFramesInState == rollingDuration-1) fsm.SetState("main");
        },
        
        StateEndEvent : function() {
            rollTimer = Time.frame + rollCooldown;
        }
    });
    
    fsm.SetState("idle");
    
#endregion