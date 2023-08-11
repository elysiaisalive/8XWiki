function initWindow() {
	switch( __WINDOW_MODE ) {
		case RES_MODE.FULLSCREEN:
			window_set_fullscreen( true );
			window_set_size( display_get_width(), display_get_height() );
			window_set_showborder( false );
			break;
		case RES_MODE.WINDOWED:
			window_set_fullscreen( false );
			window_set_size( display_get_width(), display_get_height() );
			window_set_position( 0, 0 );
			window_set_showborder( true );
			break;
		case RES_MODE.BORDERLESS:
			window_set_fullscreen( true );
			window_set_showborder( false );
			break;
	}
	
	__resManager.updateResolution = false;
}