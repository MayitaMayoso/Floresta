
var t = current_time / 2000;
var a = 10;
x = xstart + PerlinNoise(t) * a;
y = ystart + PerlinNoise(0.1, t) * a;
image_angle = PerlinNoise(t+1000) * a;