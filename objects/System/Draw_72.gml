
    // Clear the screen
    draw_clear_alpha(c_black, 0);
    for(var i=0; i<components.Size(); i++) if components.Get(i).enabled components.Get(i).DrawBegin();