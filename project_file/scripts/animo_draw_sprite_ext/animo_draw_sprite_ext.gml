/// @param {struct} animation   Struct reference to the animo animation. Recommend to use 'currentAnimation' or something similar.
/// @param {number} index       Image index variable to reference when drawing the animation frames.
/// @param {number} x
/// @param {number} y
/// @param {number} xScale
/// @param {number} yScale
/// @param {number} angle
/// @param {number} colour
/// @param {number} opacity
function animo_draw_sprite_ext( animation, index, x, y, xScale, yScale, angle, colour, opacity ) {
    if ( !is_struct( animation ) || !is_instanceof( animation, cAnimation ) ) {
        show_error( "Animation is not a valid Animo object!", true );
    }
    
    draw_sprite_ext( animation.sprite, animation.frames[index][0], x, y, xScale, yScale, angle, colour, opacity ); 
}