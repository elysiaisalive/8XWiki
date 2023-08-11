var _time = 0;
_time+=0.50;
draw_sprite_ext( sprite_index, -1, x, y, ( sin(get_timer()/10000000)), 1, _time, c_green, 1 );
draw_sprite_ext( sprite_index, -1, x + 16, y + 16, 1, cos(get_timer()/1000000), _time, c_lime + _time, 1 );
draw_text( x, y + sprite_get_height(sprite_index), "Help! I am trapped!" );
