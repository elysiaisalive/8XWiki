/// @param		{sprite}	_animation
/// @param		{struct}	_end_animation
/// @param		{number}	_anim_spd
/// @param		{number}	_repeats
/// @param		{number}	_start_frame
function animation_init_chained( _animation, _end_animation, _anim_spd, _repeats = -1, _start_frame = 0 ) {
    var animation = new cAnimation();
    animation.animType = ANIMATION_TYPE.CHAINED;
    animation.sprite = _animation;
    animation.animSpd = _anim_spd;
    animation.animNext = _end_animation;
	animation.animRepeats = ( _repeats != -1 ) ? _repeats : 0;
    animation.animStartIndex = _start_frame;
    
    return animation;
}