function cConsole() constructor {
    enabled = false;
    registeredCommands = {};

    consoleWidth = __resManager.windowWidth;
    consoleHeight = 64;
    consoleDefaultHeight = consoleHeight;
    consoleFullScreenHeight = 270 - 5;
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
    consoleOffScreenY = ( -__resManager.windowHeight / 8 ) - ( consoleFullScreenHeight );
    
    consoleRegex = "abcdefghijklmnopqrstuvwxyz-_+=<>.,/\|{}[]12345678910 ";
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
        var _welcome_str = string( "Welcome to {0}, Runtime Version {1}", game_project_name, GM_runtime_version );
        var _date_str = string( "Built On {0}/{1}/{2}", date_get_day( GM_build_date ), date_get_month( GM_build_date ), date_get_year( GM_build_date ) );
        var _compile_str = string( "Compiled with {0}", code_is_compiled() ? "YYC" : "VM" );
        
        RegisterDefaultCommands();
        PushMessage( _welcome_str, true );
        PushMessage( _date_str, true );
        PushMessage( _compile_str, true );
    }
    //
    
    static RegisterCommand = function( _command_struct = new cCommand() ) {
        registeredCommands[$ _command_struct.label] = _command_struct;
        
        show_debug_message( registeredCommands );
    };
    
    static RegisterDefaultCommands = function() {
        var help = new cCommand();
        help.label = "help";
        help.usageTip = "help <command_ref>   Prints a list of all available commands or the usage of a command.";
        help.SetArguments( "_command_ref" );
        help.func = function() {
            struct_foreach( registeredCommands, function( i ) {
                var _help_str = string( i.label + i.usageTip );
                
                PushMessage( _help_str, true );
            } );
        }
        
        RegisterCommand( help );
    }
    
    static SubmitCommand = function( command_string ) {
        // Execute command if it exists / has valid parameters, if not then throw an error in the console
    }
    
    static PushMessage = function( msg, ignore_history = false ) {
        /* 
            BUG:
                Filtered messages do not get pushed.
        */
        var _message = string_lower( msg );
        var _regex = string_split( consoleRegex, "" );
        var _filtered_msg = string( "" );
        
        for( var i = 1; i <= array_length( _message ); ++i ) {
            var _char = string_char_at( _message, i );
            
            if ( string_pos( _char, _regex ) > 0 ) {
                _filtered_msg += _char;
            }
        }
        
        if ( string_length( _message ) > 0 ) {
            if ( array_length( consoleLog ) < consoleMaxLog ) {
                array_push( consoleLog, _message );
                
                if ( !ignore_history ) {
                    array_push( consoleHistory, _message ); 
                }
            }
            else {
                // Shift the array if the log and history are full.
                array_shift( consoleLog );
                array_push( consoleLog, _message );
                
                if ( !ignore_history ) {
                    array_shift( consoleHistory );
                    array_push( consoleHistory, _message );
                }
            }
        }
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