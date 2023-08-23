#macro __resManager initResolutionManager()
#macro __eventHandler event_handler()

console();
// Ticking the console every frame
// call_later( 1, time_source_units_frames, function(){ console().Tick(); }, true );
// call_later( 1, time_source_units_frames, function(){ console().Draw(); }, true );

global.camera = undefined;

call_later( 10, time_source_units_frames, function() {
    initWindow();
    global.camera = new cCamera();
}, false );