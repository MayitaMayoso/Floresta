function GunSystem() constructor {
	owner =  other.id;
	firstGun = instance_create_layer(owner.x, owner.y, owner.layer, obj_gun);
	secondGun = instance_create_layer(owner.x, owner.y, owner.layer, obj_bazooka);
	firstGun.owner = owner;
	secondGun.owner = owner;
	
	ThrowGun = function() {
		// Throw the gun
		if (firstGun!=noone) {
		    firstGun.Throw(owner.controls.gunDirection, 3);
		    firstGun = secondGun;
		    secondGun = noone;
		}
		
		UpdateGunState();
	}

	SwapGun = function() {
		if (firstGun!=noone && secondGun!=noone) {
		    var aux = firstGun;
		    firstGun = secondGun;
		    secondGun = aux;
		}
		
		UpdateGunState();
	}

	GrabGun = function() {
		// Check if there is a close gun that is none of the ones that we have with us
		if (firstGun!=noone) firstGun.x += 10000;
		if (secondGun!=noone) secondGun.x += 10000;
		var nearest = instance_nearest(owner.x, owner.y, obj_gun);
		if (firstGun!=noone) firstGun.x -= 10000;
		if (secondGun!=noone) secondGun.x -= 10000;
		if (nearest==firstGun || nearest==secondGun) nearest = noone;
                
		// Grab Gun
		if (nearest!=noone) {
			if (point_distance(owner.x, owner.y, nearest.x, nearest.y)<owner.hitRadius*3) {
			    if (secondGun!=noone) secondGun.Throw(owner.controls.gunDirection);
			    secondGun = firstGun;
			    firstGun = nearest;
			    nearest.owner = owner;
			}
		}
		
		UpdateGunState();
	}
	
	UpdateGunState = function() {
		if (firstGun!=noone) firstGun.wielded = true;
		if (secondGun!=noone) secondGun.wielded = false;
	}
	
	Shoot = function() {	
        if (firstGun!=noone)
            firstGun.Shoot(owner.controls.gunDirection);
	}
	
	UpdateGunState();
}