
// Inherit the parent event
event_inherited();
controls = owner.controls;
controls.gunDirection = point_direction(x, y, mouse_x, mouse_y);
fsm.spriteDirection = (controls.gunDirection>90 && controls.gunDirection<270)?1:0;


if (controls.gunThrow) gunSystem.gunSystem.GunThrow();
if (controls.swapGun) gunSystem.SwapGun();
if (controls.grab) gunSystem.GrabGun();