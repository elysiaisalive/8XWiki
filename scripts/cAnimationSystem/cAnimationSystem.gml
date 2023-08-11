/* 
	USAGE:
		Create a variable in an object to hold the current animation struct ( current_animation or currentAnim )
		Initialize your animations using the animation_init() functions.
		
		EXAMPLE:
			var walk = animation_init_finite(spr_player_walk, 0, 0);
			var jump = animation_init_chained(spr_player_jump, walk, 0, 0);
			
			^^ The Above code will init 2 animation structs 'walk' and 'jump'.
			'jump' is a chained animation that will return back to the 'walk' animation immediately after it finishes.
*/

/// Tick animations. WIP!!!!
// Increment frame index
//AnimIndex += currentAnimation.animSpd * delta;
        
//if ( floor( AnimIndex ) >= sprite_get_number( currentAnimation.anim ) ) {
//    switch( currentAnimation.animType ) {
//        case ANIMATION_TYPE.FINITE :
//        	// Switch back to the start index and stop animating
//        	currentAnimation.animSpd = 0;
//            break;
//        case ANIMATION_TYPE.CHAINED :
//        	// If we have reached the amount of set repeats and there is a valid animation to change to, we will switch
//            if ( ( currentAnimation.currentIterations >= currentAnimation.animRepeats )
//            && !is_undefined( currentAnimation.animNext ) ) {
//        		/* 
//        			TODO:
//        				Add support for randomizing chain animations
//        		*/
//        		currentAnimation = currentAnimation.animNext;
//        		AnimIndex = 0;
//        		currentAnimation.OnAnimationSwitch();
//            }
//            // If there is no animation to switch to, just start looping, but don't change type because we may want to set this later.
//            else if ( is_undefined( currentAnimation.animNext ) ) {
//        		AnimIndex = 0;
//        		currentAnimation.OnAnimationSwitch();
//            }
//            break;
//    }
            
//    AnimIndex = 0;
        	
//    // If there is no end index available, we will just execute the function now
//    if ( !is_undefined( currentAnimation.animEndFunc ) 
//    && is_undefined( animEndIndex ) ) {
//        animEndFunc();
//    }
 	
//    if ( currentAnimation.currentIterations < currentAnimation.animRepeats ) {
//        ++currentAnimation.currentIterations;
//    }
//}
//////////
        
//// If there is an end index available, we will execute the function on the frame.
//if ( !is_undefined( currentAnimation.animEndFunc ) 
//&& !is_undefined( animEndIndex ) ) {
//    if ( floor( animIndex ) >= sprite_get_number( currentAnimation.anim ) ) {
//    	animEndFunc();
//    }
//}
        
//AnimIndex = clamp( AnimIndex, 0, sprite_get_number( currentAnimation.anim ) );



/// @param		{sprite}	_animation
/// @param		{number}	_anim_spd
/// @param		{number}	_start_frame
function animation_init_finite( _animation, _anim_spd, _start_frame = 0 ) {
    var animation = new cAnimation();
    animation.animType = ANIMATION_TYPE.FINITE;
    animation.anim = _animation;
    animation.animSpd = _anim_spd;
    animation.animStartIndex = _start_frame;
    
    return animation;
}

/// @param		{sprite}	_animation
/// @param		{number}	_anim_spd
/// @param		{number}	_repeats
/// @param		{number}	_start_frame	
function animation_init_looped( _animation, _anim_spd, _repeats = -1, _start_frame = 0 ) {
    var animation = new cAnimation();
    animation.animType = ANIMATION_TYPE.LOOPED;
    animation.anim = _animation;
    animation.animSpd = _anim_spd;
	animation.animRepeats = ( _repeats != -1 ) ? 0 : _repeats;
    animation.animStartIndex = _start_frame;
    
    return animation;
}

/// @param		{sprite}	_animation
/// @param		{struct}	_end_animation
/// @param		{number}	_anim_spd
/// @param		{number}	_repeats
/// @param		{number}	_start_frame
function animation_init_chained( _animation, _end_animation, _anim_spd, _repeats = -1, _start_frame = 0 ) {
    var animation = new cAnimation();
    animation.animType = ANIMATION_TYPE.CHAINED;
    animation.anim = _animation;
    animation.animSpd = _anim_spd;
    animation.animNext = _end_animation;
	animation.animRepeats = ( _repeats != -1 ) ? _repeats : 0;
    animation.animStartIndex = _start_frame;
    
    return animation;
}