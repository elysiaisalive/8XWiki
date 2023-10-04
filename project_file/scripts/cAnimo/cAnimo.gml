/// @self {cAnimo|function}
function cAnimo() constructor {
    self.sprite = -1; // Asset index of the sprite
    self.frames = [];
    self.currentIterations = 0; // How many times we already have looped.
	self.animRepeats = 0; // How many times we will loop.
    self.animNext = undefined; // Struct reference of next animation.
    self.animType = ANIMO_TYPE.FINITE;
    self.animSpeed = 0;
    self.animStartIndex = 0;
    
    // End frame defined to execute the end function. If none is defined then it will execute at the end of an animation
    self.animEndIndex = 0;
    self.animEndFunc = undefined;
	
	#region Getters
	/// @static
	static GetCurrentAnimSpeed = function() {
		return self.animSpeed;
	}
	#endregion
	#region Setters
	/// @static
	/// @param {number} _frame
	/// @param {function} callback
	static SetFrameCallback = function( _frame = 0, callback ) {
		if ( !is_undefined( callback ) ) {
			self.frames[_frame][1] = callback;
		}
		else {
			show_error( $"Callback on {_frame} cannot be invoked, make sure it is defined!", true );
		}
	}
	
	/// @static
	/// @param {function} callback
	static SetAnimationEndCallback = function( _func = -1 ) {
		if ( self.animEndFunc != -1 ) {
			self.animEndFunc = _func;
		}
	}
	
	/// @static
	/// @param {number} anim_speed
	static SetAnimSpeed = function( anim_speed ) {
		self.animSpeed = anim_speed;
	}
	
	/// @static
	/// @param {number} type
	static SetAnimType = function( type ) {
		self.animType = type;
	}
	#endregion
	
	// Populating the frame array with all sprite frames
	static Init = function() {
		var _image_count = sprite_get_number( self.sprite );
		
		for( var i = 0; i < _image_count; ++i ) {
			self.frames[i] = [i, undefined];
		}
	}
	
	/// @static
	static OnAnimationSwitch = function() {
		self.currentIterations = 0;
	}
}