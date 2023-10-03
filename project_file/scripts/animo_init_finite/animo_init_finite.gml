/// @param		{sprite}	sprite
/// @param		{number}	_anim_spd
/// @param		{number}	_start_frame
function animo_init_finite( sprite, _anim_spd, _start_frame = 0 ) {
	if ( sprite_exists( sprite ) ) {
	    var animation = new cAnimo();
	    animation.sprite = sprite;
	    animation.Init();
	    animation.animType = ANIMO_TYPE.LOOPED;
	    animation.animSpeed = _anim_spd;
	    animation.animStartIndex = _start_frame;
	    
	    return animation;
	}
	else {
		show_error( "Animation is not a valid sprite!", true );
	}
}