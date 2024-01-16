  /*
#region Road placement

    // Manually edit
    var cx = mouse_x div ( TSIZE * CHUNK_SIZE );
    var cy = mouse_y div ( TSIZE * CHUNK_SIZE );
    var tw = room_width div TSIZE;
    var th = room_height div TSIZE;
    
    if (false) {
        roadmap[# cy, cx] = 1;
        updateRoads = true;
    }
    
    if (false) {
        roadmap[# cy, cx] = 0;
        updateRoads = true;
    }
    
    if (false) {
        PlaceSection(section_bushes, cx * CHUNK_SIZE, cy * CHUNK_SIZE);
    }
    
        if (false) {
        PlaceSection(section_house, cx * CHUNK_SIZE, cy * CHUNK_SIZE-1);
    }
    
    // Random walk
    if (false) {
        ds_grid_clear(roadmap, 0);
        
        var pos = [.5 * WChunks, .5 * HChunks];
        
        repeat(randSteps) {
            roadmap[# pos[1], pos[0]] = 1;
            
            var moves = [];
            if (EvaluatePosition(x+1, y)) array_push(moves, [1, 0]);
            if (EvaluatePosition(x-1, y)) array_push(moves, [-1, 0]);
            if (EvaluatePosition(x, y+1)) array_push(moves, [0, 1]);
            if (EvaluatePosition(x, y-1)) array_push(moves, [0, -1]);
            
            // Pick a random move
            var l = array_length(moves);
            var m = (l>0)?moves[irandom(l-1)]:[0,1];
            pos[0] += m[0];
            pos[1] += m[1];
            
            if (pos[0]<0 || pos[0]>=16 || pos[1]<0 || pos[1]>=16)
                pos = [.5 * WChunks, .5 * HChunks];
        }
        
        for(var c=0; c<=1000; c++) {
            // Place sections
            for(var j=1; j<HChunks-1; j++) {
                for(var i=1; i<WChunks-1; i++) {
                    if (random(1)>.95) {
                        var b = roadmap[# j+1, i];
                        var t = roadmap[# j-1, i];
                        var r = roadmap[# j, i+1];
                        var l = roadmap[# j, i-1];
                        
                        var br = roadmap[# j+1, i+1];
                        var bl = roadmap[# j+1, i-1];
                        var tr = roadmap[# j-1, i+1];
                        var tl = roadmap[# j-1, i-1];
                        
                        if (t && tr && r ||
                            t && tl && l ||
                            b && bl && l ||
                            b && br && r ||
                            !r && !t && !l && !b)
                            roadmap[# j, i] = 0;
                            
                        if (r + t + l + b == 3 && br + bl + tr + tl == 0)
                            roadmap[# j, i] = 1;
                    }
                }
            }
        }
        
        updateRoads = true;
    }
    
    // Update the roads
    if (updateRoads) {
        updateRoads = false;
            
        // Place sections
        for(var j=0; j<HChunks; j++) {
            for(var i=0; i<WChunks; i++) {
                if (roadmap[# j, i]==1) {
                    var right = (i<WChunks-1)?roadmap[# j, i+1]:0;
                    var top = (j>0)?roadmap[# j-1, i]:0;
                    var left = (i>0)?roadmap[# j, i-1]:0;
                    var bottom = (j<HChunks-1)?roadmap[# j+1, i]:0;
                    
                    var code = right + 2 * top + 4 * left + 8 * bottom;
                    var section = asset_get_index("section_road_" + string(code));
                    
                    PlaceSection(section, i * CHUNK_SIZE, j * CHUNK_SIZE);
                } else {
                    PlaceSection(section_road_empty, i * CHUNK_SIZE, j * CHUNK_SIZE);
                }
            }
        }
    }

#endregion

*/