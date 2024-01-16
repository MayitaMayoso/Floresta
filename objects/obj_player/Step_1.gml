
event_inherited();

if (keyboard_check_pressed(ord("1"))) PlaceSection(section_example, mouse_x div TSIZE, mouse_y div TSIZE);


if (keyboard_check_pressed(ord("2")))
    instance_create_layer(mouse_x, mouse_y, layer, choose(obj_gun, obj_bazooka));


if (keyboard_check_pressed(ord("3")))
    instance_create_layer(mouse_x, mouse_y, layer, obj_turret, {gunType:obj_gun});
    
    
if (keyboard_check_pressed(ord("4")))
    instance_create_layer(mouse_x, mouse_y, layer, obj_turret, {gunType:obj_bazooka});

if (keyboard_check_pressed(ord("5")))
    repeat(10) instance_create_layer(mouse_x, mouse_y, layer, obj_slime);
	
if (keyboard_check_pressed(ord("6")))
    instance_create_layer(mouse_x, mouse_y, layer, obj_inventory);