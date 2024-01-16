/// @function  Print(message [, message]);
/// @description Prints on the console every parameter given to the function.
/// @parameter [ Message ]
function Print(messsage) {
	if ( argument_count == 1 ) {
		show_debug_message(string(messsage));
		return string(messsage)
	} else {
		var totalMessage = "";
		for ( var i=0; i < argument_count - 1 ; i++ ) totalMessage += string(argument[i]) + " ";
		totalMessage += string(argument[argument_count - 1]);
			
		show_debug_message(totalMessage);
		return totalMessage;
	}
};

function TESTPRINT() {
	Print("SI SE EJECUTA");
	return true;
}

#macro DEBUGLINE Print("==========================================================")

/// @function Between(value, minimum, maximum)
/// @description Checks if the given value is between the min and the max.
/// @parameter {Real} value
/// @parameter {Real} minimum
/// @parameter {Real} maximum
function Between(value, minimum, maximum) {	
	return value >= minimum && value <= maximum;
};


/// @function approach(from, to, amount)
/// @description Approach by a constant the given amount in the direction of the target value.
/// @parameter {Real} from
/// @parameter {Real} to
/// @parameter {Real} amount
function Approach(from, to, amount) {
	if(from < to){
		return min(from + amount, to); 
	}else{
		return max(from - amount, to);
	}
};


/// @function Wave(from, to, period, offset)
/// @description Gives an oscilated value between two numbers in the given amount of milisecons.
/// @parameter {Real} from
/// @parameter {Real} to
/// @parameter {Real} period
/// @parameter [ {Real} offset ]
function Wave(from, to, period, offset = 0, pos = current_time) {
	var amplitude = ( to - from ) / 2;
	return from + amplitude + amplitude * sin( 2 * pi * pos / period + offset * period );
};

// Wave but it works relative to the Time manager
function FixedWave(from, to, period, offset = 0, pos = current_time) {
	return Wave(from, to, period, offset, 1000 * Time.frame / Time.second);
};


/// @function Wrap(value, minimum, maximum)
/// @description If the given value surpases one of the boundaries it appears by the other side.
/// @parameter {real} value
/// @parameter {real} minimum
/// @parameter {real} maximum
function Wrap(value, minimum, maximum) {
	var range = maximum - minimum;
	if (range==0) return value;
	while(value >= maximum) value -= range;
	while(value < minimum) value += range;
	return value;
};


/// @function IsIn(value, minimum, maximum)
/// @description Checks if a value is inside a list of values
/// @parameter {real} value
/// @parameter {Array} list
function IsIn(value, list) {
	for(var i=0; i<array_length(list); i++) {
		if (list[i]==value) return true;
	}
	return false;
};

function ObjectInstances(objIndex) {
	var ids = []
	for(var i=0; i<instance_number(objIndex); i++) {
		array_push(ids, instance_find(objIndex, i));
	}
	return ids;
}

function FindInstanceNumber(id) {
	for(var i=0; i<instance_number(id.object_index); i++)
		if (instance_find(id.object_index, i) == id) return i;
	return -1;
}

function InstanceNearest(object=object_index) {
	x += 100000;
	var inst = instance_nearest(x-100000, y, object);
	x -= 100000;
	if (inst==noone || inst==id) return noone;
	return inst;
}

function DistanceToObject(obj) {
	return point_distance(x, y, obj.x, obj.y);	
}


function DirectionToObject(obj) {
	return point_direction(x, y, obj.x, obj.y);	
}