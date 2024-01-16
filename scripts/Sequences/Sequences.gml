function sequence_get_track(sequence, trackName, subtrack=-1) {
	var seq = sequence;
	for(var i=0; i<array_length(seq.tracks); i++) {
		var t = seq.tracks[i];
	    if (t.name == trackName) {
	    	if (subtrack==-1) {
	    		t.length = seq.length;
	    		return t;
	    	} else {
	    		for(var j=0; j<array_length(t.tracks); j++) {
	    			var tt = t.tracks[j];
	    			if (tt.name==subtrack) {
	    				tt.length = seq.length;
	    				return tt;
	    			}
	    		}
	    	}
	    }
	}
}

function track_get_value(track, frame=0, channel=0) {
	// -------------- GET THE FRAMES WE WANT --------------------------------
	
	// How many frames do we have in this track
	var keyNum = array_length(track.keyframes);
	
	// By default we return the last frame
	var frames = track.keyframes[keyNum-1];
	
	// Maybe interpolate between two frames
	for(var i=0; i<keyNum; i++) {
		var key = track.keyframes[i];
		
		// The frame is the same so we dont interpolate
		if (key.frame==frame) {
			frames = key;
			break;
		} else if (frame<key.frame) {
			if (i==0) {
				frames = key;
				break;
			} else {
				// We will need to values to be interpolated
				var keyB = track.keyframes[i-1];
				frames = [keyB, key];
				break;
			}
		}
	}

	// -------------- INTERPOLATE THE VALUE BETWEEN FRAMES -------------
	if (!is_array(frames)) {
		if (frames.channels[channel])
			return keyframe_curve_get_value(frames, frame, channel);
			
		return keyframe_get_value(frames, track.type, channel);
	} else {
		var valA = keyframe_get_value(frames[0], track.type, channel);
		var valB = keyframe_get_value(frames[1], track.type, channel);
		
		var percentage = (frame - frames[0].frame) / (frames[1].frame - frames[0].frame);
		
		return lerp(valA, valB, percentage); 
	}
}


function keyframe_get_value(keyframe, type, channel=0) {
	switch(type) {
		case seqtracktype_real:
			return keyframe.channels[channel].value;
		default:
			return 0;
	}
}

function keyframe_curve_get_value(keyframe, current_frame, channel=0) {
	if (array_length(keyframe.channels)==0) return 0;
	if (keyframe.channels[channel].curve==-1) return 0;
	var _channel = keyframe.channels[0].curve.channels[channel];
	var _pos = current_frame / keyframe.length;
	var res = animcurve_channel_evaluate(_channel, _pos);
	return res;
}