function cCamera() constructor {
	// Increment the Cam ID for every new instance of the camera class
	static camID = 0;
	
	if ( camID < __MAX_CAMS ) {
		++camID;
	}
	else {
		show_debug_message( string( "\n#Error instancing Camera with ID {0} The maximum amount of cameras already exists#", camID ) );
		exit;
	}

	// Set the corresponding view to the camera ID and create a new camera.
	view_camera[camID] = camera_create();
	
	// Animation curves used for 'zoom' and 'shake' FX
	zoomCurve = undefined;
	shakeCurve = undefined;
	
	position = new Vector2( 0, 0 );
	camAngle = 0;
	camVelocity = 0;
	
	// Camera bound box size used for movement
	camBBoxSize = 32;
	
	focusPosition = 0;
	
	/// @static
	/// @desc Sets a new focus position using a Vec2
	/// @param {number} x
	/// @param {number} y
	static SetFocusPosition = function( _x, _y ) {
		focusPosition = new Vector2( _x, _y );
	}
	
	static DrawDebug = function() {
		if ( __CAM_DEBUG ) {
			
			draw_text( __resManager.displayCenterW, __resManager.displayCenterW, string( "Cam ID {0}", camID ) );
			
			draw_rectangle( 0, 0, 1920, 1080, true );
		}
	}
}