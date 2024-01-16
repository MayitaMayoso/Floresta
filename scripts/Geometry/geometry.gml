/*
function Material(_name, _textureSprite, _ShadingFunc ) constructor {
	name = _name;
	sprite = _textureSprite;
	texture = sprite_get_texture(_textureSprite, 0);
	ShadingFunc = _ShadingFunc;
	
	// Public methods
	static Apply = function() {
		if (ShadingFunc!=undefined) ShadingFunc();
		else Geometry.defaultMaterial.Apply();
	}
	
	static CleanUp = function() {
		sprite_flush(sprite);
	}
	
	static toString = function() {
		return "Material: " + name;
	}

	Geometry.materials.Push(self);
}

function Mesh(_name, _buffer, _material = Geometry.defaultMaterial) constructor {
	// Initialization
	name = _name;
	buffer = _buffer;
	material = _material;
	
	primitive = pr_trianglelist;
	
	// Public Methods
	static Draw = function() {
		material.Apply();
		vertex_submit(buffer, primitive, material.texture);
	};
	
	static CleanUp = function() {
		buffer_delete(buffer);
	};
	
	static toString = function(tab="") {
		return tab + name + ": Material [" + material.name + "]";
	}
};

function Model(_name, _meshes, _transform = IDENTITY) constructor {
	name = _name;
	meshes = new List(_meshes);
	transform = _transform;
	
	// Public methods
	static Draw = function() {
		matrix_set(matrix_world, matrix_multiply(matrix_build(0,0,0,0,0,0,PPM,PPM,PPM),transform));
		for(var i=0; i<meshes.Size(); i++) meshes.Get(i).Draw();
	}
	
	static CleanUp = function() {
		for(var i=0; i<meshes.Size(); i++) meshes.Get(i).CleanUp();
	}
	
	static toString = function(tab="") {
		var str = tab + name + ": [\n";
		for(var i=0; i<meshes.Size(); i++) {
			str += tab + TABSTR + meshes.Get(i).toString(tab+TABSTR) + "\n";
		}
		str += tab + "]"
		return str;
	}
	
	Geometry.models.Push(self);
}
*/