
if (!array_length(surf)) surf = array_create(hNum*vNum, -1);

for(var i=0; i<hNum*vNum; i++) {
    if (!surface_exists(surf[i])) {
        surf[i] = surface_create(surfSize, surfSize);
        
        surface_set_target(surf[i]);
        draw_clear_alpha(c_black, 0);
        // draw_rectangle(1,1,surfSize-1, surfSize-1, true);
        surface_reset_target();
    }
    
    var xx = i % hNum;
    var yy = i div vNum;
    draw_surface_ext(surf[i], xx*surfSize, yy*surfSize, 1, 1, 0, c_white, .5);
}