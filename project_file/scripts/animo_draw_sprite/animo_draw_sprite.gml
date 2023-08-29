/* 
    Feel free to change these to your hearts content... if you understand what you are doing! Feel free to ask if you need help!
*/
 
/// @param {number} scope               The object that the function will be scoped to.
/// @param {string} animo_struct_ref    Struct reference to the animo animation. Recommend to use 'currentAnimation' or something similar.
/// @param {string} variable_name       The variable that will be used for animating the animation.
/// @param {number} x
/// @param {number} y
function animo_draw_sprite( scope, animo_struct_ref, variable_name, x, y ) {
    if ( !is_string( animo_struct_ref ) ) {
        show_error( "Animation is not a valid Animo string!", true );
    }

    var index = scope[$ variable_name];
    
    draw_sprite_ext( scope[$ animo_struct_ref].sprite, scope[$ animo_struct_ref].frames[index][0], x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha );
}