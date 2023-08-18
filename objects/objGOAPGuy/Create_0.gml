// GOAP FSM states
enum STATES {
    IDLE,
    MOVE,
    PERFORMING
}

z = x * y;
image_speed = 0;

state = STATES.IDLE;
frame = 0;
animSpd = 1;

// testing
transform = {
    position : new Vector3( x, y, z ),
    rotation : 0,
    scale : new Vector2( 2, 2 )
}
// Example use 
// entity.transform.position.x OR entity.transform.scale