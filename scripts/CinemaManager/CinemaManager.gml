enum CAMERAMODE {
	STATIC,
	FREE,
	OBJECT_FOLLOWING,
	MOUSE_BORDERS,
	MOUSE_DRAG,
	FIRST_PERSON_3D,
	REEL_FOLLOWING_3D,
	_ENUMSIZE
}

global.cmodenames = ["FREE","OBJECT_FOLLOWING","MOUSE_BORDERS","MOUSE_DRAG","FIRST_PERSON_3D","REEL_FOLLOWING_3D"];
#macro CAMERAMODENAMES global.cmodenames

function CinemaManager() : Component() constructor {
	
	mode = CAMERAMODE.FREE;
	prevMode = CAMERAMODE.FREE;
		
	// First Person Mode
	look_dir = 180;
	look_pitch = 0;
	maxSpd = 10;
	acceleration = 0.1;
	mouseSensitivity = 0.08;
	sideSpd = 0;
	frontalSpd = 0;
	verticalSpd = 0;
	
	// Reel mode
	currentReel = 0;
	reelTrans = new List();
	curve = animcurve_get_channel(curve_all, "FastToSlow");
	curvePos = 0;
	curveSpd = 120;
	
	// Following character mode
	followingInstance = -1;
	followingAcceleration = .1;
	
	// Mouse borders
	hspd = 0;
	vspd = 0;
	mouseMaxspeed = 2.5;
	mouse_borders_size = .05;
	
	// Mouse drag
	drag_mx = 0;
	drag_my = 0;
	drag_cx = 0;
	drag_cy = 0;
	target_scale = Camera.Scale();
	ratiox = 0;
	prev_mx = 0;
	ratioy = 0;
	prev_my = 0;
	disp_x = 0;
	disp_y = 0;

	static Create = function() {
		//LoadOBJ("world");
		// sky = LoadOBJ("skybox");
		// sky.meshes.Get(0).material.ShadingFunc = function() { shader_set(sh_Unshaded3DModel); };
	}
    
    static Step = function() {
    	
    	// Testing the change from perspective to orthographic projection
    	if (keyboard_check_pressed(vk_f11))
    		Camera.view.perspectiveEnabled = !Camera.view.perspectiveEnabled;
    	
    	// Camera mode step event
    	switch (Camera.view.perspectiveEnabled?CAMERAMODE.FIRST_PERSON_3D:mode) {
    		case CAMERAMODE.FREE:					ControlFree(); break;
    		case CAMERAMODE.OBJECT_FOLLOWING:		ControlObjectFollowing(); break;
    		case CAMERAMODE.MOUSE_BORDERS:			ControlMouseBorders(); break;
    		case CAMERAMODE.MOUSE_DRAG:				ControlMouseDrag(); break;
    		case CAMERAMODE.FIRST_PERSON_3D:		ControlFirstPerson3D(); break;
    		case CAMERAMODE.REEL_FOLLOWING_3D:		ControlReelFollowing3D(); break;
    	}
    	
    	prevMode = mode;
        
		// Move the skybox to our position
		// sky.transform = matrix_build(Camera.view.x, Camera.view.y, Camera.view.z, 0, 0, 0, 100, 100, 100);
		
		// if (mouse_check_button_pressed(mb_left)) instance_create_depth(Camera.view.x, Camera.view.y, Camera.view.z, obj_player);
    }
    
    // 2D Control
    static ControlFree = function() {
		Input.SetConfiguration("Camera");
		var hdir = Input.Check("Right") - Input.Check("Left");
		var vdir = Input.Check("Down") - Input.Check("Up");
		var rdir = Input.Check("Aboce") - Input.Check("Below");
		
		sideSpd = lerp(sideSpd, hdir*maxSpd, acceleration);
		verticalSpd = lerp(verticalSpd, vdir*maxSpd, acceleration);
		frontalSpd = lerp(frontalSpd, rdir*maxSpd, acceleration);
		
		var angle = Camera.Angle();
		
		Camera.view.x += sideSpd*dcos(angle) + verticalSpd*dsin(angle);
		Camera.view.y += verticalSpd*dcos(angle) + sideSpd*dsin(angle);
		
		Camera.view.xto = Camera.view.x;
		Camera.view.yto = Camera.view.y;
		
		if (abs(frontalSpd))
			Camera.Angle(angle + frontalSpd);
    }
    
    static ControlObjectFollowing = function() {
    	if (followingInstance==-1) exit;
    	
    	Camera.Position(
    		lerp(Camera.view.x, followingInstance.x, followingAcceleration),
    		lerp(Camera.view.y, followingInstance.y, followingAcceleration)
    	);
    }
    
    static ControlMouseBorders = function() {
    	// Check if the mouse is on the screen borders.
		var mx = window_mouse_get_x();
		var my = window_mouse_get_y();
		var ww = window_get_width();
		var wh = window_get_height();
		var cond =	( mx < ww*mouse_borders_size ) ||
					( mx >  ww-ww*mouse_borders_size) ||
					( my < wh*mouse_borders_size ) ||
					( my > wh-wh*mouse_borders_size );
		
		var xspd = 0;
		var yspd = 0;
		
		if (cond) {
			// If so, get the direction from the center of the camera to the mouse.
			var moveDir = point_direction(ww/2, wh/2, mx, my) - Camera.Angle();
			
			// Then get X and Y component of that direction with the length of the speed.
			xspd = lengthdir_x(mouseMaxspeed*Camera.view.scale, moveDir);
			yspd = lengthdir_y(mouseMaxspeed*Camera.view.scale, moveDir);
		}
		
		// Apply that amount of speed in a smooth way.
		hspd = Approach(hspd, xspd, 0.1);
		vspd = Approach(vspd, yspd, 0.1);
		
		// Move the camera
		Camera.Position(Camera.view.x + hspd, Camera.view.y + vspd);
    }
    
    static ControlMouseDrag = function() {
    	
    	if (mode!=prevMode) {
			disp_x = Camera.view.x;
			disp_y = Camera.view.y;
			target_scale = Camera.Scale();
    	}
    	
    	// Get some coordinates
    	var angle = Camera.Angle();
		var wincenterx = window_get_width()/2;
		var wincentery = window_get_height()/2;
		var mx_input = (window_mouse_get_x()-wincenterx)*dcos(angle) -(window_mouse_get_y()-wincentery)*dsin(angle) +wincenterx;
		var my_input = (window_mouse_get_x()-wincenterx)*dsin(angle) +(window_mouse_get_y()-wincentery)*dcos(angle) +wincentery;
		var w2v = Camera.view.width/window_get_width()*Camera.view.scale;
		
		// If we check the moving button pressed save the mouse position and the camera one
		var drag_mouse_button = mb_middle;
		var drag_keyboard_button = vk_alt;
		
		if (mouse_check_button_pressed(drag_mouse_button) || keyboard_check_pressed(drag_keyboard_button)) {
			drag_mx = mx_input;
			drag_my = my_input;
			drag_cx = Camera.view.x;
			drag_cy = Camera.view.y;
			hspd = 0;
			vspd = 0;
			disp_x = Camera.view.x;
			disp_y = Camera.view.y;
		}
		
		// Calculate the new camera position relative to the difference vs the saved variables
		if (mouse_check_button(drag_mouse_button) || keyboard_check(drag_keyboard_button)) {
			Camera.Position(drag_cx - (mx_input-drag_mx)*w2v, drag_cy - (my_input-drag_my)*w2v);
			
			// Calculate the inertia
			hspd = (Camera.view.x-Camera.view.xprevious);
			vspd = (Camera.view.y-Camera.view.yprevious);
		
			Camera.Scale( lerp(Camera.Scale(), target_scale, .1) );
		} else {
			if (mouse_check_button_released(drag_mouse_button) || keyboard_check_released(drag_keyboard_button)) {
				disp_x = Camera.view.x - disp_x;
				disp_y = Camera.view.y - disp_y;
			}
			
			// Lerp the inertia to 0
			var inertiaAcc = 0.2;
			hspd = lerp(hspd, 0, inertiaAcc);
			vspd = lerp(vspd, 0, inertiaAcc);
			
			// Move the camera
			Camera.Position(Camera.view.x + hspd, Camera.view.y + vspd);
		
			ZoomRelative2Mouse();
		}
    }
    
    // 3D Control
    static ControlFirstPerson3D = function() {
    	
		if (Console.visible) {
			window_set_cursor(cr_arrow);
			return 0;
		}
		
		Camera.Angle(0);
		
		// Control the camera
		var mouseLookDirSpd = -(window_mouse_get_x() - window_get_width() / 2) * mouseSensitivity;
		var mouseLookPitchSpd = (window_mouse_get_y() - window_get_height() / 2) * mouseSensitivity;
		window_mouse_set(window_get_width() / 2, window_get_height() / 2);
		window_set_cursor(cr_none);
	
		look_dir += mouseLookDirSpd;
		look_pitch += mouseLookPitchSpd;
	
		look_dir = look_dir - floor( look_dir / 360 ) * 360;
		look_pitch = clamp(look_pitch, -89, 89);
	
		Input.SetConfiguration("CAMERA");
		var sideDir = Input.Check("RIGHT") - Input.Check("LEFT");
		var frontalDir = Input.Check("UP") - Input.Check("DOWN");
		var verticalDir = Input.Check("ABOVE") - Input.Check("BELOW");
	
		sideSpd = lerp(sideSpd, sideDir* maxSpd, acceleration);
		frontalSpd = lerp(frontalSpd, frontalDir* maxSpd, acceleration);
		verticalSpd = lerp(verticalSpd, verticalDir* maxSpd, acceleration);
	
		Camera.view.x += frontalSpd*dcos(look_dir) + sideSpd*dcos(look_dir-90);
		Camera.view.z += frontalSpd*dsin(look_dir) + sideSpd*dsin(look_dir-90);
		Camera.view.y += verticalSpd;
		
		Camera.view.xto = Camera.view.x + dcos(look_dir)*dcos(look_pitch);
		Camera.view.yto = Camera.view.y + dsin(look_pitch);
		Camera.view.zto = Camera.view.z + dsin(look_dir)*dcos(look_pitch);
		
		// Save the reel positions
		if (keyboard_check_pressed(ord("R"))) {
			reelTrans.Push( 
				[Camera.view.x, Camera.view.y, Camera.view.z,
				Camera.view.xto, Camera.view.yto, Camera.view.zto]
			);
		}
    }
    
    static ControlReelFollowing3D = function() {
    	var n = reelTrans.Size();
    	
    	if (n>1) {
	    	var posA = reelTrans.Get(currentReel);
	    	var posB = reelTrans.Get( (currentReel+1) % n );
	    	var per = animcurve_channel_evaluate(curve, curvePos);
	    	var invPer = 1 - per;
	    	curvePos += 1 / curveSpd;
	    	
	    	Camera.view.x = posA[0] * invPer + posB[0] * per;
			Camera.view.y = posA[1] * invPer + posB[1] * per;
			Camera.view.z = posA[2] * invPer + posB[2] * per;
			Camera.view.xto = posA[3] * invPer + posB[3] * per;
			Camera.view.yto = posA[4] * invPer + posB[4] * per;
			Camera.view.zto = posA[5] * invPer + posB[5] * per;
	    	
	    	if (curvePos>=1) {
	    		curvePos = 0;
	    		currentReel = (currentReel+1) % n;
	    	}
    	}
    }
    
    static ZoomRelative2Mouse = function() {
		// Scale the camera
		var scaleDir = mouse_wheel_down() - mouse_wheel_up();
		
		if (scaleDir!=0) {
			var zoomDiff = 0.1
			target_scale *= 1 + ((scaleDir)?(zoomDiff):(-zoomDiff));
			
			ratiox = (mouse_x - Camera.view.x) / (Camera.view.width * Camera.Scale());
			ratioy = (mouse_y - Camera.view.y) / (Camera.view.height * Camera.Scale());
			prev_mx = mouse_x;
			prev_my = mouse_y;
		}
		
		Camera.Scale( lerp(Camera.Scale(), target_scale, .1) );
		
		prev_mx += disp_x;
		prev_my += disp_y;
		disp_x = 0;
		disp_y = 0;
		
		if (abs(Camera.Scale() - target_scale) != 0) {
			Camera.Position(
				prev_mx - ratiox * Camera.view.width * Camera.Scale(),
				prev_my - ratioy * Camera.view.height * Camera.Scale()
			);
		}
			
		
		prev_mx += hspd;
		prev_my += vspd;
    }
    
    // Utilities
    static Follow = function(inst) {
    	followingInstance = inst;
    }
}






