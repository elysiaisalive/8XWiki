function cTimerController() constructor {
    self.timers = [];
    
    /// @desc Adds multiple new timers to the controller.
    /// @param {struct} Struct references of the timers
    static AddTimers = function() {
        for( var i = 0; i < argument_count; ++i ) {
            if ( is_struct( argument[i] ) 
            && is_instanceof( argument[i], cTimer ) ) {
                array_push( self.timers, argument[i] );
            }
            else {
                show_error( "Argument {0} is not a timer class!", false );
                break;
            }
        }
    }
    
    static TickTimers = function() {
        array_foreach( timers, function( _timer ) {
            _timer.Tick();
        });
    }
}