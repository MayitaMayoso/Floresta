
    draw_text(10, 20, string(game_get_speed(gamespeed_fps)) + " | " + string(fps) + " | " + string(fps_real));
    draw_text(10, 40, "Instance count: " + string(instance_count));
    
    for(var i=0; i<components.Size(); i++) if components.Get(i).enabled components.Get(i).DrawGUI();