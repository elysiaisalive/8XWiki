/// @param		{sprite}	sprite
/// @param		{number}	anim_spd
/// @param		{number}	_start_frame
function animo_init_finite( sprite, anim_spd, _start_frame = 0 ) {
	if ( sprite_exists( sprite ) ) {
	    var animation = new cAnimation();
	    animation.sprite = sprite;
	    animation.Init();
	    animation.animType = ANIMO_TYPE.LOOPED;
	    animation.animSpd = anim_spd;
	    animation.animStartIndex = _start_frame;
	    
	    return animation;
	}
	else {
		show_error( "Animation is not a valid sprite!", true );
	}
}