function cCamera() constructor {
	// Increment the Cam ID for every new instance of the camera class
	camID = 0;
	position = new Vector3( 0, 0, -512 );

	// Set the corresponding view to the camera ID and create a new camera.
	view_camera[camID] = camera_create();
	camera = view_camera[camID];
	
	// Animation curves used for 'zoom' and 'shake' FX
	zoomCurve = undefined;
	shakeCurve = undefined;
	
	zoomLevel = 0;
	camAngle = 0;
	camZ = -256;
	camFov = 90;
	camAspectRatio = camera_get_view_width( camera ) / camera_get_view_height( camera );
	camVelocity = 0;
	
	var camX = camera_get_view_x( camera ) + camera_get_view_width( camera ) / 2;
	var camY = camera_get_view_y( camera ) + camera_get_view_height( camera ) / 2;
	
	projMatrix = matrix_build_projection_ortho( __GAME_WIDTH, __GAME_HEIGHT, 0, 2048 );
	viewMatrix = matrix_build_lookat( position.x, position.y, position.z, position.x, position.y, 0, -dsin( camAngle ), dcos( camAngle ), 0 );
	
	// The direction the camera will go based on velocity and other factors
	camDir = 0;
	
	camWidth = __GAME_WIDTH;
	camHeight = __GAME_HEIGHT;
	
	// Camera bound box size used for movement
	camBBoxSize = 32;
	
	focusPosition = undefined;
	
	static GetCamera = function() {
		return camera;
	}
	
	/// @static
	static ClearFocus = function() {
		focusPosition = undefined;
	}
	
	static SetCameraPosition = function( _x, _y, _z = 0 ) {
		position.x = _x;
		position.y = _y;
		position.z = _z;
	}
	
	/// @static
	/// @desc Sets a new focus position using a Vec2
	/// @param {number} x
	/// @param {number} y
	static SetFocusPosition = function( _x, _y, _z = 0 ) {
		focusPosition = new Vector3( _x, _y, _z );
	}
	
	static Tick = function() {
		if ( !is_undefined( focusPosition ) ) {
			position.x += sin( focusPosition.x ) * camVelocity;
			position.y -= cos( focusPosition.y ) * camVelocity;
		}
	}
	
	// For use in the draw_begin event
	static Render = function() {
		draw_clear( c_black );
		
		camera_set_view_size( camera, __GAME_WIDTH / 2, __GAME_HEIGHT / 2 );
		camera_set_view_pos( camera, position.x, position.y );
		
		camera_set_proj_mat( camera, projMatrix );
		camera_set_view_mat( camera, viewMatrix );
		
		camWidth = clamp( camWidth, __GAME_WIDTH / 2, __GAME_WIDTH );
		camHeight = clamp( camHeight, __GAME_HEIGHT / 2, __GAME_HEIGHT );
		
		camera_set_view_angle( camera, camAngle );
		camera_apply( camera );

		// audio_listener_position( global.camera_target.x, global.camera_target.y, 0 );
		// audio_listener_set_position( 0, camera_x, camera_y, 0 );
		// audio_listener_orientation( camera_x, camera_y, 0, -dsin( camera_angle ), dcos( camera_angle ), 0 );
		// gpu_set_zwriteenable(true);
		// gpu_set_ztestenable(false);
		// camera_set_view_mat(camera, matrix_build_lookat(camera_x, camera_y, -512, camera_x, camera_y, 0, -dsin(camera_angle), dcos(camera_angle), 0));
		// camera_set_proj_mat(camera, matrix_build_projection_ortho(camera_width, camera_height, 0, 2048));
		// camera_apply(camera);

		camera_apply( camera );
	}
	
	static DrawDebug = function() {
		if ( __CAM_DEBUG ) {
			draw_text( __resManager.displayCenterW, __resManager.displayCenterW, string( "Cam ID {0}", view_camera[0] ) );
			
			draw_rectangle( position.x, position.y, position.x + camera_get_view_width( camera ), position.y + camera_get_view_height( camera ), true );
		}
	}
}