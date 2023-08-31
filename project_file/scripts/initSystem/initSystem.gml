console();
resolution_manager();
event_handler();
__animoMacros();

global.camera = undefined;

// Calling resolution change 1 step later because GameMaker does not like you. >: ()
call_later( 10, time_source_units_frames, function() {
    initWindow();
    global.camera = new cCamera();
}, false );

animo_map_add_entry( global.__animoAnimationMap, "character1" );
animo_map_add_entry( global.__animoAnimationMap, "character2" );

var animation = animo_init_finite( sprGuy, 0 );

console().PrintExt( $"Result:{global.__animoAnimationMap}" );