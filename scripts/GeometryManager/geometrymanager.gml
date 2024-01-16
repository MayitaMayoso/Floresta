
/*
function GeometryManager() : Component() constructor {
		
	static GPUSettings = function() {
		gpu_set_ztestenable(true);
		gpu_set_zwriteenable(true);
		gpu_set_alphatestenable(true);
		gpu_set_blendenable(true);
		//gpu_set_cullmode(cull_counterclockwise);
		gpu_set_texrepeat(true);
		gpu_set_texfilter(false);
		//display_reset(8, true);
	}
	GPUSettings();
	
	#region FORMAT MANAGEMENT
	
		// Structure that holds every format on the engine
		static Format = {};
		
		// Create the static colored untextured format.
		vertex_format_begin();
			vertex_format_add_position_3d();	// Three f32
			vertex_format_add_color();			// Four u8
			vertex_format_add_normal();			// Three f32
		Format.Colored = vertex_format_end();
		
		// Create the static textured format.
		vertex_format_begin();
			vertex_format_add_position_3d();	// Three f32
			vertex_format_add_color();			// Four u8
			vertex_format_add_normal();			// Three f32
			vertex_format_add_texcoord();		// Two f32
		Format.Textured = vertex_format_end();
		
		// Public methods
		Format.AddVertex = function(buffer, position, color, normal = [0, 1, 0], textcoord) {
			vertex_position_3d(buffer, position[0], position[1], position[2]);
			vertex_color(buffer, color[0], color[1]);
			vertex_normal(buffer, normal[0], normal[1], normal[2]);
			if (textcoord!=undefined) vertex_texcoord(buffer, textcoord[0], textcoord[1]);
		};
		
		Format.CleanUp = function() {
			vertex_format_delete(Format.Colored);	
			vertex_format_delete(Format.Textured);
		};
		
	#endregion
	
	static models = new List();
	static materials = new List();
	
	// Public methods
	static toString = function() {
		var str = "Models list: [\n";
		for(var i=0; i<models.Size(); i++) {
			str += TABSTR + models.Get(i).toString(TABSTR) + "\n";
		}
		str += "]"
		return str;
	}

	// Private methods
	static Create = function() {
		defaultMaterial = new Material("Default", tex_default,
			function() {
				shader_set(sh_3DModel);
				shader_set_uniform_f(shader_get_uniform(sh_3DModel, "lightPos"), 10, 10, 10);
				shader_set_uniform_f(shader_get_uniform(sh_3DModel, "minDarkness"), 0.3);
			}
		);
	}
	
	static Draw = function() {
		
		for(var i=0; i<models.Size(); i++) models.Get(i).Draw();
		
		matrix_set(matrix_world, IDENTITY);
		shader_reset();
	}
	
	static CleanUp = function() {
		for(var i=0; i<models.Size(); i++) models.Get(i).CleanUp();
		for(var i=0; i<materials.Size(); i++) materials.Get(i).CleanUp();
	}
}

*/