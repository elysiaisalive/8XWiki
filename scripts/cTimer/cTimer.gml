function cTimer( time, loop = false, start_paused = false ) constructor {
    name            = "";
    tickSpeed       = 1; // Rate at which the timer decreases
    setTime        = time;
    setMaxTime     = time;
    looped          = loop;
    paused    = false;
    
    if ( start_paused )
        paused = true;
    
    static SetTime = function( new_time )
    {
        setTime = new_time;
    };
    
    static SetNewTime = function( new_time ) {
        setTime = new_time;
        setMaxTime = new_time;
    }
    
    static GetTime = function()
    {
        return setTime;
    };
    
    static EndTimer = function()
    {
        SetTime( -1 );
        return true;
    };
    
    static ResetTimer = function( _bRandomize = false, _bPause = false )
    {
        if ( !_bRandomize ) {
            SetTime( setMaxTime );
        }
            else {
            SetTime( random_range( 0, setMaxTime ) );
        }
        
        if ( _bPause ) {
            paused = true;
        }
    };
    
    static SetTickSpeed = function( _spd = 1 ) {
        tickSpeed = _spd;
    }
    
    static OnTimerEnd = function(){ return true; };
    
    static Tick = function()
    {
        // If tickspeed is not set, stop ticking and set tickSpeed to 1
        if ( tickSpeed <= 0 ) {
            SetTickSpeed( 1 );
            Pause();
        }
        
        if ( !paused 
        && setTime > 0
        && tickSpeed > 0 ) {
            setTime -= tickSpeed;
            
            if ( setTime <= 0 )
            {
                if ( looped )
                {
                   ResetTimer(); 
                };
                
               OnTimerEnd();
            };
        };
    };
    
    static Pause = function()
    {
        paused = true;
    };   
    
    static Unpause = function()
    {
        paused = false;
    };
};