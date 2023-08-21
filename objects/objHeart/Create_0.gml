// GOAP FSM states

z = 8;

image_speed = 0;

state = STATES.IDLE;
frame = 0;
animSpd = 1;
height = 35;

// testing
transform = {
    position : new Vector3( x, y, depth - height ),
    rotation : 0,
    scale : new Vector2( 1, 1 )
}
// Example use 
// entity.transform.position.x OR entity.transform.scale
depth = transform.position.z;