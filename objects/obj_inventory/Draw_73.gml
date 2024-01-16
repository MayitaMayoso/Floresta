var sz = Wave(.8, 1.2, 1000, 0, current_time - pressTimer);
draw_sprite_ext(spr_press_E, 0, x, y-50+Wave(-5, 10, 1000, 500, current_time - pressTimer), sz, sz, Wave(-30, 30, 2000, 500, current_time - pressTimer), c_white, pressAlpha);

if (DistanceToObject(obj_player)<50) {
	pressAlpha = lerp(pressAlpha, 1, .3);
} else {
	pressAlpha = lerp(pressAlpha, 0, .3);
}

if (pressAlpha==0) 
	pressTimer = current_time;