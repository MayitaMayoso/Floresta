
shader_set(sh_plain_colour);
shader_set_uniform_f(uniform_colour, 1, 1, 1);
shader_set_uniform_f(uniform_value, juice);
event_inherited();
shader_reset();