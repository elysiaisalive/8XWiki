function cConsole() constructor {
    enabled = false;
    registeredCommands = {};
    
    RegisterDefaultCommands();

    consoleWidth = __resManager.windowWidth;
    consoleHeight = 48;
    consoleRevealSpd = 1;
    consoleX = 0;
    consoleY = 0;
    
    consoleTimeStamp = get_timer();
    
    consoleHistoryEnabled = true;
    consoleCurrentLog = 0;
    consoleMaxLog = 256;
    consoleHistory = [];
    
    consoleTextScale = 0.050;
    consoleOnscreenX = 0;
    consoleOnscreenY = 0;   
    consoleOffScreenX = 0;
    consoleOffScreenY = -__resManager.windowHeight;
    
    consoleRegex = "abcdefghijklmnopqrstuvwxyz-_+=<>.,/\|{}[]12345678910 ";
    
    cursorCharacter = "_";
    cursorAlpha = 1;
    cursorBlinkTimer = new cTimer( 60 * 3, true );
    
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
    
    static RegisterCommand = function( _command_struct = new cCommand() ) {
        registeredCommands[$ _command_struct.label] = _command_struct;
        
        show_debug_message( registeredCommands );
    };
    
    static SubmitCommand = function( command_string ) {
        // Execute command if it exists / has valid parameters, if not then throw an error in the console
    }
    
    static PushMessage = function( msg = "" ) {
        var _message = string_lower( msg );
        var _regex = string_split( consoleRegex, "" );
        var _filtered_msg = "";
        
        for( var i = 0; i < array_length( _message ); ++i ) {
            if ( string_pos( _message[i], _regex ) != 0 ) {
                _filtered_msg += _message[i];
            }
        }
    
        if ( array_length( consoleHistory ) < consoleMaxLog ) {
            ++consoleCurrentLog;
            array_push( consoleHistory, _filtered_msg + "\n" );
        }
        else if ( array_length( consoleHistory ) >= consoleMaxLog ) {
            array_shift( consoleHistory );
            array_push( consoleHistory, _filtered_msg + "\n" );
        }
    }
    
    static Tick = function() {
        // Replace with appropriate binding stuff for a project
        if ( keyboard_check_pressed( vk_tab ) ) {
            enabled = !enabled;
        } 
        //
        
        if ( enabled ) {
            //
            cursorBlinkTimer.Tick();
            
            if ( cursorBlinkTimer.GetTime() <= 0 ) { 
                cursorCharacter = "";
            }
            else {
                cursorCharacter = "_";
            }
            //
            
            // Stopping certain characters from being typed into the text field
            switch( keyboard_lastkey ) {
                case vk_tab:
                case vk_alt:
                case vk_control:
                case vk_shift:
                case vk_lshift:
                case vk_rshift:
                    return false;
                    break;                
                // case vk_backspace:
                //     typingField = string_delete( typingField, string_length( typingField ), 1 );
                //     break;
            }
            
            if ( keyboard_check_pressed( vk_backspace ) ) {
                typingField = string_delete( typingField, string_length( typingField ), 1 );
            }   
            
            if ( keyboard_check_pressed( vk_anykey ) ) {
                typingField += keyboard_lastchar;
            }
            
            if ( keyboard_check_pressed( vk_enter ) ) {
                PushMessage( typingField );
                typingField = "";
            }
            
            // Console Logic
            typingField = string_lower( typingField );
            // typingField = string_insert( cursorCharacter, typingField, string_length( typingField ) - 1 );
            
            consoleY = lerp( consoleY, consoleOnscreenY, consoleRevealSpd );
            typingFieldY = lerp( typingFieldY, consoleOnscreenY, consoleRevealSpd );
        }
        else {
            consoleY = lerp( consoleY, consoleOffScreenY, consoleRevealSpd );
            typingFieldY = lerp( typingFieldY, consoleOffScreenY, consoleRevealSpd );
        }
    };
    
    // For use in DRAW_GUI event
    static Draw = function() {
        display_set_gui_size( __GAME_WIDTH, __GAME_HEIGHT );
        draw_set_color( c_black );
        draw_rectangle( consoleX, consoleY, consoleX + consoleWidth, consoleY + consoleHeight, false );
        
        // Highlight
        draw_set_color( c_black );
        draw_rectangle( consoleX, consoleY + consoleHeight, consoleX + typingFieldWidth, ( consoleY + consoleHeight ) + typingFieldHeight, false );
        
        draw_set_color( c_white );
        draw_rectangle( consoleX - 1, consoleY + consoleHeight, consoleX + consoleWidth, ( consoleY + consoleHeight ) + typingFieldHeight, true );
        
        // Drawing console messages
        draw_set_font( fntConsole );
        draw_set_halign( fa_left );
        draw_set_valign( fa_middle );
        
        // Console History / Prints
        if ( array_length( consoleHistory ) > 0 ) {
            for( var i = 0; i < array_length( consoleHistory ); ++i ) {
                var _sep = 4;
                var _x = typingFieldX;
                var _y = ( typingFieldY + consoleHeight ) - typingFieldHeight - ( _sep * i );
                
                draw_text_transformed( _x, _y, string( consoleHistory[ array_length( consoleHistory ) - i - 1 ] ), consoleTextScale, consoleTextScale, 0 );
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
    
    static RegisterDefaultCommands = function() {
        var _help = new cCommand();
        _help.label = "help";
        _help.usageTip = "help <command_ref>   Prints a list of all available commands or the usage of a command.";
        _help.SetArguments( "_command_ref" );
        
        RegisterCommand( _help );
    }
}

function cCommand() constructor {
    label = "command";
    shortHand = undefined;
    arguments = [];
    usageTip = "If you're reading this, someone forgot something!";
    
    static SetArguments = function() {
        for( var i = 0; i < argument_count; ++i ) {
            array_push( arguments, argument[i] );
        };
    }
    static func = function(){};
}

/* 
    BASIC IDEA:
        register command - >
            teleport() -- > arguments x, y, z. Optional arguments can be '~' so that they default to current position.
            Teleport args = instance ref, _x, _y, _z
            _arg < - underscore determines optional parameter
        basic structure of a command
        
        -LABEL-
        teleport[
            -ARGUMENTS-
            arguments[
            ]
            -FUNCTION-
            function
        ]
*/