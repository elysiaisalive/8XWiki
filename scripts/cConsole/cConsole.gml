function cConsole() constructor {
    enabled = false;
    registeredCommands = {};

    consoleWidth = __resManager.windowWidth;
    consoleHeight = 64;
    consoleDefaultHeight = consoleHeight;
    consoleFullScreenHeight = 270 - 5.1;
    consoleRevealSpd = 0.075;
    consoleX = 0;
    consoleY = 0;
    
    consoleMaxLog = 256;
    consoleLog = [];
    consoleMaxHistory = 64;
    consoleHistory = [];
    consoleHistorySelect = 0;
    
    // Drawing
    consoleOpacity = 1;
    consoleTextColour = #62beff;
    consoleBGColour = new Vector2( #272B33, #11131c );
    //consoleBGColour = #272B33;
    //consoleTypeFieldColour = consoleBGColour;
    consoleTypeFieldColour = consoleBGColour.x;
    consoleTypeFieldHighlightColour = #62beff;
    //
    
    consoleTextScale = 0.050;
    consoleOnscreenX = 0;
    consoleOnscreenY = 0;   
    consoleOffScreenX = 0;
    consoleOffScreenY = ( -__resManager.windowHeight / 16 ) - ( consoleFullScreenHeight );
    
    consoleRegex = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_+=<>.,/\|{}[]:12345678910 ";
    consoleSuggestions = [];
    
    cursorCharacter = "_";
    cursorBlinkTimer = new cTimer( 60 * 3, true );
    
    typingFieldHoveredChar = 0;
    typingFieldWidth = consoleWidth;
    typingFieldHeight = 4;
    typingFieldMaxLength = 1024;
    typingField = "";
    typingAssistEnabled = false;
    typingFieldX = 0;
    typingFieldY = consoleY + typingFieldHeight;
    
    // 
    consoleX = consoleOffScreenX;
    consoleY = consoleOffScreenY;
    
    Init();
    SetMaximize();
    
    // Hello World!
    static Init = function() {
        var _welcome_str = string( "--Welcome to {0}, Runtime Version {1}--", game_project_name, GM_runtime_version );
        var _date_str = string( "Built On {0}/{1}/{2}", date_get_day( GM_build_date ), date_get_month( GM_build_date ), date_get_year( GM_build_date ) );
        var _compile_str = string( "Compiled with {0}", code_is_compiled() ? "YYC" : "VM" );
        var _end_str = string( "---------------------------------------------------" );
        
        PushMessageExt( _welcome_str, true );
        PushMessageExt( _date_str, true );
        PushMessageExt( _compile_str, true );
        PushMessageExt( _end_str, true );
        
        RegisterDefaultCommands();
    }
    //
    
    /// @returns {array} [command_list] Returns an array of each command struct.
    static GetCommandList = function() {
        var _command_names = struct_get_names( registeredCommands );
        var _command_list = [];

        for( var i = 0; i < array_length( _command_names ); ++i ) {
            array_push( _command_list, struct_get( registeredCommands, _command_names[i] ) );
        }
        
        return _command_list;
    }
    
    static RegisterCommand = function( _command_struct = new cCommand() ) {
        registeredCommands[$ _command_struct.label] ??= _command_struct;
        
        PushMessageExt( string( "Registered New Command {0}", _command_struct.label ) );
    };
    
    static RegisterDefaultCommands = function() {
        var help = new cCommand();
        help.label = "help";
        help.usageTip = "help   <command_ref>   Prints out a list of every available command.";
        help.SetArguments( "<command_ref>" );
        help.Execute = function() {
            var _command_list = GetCommandList();
            var _help_str = "For more information about a specific command, type help <command_name>";

            PushMessageExt( "  ", true );
            PushMessageExt( _help_str, true );

            for( var i = 0; i < array_length( _command_list ); ++i ) {
                PushMessageExt( _command_list[i].usageTip, true );
            }
            
            _command_list = [];
        }  
        
        var playsound = new cCommand();
        playsound.label = "playsound";
        playsound.usageTip = "playsound     [sound], <pitch>    Plays a sound at a specified pitch.";
        playsound.SetArguments( "[sound]" );
        playsound.Execute = function() {};
        
        RegisterCommand( help );
        RegisterCommand();
    }
    
    /* 
        TODO: 
            Iterate over argument array and check for types
    */
    
    static VerifyCommand = function( command_key ) {
        var _command_list = struct_get_names( registeredCommands );
        var _command_key = string_lower( command_key );
        var _result = false;
        
        for( var i = 0; i < array_length( _command_list ); ++i ) {
            var _struct = struct_get( registeredCommands, _command_list[i] );
            
            if ( struct_exists( registeredCommands, command_key ) ) {
                _result = true;
            }
        }
        
        return _result;
    }
    
    static ExecuteCommand = function( command_key ) {
        var _args = [];
        var _converted_args = [];
        
        for( var i = 0; i < array_length( _args ); ++i ) {
            array_push( _converted_args, _args[i] );
        }
        
        registeredCommands[$ command_key].Execute();
    }
    
    static FilterString = function( str ) {
        var _string = string( str );
        var _regex = string_split( consoleRegex, "" );
        var _filtered_str = string( "" );
        
        for( var i = 1; i <= string_length( _string ); ++i ) {
            var _char = string_char_at( _string, i );
            
            if ( string_pos( _char, _regex ) > 1 ) {
                _filtered_str += _char;
            }
        }
        
        return string( _filtered_str );
    }
    
    static PushMessage = function( msg, ignore_history = false ) {
        var _filtered_msg = FilterString( msg );
        
        if ( string_length( _filtered_msg ) > 1 ) {
            if ( array_length( consoleLog ) < consoleMaxLog ) {
                array_push( consoleLog, _filtered_msg );
                
                if ( !ignore_history ) {
                    array_push( consoleHistory, _filtered_msg ); 
                }
            }
            else {
                // Shift the array if the log and history are full.
                array_shift( consoleLog );
                array_push( consoleLog, _filtered_msg );
                
                if ( !ignore_history ) {
                    array_shift( consoleHistory );
                    array_push( consoleHistory, _filtered_msg );
                }
            }
        }
        
        if ( VerifyCommand( _filtered_msg ) ) {
            ExecuteCommand( _filtered_msg );
        }
    }
    
    static PushMessageExt = function( msg, ignore_history = false ) {
        var _str = FilterString( msg );
        
        show_debug_message( _str );
        PushMessage( _str, true );
    }
    
    static SetMaximize = function() {
        consoleHeight = consoleFullScreenHeight;
    }  
    
    static SetMinimized = function() {
        consoleHeight = consoleDefaultHeight;
    }
    
    static Tick = function() {
        cursorBlinkTimer.Tick();
        
        // Replace with appropriate binding stuff for a project
        if ( keyboard_check_pressed( vk_tab ) ) {
            enabled = !enabled;
            typingField = "";
        }
        //
        
        if ( enabled ) {
            //
            if ( cursorBlinkTimer.GetTime() <= 0 ) { 
                cursorCharacter = "";
            }
            else {
                cursorCharacter = "_";
            }
            //
            
            // Getting last inputted messages
            if ( keyboard_check_pressed( vk_up ) ) {
                if ( array_length( consoleHistory ) > 0 ) {
                    var _str = string( consoleHistory[consoleHistorySelect] );
                    
                    typingField = _str;
                    ++consoleHistorySelect;
                    
                    // Trim duplicates when fetching history
                    consoleHistory = array_unique( consoleHistory );
                    
                    if ( consoleHistorySelect > array_length( consoleHistory ) - 1 ) {
                        consoleHistorySelect = 0;
                    }
                    
                    consoleHistorySelect = clamp( consoleHistorySelect, 0, consoleMaxHistory );
                }
            }
            
            if ( keyboard_check_pressed( vk_backspace ) ) {
                typingField = string_delete( typingField, string_length( typingField ), 1 );
            }
            
            if ( keyboard_check_pressed( vk_enter ) ) {
                PushMessage( typingField );
                consoleHistorySelect = 0;
                typingField = "";
            }
            
            consoleY = lerp( consoleY, consoleOnscreenY, consoleRevealSpd );
            typingFieldY = lerp( typingFieldY, consoleOnscreenY, consoleRevealSpd );
            
            // Stopping certain characters from being typed into the text field
            switch( keyboard_lastkey ) {
                case vk_up:
                case vk_down:
                case vk_left:
                case vk_right:
                case vk_escape:
                case vk_tab:
                case vk_alt:
                case vk_lalt:
                case vk_ralt:
                case vk_control:
                case vk_lcontrol:
                case vk_rcontrol:
                case vk_shift:
                case vk_lshift:
                case vk_rshift:
                case vk_backspace:
                case vk_enter:
                case vk_end:
                case vk_printscreen:
                case 91:// L Windows Key
                case 92:// R Windows Key
                case 20:// CAPS
                    return;
                    break;                
            }
            
            // Console Logic
            if ( keyboard_check_pressed( vk_anykey ) ) {
                typingField += string_lower( keyboard_lastchar );
            }
        }
        else {
            consoleY = lerp( consoleY, consoleOffScreenY, consoleRevealSpd );
            typingFieldY = lerp( typingFieldY, consoleOffScreenY, consoleRevealSpd );
        }
    };
    
    // For use in DRAW_GUI event
    static Draw = function() {
        display_set_gui_size( __GAME_WIDTH, __GAME_HEIGHT );
        //draw_set_color( consoleBGColour );
        //draw_rectangle_color( consoleX, consoleY, consoleX + consoleWidth, consoleY + consoleHeight, false );
        
        draw_set_alpha( consoleOpacity );
        
        // Using Vectors as color inputs
        draw_rectangle_color( consoleX, consoleY, consoleX + consoleWidth, consoleY + consoleHeight, consoleBGColour.x, consoleBGColour.y, consoleBGColour.x, consoleBGColour.y, false );
        
        // Highlight
        draw_set_color( consoleTypeFieldColour );
        draw_rectangle( consoleX, consoleY + consoleHeight, consoleX + typingFieldWidth, ( consoleY + consoleHeight ) + typingFieldHeight, false );
        
        draw_set_color( consoleTypeFieldHighlightColour );
        draw_rectangle( consoleX - 1, consoleY + consoleHeight, consoleX + consoleWidth, ( consoleY + consoleHeight ) + typingFieldHeight, true );
        
        // Drawing console messages
        draw_set_font( fntConsole );
        draw_set_halign( fa_left );
        draw_set_valign( fa_middle );
        
        draw_set_color( consoleTextColour );
        // Console History / Prints
        if ( array_length( consoleLog ) > 0 ) {
            for( var i = 0; i < array_length( consoleLog ); ++i ) {
                var _sep = 6;
                var _x = typingFieldX;
                var _y = ( typingFieldY + consoleHeight ) - typingFieldHeight - ( _sep * i );
                
                draw_text_transformed( _x, _y, string( consoleLog[ array_length( consoleLog ) - i - 1 ] ), consoleTextScale, consoleTextScale, 0 );
            }
        }
        
        // Typed Field
        draw_text_transformed( typingFieldX, ( typingFieldY + consoleHeight ) - ( typingFieldHeight - 6.5 ), string( ">" + typingField + cursorCharacter ), consoleTextScale, consoleTextScale, 0 );
        
        // Reset Drawing back to defaults
        draw_set_alpha( 1 );
        draw_set_valign( fa_top );
        draw_set_font( -1 );
        draw_set_color( c_white );
    }
}