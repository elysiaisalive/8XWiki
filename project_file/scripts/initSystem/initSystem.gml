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

animo_populate_by_tag( "Bob" );
animo_populate_by_tag( "Guy" );

print( $"Result:{global.__animoAnimationMap}" );