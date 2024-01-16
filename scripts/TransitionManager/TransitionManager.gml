function TransitionManager() : Component() constructor {
	
	enum TRANSITION_TYPE {
		NONE,
		FADE,
		BARS,
		_ENUMSIZE
	}
	
	curve = animcurve_get_channel(curve_all, "FastToSlow");
	
	static Create = function() {
	    Init();
	}
	
	static Init = function() {
		// General variables
		targetRoom = noone;
		transitionType = TRANSITION_TYPE.NONE;
		timer = -1;
		onTransition = false;
		
		waitTime = 500;
		
 		// Fade variables
		fadeValue = 0;
		fadeTarget = 1;
		fadeDuration = 500;
		
		// Bars variables
		barsValue = 0;
		barsTarget = 1;
		barsDuration = 1000;
	}
	
	static GoTo = function(_room, _type=choose(TRANSITION_TYPE.FADE, TRANSITION_TYPE.BARS)) {
		if (!onTransition) {
			targetRoom = _room;
			transitionType = _type;
			onTransition = true;
		}
	}
	
	static RoomGoTo = function() {
		room_goto(targetRoom);
	}
	
	static DrawGUI = function() {
		if (!onTransition) exit;
		
		switch(transitionType) {
			case TRANSITION_TYPE.NONE:
				DrawNone();
				break;
			case TRANSITION_TYPE.FADE:
				DrawFade();
				break;
			case TRANSITION_TYPE.BARS:
				DrawBars();
				break;
		}
	}
	
	static DrawNone = function() {
		RoomGoTo();
		Init();
	}
	
	static DrawFade = function() {
		
		if (fadeValue==0 && fadeTarget==0)
			Init();
		
		if (fadeValue==1) {
			if (timer==-1) {
				timer = current_time + waitTime;
			} else {
				if (current_time>timer) {
					RoomGoTo();
					fadeTarget = 0;
				}
			}
		}
		
		// Draw the fade
		var c = /*#*/0x000000
		draw_set_alpha(fadeValue);
		draw_rectangle_color(0, 0, display_get_gui_width(), display_get_gui_height(), c, c, c, c, false);
		draw_set_alpha(1);
		
		// Update the fade
		fadeValue = Approach(fadeValue, fadeTarget, 1 / (60*fadeDuration/2000) );
	}
	
	static DrawBars = function() {
		if (barsValue==0 && barsTarget==0)
			Init();
		
		if (barsValue==1) {
			if (timer==-1) {
				timer = current_time + waitTime;
			} else {
				if (current_time>timer) {
					RoomGoTo();
					barsTarget = 0;
				}
			}
		}
		
		// Update the bars
		barsValue = Approach(barsValue, barsTarget, 1 / (60*barsDuration/2000));
		
		// Draw the bars
		var c = /*#*/0x000000
		var gw = display_get_gui_width();
		var gh = display_get_gui_height();
		var perc = animcurve_channel_evaluate(curve, barsValue);
		draw_rectangle_color(0, 0, gw, gh*perc/2, c, c, c, c, false);
		draw_rectangle_color(0, gh - gh*perc/2, gw, gh, c, c, c, c, false);
	}
	
	Init();
	
}
	