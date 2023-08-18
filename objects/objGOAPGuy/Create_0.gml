// GOAP FSM states
enum STATES {
    IDLE,
    MOVE,
    PERFORMING
}

state = STATES.IDLE;


// testing
transform = {
    position : new Vector3( x, y, 0 ),
    rotation : 0,
    scale : new Vector2( 1, 1 )
}
// Example use 
// entity.transform.position.x OR entity.transform.scale