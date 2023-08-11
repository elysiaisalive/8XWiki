#macro __resManager initResolutionManager()
#macro __eventHandler initEventHandler()

global.camera = undefined;

call_later( 10, time_source_units_frames, function() {
    initWindow();
    global.camera = new cCamera();
}, false );