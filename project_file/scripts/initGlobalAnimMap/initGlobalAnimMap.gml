function initGlobalAnimMap(){
	    globalvar __FRAME_ANIM_MAP;
	    __FRAME_ANIM_MAP = {
			// Populate this with structs for every tag.
	    	dummy:{
	    	    animations:{},
	    	},
	    }
    
	    show_debug_message( string( "\n# Init sprite Lookup Table #\n{0}\n", __FRAME_ANIM_MAP ) );
    
	    preinit_tagged_animations( "dummy" );


	//	!!!# MOVE ALL BELOW TO SEPARATE FILES#!!!

	/// @param      {string}        character_tag       The character TAG we will be loading to automatically populate its table entry with animations
	function preinit_tagged_animations( character_tag ) {
	    var _anim_array = tag_get_assets( character_tag );
	    var _char_string = string_lower( character_tag );
	    var _asset_arr = tag_get_asset_ids( character_tag, asset_sprite );

	    for( var i = 0; i < array_length( _asset_arr ); ++i ) {
	        var _asset_name = string_lower( sprite_get_name( _asset_arr[i] ) );

	        if ( string_pos( "spr" + "_" + _char_string + "_", _asset_name ) != -1 ) {
	            var _anim_key = string_replace_all( _asset_name, "spr" + "_" + _char_string + "_", "" );
	            var _sprite = _asset_arr[i];

	            // We initialize with 0 sprite speed for now, we can set these properties later manually.
	            __FRAME_ANIM_MAP[$ _char_string].animations[$ _anim_key] ??= animation_init_looped( _sprite, 0 );
	        }
	    }

	    print( string( "\n#Initialized New Tagged Assets With Tag [{1}] took {2}ms\n{0}\n#", __FRAME_ANIM_MAP[$ character_tag].animations, character_tag, ( get_timer() - timer ) / 1000 ) );
	}

	/// @param      {string}     character_key       The name of the character
	/// @param      {struct}     struct_ref          The animation struct to push to the animation table
	/// @param      {string}     animation_key       The animation key name to be referenced by other functions
	function add_animation_to_index( character_key, struct_ref, animation_key ) {
	    // Lowercasing the strings so we don't have to worry about retreiving undefined objects
	    var _char_key = string_lower( character_key );
	    var _anim_key = string_lower( animation_key );
    
	    __FRAME_ANIM_MAP[$ _char_key].animations[$ _anim_key] ??= struct_ref ?? FALLBACK_ANIMATION;
	}

	/* 
	    USAGE :
	        example 1;
	        When referencing an animation key from inside of a struct.
	        get_animation_from_index( character, currentItem.walk );
        
	        example 2;
	        Manually inputting animation key.
	        get_animation_from_index( character, "AnimationWalk" );
	*/
	/// @param      {string}     character_key       The name of the character
	/// @param      {string}     animation_key       The animation key name to be fetched
	/// @return     {struct}     Returns the animation struct found in the characters animation key
	function get_animation_from_index( character_key, animation_key ) {
	    // Lowercasing the strings so we don't have to worry about retreiving undefined objects
	    var _char_key = string_lower( character_key );
	    var _anim_key = string_lower( animation_key );
	    var _result = __FRAME_ANIM_MAP[$ _char_key].animations[$ _anim_key];
    
	    return _result;
	}

	/// @param      {string}     character_key          The name of the character
	/// @param      {string}     animation_key          The animation key name to be fetched
	/// @param      {struct}     properties_struct      Struct containing all the valid animation properties
	/// @returns    {struct}     Returns a reference to the modified animation struct
	function modify_animation_from_index( character_key, animation_key, properties_struct ) {
	    // Lowercasing the strings so we don't have to worry about retreiving undefined objects
	    var _char_key = string_lower( character_key );
	    var _anim_key = string_lower( animation_key );
	    var _anim_table = __FRAME_ANIM_MAP[$ _char_key].animations[$ _anim_key];
    
	    _anim_table.animType ??= variable_struct_get( properties_struct, "animType" );
	    _anim_table.animRepeats ??= variable_struct_get( properties_struct, "animRepeats" );
	    _anim_table.animNext ??= variable_struct_get( properties_struct, "animNext" );
	    _anim_table.animStartIndex ??= variable_struct_get( properties_struct, "animStartIndex" );
	    _anim_table.animSpd ??= variable_struct_get( properties_struct, "animSpd" );
    
	    return _anim_table;
	}

	function animation_exists( character_key, animation_key ) {
	   return __FRAME_ANIM_MAP[$ character_key].animations[$ animation_key] != -1;
	}
}