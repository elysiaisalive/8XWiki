/* 
    Game config class. 
    
    Basic structure:
    
    config {
        category {
            setting:value
        }
    }
    
    Adding / Init new settings
    
    settings().AddConfig( category, label, value ) <- Auto-adds a category if none exist
    
    settings().Edit( 'vol', 'master', 5 ); <- Changes 'master' volume setting inside of 'vol' to 5.
    
    settings().SaveConfig( filename, ?path ) <- Serializes all settings data according to their values respective types and saves by default to appdata
    
*/
function settings() {
    static sClass = new cGameConfig();
    return sClass;
}

function cGameConfig() constructor {
    config = {};
    
    static AddConfig = function( category, name, value ) {
        var _category = new cConfigCategory();
        
        if ( is_undefined( config[$ category] ) ) {
            config[$ category] = _category;
        }
        
        config[$ category][$ name] = new cConfigOption();
        
        var _option_data = config[$ category][$ name];
        
        // Return the option so we can chain methods.
        return _option_data;
    }
    
    static Edit = function( category, name, new_value, new_min, new_max ) {
        var _config = config[$ category];
        
        _config[$ name].value = new_value;
        _config[$ name].valueMin = new_min;
        _config[$ name].valueMax = new_max;
    }
    
    static SaveConfig = function( _filename = "config.cfg", _path = working_directory ) {
        var _config_json = json_stringify( config );
        var _temp_buffer = buffer_create( 0, buffer_grow, 1 );
        
        try {
            buffer_write( _temp_buffer, buffer_string, _config_json );
            buffer_save( _temp_buffer, _filename );
            buffer_delete( _temp_buffer );
            
            show_debug_message( $"Save success! Saved :{_filename} at {_path}" );
        }
        catch(e) {
            show_debug_message( $"Failed to save :{_filename} at {_path}" );
        }
        
        return;
    }
}

function cConfigCategory() constructor {

}

function cConfigOption() constructor {
    value = 0;
    valueMin = 0;
    valueMax = 0;
}