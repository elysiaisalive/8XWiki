function cConsole() constructor {
    enabled = false;
    registeredCommands = [];
    
    cursorPollRate = 60 / 30;
    cursorBlink = 0;
    
    typingField = "";
    typingAssistEnabled = false;
    
    static RegisterCommand = function( label, arguments, func ) {};
    
    static Tick = function() {
        // Replace with appropriate binding stuff for a project
        if ( keyboard_check_pressed( vk_tab ) ) {
            enabled = !enabled;
        }
        //
    };
}