function tile_meeting(_x, _y, _layer="Colliders") {
    var tid = layer_tilemap_get_id(_layer);
        
    var xoff = _x - x;
    var yoff = _y - y;
    
    var _x1 = tilemap_get_cell_x_at_pixel(tid, bbox_left + xoff    , _y                    );
    var _y1 = tilemap_get_cell_y_at_pixel(tid, _x                  , bbox_top + yoff       );
    var _x2 = tilemap_get_cell_x_at_pixel(tid, bbox_right + xoff   , _y                    );
    var _y2 = tilemap_get_cell_y_at_pixel(tid, _x                  , bbox_bottom + yoff    );
    
    for(var _xx = _x1; _xx <= _x2; _xx++){
        for(var _yy = _y1; _yy <= _y2; _yy++){
            if(tile_get_index(tilemap_get(tid, _xx, _yy))){
                return true;
            }
        }
    }
    
    return false;
}

function tile_meeting_precise(_x, _y, _layer="Colliders") {
    var _angle = image_angle;
    image_angle = 0;
    var tid = layer_tilemap_get_id(_layer);
    if(!instance_exists(obj_precise_tile_checker)) instance_create_depth(0,0,0,obj_precise_tile_checker);
    var xoff = _x - x;
    var yoff = _y - y;
    
    var _x1 = tilemap_get_cell_x_at_pixel(tid, bbox_left + xoff    , _y                    );
    var _y1 = tilemap_get_cell_y_at_pixel(tid, _x                  , bbox_top + yoff       );
    var _x2 = tilemap_get_cell_x_at_pixel(tid, bbox_right + xoff   , _y                    );
    var _y2 = tilemap_get_cell_y_at_pixel(tid, _x                  , bbox_bottom + yoff    );

    for(var _xx = _x1; _xx <= _x2; _xx++){
        for(var _yy = _y1; _yy <= _y2; _yy++){
            var _tile = tile_get_index(tilemap_get(tid, _xx, _yy));
            if(_tile == 1) return true;

            obj_precise_tile_checker.x = _xx * tilemap_get_tile_width(tid);
            obj_precise_tile_checker.y = _yy * tilemap_get_tile_height(tid);
            obj_precise_tile_checker.image_index = _tile;
            
            if(place_meeting(_x, _y, obj_precise_tile_checker)) {
                image_angle = _angle;
                return true;
            }
        }
    }
    image_angle = _angle;
    return false;
}