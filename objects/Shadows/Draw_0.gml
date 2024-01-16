
if (!surface_exists(surf))
    surf = surface_create(Camera.Width(), Camera.Height());
    
surface_set_target(surf);
draw_clear_alpha(c_black, 0);

var xx = Camera.view.x - Camera.Width()*.5;
var yy = Camera.view.y - Camera.Height()*.5;
for(var i=0; i<instance_number(obj_entity); i++) {
    var inst = instance_find(obj_entity, i);
    
    if (inst.shadow) {
        if(inst.shadowPrecise) {
            draw_sprite_ext(inst.sprite_index, inst.image_index, inst.x - xx, inst.y - yy + 2, inst.image_xscale, inst.image_yscale*.8, inst.image_angle, c_black, 1);
        } else {
            var totalScl = inst.shadowScale * inst.sprite_width/sprite_get_width(spr_shadow);
            draw_sprite_ext(spr_shadow, 0, inst.x - xx, inst.y - yy, totalScl, totalScl, 0, c_black, 1);
        }
    }
}

surface_reset_target();

//shader_set(sh_gaussian_blur);

//shader_set_uniform_f(shader_get_uniform(sh_gaussian_blur, "blur_steps"), 1);
//shader_set_uniform_f(shader_get_uniform(sh_gaussian_blur, "texel_size"), 1/Camera.Width(), 1/Camera.Height());
//shader_set_uniform_f(shader_get_uniform(sh_gaussian_blur, "sigma"), 1);
draw_surface_ext(surf, Camera.view.x - Camera.Width()/2, Camera.view.y - Camera.Height()/2, 1, 1, 0, c_white, .5);
//shader_reset();