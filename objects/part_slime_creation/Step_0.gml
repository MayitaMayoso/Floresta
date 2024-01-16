
event_inherited();

var decay = 1*image_xscale/lifeTime;
image_xscale = max(0, image_xscale - decay);
image_yscale = max(0, image_yscale - decay);