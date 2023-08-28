/// @param		{sprite}	_animation
/// @param		{number}	_anim_spd
/// @param		{number}	_start_frame
function animation_init_finite( _animation, _anim_spd, _start_frame = 0 ) {
    var animation = new cAnimation();
    animation.animType = ANIMATION_TYPE.FINITE;
    animation.sprite = _animation;
    animation.animSpd = _anim_spd;
    animation.animStartIndex = _start_frame;
    
    return animation;
}