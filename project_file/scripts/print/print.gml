// Literally just a wrapper for the debug_message function to make it more useful
function print() {
	if ( argument_count > 0 ) {
		var _log = "", i = 0;
		
		for( var i = 0; i < argument_count; ++i ) {
			_log += string( argument[i] );
			
			if ( argument_count > 1 ) {
			    _log += " | ";
			}
		}
		show_debug_message( _log );
	}
} 