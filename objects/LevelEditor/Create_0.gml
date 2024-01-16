
Camera.Scale(5);
Camera.Position(Camera.Scale() * Camera.view.width/2, Camera.Scale() * Camera.view.height/2);
Cinema.mode = CAMERAMODE.MOUSE_DRAG;
    
var tw = room_width div TSIZE;
var th = room_height div TSIZE;

#region Randomize floor tiles

	/*
    floorTiles = [181];
    floorExtra = [178, 179, 180];
    
    for(var i=0; i<tw*th; i++) {
        var cx = i % tw;
        var cy = i div tw;
        
        var lay_id = layer_get_id("Ground");
        var map_id = layer_tilemap_get_id(lay_id);
        
        var tile = floorTiles[irandom(array_length(floorTiles)-1)];
        var tileExtra = floorExtra[irandom(array_length(floorExtra)-1)];
        tile = (random(1)<.9)?tile:tileExtra;
        tilemap_set(map_id, tile, cx, cy);
    }*/
    
    // repeat(100)
    // PlaceSection(choose(section_rock_1, section_rock_2, section_rock_3), irandom(tw), irandom(th));
    
#endregion

#region ROADS

    #macro CHUNK_SIZE 5
    roadmap = ds_grid_create(tw / CHUNK_SIZE, th / CHUNK_SIZE);
    ds_grid_clear(roadmap, 0);
    updateRoads = false;
    
    //randWalker = [.5 * tw / CHUNK_SIZE, .5 * th / CHUNK_SIZE];
    randSteps = 100;
    
    GetCell = function(x, y) {
        var ww = ds_grid_width(roadmap);
        var hh = ds_grid_height(roadmap);
        
        if (x<0 || x>=ww || y<0 || y>=hh) return 0;
        return roadmap[# y, x];
    }
    
    GetAdjacent = function(x, y) {
        
        var r = GetCell(x+1, y);
        var t = GetCell(x, y-1);
        var l = GetCell(x-1, y);
        var b = GetCell(x, y+1);
        
        var tr = GetCell(x+1, y-1);
        var tl = GetCell(x-1, y-1);
        var bl = GetCell(x-1, y+1);
        var br = GetCell(x+1, y+1);
        
        return [r, tr, t, tl, l, bl, b, br];
    }
    
    EvaluatePosition = function(x, y) {
        
        if (GetCell(x, y)) return true;
        
        var adj = GetAdjacent(x, y);
        
        if (adj[0] && adj[1] && adj[2] ||
            adj[2] && adj[3] && adj[4] ||
            adj[4] && adj[5] && adj[6] ||
            adj[6] && adj[7] && adj[0])
            return false;
        
        return true;
    }

#endregion

WChunks = room_width div (TSIZE * CHUNK_SIZE);
HChunks = room_height div (TSIZE * CHUNK_SIZE);

alarm[0] = 1;