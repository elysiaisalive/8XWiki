function cAnimation() constructor {
    self.sprite = -1; // Asset index of the sprite
    self.frames = [];
    self.currentIterations = 0; // How many times we already have looped.
	self.animRepeats = 0; // How many times we will loop.
    self.animNext = undefined; // Struct reference of next animation.
    self.animType = ANIMATION_TYPE.FINITE;
    self.animSpd = 0;
    self.animStartIndex = 0;
    
    // End frame defined to execute the end function. If none is defined then it will execute at the end of an animation
    self.animEndIndex = 0;
    self.animEndFunc = undefined;
	
	// Populating the frame array with all sprite frames
	static Init = function() {
		var _image_count = sprite_get_number( self.sprite );
		
		for( var i = 0; i < _image_count; ++i ) {
			self.frames[i] = [i, undefined];
		}
	}
	
	/// @static
	static SetFrameCallback = function( _frame = 0, callback ) {
		if ( callback != -1 ) {
			self.frames[_frame][1] = callback;
		}
	}
	
	/// @static
	static SetAnimationEndCallback = function( _func = -1 ) {
		if ( self.animEndFunc != -1 ) {
			self.animEndFunc = _func;
		}
	}
	
	/// @static
	static GetCurrentAnimSpeed = function() {
		return self.animSpd;
	}
	
	/// @static
	static OnAnimationSwitch = function() {
		self.currentIterations = 0;
	}
}