function cTimer( time, _loop = false, _start_paused = false ) constructor {
    label            = "";
    tickSpeed       = 1; // Rate at which the timer decreases
    setTime        = time;
    setMaxTime     = time;
    looped          = _loop;
    paused    = false;
    
    if ( _start_paused ) {
        paused = true;
    }
    
    static GetLabel = function() {
        return label;
    }
    
    static SetTime = function( new_time ) {
        setTime = new_time;
    };
    
    static SetNewTime = function( new_time ) {
        setTime = new_time;
        setMaxTime = new_time;
    }
    
    static GetTime = function() {
        return setTime;
    };
    
    static EndTimer = function() {
        SetTime( -1 );
        return true;
    };
    
    static ResetTimer = function( _randomize_time = false, _pause_on_reset = false ) {
        if ( !_randomize_time ) {
            SetTime( setMaxTime );
        }
        else {
            SetTime( random_range( 0, setMaxTime ) );
        }
        
        if ( _pause_on_reset ) {
            paused = true;
        }
    };
    
    static SetTickSpeed = function( _spd = 1 ) {
        tickSpeed = _spd;
    }
    
    static TimerIsEnded = function(){ return true; };
    
    static Tick = function() {
        var _delta = ( delta_time / 1000000 );
        
        // If tickspeed is not set, set tickSpeed to 1
        if ( tickSpeed <= 0 ) {
            SetTickSpeed( 1 );
        }
        
        if ( !paused 
        && setTime > 0
        && tickSpeed > 0 ) {
            setTime -= tickSpeed * _delta;
            
            if ( setTime <= 0 ) {
                TimerIsEnded();
                
                if ( looped ) {
                   ResetTimer(); 
                };
            };
        };
    };
    
    static Pause = function() {
        paused = true;
    };   
    
    static Unpause = function() {
        paused = false;
    };
};