/// @param      {string}        character_tag       The character TAG we will be loading to automatically populate its table entry with animations
function animo_init_tagged_animations( _table = global.__animoAnimationMap, tag_key ) {
    tag_key = string_lower( tag_key );
    var _tagged_asset_array = tag_get_assets( tag_key );
    var _tagged_asset_ids = tag_get_asset_ids( tag_key, asset_sprite );

    // Looping through every single asset with the character tag and intializing a generic animation
    for( var i = 0; i < array_length( _tagged_asset_array ); ++i ) {
        var _asset_name = string_lower( sprite_get_name( _tagged_asset_ids[i] ) );

        if ( string_pos( "spr" + "_" + tag_key + "_", _asset_name ) != -1 ) {
            var _animo_key = string_replace_all( _asset_name, "spr" + "_" + tag_key + "_", "" );
            var _sprite = _tagged_asset_ids[i];

            // We initialize with 0 anim speed for now, we can set these properties later manually.
            _table[$ tag_key].animations[$ _animo_key] ??= animo_init_looped( _sprite, 0 );
        }
    }

    print( string( "\nInitialized New Tagged Assets With Tag [{0}] took {1}ms", tag_key, ( get_timer() ) / 1000 ) );
}

function animo_map_add_entry( _map = global.__animoAnimationMap, tag_key ) {
    var _lowercase_tag_key = string_lower( tag_key );
    
    if ( is_undefined( _map[$ _lowercase_tag_key] ) ) {
        _map[$ _lowercase_tag_key] = new cAnimoMapEntry();
    }
    else {
        console().PrintExt( $"Entry {_lowercase_tag_key} already exists!" );
    }
};

function animo_map_add_to_entry( _map, tag_key, animo_struct ) {
    // var _lowercase_tag_key = string_lower( tag_key ); 
    // _map[$ _lowercase_tag_key].animations ??= animo_struct;
}

function animo_get_from_map(  _table = global.__animoAnimationMap, tag_key, animation_key ) {
    tag_key = string_lower( tag_key );
    animation_key = string_lower( animation_key );
    
    if ( animo_exists( _table, tag_key, animation_key ) ) {
        return _table[$ tag_key].animations[$ animation_key];
    }
    else {
        show_error( string( "Animo with key {0} does not exist.", tag_key ), true );
    }
}

function animo_modify_from_map( _table = global.__animoAnimationMap, tag_key, animation_key, properties_struct ) {
    // Lowercasing the strings so we don't have to worry about retreiving undefined objects
    tag_key = string_lower( tag_key );
    animation_key = string_lower( animation_key );
    var _target_anim = get_animation_from_index( tag_key, animation_key );
    
    _target_anim.animType = properties_struct[$ "animType"];
    _target_anim.animStartIndex = properties_struct[$ "animStartIndex"];
    _target_anim.animSpeed = properties_struct[$ "animSpeed"];
    _target_anim.animRepeats = properties_struct[$ "animRepeats"];
    _target_anim.animNext = properties_struct[$ "animNext"];
    
    return _target_anim;
}

function animo_exists(  _table = global.__animoAnimationMap, tag_key, animation_key ) {
    tag_key = string_lower( tag_key );
    animation_key = string_lower( animation_key );
    
    if ( !is_undefined( _table[$ tag_key] ) ) {
        if ( struct_exists( _table[$ tag_key], "animations" ) ) {
            var _animation_data = _table[$ tag_key].animations;
            
            if ( !is_undefined( _animation_data[$ animation_key] ) ) {
                return true;
            }
        }
    }
    else {
        return false;
    }
}