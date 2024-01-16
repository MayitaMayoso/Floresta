#macro TSIZE 32

function PlaceSection(section, cell_x, cell_y) {
    layer_set_target_room(section);
    map = new MapSection(section);
    map.Record();
    layer_reset_target_room();
    map.Place(cell_x, cell_y);
}

function MapSection(_room) constructor {
    sectionRoom = _room;
    name = room_get_name(sectionRoom);
    
    layers = new List();
    
    static Record = function() {
        layer_set_target_room(sectionRoom);
        
        var lays = layer_get_all();
        for(var i=0; i<array_length(lays); i++) {
            
            var name = layer_get_name(lays[i]);
            if (name=="System") continue;
            
            var type = layer_get_element_type(layer_get_all_elements(lays[i])[0]);
            layers.Push(new MapSectionLayer(name, type));
            layers.Tail().Record();
        }
    }
    
    static Place = function(cell_x, cell_y) {
        for(var i=0; i<layers.Size(); i++)
            layers.Get(i).Place(cell_x, cell_y);
    }
    
    static toString = function() {
        var str = "========================\n";
        str += name + "\n";
        
        for(var i=0; i<layers.Size(); i++)
            str += string(layers.Get(i));
        
        return str;
    }
}

function MapSectionLayer(_name, _type) constructor {
    name = _name;
    type = _type;
    
    // Tile data
    tileset = -1;
    tilemap = -1;
    map = -1;
    
    // Instances data
    instances = -1;
    
    static Record = function() {
        if (type==layerelementtype_tilemap) {
            RecordTileMap();
        } else {
            RecordInstances();
        }
    }
    
    static Place = function(cell_x, cell_y) {
        if (type==layerelementtype_tilemap) {
            PlaceTileMap(cell_x, cell_y);
        } else {
            PlaceInstances(cell_x, cell_y);
        }
    }
    
    static RecordTileMap = function() {
        var lay_id = layer_get_id(name);
        var map_id = layer_tilemap_get_id(lay_id);
        
        tileset = tilemap_get_tileset(map_id);
        
        var ww = tilemap_get_width(map_id);
        var hh = tilemap_get_height(map_id);
        
        tilemap = array_create(hh);
        
        for(var j=0; j<hh; j++) {
            tilemap[j] = array_create(ww);
            for(var i=0; i<ww; i++) {
                var tile_id = tilemap_get(map_id, i, j);
                tilemap[j][i] = tile_id;
            }
        }
    }
    
    static RecordInstances = function() {
        // =================================
    }
    
    static PlaceTileMap = function(cell_x, cell_y) {
        if (!layer_exists(name)) return;
        
        var lay_id = layer_get_id(name);
        var map_id = layer_tilemap_get_id(lay_id);
        
        for(var j=0; j<array_length(tilemap); j++) {
            for(var i=0; i<array_length(tilemap[j]); i++) {
                if (tilemap[j][i]!=0)
                    tilemap_set(map_id, tilemap[j][i], cell_x + i, cell_y + j);
            }
        }
    }
    
    static PlaceInstances = function(cell_x, cell_y) {
        // =================================
    }
    
    static toString = function() {
        return "    " + name + " - type: " + (type==layerelementtype_tilemap?"tiles":"instances") + "\n";
    }
}

