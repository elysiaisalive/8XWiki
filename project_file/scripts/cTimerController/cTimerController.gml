function cTimerController() constructor {
    timers = [];
    
    /// @desc Adds multiple new timers to the controller.
    /// @param {struct} Struct references of the timers
    static AddTimers = function() {
        for( var i = 0; i < argument_count; ++i ) {
            array_push( timers, argument[i] );
        }
    }
    
    static TickTimers = function() {
        array_foreach( timers, function( _timer ) {
            _timer.Tick();
        });
    }
}