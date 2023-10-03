/// !!! Experimental and this might not stay in future versions !!!

/// @param {string} tag_key     The name of the asset tag as a string.
/// @param {string} animation_key   animation_key The name of the animation as a string.
function animo_modify( tag_key, animation_key, properties_struct ) {
    var _lowercase_tag_key = string_lower( tag_key );
    var _target_anim = animo_get_animation( tag_key, animation_key );
    
    _target_anim.animType = properties_struct[$ "animType"];
    _target_anim.animStartIndex = properties_struct[$ "animStartIndex"];
    _target_anim.animSpeed = properties_struct[$ "animSpeed"];
    _target_anim.animRepeats = properties_struct[$ "animRepeats"];
    _target_anim.animNext = properties_struct[$ "animNext"];
    
    return _target_anim;
}