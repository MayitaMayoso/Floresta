function List() constructor {
	
	#region Public Methods
	
		static Get = function(index) {
			return arr[index];
		}
		
		static Set = function(index, value) {
			arr[index] = value;
		}
		
		static Size = function() {
			return array_length(arr);
		}
		
		static Clear = function() {
			arr = [];
		}
		
		static Copy = function(source) {
			if (is_array(source))
				array_copy(arr, 0, source, 0, array_length(source))
			if (instanceof(source)=="List")
				array_copy(arr, 0, source.arr, 0, source.Size())
		}
		
		static Resize = function(size) {
			array_resize(arr, size);
		}
		
		static Fill = function(value) {
			for(var i=0; i<Size(); i++) {
				arr[i] = value;
			}
		}
		
		static Equals = function(source) {
			if (Size()!=source.Size()) return false;
			
			for(var i=0; i<Size(); i++) {
				if (arr[i]!=source.Get(i)) return false
			}
			
			return true;
		}
		
		static Remove = function(index, number=1) {
			array_delete(arr, index, number);
		}
		
		static Push = function(value) {
			arr[Size()] = value;
		}
		
		static Pop = function(value) {
			var val = arr[Size()-1];
			Resize(Size()-1);
			return val;
		}
		
		static Insert = function(index, value) {
			array_insert(arr, index, value);
			if (argument_count>2) {
				for(var i=0; i<argument_count-2; i++) {
					array_insert(arr, index+1+i, argument[2+i]);
				}
			}
		}
		
		static Sort = function(sorttype_or_function) {
			array_sort(arr, sorttype_or_function);
		}
		
		static Index = function(value, varName) {
			
			if ( varName == undefined ) {
				for(var i=0; i<Size(); i++) {
					if (arr[i]==value) return i;
				}
			} else {
				for(var i=0; i<Size(); i++) {
					if (is_struct(arr[i]) && arr[i][$ varName]==value) return i;
					if (variable_instance_get(arr[i], varName)==value) return i;
				}
			}
			
			return -1;
		}
		
		static RemoveValues = function(value) {
			for(var i=0; i<Size(); i++) {
				if (arr[i]==value) {
					Remove(i);
					i--;
				}
			}
		}
		
		static Head = function() {
			if (!Size()) return -1;
			return arr[0];
		}
		
		static Tail = function() {
			if (!Size()) return -1;
			return arr[Size()-1];
		}
		
		static IsEmpty = function() {
			return Size()==0;
		}
		
		static toString = function(tab="") {
			var str = tab + "List: [\n";
		    for(var i=0; i<Size(); i++) {
	    		str += tab + TABSTR + string(i) + ": " + string(arr[i]) + "\n"
		    }
		    str += tab + "]";
		    return str;
		}
		
	#endregion
	
	#region Private variables
	
		arr = [];
	
	#endregion
	
	#region Construction
	
		if ( argument_count == 1 ) {
			if ( is_array(argument[0]) || instanceof(argument[0])=="List" ) Copy(argument[0]);
			if ( is_real(argument[0]) ) Resize(argument[0]);
		} else if ( argument_count == 2 ) {
			Resize(argument[0]);
			Fill(argument[1]);
		}
	
	#endregion
}