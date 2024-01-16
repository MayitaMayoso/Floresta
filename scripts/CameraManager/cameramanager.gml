#macro ZNEAR 1
#macro ZFAR 100000
#macro PPM 64

function CameraManager() : Component() constructor {
	
	// Activate the camera
	enabled = true;
	
	port = {
		// Properties
		//* // Add or remove a "/" at the begining of this line to swap the resolutions
	    width : 1920,
	    height : 1080,
	    fullscreen : true,
	    
	    /*/  
	    width : 1366,
	    height : 1024,
	    fullscreen : false,
	    //*/
	    
	    // Variables
	    aspect : 1,
	    center : false,
	    
	    // Update the canvas every step
	    Update : function() {
	    	// Calculating the aspect ratio
	        aspect = width / height;
	        
	        // Centering the canvas
	        if ( center ) {
	            window_center();
	            center = false;
	        }
	        
	        // Resizing the desktop canvas
	        if ( DESKTOP ) {
	            if ( window_get_width() != width || window_get_height() != height ) {
	                window_set_size(width, height);
	                display_set_gui_size(width, height);
	                surface_resize(application_surface, width, height);
	                //center = true;
	            }
	            
	            if (window_get_fullscreen() != fullscreen) {
	            	window_set_fullscreen(fullscreen);
	            	display_reset(8, true);
	            }
	        }
	        
	        // Resizing the browser canvas
	        if ( BROWSER ) {
	            if ( browser_width != width || browser_width != height ) {
	                width = browser_width; height = browser_height;
	                window_set_size(width, height);
	                surface_resize(application_surface, width, height);
	                //center = true;
	            }
	        }
	    }
	};
	
	view = {
		// Properties
	    x : 240,
	    y : 135,
	    z : -9999,
	    xprevious : 0,
	    yprevious : 0,
	    zprevious : 0,
	    width : 480,
	    height : 270,
	    aspect : 1,
	    scale : 1.4,
	    fov : 60,
		perspectiveEnabled : false,
		xto : 240,
		yto : 135,
		zto : 0,
		xup : 0,
		yup : -1,
		zup : 0,
		
		// Variables
		fixedWidth : 1,
		fixedHeight : 1,
		
		
	    
		// Update the view every step
		Update : function() {
			// Fix the size of the camera relative to the aspect of the port
			aspect = Camera.port.width / Camera.port.height;
			if ( aspect > 1 ) {
			    fixedWidth = width;
			    fixedHeight = width / aspect;
			} else {
			    fixedHeight = height;
			    fixedWidth = height * aspect;
			}
			
			// Generate the matrices of the camera
			var lookMat, projMat;
			if (!perspectiveEnabled) {
				var totalX = random_range(-Camera.effects.shake, Camera.effects.shake)*scale;
				var totalY = random_range(-Camera.effects.shake, Camera.effects.shake)*scale;
				var totalA = .25*random_range(-Camera.effects.shake, Camera.effects.shake)*scale;
				var angle = Camera.Angle();
				var totalUpX =dcos(angle-90+totalA);
				var totalUpY =dsin(angle-90+totalA);
				var hw = scale*width/2;
				var hh = scale*height/2;
			
				x = clamp(x,hw,room_width-hw);
				y = clamp(y,hw,room_width-hw);
				xto = clamp(xto,hw,room_width-hw);
				yto = clamp(yto,hw,room_width-hw);
				
				lookMat = matrix_build_lookat(x+totalX, y+totalY, z, xto+totalX, yto+totalY, zto, totalUpX, totalUpY, zup);
				projMat = matrix_build_projection_ortho(-width*scale, -height*scale, ZNEAR, ZFAR);
			} else {
				lookMat = matrix_build_lookat(x, y, z, xto, yto, zto, xup, yup, zup);
				projMat = matrix_build_projection_perspective_fov(-fov, aspect, ZNEAR, ZFAR);
			}
			
			var cam = view_camera[0];
			camera_set_view_mat(cam, lookMat);
			camera_set_proj_mat(cam, projMat);
			camera_apply(cam);
		}
	};
	
	effects = {
		shake : 0,
		Update : function() {
			shake = lerp(shake, 0, 0.05);
		}
	};
	
	static StepBegin = function() {
		view.xprevious = view.x;
		view.yprevious = view.y;
	}
	
	maximized = true;
	
	static Step = function() {
		// Update the display
		port.Update();
		view.Update();
	};
	
	static FixedStep = function() {
		effects.Update();
		view.scale = lerp(view.scale, scaleTarget, scalingSpd);
		
		if (move) {
			view.x = lerp(view.x, xTarget, movingSpd);
			view.y = lerp(view.y, yTarget, movingSpd);
			view.xto = lerp(view.xto, xTarget, movingSpd);
			view.yto = lerp(view.yto, yTarget, movingSpd);
			if (point_distance(view.x, view.y, xTarget, yTarget)<.001) {
				Position(xTarget, yTarget);
				move = false;
			}
		}
	}
	
	static RoomStart = function() {
		for (var i = 0; i < 8; i++) {
		    view_enabled = true;
		    view_visible[i] = (i==0);
		}
	};
	
	// Public functions for 2D Control
	static Position = function(posx, posy, posz=view.z, tox=posx, toy=posy, toz=posz+1) {

		view.x = posx;
		view.y = posy;
		view.z = posz;
		
		view.xto = tox;
		view.yto = toy;
		view.zto = toz;
	}
	
	static X = function() {return view.x};
	static Y = function() {return view.y};
	
	xTarget = view.x;
	yTarget = view.y;
	movingSpd = .05;
	move = false;
	static LerpPosition = function(posx, posy, spd = movingSpd) {
		xTarget = posx;
		yTarget = posy;
		movingSpd = spd;
		move = true;
	}
	
	static Move = function(posx=0, posy=0, posz=0, tox=posx, toy=posy, toz=posz) {
		
		view.x += posx;
		view.y += posy;
		view.z += posz;
		
		view.xto += tox;
		view.yto += toy;
		view.zto += toz;
	}
	
	static Angle = function(angle) {
		if (angle!=undefined) {
			view.xup = dcos(angle-90);
			view.yup = dsin(angle-90);
			view.zup = 0;
		}
		return point_direction(0, 0, view.xup, -view.yup) + 90;
	}
	
	static Scale = function(scale) {
		if (scale!=undefined) {
			view.scale = scale;
			scaleTarget = scale;
			if (instance_exists(Shadows))
				Shadows.surf = -1;
		}
		return view.scale;
	}
	
	scaleTarget = view.scale;
	scalingSpd = .01;
	static LerpScale = function(scale, spd=scalingSpd) {
		scaleTarget = scale;
		scalingSpd = spd;		
	}
	
	static Shake = function(shake) {
		effects.shake = shake;
	}
	
	static Maximize = function() {
		window_set_position((port.width==1280*2)?10:display_get_width(), 10);
        if (!maximized) {
            window_command_run(window_command_maximize);
            maximized = true;
        } else {
            window_command_run(window_command_restore);
            maximized = false;
        }
	    	
	}
	
	static Fullscreen = function() {
		port.fullscreen = !port.fullscreen;
		if (!port.fullscreen) Center();
	}
	
	static Center = function() {
		port.center = true;
	}
	
	static Width = function() {
		return view.width * view.scale;
	}
	
	static Height = function() {
		return view.height * view.scale;
	}
}