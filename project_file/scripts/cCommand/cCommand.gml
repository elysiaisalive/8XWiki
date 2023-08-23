function cCommand() constructor {
    // The prefix that is typed
    label = "command";
    shortHand = undefined;
    //
    
    // Arguments
    arguments = [];
    
    // Usage tip printed in console when used with the 'help' command
    usageTip = "If you're reading this, someone forgot something!";
    
    static SetArguments = function() {
        for( var i = 0; i < argument_count; ++i ) {
            array_push( arguments, argument[i] );
        };
    }
    static Execute = function(){};
}