/// @desc This function will initialize an entry in the global animo map and then auto-populate it with animations based on what sprites are tagged with the tag key.
/// @param {string} tag_key         The name of the asset tag as a string.
/// @param {number} ?_name_regex    Naming pattern to use
function animo_populate_by_tag( tag_key, _name_regex = __animoRegex ) {
    var _lowercase_tag_key = string_lower( tag_key );
    var _tagged_asset_array = tag_get_assets( _lowercase_tag_key );
    var _tagged_asset_ids = tag_get_asset_ids( _lowercase_tag_key, asset_sprite );

    animo_init_tag( _lowercase_tag_key );

    if ( is_undefined( tag_key ) 
    || !is_string( tag_key ) ) {
        show_error( "No asset tag defined", true );
    }
    
    /* 
        This can probably be done better but this will work for now. 
    */

    // Looping through every single asset with the character tag and intializing a generic animation
    for( var i = 0; i < array_length( _tagged_asset_array ); ++i ) {
        var _asset_name = sprite_get_name( _tagged_asset_ids[i] );
        var _animo_key = "";
        var _animo_sprite = -1;
        
        for ( var j = 0; j < array_length( __animoRegex ); ++j ) {
            var _regex_pattern = __animoRegex[j];
            
            if ( string_pos( _regex_pattern, _asset_name ) != -1 ) {
                _asset_name = string_replace_all( _asset_name, _regex_pattern, "" );
            }
        }

        _animo_key = string_lower( _asset_name );
        _animo_sprite = _tagged_asset_ids[i];
        
        // We initialize with 0 anim speed for now, we can set these properties later manually.
        global.__animoAnimationMap[$ _lowercase_tag_key].animations[$ _animo_key] = animo_init_looped( _animo_sprite, 0 );
        
    }

    var _ms = ( get_timer() / 1000 );
    show_debug_message( $"# Animo initialized animations from tag [{_lowercase_tag_key}] took {_ms}ms #" );
};