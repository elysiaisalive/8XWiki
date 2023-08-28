/* 
    Feel free to change these to your hearts content... if you understand what you are doing! Feel free to ask if you need help!
*/
 
/// @param {struct} animation   Struct reference to the animo animation. Recommend to use 'currentAnimation' or something similar.
/// @param {number} index       Image index variable to reference when drawing the animation frames.
/// @param {number} x
/// @param {number} y
function animo_draw_sprite( animation, index, x, y ) {
    if ( !is_struct( animation ) || !is_instanceof( animation, cAnimation ) ) {
        show_error( "Animation is not a valid Animo object!", true );
    }
    
    draw_sprite_ext( animation.sprite, animation.frames[index][0], x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha );
}