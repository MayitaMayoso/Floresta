
if (instance_exists(obj_player) && instance_number(obj_slime)<0) {
    repeat(10) {
        var MAXITER = 10;
        var iter = 0;
        do {
            var dir = obj_player.controls.gunDirection + random_range(-45, 45);
            var dist = random_range(150, 250);
            var xx = obj_player.x + lengthdir_x(dist, dir);
            var yy = obj_player.y + lengthdir_y(dist, dir);
            iter++;
        } until (Between(xx, 0, room_width) && Between(yy, 0, room_height) || iter>=MAXITER);
        
        instance_create_layer(xx, yy, "Instances", obj_slime);
    }
}

alarm[0] = 120;