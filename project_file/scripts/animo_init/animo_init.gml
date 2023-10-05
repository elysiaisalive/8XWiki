// You should be calling this function in the very beginning of your game.
function animo_init() {
	__animoMacros();
	
	show_debug_message( __animoWelcomeString );
	global.__animoAnimationMap = {};
}