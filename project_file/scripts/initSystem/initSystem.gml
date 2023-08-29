console();
resolution_manager();
event_handler();

global.camera = undefined;

// Calling resolution change 1 step later because GameMaker does not like you. >: ()
call_later( 10, time_source_units_frames, function() {
    initWindow();
    global.camera = new cCamera();
}, false );

animo_add_map_entry( , "character1" );
animo_add_map_entry( , "character2" );

var animation = animo_init_finite( sprGuy, 0 );

//animo_add_to_map( __animoAnimationMap, animation, "character1" );

console().PrintExt( __animoAnimationMap );