function ConsoleManager() : Component() constructor {
    
    // Private methods
    static Message = function(_content, _colour = c_white) constructor {
		
		static Process = function() {
			if (string_char_at(content, 1)=="$") {
				isCommand = true;
				content = string_delete(content, 1, 1);
				var result = live_execute_string(content);
				
				if (!result) {
					Console.LogColour(live_result, c_red);
				} else if (string_copy(content, 1, 6)=="return") {
					Console.LogColour(string(live_result), make_color_rgb(0, 204, 255));
				}
			}
			lines += string_count("\n", content);
			splitContent = StringSplit(content, "\n");
			if (isCommand) Console.commandMessages.Push(self);
		}
    	
		content = _content
		splitContent = "";
		colour = _colour;
		time = TimeString();
		date = DateString();
		lines = 1;
		isCommand = false;
		Console.messages.Push(self);
		Process();
    }
    
    static Step = function() {
		var gw, gh;
		gw = display_get_gui_width(); gh = display_get_gui_height();
		var strHeight = string_height("A") * style.textScale;
		var lineHeight = strHeight + style.textSpacing * 2;
		
		// Manage the Console
		if (Input.CheckPressed("Console", "General")) Toggle();
		pos = lerp(pos, visible, .1);
		
		// Movement
		tScroll += (mouse_wheel_up() - mouse_wheel_down());
		tScroll = clamp(tScroll, 0, max(lines-3, 0));
		scroll = lerp(scroll, tScroll, 0.4);
		
		// Text input
		if (visible) {
			var dir = keyboard_check_pressed(vk_up) - keyboard_check_pressed(vk_down);
			if (dir!=0) {
				linesRecap += dir;
				linesRecap = clamp(linesRecap, 0, commandMessages.Size());
				if ((linesRecap) == 0) {
					keyboard_string = "";
				} else {
					var msg = commandMessages.Get(commandMessages.Size()-linesRecap);
					keyboard_string = msg.content;
				}
			}
			if (keyboard_check_pressed(vk_enter) && keyboard_string!="") {
				linesRecap = 0;
				Log("$" + keyboard_string);
				keyboard_string = "";
			}
		}
		
		var spd = .9;
		cursorX = lerp(cursorX, 10 + string_width(keyboard_string) * style.textScale, spd);
		cursorY = lerp(cursorY, gh - style.textSpacing, spd);
    }
    
	static DrawGUI = function() {
		// No need to draw
		if (pos==0) exit;
		
		// Basic elements for drawing
		var gw, gh;
		gw = display_get_gui_width(); gh = display_get_gui_height();
		draw_set_halign(fa_left);
		draw_set_valign(fa_bottom);
		var strHeight = string_height("A") * style.textScale;
		var lineHeight = strHeight + style.textSpacing * 2;
		
		if (!surface_exists(canvas)) canvas = surface_create(gw, gh);
		
		if (true) {
			gpu_set_tex_filter(true);
			surface_set_target(canvas); // ------------------------------
			draw_clear_alpha(c_black, 0);
			
			// Background and text colour
			draw_set_alpha(style.bgOpacity);
			draw_set_color(style.bgColour);
			draw_rectangle(0, 0, gw, gh - lineHeight, false);
			draw_set_alpha(1);
			draw_set_color(style.textColour);
			draw_set_font(style.textFont);
			// Logged messages
			lines = 2;
			for(var i=0, n=messages.Size(); i<n; i++) {
				var msg = messages.Get(n-i-1);
				
				for(var j=0; j<msg.lines; j++)
					draw_text_ext_transformed_color(
							20 + string_width(msg.time) * style.textScale,
							gh - lineHeight*(lines+j) + lineHeight*scroll, 
							msg.splitContent[j],
							0, 1000,
							style.textScale, style.textScale, 0,
							msg.colour, msg.colour, msg.colour, msg.colour, 1
					);
				
				lines+=msg.lines;
				draw_text_ext_transformed(
						10, gh - lineHeight*(lines-1) + lineHeight*scroll,
						msg.time,
						0, 10000,
						style.textScale, style.textScale, 0
				);
			}
			
			// Background and text colour
			draw_set_alpha(style.textBoxOpacity);
			draw_set_color(style.textBoxColour);
			draw_rectangle(0, gh - lineHeight, gw, gh, false);
			draw_set_alpha(1);
			draw_set_color(style.textColour);
			draw_set_font(style.textFont);
			
			// Keyboard input
			draw_text_transformed(10, gh - style.textSpacing, keyboard_string, style.textScale, style.textScale, 0);
			var showCursor = (current_time div 1000)%2
			draw_text_transformed(cursorX, cursorY, showCursor?"|":"", style.textScale, style.textScale, 0);
		
			surface_reset_target(); // ----------------------------------
		
			gpu_set_tex_filter(false);
		}
		
		draw_set_alpha(pos);
		draw_surface(canvas, 0, -gh + gh*pos*style.height);
		
		draw_set_alpha(1);
		draw_set_color(c_white);
	}
	
	static CleanUp = function() {
		if (surface_exists(canvas)) surface_free(canvas);
	}
	
	// Public methods
	static Toggle = function() {
		visible = !visible;
		if (visible) keyboard_string = "";
	};
	
	static Log = function(str) {
		str = string(str)
		for(var i=1; i<argument_count; i++)
			str += " " + string(argument[i]);
		
		show_debug_message(str);
		
		var msg = new Message(str);
	};
	
	static LogColour = function(str, colour) {
		show_debug_message(str);
		var msg = new Message(string(str), colour);
	};

	
	// Memory
	messages = new List();
	commandMessages = new List();
	canvas = surface_create(display_get_gui_width(), display_get_gui_height());
	
	// Behaviour
	printOnBuiltInConsole = true;
	savePath = "ConsoleLogs/"+ DateString(".") + "-" + TimeString(".") + ".log";
	
	// Display variables
	visible = false;
	pos = 0;
	scroll = 0;
	tScroll = 0;
	lines = 0;
	linesRecap = 0;
	
	cursorX = -1;
	cursorY = -1;
	
	style = {
		// Sizes
		height : .45, // Percentage of screen taken by the console
		
		textFont : fnt_ubuntu,
		textColour : c_white,
		textScale : 1.5,
		textSpacing : 3,
		
		bgColour : #000044,
		bgOpacity : .9,
		
		textBoxColour : #000000,
		textBoxOpacity : 1
	};
}
