draw_set_color( c_aqua );
draw_circle( transform.position.x, transform.position.y, 64, true );
draw_set_color( c_white );
draw_line( transform.position.x, transform.position.y, transform.position.x + lengthdir_x( 64, transform.rotation ), transform.position.y + lengthdir_y( 64, transform.rotation ) );
