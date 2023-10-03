/// @desc Adds a new animation entry to the global map
/// @param {string} tag_key     The name of the asset tag as a string.
/// @returns {bool} Returns true if the addition succeeds.
function animo_init_tag( tag_key ) {
    var _lowercase_tag_key = string_lower( tag_key );
    
    if ( is_undefined( global.__animoAnimationMap[$ _lowercase_tag_key] ) ) {
        global.__animoAnimationMap[$ _lowercase_tag_key] = new cAnimoMapEntry();
        return true;
    }
    else {
        // If entry already exists, return
        show_debug_message( $"Entry {_lowercase_tag_key} already exists!" );
        return false;
    }
};