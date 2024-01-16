/// @function StringSplit(str, separator, toReal)
/// @description Returns an array split by the separator
/// @param {Real} str
/// @param {String} separator
/// @param [ {Bool} toReal ]
function StringSplit(str, separator=" ", toReal=false) {
	var splitStr = [str];
	var l = 0;
	var sepL = string_length(separator);
	while(string_pos(separator, splitStr[l])) {
		var pos = string_pos(separator, splitStr[l]);
		var aux = splitStr[l];
		splitStr[l] = string_copy(aux, 0, pos-1);
		splitStr[l+1] = string_copy(aux, pos+sepL, string_length(aux) - pos - sepL + 1);
		l++;
	};
	
	var blank = 0;
	var l = array_length(splitStr);
	for(var i=0; i<l-blank ; i++) {
		if (splitStr[i]=="") {
			var aux = splitStr[l-1-blank];
			splitStr[l-1-blank] = splitStr[i];
			splitStr[i] = aux;
			blank++;
		}
	}
	array_resize(splitStr, l-blank);
	
	if (toReal) {
		var l = array_length(splitStr);
		for(var i=0; i<l-blank ; i++) {
			splitStr[i] = real(splitStr[i]);
		}
	}
	
	return splitStr;
};

function TimeString(sep=":") {
	var str = "";
	
	// Hours
	str += string(current_hour) + sep;
	
	// Minutes
	str += ((current_minute<10)?"0":"") + string(current_minute) + sep;
	
	// Seconds
	str += ((current_second<10)?"0":"") + string(current_second);
	
	return str;
}

function DateString(sep="/") {
	var str = "";
	
	// Year
	str += string(current_year) + sep;
	
	// Month
	str += ((current_month<10)?"0":"") + string(current_month) + sep;
	
	// Day
	str += ((current_day<10)?"0":"") + string(current_day);
	
	return str;
}

#macro TABSTR "    "

function StructStringify(stt, maxDepth=0, offset=0) {
	if (maxDepth==-1) return "Struct ( " + string(instanceof(stt)) + " )";
	var str = string(instanceof(stt)) + " {\n";
	
	var tab = "";
	repeat(offset) tab+=TABSTR;
	
	var keys = variable_struct_get_names(stt);
	for(var i=0, l=array_length(keys); i<l-1; i++) {
		str += tab + TABSTR + keys[i] + ":" + TABSTR + Stringify(stt[$ keys[i]], maxDepth-1, offset+1) + ",\n";
	}
	str += tab + TABSTR + keys[l-1] + ":" + Stringify(stt[$ keys[l-1]], maxDepth-1, offset+1) + "\n" + tab + "}";
	
	return str;
}

function ArrayStringify(arr, maxDepth=0, offset=0) {
	if (maxDepth==-1) return "Array";
	
	var str = "[";
	for(var i=0, l = array_length(arr); i<l-1; i++)
		str += Stringify(arr[i], maxDepth-1, offset + 1) + ", ";
	str += Stringify(arr[l-1], maxDepth-1, offset + 1) + "]";
	
	return str;
}

function Stringify(value, maxDepth=1, offset=0) {
	if ( is_array(value) ) return ArrayStringify(value, maxDepth, offset);
	if ( is_struct(value) ) return StructStringify(value, maxDepth, offset);
	if ( is_method(value) ) return value;
	return string(value);
}

function StringIsReal(str) {
	var n = string_length(string_digits(str));
	return n > 0 && n == string_length(str) - (string_ord_at(str, 1) == ord("-")) - (string_pos(".", str) != 0);
}