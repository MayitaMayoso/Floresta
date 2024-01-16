global.selectedMenu = undefined;

function MenuInstance(_label="", _Action = function() {} ) constructor {
    label = _label;
    Action = method(undefined, _Action);
    
    children  = new List();
    parent = -1;
    option = 0;
    
    // Display options
    static vspace = 20;
    anim = 0;
    
    // Public functions
    static Update = function() {
        // Navigate through menu
        if (global.selectedMenu==self) {
    		Input.SetConfiguration("MENU");
    		var dir = Input.CheckRepeatedLong("DOWN") - Input.CheckRepeatedLong("UP") + Input.CheckPressed("DOWN") - Input.CheckPressed("UP");
            option = Wrap(option+dir, 0, children.Size());
        }
        
        if (parent) {
            // This is for animation thingys
            var imSelected = global.selectedMenu==parent && parent.children.Index(self)==parent.option;
            anim = lerp(anim, imSelected, .3);
            
            // Do the defined action on select
            if (Input.CheckPressed("SELECT", "MENU") && imSelected)
                Action();
        }
        
        // Update children
        for(var i=0; i<children.Size(); i++) {
            children.Get(i).Update();
        }
    };
    
    static Draw = function(x, y) {
        // Draw setting up
        draw_set_font(fnt_ubuntu);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        var total_h = 0;
        
        // Draw self
        
        if (label!="") {
            total_h += string_height(label) + vspace;
            
            var bor = 2;
            var sh = string_height(label)*.05;
            draw_set_color(/*#*/0x999900);
            draw_set_alpha(anim*.5);
            draw_rectangle(x - bor + anim*10, y - sh - 10, x + string_width(label) + bor + anim*10, y + sh + 10, false);
            draw_set_color(c_white);
            draw_set_alpha(1);
            
            draw_text(x + anim*10, y, label);
            
                
            // Mouse selection
            if (global.selectedMenu==parent) {
                var mx = Between(mouse_x, x - bor + anim*10, x + string_width(label) + bor + anim*10);
                var my = Between(mouse_y, y - sh*2 - 10, y + sh*2 + 10);
                
                if (mx && my && (point_distance(mouse_x, mouse_y, mouse_x_previous, mouse_y_previous)||mouse_check_button_pressed(mb_left))) {
                    parent.option = parent.children.Index(self);
                
                    if (mouse_check_button_pressed(mb_left)) Action();
                }
            }
        }
        
        // Draw children
        for(var i=0; i<children.Size(); i++) {
            var off = (label!="")*100;
            total_h += children.Get(i).Draw(x + off, y + total_h);
        }
        
        return total_h;
    };
    
    static AddChild = function(child) {
        children.Push(child);
        child.parent = self;
    }
};

function MenuGrid(_x, _y) constructor {
    x = _x;
    y = _y;
    children = new List();
    maxW = 0;
    maxH = 0
	
	static FindCoords = function(label) {		
        for(var i=0; i<children.Size(); i++) {
			var child = children.Get(i);
            if (child.label == label)
				return [child.i, child.j];
        }
	}
    
    static AddInstance = function(i, j, label, sprite) {
        children.Push(new MenuGridInstance(i, j, label, sprite))
    }
    
    static Draw = function() {
        // Center the children
        var ww = sprite_get_width(children.Head().sprite);
        var hh = sprite_get_height(children.Head().sprite);
        
        // Draw children
        for(var i=0; i<children.Size(); i++) {
            children.Get(i).Draw(x - (maxW+1)*ww/2, y - (maxH+1)*hh/2);
        }
    }
    
    static Init = function() {
        maxW = 0;
        maxH = 0;
        for(var i=0; i<children.Size(); i++) {
            if (children.Get(i).i>maxW) maxW = children.Get(i).i;
            if (children.Get(i).j>maxH) maxH = children.Get(i).j;
        }
    }
    
    static GetX = function(i) {
        var ww = sprite_get_width(children.Head().sprite);
        return x - (maxW+1)*ww/2 + i*ww;
    };
    
    static GetY = function(j) {
        var hh = sprite_get_width(children.Head().sprite);
        return y - (maxH+1)*hh/2 + j*hh;
    };
    
    static FixCoords = function(i, j, hdir, vdir) {
        var maxrow = 0;
        var maxcol = 0;
        var minrow = 999;
        var mincol = 999;
        
        for(var n=0; n<children.Size(); n++) {
            var c = children.Get(n);
            if (c.j==j && c.i>maxcol) maxcol = c.i;
            if (c.i==i && c.j>maxrow) maxrow = c.j;
            if (c.j==j && c.i<mincol) mincol = c.i;
            if (c.i==i && c.j<minrow) minrow = c.j;
        }
        
        return [Wrap(i+hdir, mincol, maxcol+1), Wrap(j+vdir, minrow, maxrow+1)];
    };
    
    static GetInst = function(i, j) {
        for(var n=0; n<children.Size(); n++) {
            var c = children.Get(n);
            if (c.j==j && c.i==i) return c;
        }
    }
    
    static DrawSelector = function(i, j, color = c_blue) {
        var ww = sprite_get_width(children.Head().sprite);
        var hh = sprite_get_height(children.Head().sprite);
        //draw_set_alpha(.3);
		draw_sprite_stretched(spr_menu_selector, 0, GetX(i), GetY(j), ww, hh)
        //draw_rectangle_color(GetX(i), GetY(j), GetX(i)+ww-2, GetY(j)+ww-2, color, color, color, color, false);
        //draw_set_alpha(1);
    }
}

function MenuGridInstance(_i, _j, _label, _sprite) constructor {
    i = _i;
    j = _j;
    label = _label;
    sprite = _sprite;
    
    static Draw = function(x, y) {
        var ww = sprite_get_width(sprite);
        var hh = sprite_get_height(sprite);
        draw_sprite(sprite, 0, x + ww * i, y + hh * j)
    };
}
