/// @desc THIS FUNCTION SHOULD NOT BE TOUCHED, !!! UNLESS YOUR GAME HAS SOME SPECIAL FUNCTIONALITY !!!
/// @param {struct} animation       Animation struct to tick.
/// @param {number} scope           The object that the function will be scoped to.
/// @param {string} variableName    The variable that will be used for animating the animation.
/// Thanks to JujuAdams from GameMaker Kitchen for the elegant solution!!!
function animo_tick_animation( animation, scope, variableName ) {
        if ( !is_struct( animation )
        || !is_instanceof( animation, cAnimo ) ) {
            show_error( "Animation is not a valid Animo object!", true );
        }
        
        var index = scope[$ variableName];
        index += animation.animSpeed;
    
        if ( floor( index ) >= array_length( animation.frames ) ) {
        switch( animation.animType ) {
            case ANIMO_TYPE.FINITE :
            	// Switch back to the start index and stop animating
            	animation.animSpeed = 0;
                break;
            case ANIMO_TYPE.CHAINED :
            	// If we have reached the amount of set repeats and there is a valid animation to change to, we will switch
                if ( ( animation.currentIterations >= animation.animRepeats )
                && !is_undefined( animation.animNext ) ) {
            		animation = animation.animNext;
            		index = 0;
            		animation.OnAnimationSwitch();
                }
                // If there is no animation to switch to, just start looping, but don't change type because we may want to set this later.
                else if ( is_undefined( animation.animNext ) ) {
            		index = 0;
            		animation.OnAnimationSwitch();
                }
                break;
        }
                
        index = 0;
        
        if ( !is_undefined( animation.frames[index][1] ) ) {
            animation.frames[index][1]();
        }
        	
        // If there is no end index available, we will just execute the function now
        if ( !is_undefined( animation.animEndFunc ) 
        && is_undefined( animation.animEndIndex ) ) {
            animation.animEndFunc();
        }
     	
        if ( animation.currentIterations < animation.animRepeats ) {
            ++animation.currentIterations;
        }
        
        scope[$ variableName] = clamp( index, 0, array_length( animation.frames ) );
    }
}