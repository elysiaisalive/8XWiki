#macro __resManager initResolutionManager()
#macro __eventHandler initEventHandler()

console();
// Ticking the console every frame
call_later( 1, time_source_units_frames, function(){ console().Tick(); }, true );

global.camera = undefined;

call_later( 10, time_source_units_frames, function() {
    initWindow();
    global.camera = new cCamera();
}, false );