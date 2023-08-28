/// @param		{sprite}	_animation
/// @param		{number}	_anim_spd
/// @param		{number}	_repeats
/// @param		{number}	_start_frame	
function animation_init_looped( _animation, _anim_spd, _repeats = -1, _start_frame = 0 ) {
    var animation = new cAnimation();
    animation.animType = ANIMATION_TYPE.LOOPED;
    animation.sprite = _animation;
    animation.Init();
    animation.animSpd = _anim_spd;
	animation.animRepeats = ( _repeats != -1 ) ? 0 : _repeats;
    animation.animStartIndex = _start_frame;
    
    return animation;
}