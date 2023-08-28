/// @param {number}     time The timers time in seconds.
/// @param {bool}       loop If the timer should continously reset when it reaches 0.
/// @param {bool}       start_paused If the timer should start paused.
function cTimer( time, _loop = false, _start_paused = false ) constructor {
    self.label              = ""; // Timer labels. You can use these for debugging.
    self.tickSpeed          = 1;
    self.setTime            = time;
    self.setMaxTime         = time;
    self.looped             = _loop;
    self.startPaused        = _start_paused;
    self.paused             = false;
    
    #region Setters
    static GetLabel = function() {
        return self.label;
    }  
    
    static GetTime = function() {
        return self.setTime;
    };
    #endregion
    #region Getters
    static SetTime = function( new_time ) {
        self.setTime = new_time;
    };
    
    static SetNewTime = function( new_time ) {
        self.setTime = new_time;
        self.setMaxTime = new_time;
    }
    
    static SetTickSpeed = function( _ticks_in_seconds = 1 ) {
        self.tickSpeed = _ticks_in_seconds;
    }
    #endregion
    #region Callbacks
    static EndTimer = function() {
        SetTime( -1 );
        return true;
    };
    
    static ResetTimer = function( _randomize_time = false, _pause_on_reset = false ) {
        if ( !_randomize_time ) {
            SetTime( self.setMaxTime );
        }
        else {
            SetTime( random_range( 0, self.setMaxTime ) );
        }
        
        if ( _pause_on_reset ) {
            self.paused = true;
        }
    };
    
    static OnTimerEnd = function(){};
    #endregion
    
    static Pause = function() {
        self.paused = true;
    };   
    
    static Unpause = function() {
        self.paused = false;
    };
    
    // Timer Logic.
    static Tick = function() {
        var _delta = ( delta_time / 1000000 );
        
        if ( self.startPaused ) {
            self.paused = true;
        }
        
        // If tickspeed is not set, set tickSpeed to 1.
        if ( self.tickSpeed <= 0 ) {
            SetTickSpeed( 1 );
        }
        
        if ( !self.paused 
        && self.setTime > 0
        && self.tickSpeed > 0 ) {
            self.setTime -= self.tickSpeed * _delta;
            
            // If timer is expired, invoke OnTimerEnd() callback and reset the timer.
            if ( self.setTime <= 0 ) {
                OnTimerEnd();
                
                if ( self.looped ) {
                   ResetTimer(); 
                };
            };
        };
    };
};