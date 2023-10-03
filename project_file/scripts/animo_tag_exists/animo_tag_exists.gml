/// @param {string} tag_key     The name of the asset tag as a string.
/// @returns {bool} Returns true if the tag exists in the global map, false if it does not
function animo_tag_exists( tag_key ) {
    var _lowercase_tag_key = string_lower( tag_key );
    
    if ( !is_undefined( global.__animoAnimationMap[$ _lowercase_tag_key] ) ) {
        return true;
    }
    else {
        return false;
    }
};