function DepthSortingManager() : Component() constructor {
    instances = new List();
    
    static RoomStart = function() {
        var layers = layer_get_all();
        for (var i=0; i<array_length(layers); i++) {
            var lay = layers[i];
            if (string_pos("Instances", layer_get_name(lay))) {
                instance_create_layer(0, 0, lay, DepthSortingAgent);
            }
        }
    }
    
    static DrawPre = function() {
        for(var i=0; i<instances.Size(); i++)
            if (!instance_exists(instances.Get(i)))
                instances.Remove(i--);
        
        instances.Sort(function(_a, _b) {
            return _a.y - _b.y;
        });
    }
    
    static DrawBeginCallback = function(_layer) {
        for(var i=0; i<instances.Size(); i++) {
            if (!instance_exists(instances.Get(i))) {
                instances.Remove(i--);
                continue;
            }
            if (instances.Get(i).layer == _layer)
                with(instances.Get(i))
                    event_perform(ev_draw, ev_draw_begin);
        }
    }
    
    static DrawCallback = function(_layer) {
        for(var i=0; i<instances.Size(); i++) {
            if (!instance_exists(instances.Get(i))) {
                instances.Remove(i--);
                continue;
            }
            if (instances.Get(i).layer == _layer)
	            with(instances.Get(i))
	                event_perform(ev_draw, 0);
        }
    }
    
    static DrawEndCallback = function(_layer) {
        for(var i=0; i<instances.Size(); i++) {
            if (!instance_exists(instances.Get(i))) {
                instances.Remove(i--);
                continue;
            }
            if (instances.Get(i).layer == _layer)
                with(instances.Get(i))
                    event_perform(ev_draw, ev_draw_end);
        }
    }
	
	static DrawGUICallback = function(_layer) {
        for(var i=0; i<instances.Size(); i++) {
            if (!instance_exists(instances.Get(i))) {
                instances.Remove(i--);
                continue;
            }
            if (instances.Get(i).layer == _layer)
                with(instances.Get(i))
                    event_perform(ev_draw, ev_gui);
        }
    }
    
    static Register = function(instID) {
        instances.Push(instID);
        instID.visible = false;
    }
    
    static Unregister = function(instID) {
        instances.RemoveValues(instID);
        instID.visible = true;
    }
}