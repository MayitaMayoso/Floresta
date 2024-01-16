
surf = [];
surfSize = 1024;
hNum = 1;
vNum = 1;

DrawObject = function(part) {
    var xIndex = part.x div surfSize;
    var yIndex = part.y div surfSize;
    var index = xIndex + yIndex * hNum;
    
    if (surface_exists(surf[index])) {
        surface_set_target(surf[index]);
        
        var xOffset = xIndex*surfSize;
        var yOffset = yIndex*surfSize;
        draw_sprite_ext(
            part.sprite_index, part.image_index,
            part.x - xOffset, part.y - yOffset,
            part.image_xscale, part.image_yscale,
            part.image_angle, part.image_blend, part.image_alpha
        );
        
        surface_reset_target();
    }
}

DrawSprite = function(_sprite, _frame, _x, _y, _scale=1, _angle=0, _alpha=1) {
    var width = sprite_get_width(_sprite)*_scale*.5;
    var height = sprite_get_height(_sprite)*_scale*.5;
    
    var pos = [ [0,0], [0,1], [1,0], [0,-1], [-1,0], [1,1], [-1,1], [1,-1], [-1,-1]];
    for(var i=0; i<array_length(pos); i++) {
        var p = pos[i];
        var xIndex = (_x + p[0]*width) div surfSize;
        var yIndex = (_y + p[1]*height) div surfSize;
        var index = xIndex + yIndex * hNum;
        
        if (surface_exists(surf[index])) {
            surface_set_target(surf[index]);
            var xx = _x - xIndex*surfSize;
            var yy = _y - yIndex*surfSize;
            draw_sprite_ext(
                _sprite, _frame,
                xx, yy,
                _scale, _scale,
                _angle, c_white, _alpha
            );
            surface_reset_target();
        }
    }
}