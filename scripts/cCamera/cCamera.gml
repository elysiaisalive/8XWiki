function cCamera() constructor {
	// Increment the Cam ID for every new instance of the camera class
	camID = 0;
	position = new Vector2( 0, 0 );

	// Set the corresponding view to the camera ID and create a new camera.
	view_camera[camID] = camera_create();
	
	// Animation curves used for 'zoom' and 'shake' FX
	zoomCurve = undefined;
	shakeCurve = undefined;
	
	zoomLevel = 0;
	camAngle = 0;
	camVelocity = 0;
	
	// The direction the camera will go based on velocity and other factors
	camDir = 0;
	
	camWidth = 0;
	camHeight = 0;
	
	// Camera bound box size used for movement
	camBBoxSize = 32;
	
	focusPosition = undefined;
	
	currentCam = view_camera[camID];
	camera_set_view_size( currentCam, __GAME_WIDTH, __GAME_HEIGHT );
	camera_set_view_pos( currentCam, position.x, position.y );
	camera_apply( currentCam );
	
	static Update = function() {
		if ( !is_undefined( focusPosition ) ) {
			// TODO: approach these coords based on speed and dir
			position.x += sin( focusPosition.x ) * camVelocity;
			position.y -= cos( focusPosition.y ) * camVelocity;
		}
	}
	
	/// @static
	static ClearFocus = function() {
		focusPosition = undefined;
	}
	
	/// @static
	/// @desc Sets a new focus position using a Vec2
	/// @param {number} x
	/// @param {number} y
	static SetFocusPosition = function( _x, _y ) {
		focusPosition = new Vector2( _x, _y );
	}
	
	static DrawDebug = function() {
		if ( __CAM_DEBUG ) {
			draw_text( __resManager.displayCenterW, __resManager.displayCenterW, string( "Cam ID {0}", view_camera[0] ) );
			
			draw_rectangle( position.x, position.y, camera_get_view_width( currentCam ), camera_get_view_height( currentCam ), true );
		}
	}
}