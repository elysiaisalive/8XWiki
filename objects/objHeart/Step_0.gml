depth = transform.position.z;
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
