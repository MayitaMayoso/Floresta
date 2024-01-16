var mw = Camera.port.width*.6*menuSize/16;
var mh = Camera.port.height*.6*menuSize/16;
var mx = Camera.port.width/2;
var my = Camera.port.height/2;

draw_sprite_ext(spr_ui_frame_centered, 0, mx, my, mw, mh, 30*(1-menuSize), c_white, menuSize);