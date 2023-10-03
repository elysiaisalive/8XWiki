/// @desc Retrieves an animation from an entry in the global map and returns it.
/// @param {string} tag_key         The name of the asset tag as a string.
/// @param {string} animation_key   animation_key The name of the animation as a string.
/// @returns {struct} Returns the animation struct if it is retrieved
function animo_get_animation( tag_key, animation_key ) {
    var _lowercase_tag_key = string_lower( tag_key );
    
    if ( animo_animation_exists( _lowercase_tag_key, animation_key ) ) {
        return global.__animoAnimationMap[$ _lowercase_tag_key].animations[$ animation_key];
    }
    else {
        show_debug_message( $"Animo with key [{animation_key}] does not exist." );
        return;
    }
};