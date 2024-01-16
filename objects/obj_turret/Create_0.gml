
event_inherited();
gun = instance_create_layer(x, y, layer, gunType);
gun.owner = id;
gun.holdHeight = 12;
agro = 300;


ControlsUpdate = function() {
    if (instance_exists(obj_enemy)) {
        var nearest = instance_nearest(x, y, obj_enemy);
        controls.gunDirection = point_direction(x, y, nearest.x, nearest.y - gun.holdHeight);
        
        if (point_distance(x, y, nearest.x, nearest.y) < agro) controls.shoot = true;
        else controls.shoot = false;
    } else {
        controls.shoot = false;
    }
}

fsm.CreateState("idle", {
    sprite_index : sprite_index,
    
    TransitionEvent : function() {
        if (controls.shoot)
            fsm.SetState("shoot");
    }
});

fsm.CreateState("shoot", {
    sprite_index : sprite_index,
    
    TransitionEvent : function() {
        if (!controls.shoot)
            fsm.SetState("idle");
    },
    
    FixedStepEvent : function() {
        gun.Shoot(controls.gunDirection);
    }
});