/* 
    Feel free to change these to your hearts content... if you understand what you are doing! Feel free to ask if you need help!
*/
 
/// @param {struct} animation   Struct reference to the animo animation. Recommend to use 'currentAnimation' or something similar.
/// @param {number} scope           The object that the function will be scoped to.
/// @param {string} variableName    The variable that will be used for animating the animation.
/// @param {number} x
/// @param {number} y
function animo_draw_sprite( animation, scope, variableName, x, y ) {
    if ( !is_struct( animation ) || !is_instanceof( animation, cAnimo ) ) {
        show_error( "Animation is not a valid Animo object!", true );
    }
    
    scope[$ variableName] += animation.animSpeed;
    
    draw_sprite_ext( animation.sprite, animation.frames[scope[$ variableName]][0], x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha );
}