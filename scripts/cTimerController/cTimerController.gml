function cTimerController() constructor {
    timers = [];
    
    // Init new timers and automatically add them
    static Init = function() {
        for( var i = 0; i < argument_count; ++i ) {
            array_push( timers, argument[i] );
        }
    }
    
    static TickTimers = function() {
        array_foreach( timers, function( _timer ) {
            _timer.Tick();
        });
    }
    
    static GetTimers = function() {
        var _arr = [];
        
        array_foreach( timers, function( _timer ) {
            array_push( _arr, _timer );
        });
        
        return _arr;
    }
}