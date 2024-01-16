// Inherit the parent event
event_inherited();

if (DistanceToObject(obj_player)<70) {
	if (Input.CheckPressed("Action", "Keyboard")) {
		opened = !opened;
		
		obj_player.cameraFollow = !opened;
	}
} else {
	opened = false;
}