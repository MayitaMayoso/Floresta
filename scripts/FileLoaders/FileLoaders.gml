function LoadMTL(filename) {
	
	// We open the file and go line by line
	var file = file_text_open_read("Models/" + filename + "/" + filename + ".mtl");
		
	var name;
	var materials = new List();
	
	while(!file_text_eof(file) ) {
		
		var line = file_text_read_string(file);
		file_text_readln(file);
		
		// We split each term of the line, if empty we continue
		var terms = StringSplit(line, " ");
		if (!array_length(terms)) continue;
		
		switch(terms[0]) {
			case "newmtl":
				name = terms[1];
				break;
			case "map_Kd":
				var spr = sprite_add("Models/" + filename + "/" + terms[1], 0, false, false, 0, 0);
				materials.Push(new Material(name, spr));
				break;
		}
	}
		
	return materials;
};

function LoadOBJ(filename) {
	
	// This is what we will return
	var buffers = new List();
	var materials = new List();
	var names = new List();
	var mtl = new List();
	
	// Components of each mesh
	var position = new List();
	var normal = new List();
	var textcoord = new List();
	
	// We open the file and go line by line
	var file = file_text_open_read("Models/" + filename + "/" + filename + ".obj");
	
	while(!file_text_eof(file) ) {
		
		var line = file_text_read_string(file);
		file_text_readln(file);
		
		// We split each term of the line, if empty we continue
		var terms = StringSplit(line, " ");
		if (!array_length(terms)) continue;
		
		switch(terms[0]) {
			case "mtllib":
				mtl.Copy(LoadMTL(filename));
				break;
				
			case "o": // NEW OBJECT
				var len = buffers.Size();
				if (len>0) {
					vertex_end(buffers.Tail());
					vertex_freeze(buffers.Tail());
				}
				names.Push(terms[1]);
				buffers.Push(vertex_create_buffer());
				vertex_begin(buffers.Tail(), Geometry.Format.Textured);
				break;
				
			case "usemtl": // SELECT THE TEXTURE
				var mat = -1;
				for(var i=0; i<mtl.Size(); i++) {
					if (mtl.Get(i).name==terms[1]) {
						mat = mtl.Get(i);
						break;
					}
				}
				materials.Push(mat)
				break;
				
			case "v": // VERTEX POSITION
				position.Push([real(terms[1]), real(terms[2]), real(terms[3])]);
				break;
				
			case "vt": // VERTEX TEXTURE COORD
				textcoord.Push([real(terms[1]), 1-real(terms[2])]);
				break;
				
			case "vn": // VERTEX NORMAL
				normal.Push([real(terms[1]), real(terms[2]), real(terms[3])]);
				break;
				
			case "f": // NEW TRIANGLE
				for ( var i=1 ; i<=3 ; i++ ) {
					var index = StringSplit(terms[i], "/");
					var tmpPos = position.Get(index[0]-1);
					var tmpTex = textcoord.Get(index[1]-1);
					var tmpNor = normal.Get(index[2]-1);
					Geometry.Format.AddVertex(buffers.Tail(), tmpPos, [c_white, 1], tmpNor, tmpTex);
				}			
				break;
		}
	}
	file_text_close(file);

	vertex_end(buffers.Tail());
	vertex_freeze(buffers.Tail());
	
	var meshes = new List();
	
	for(var i=0; i<buffers.Size(); i++)
		if (materials.Get(i)!=-1)
			meshes.Push(new Mesh(names.Get(i), buffers.Get(i), materials.Get(i)));

	return new Model(filename, meshes);
};
