// Draw each layer of the image in their respective colors

// Outline (always just black)
draw_sprite(spriteSet[0],image_index,x,y);

// Hair
draw_sprite_ext(spriteSet[1], image_index, x, y, 1, 1, 0, hairColor, 1);

// Skin
draw_sprite_ext(spriteSet[2], image_index, x, y, 1, 1, 0, skinColor, 1);

// Dress
draw_sprite_ext(spriteSet[3], image_index, x, y, 1, 1, 0, dressColor, 1);

