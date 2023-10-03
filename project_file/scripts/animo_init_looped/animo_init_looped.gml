/// @param		{sprite}	sprite
/// @param		{number}	anim_spd
/// @param		{number}	_repeats
/// @param		{number}	_start_frame	
function animo_init_looped( sprite, _anim_spd, _repeats = -1, _start_frame = 0 ) {
	if ( sprite_exists( sprite ) ) {
	    var animation = new cAnimo();
	    animation.sprite = sprite;
	    animation.Init();
	    animation.animType = ANIMO_TYPE.LOOPED;
	    animation.animSpeed = _anim_spd;
		animation.animRepeats = ( _repeats != -1 ) ? 0 : _repeats;
	    animation.animStartIndex = _start_frame;
	    
	    return animation;
	}
	else {
		show_error( "Animation is not a valid sprite!", true );
	}
}