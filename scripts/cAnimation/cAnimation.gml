function cAnimation() constructor {
    anim = -1; // Asset index of the sprite
    currentIterations = 0; // How many times we will loop
	animRepeats = 0;
    animNext = undefined; // Struct reference of next animation
    animType = ANIMATION_TYPE.FINITE;
    animSpd = 0;
    animStartIndex = 0;
    
    // End frame defined to execute the end function. If none is defined then it will execute at the end of an animation
    animEndIndex = undefined;
    animEndFunc = undefined;
	
	/// @static
	static GetCurrentAnimSpeed = function() {
		return animSpd;
	}
	
	/// @static
	static OnAnimationSwitch = function() {
		currentIterations = 0;
	}
}