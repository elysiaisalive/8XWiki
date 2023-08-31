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

animo_map_init_from_tag( global.__animoAnimationMap, "guy", ANIMO_NAMING_RULES.SNAKE_CASE );

console().PrintExt( $"Result:{global.__animoAnimationMap}" );