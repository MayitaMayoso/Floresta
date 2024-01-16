
event_inherited();

preciseCollisions = true;

fsm = new FiniteStateMachine();

    // =========================== Common states ===========================
    fsm.CreateState("knockback", {
        sprite_index : sprite_index,
        
        FixedStepEvent : function() {
            image_index = 0;
            if (z==0 && Speed()<.1)
                fsm.SetState("idle");
        }
    });

controls = {
    xdir : 0, ydir : 0, roll : false,
    gunDirection : 0, shoot : 0,
    gunThrow : false, grab : true
}

ControlsUpdate = -1;

avoidRadius = 16;
hp = 100;
GetDamage = function(damage) {
    hp = max(0, hp-damage);
    if (hp==0) Die();
    juice = 1;
}

Die = function() {
    instance_destroy();
    repeat(50) instance_create_layer(x, y, "BelowInstances", part_slime_death);
    //Camera.Shake(3);
}

uniform_colour = shader_get_uniform(sh_plain_colour, "colour");
uniform_value = shader_get_uniform(sh_plain_colour, "value");

juice = 0;