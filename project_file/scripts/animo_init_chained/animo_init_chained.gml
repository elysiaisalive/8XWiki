/// @param		{sprite}	sprite
/// @param		{struct}	end_animation
/// @param		{number}	anim_spd
/// @param		{number}	_repeats
/// @param		{number}	_start_frame
function animo_init_chained( sprite, end_animation, _anim_spd, _repeats = -1, _start_frame = 0 ) {
	if ( sprite_exists( sprite )
	&& is_struct( end_animation )
	&& is_instanceof( end_animation, cAnimo ) ) {
	    var animation = new cAnimo();
	    animation.sprite = sprite;
	    animation.Init();
	    animation.animType = ANIMO_TYPE.CHAINED;
	    animation.animSpeed = _anim_spd;
	    animation.animNext = end_animation;
		animation.animRepeats = ( _repeats != -1 ) ? _repeats : 0;
	    animation.animStartIndex = _start_frame;
	    
	    return animation;
	}
	else {
		show_error( "End Animation is not a valid animo animation!", true );
	}
}