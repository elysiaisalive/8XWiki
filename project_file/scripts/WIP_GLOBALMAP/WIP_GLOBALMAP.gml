/// @desc This function will initialize an entry in the global animo map and then auto-populate it with animations based on what sprites are tagged with the tag key.
/// @param {string} tag_key         The name of the asset tag as a string.
/// @param {string} naming_prefix   Asset prefix rule 'spr_snakecased' or 'sprPascalCase'
/// @param {number} naming_rule     The enum of the naming rule to use. Naming rule enum is located at '__animoMacros'
function animo_map_init_from_tag( tag_key, naming_prefix, naming_rule ) {
    var _lowercase_tag_key = string_lower( tag_key );
    var _tagged_asset_array = tag_get_assets( _lowercase_tag_key );
    var _tagged_asset_ids = tag_get_asset_ids( _lowercase_tag_key, asset_sprite );

    animo_map_add_entry( _lowercase_tag_key );

    if ( is_undefined( tag_key ) || !is_string( tag_key ) ) {
        show_error( "No asset tag defined", true );
    }
    
    if ( is_undefined( naming_prefix ) || !is_string( naming_prefix ) ) {
        show_error( "No naming prefix defined", true );
    }  
    
    if ( is_undefined( naming_rule ) ) {
        show_error( "No naming rule defined", true );
    }

    // Looping through every single asset with the character tag and intializing a generic animation
    for( var i = 0; i < array_length( _tagged_asset_array ); ++i ) {
        var _asset_name = sprite_get_name( _tagged_asset_ids[i] );
        var _animo_key = "";
        var _sprite = -1;
        var _sprite_name_rule = "";

        /* TODO:
        
            Find a way to just get the sprite action name. spr_TAG_ACTION
        
        */
        switch( naming_rule ) {
            case ANIMO_NAMING_RULES.SNAKE_CASE:
                _sprite_name_rule = naming_prefix + tag_key + "_";
            
                if ( string_pos( _sprite_name_rule, _asset_name ) != -1 ) {
                    _animo_key = string_replace_all( _asset_name, _sprite_name_rule, "" );
                    //_animo_key = string_replace_all( _asset_name, _asset_name, tag_key );
                }
                break;            
            case ANIMO_NAMING_RULES.CAMEL_CASE:
                _sprite_name_rule = naming_prefix + tag_key;
            
                if ( string_pos( _sprite_name_rule, _asset_name ) != -1 ) {
                    _animo_key = string_replace_all( _asset_name, _sprite_name_rule, "" );
                }
                break;            
            case ANIMO_NAMING_RULES.PASCAL_CASE:
                _sprite_name_rule = naming_prefix + tag_key;
            
                if ( string_pos( _sprite_name_rule, _asset_name ) != -1 ) {
                    _animo_key = string_replace_all( _asset_name, _sprite_name_rule, "" );
                }
                break;
        }
        
        _sprite = _tagged_asset_ids[i];
        
        // We initialize with 0 anim speed for now, we can set these properties later manually.
        global.__animoAnimationMap[$ _lowercase_tag_key].animations[$ _animo_key] = animo_init_looped( _sprite, 0 );
        
    }

    var _ms = ( get_timer() / 1000 );
    console().PrintExt( $"\nAnimo initialized animations from tag [{_lowercase_tag_key}] took {_ms}ms" );
}

function animo_map_add_entry( tag_key ) {
    var _lowercase_tag_key = string_lower( tag_key );
    
    if ( is_undefined( global.__animoAnimationMap[$ _lowercase_tag_key] ) ) {
        global.__animoAnimationMap[$ _lowercase_tag_key] = new cAnimoMapEntry();
    }
    else {
        // If entry already exists, return
        return;
        console().PrintExt( $"Entry {_lowercase_tag_key} already exists!" );
    }
};

/// @desc Retrieves an animation from an entry in the global map and returns it.
/// @param {string} tag_key     The name of the asset tag as a string.
/// @param {string} animation_key
function animo_map_get_animation( tag_key, animation_key ) {
    var _lowercase_tag_key = string_lower( tag_key );
    
    if ( animo_map_animation_exists( _lowercase_tag_key, animation_key ) ) {
        return global.__animoAnimationMap[$ _lowercase_tag_key].animations[$ animation_key];
    }
    else {
        show_error( string( $"Animo with key [{animation_key}] does not exist." ), true );
    }
}

/// @param {string} tag_key     The name of the asset tag as a string.
/// @param {string} animation_key
function animo_map_animation_exists( tag_key, animation_key ) {
    var _lowercase_tag_key = string_lower( tag_key );
    
    if ( !is_undefined( global.__animoAnimationMap[$ _lowercase_tag_key] ) ) {
        if ( struct_exists( global.__animoAnimationMap[$ _lowercase_tag_key], "animations" ) ) {
            var _animation_data = global.__animoAnimationMap[$ _lowercase_tag_key].animations;
            
            if ( !is_undefined( _animation_data[$ animation_key] ) ) {
                return true;
            }
        }
    }
    else {
        return false;
    }
}
 
/// --------------IDK ABOUT THIS ONE
/// @param {struct} _map        The animation map to use, defaults to animo's predefined map from script '__animoMacros'
/// @param {string} tag_key     The name of the asset tag as a string.
function animo_modify_from_map( _map = global.__animoAnimationMap, tag_key, animation_key, properties_struct ) {
    // Lowercasing the strings so we don't have to worry about retreiving undefined objects
    var _lowercase_tag_key = string_lower( tag_key );
    var _target_anim = get_animation_from_index( tag_key, animation_key );
    
    _target_anim.animType = properties_struct[$ "animType"];
    _target_anim.animStartIndex = properties_struct[$ "animStartIndex"];
    _target_anim.animSpeed = properties_struct[$ "animSpeed"];
    _target_anim.animRepeats = properties_struct[$ "animRepeats"];
    _target_anim.animNext = properties_struct[$ "animNext"];
    
    return _target_anim;
}