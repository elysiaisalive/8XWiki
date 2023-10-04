/// @desc THIS FUNCTION SHOULD NOT BE TOUCHED, !!! UNLESS YOUR GAME HAS SOME SPECIAL FUNCTIONALITY !!!
/// @param {instance} scope              The object that the function will be scoped to.
/// @param {string} animo_struct_ref    Animation struct to tick.
/// @param {string} variable_name       The variable that will be used for animating the animation.
/// Thanks to JujuAdams from GameMaker Kitchen for the elegant solution!!!
function animo_tick_animation( scope, animo_struct_ref, variable_name ) {
        if ( !instance_exists( scope ) ) {
            show_error( "Scoped Instance does not exist!", true );
        }
        
        if ( !is_string( animo_struct_ref ) ) {
            show_error( "Struct reference must be a string!", true );
        }
        
        if ( !is_string( variable_name ) ) {
            show_error( "Variable reference must be a string!", true );
        }
        
        var index = scope[$ variable_name] + scope[$ animo_struct_ref].animSpeed;
        
        scope[$ variable_name] += scope[$ animo_struct_ref].animSpeed;
        
        if ( floor( index ) >= array_length( scope[$ animo_struct_ref].frames ) ) {
            switch( scope[$ animo_struct_ref].animType ) {
                case ANIMO_TYPE.FINITE :
                	// Switch back to the start index and stop animating
                	index = 0;
                	scope[$ animo_struct_ref].animSpeed = 0;
                    break;
                case ANIMO_TYPE.CHAINED :
                	// If we have reached the amount of set repeats and there is a valid animation to change to, we will switch
                    if ( ( scope[$ animo_struct_ref].currentIterations >= scope[$ animo_struct_ref].animRepeats )
                    && !is_undefined( scope[$ animo_struct_ref].animNext ) ) {
                		scope[$ animo_struct_ref].OnAnimationSwitch();
                		scope[$ animo_struct_ref] = scope[$ animo_struct_ref].animNext;
                		index = 0;
                    }
                    // If there is no animation to switch to, just start looping, but don't change type because we may want to set this later.
                    else if ( is_undefined( scope[$ animo_struct_ref].animNext ) ) {
                		index = 0;
                		scope[$ animo_struct_ref].OnAnimationSwitch();
                    }
                    break;
            }
                    
            index = 0;
            
            if ( !is_undefined( scope[$ animo_struct_ref].frames[index][1] ) ) {
                scope[$ animo_struct_ref].frames[index][1]();
            }
            	
            // If there is no end index available, we will just execute the function now
            if ( !is_undefined( scope[$ animo_struct_ref].animEndFunc ) 
            && is_undefined( scope[$ animo_struct_ref].animEndIndex ) ) {
                scope[$ animo_struct_ref].animEndFunc();
            }
         	
            if ( scope[$ animo_struct_ref].currentIterations < scope[$ animo_struct_ref].animRepeats ) {
                ++scope[$ animo_struct_ref].currentIterations;
            }
            
            scope[$ variable_name] = clamp( index, 0, array_length( scope[$ animo_struct_ref].frames ) );
    }
}