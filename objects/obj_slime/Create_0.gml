
event_inherited();


ControlsUpdate = function() {
    // Default direction is 0
    controls.xdir = 0;
    controls.ydir = 0;
    
    // Normalizing the movement on 1
    if (instance_exists(obj_player)) {
        var dist = point_distance(x, y, obj_player.x, obj_player.y);
        if (dist<agro&&dist>hitRadius) {
            var dir = point_direction(x, y, obj_player.x, obj_player.y);
            controls.xdir = lengthdir_x(1, dir);
            controls.ydir = lengthdir_y(1, dir);
        }
    } else {
        var dir = random(360);
        controls.xdir = lengthdir_x(1, dir);
        controls.ydir = lengthdir_y(1, dir);
    }
}

hp = 30;
wait = 0;
jump_xspd = 0;
jump_yspd = 0;
agro = 1000;
jumpForce = 1.5;
fric = .007

#region FINITE STATE MACHINE
    
    // =========================== Idle state ===========================
    fsm.CreateState("idle", {
        sprite_index : [spr_slime_move_down],
        image_speed : 0,
        
        StateBeginEvent : function() {
            wait = random_range(0, 240);
        },
        
        FixedStepEvent : function() {
            if (fsm.fixedFramesInState>=wait && z==0)
                if ( (abs(controls.xdir) || abs(controls.ydir)))
                    fsm.SetState("jump");
        }
    });

    // =========================== Jump state ===========================
    fsm.CreateState("jump", {
        sprite_index : [spr_slime_move_down],
        image_speed : 2,
    
        StateBeginEvent : function() {
            jump_xspd = controls.xdir*jumpForce;
            jump_yspd = controls.ydir*jumpForce;
        },
        
        FixedStepEvent : function() {
            if (fsm.fixedFramesInState== 60) {
                AddForce(jump_xspd, jump_yspd);
                image_xscale = .7;
                image_yscale = 1.3;
            }
            
            if (fsm.fixedFramesInState==150) {
                // repeat(20)
                //     instance_create_layer(x, y, "BelowInstances", part_slime_jump);
                SetForce(0, 0);
            }
        },
        
        StepEvent : function() {
            // Change to knockback state
            var nearest = instance_nearest(x, y, obj_player);
            if (instance_exists(nearest)) {
                if (nearest.fsm.InState("main")) {
                    var dist = point_distance(x, y, nearest.x, nearest.y);
                    if (dist<hitRadius+nearest.hitRadius) {
                        SetKnockback(nearest, jumpForce*1.2, Direction());
                        SetKnockback(id, Speed()*.5, Direction()+180, 2);
                    }
                }
            }
        },
        
        AnimationEndEvent : function() {
            fsm.SetState("idle");
        }
    });
    
    fsm.CreateState("knockback", {
        sprite_index : spr_slime_move_down,
        image_speed : 0
    });
    
    fsm.SetState("idle");
    
#endregion

repeat(20) instance_create_layer(x, y, "AboveInstances", part_slime_creation);