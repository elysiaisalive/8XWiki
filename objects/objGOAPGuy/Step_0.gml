x = transform.position.x;
y = transform.position.y;
image_angle = transform.rotation;
direction = transform.rotation;

transform.rotation += animSpd;

// Ping Pong animation.
if ( image_index < image_number ) {
    image_index += animSpd;
}
else {
    image_index -= animSpd;
}

if ( mouse_check_button( mb_left ) ) {
    var target_pos = new Vector3( mouse_x, mouse_y, 0 );
    
    transform.position.x = target_pos.x;
    transform.position.y = target_pos.y;
}

// transform.position.x += dsin( transform.rotation ) * animSpd;
// transform.position.y -= dcos( transform.rotation ) * animSpd;