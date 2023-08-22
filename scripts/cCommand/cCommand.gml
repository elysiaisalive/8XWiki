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