#macro sec *Time.second
#macro minute sec*60
#macro hour minute*60

function TimeManager() : Component() constructor {
    
    delta = 0;			// Delta is the relation between the real fps and the desired ones
    rawDelta = 0;		// RawDelta is the same as delta but without multiplying by speed
    speed = 1;			// Speed is a factor we will use to speed up or down the time in order to make slow mo
    second = 240;	// cicles is the intended speed of the game when designing the game
    accumulatedDelta = 0;
    wholeDelta = 0;
    frame = 0;
    
    instances = new List();

    static Register = function(inst, event) {
    	instances.Push(inst);
    };
    
    static Step = function() {
        // Calculate the amount of times we should run the fixed step methods of each instance
        accumulatedDelta += frac(delta);
        wholeDelta = floor(delta) + floor(accumulatedDelta);
        accumulatedDelta = frac(accumulatedDelta);
    }
    
    static StepBegin = function() {
        // We calculate the time between last frame and current and we make a normalized factor
        rawDelta = ( delta_time * second ) / 1000000;
        rawDelta = min(rawDelta, 16);
        delta = speed * rawDelta;
    }
    
    static InstancesFixedStep = function() {
        repeat(wholeDelta) {
        	for( var i=0 ; i<instances.Size() ; i++ ) {
        		if (instance_exists(instances.Get(i))) {
        		    with(instances.Get(i))
        		        event_perform(ev_other, ev_user0);
        		} else {
        			instances.Remove(i);
        			i--;
        		}
        	}
        	frame++;
        }
    }
}