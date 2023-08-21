draw_sprite_ext( sprite_index, -1, transform.position.x + 1, transform.position.y + 1, transform.scale.x, transform.scale.y, transform.rotation, c_black, image_alpha * 0.5 );
draw_sprite_ext( sprite_index, -1, transform.position.x, transform.position.y, transform.scale.x, transform.scale.y, transform.rotation, c_white, 1 );

// transform.position.x += dsin( transform.rotation ) * animSpd;
// transform.position.y -= dcos( transform.rotation ) * animSpd;
