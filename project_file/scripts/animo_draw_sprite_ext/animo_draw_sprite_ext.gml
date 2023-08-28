/// @param {struct} animation           Struct reference to the animo animation. Recommend to use 'currentAnimation' or something similar.
/// @param {number} scope           The object that the function will be scoped to.
/// @param {string} variableName    The variable that will be used for animating the animation.
/// @param {number} x
/// @param {number} y
/// @param {number} xScale
/// @param {number} yScale
/// @param {number} angle
/// @param {number} colour
/// @param {number} opacity
function animo_draw_sprite_ext( animation, scope, variableName, x, y, xScale, yScale, angle, colour, opacity ) {
    if ( !is_struct( animation ) || !is_instanceof( animation, cAnimo ) ) {
        show_error( "Animation is not a valid Animo object!", true );
    }
    
    /* 
        Old: var index = scope[$ variableName] + animation.animSpeed;
        This is a temporary fix because for some reason it wont work how I want 
    */
    scope[$ variableName] += animation.animSpeed;
    
    draw_sprite_ext( animation.sprite, animation.frames[scope[$ variableName]][0], x, y, xScale, yScale, angle, colour, opacity ); 
}