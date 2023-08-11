function initResolutionManager() {
	static sClass = new cResolutionManager();
	return sClass;
}

function cResolutionManager() constructor {
	totalCameras = 0;
	currentCamera = undefined;
	
	gameResWidth = __GAME_WIDTH;
	gameResHeight = __GAME_HEIGHT;
	
	windowResWidth = window_get_width();
	windowResHeight = window_get_height();
	
	displayCenterW = ( display_get_width() / 2 ) - ( window_get_width() / 2 );
	displayCenterH = ( display_get_height() / 2 ) - ( window_get_height() / 2 );
	
	aspectRatio = gameResWidth / gameResHeight;
	
	// Used for updating res and variables when a change to the game window is made e.x resizing
	updateResolution = false;
	
	static Tick = function() {
		if ( updateResolution ) {
			call_later( 10, time_source_units_frames, initWindow, false );
		}
	}
	
	/// @static
	/// @param {enum_tuple} mode
	static ChangeResMode = function( mode ) {
		__WINDOW_MODE = mode;
		updateResolution = true;
	}
}