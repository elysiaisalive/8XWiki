function initEventHandler() {
	static sClass = new cEventHandler();
	return sClass;
}

/* 
	USAGE :
		Call the function 'initEventHandler()' to instantiate the event handler object.
		Use the 'eventhandler_x' functions in order to subscribe and publish to the event handler.
*/
function cEventHandler() constructor {
    event_struct = {};
    
    // ID, Event ID and callback to run when an event is recieved
    static Subscribe = function( _id, _event_id, _func ) {
        if ( is_undefined( event_struct[$ _event_id] ) ) {
            event_struct[$ _event_id] = [];
        }
        else if ( IsSubscribed( _id, _event_id ) ) {
            return false;
        }
        
        // Pushing the event to the event struct, along with an array containing the events ID and Function
        array_push( event_struct[$ _event_id], [_id, _func] );
    }
    
    // Function for firing an event
    static Publish = function( _event_id, _data ) {
        var _sub_array = event_struct[$ _event_id];
        
        // If the event struct / array doesn't exist then return false and don't publish anything.
        if ( !is_undefined( _sub_array ) ) {
	        for( var i = ( array_length( _sub_array ) - 1 ); i >= 0; --i ) {
	            // Looping through the sub list and running the function on each sub
	            if ( instance_exists( _sub_array[i][0] ) ) {
	                print( $"Published : {i}" );
	                _sub_array[i][1]( _data );
	            }
	            else {
	                // Delete the function from the sub
	                array_delete( _sub_array, i, 1 );
	            }
	        }
        }
        else {
        	return false;
        }
    }
    
    static Unsubscribe = function( _event_id, _event ) {
        if ( !is_undefined( event_struct[$ _event_id] ) ) {
            var _pos = IsSubscribed( _event_id, _event );
            
            if ( _pos != -1 ) {
                array_delete( event_struct[$ _event], _pos, 1 );
            }
        }
        else {
            return false;
        }
    }  
    
    static UnsubscribeAll = function( _id ) {
		var _keys_arr = variable_struct_get_names( event_struct );
		
		for ( var i = ( array_length( _keys_arr ) - 1 ); i >= 0; --i ) {
			Unsubscribe( _id, _keys_arr[i] );
		}
    }
    
    static IsSubscribed = function( _id, _event_id ) {
        for( var i = 0; i < array_length( event_struct[$ _event_id] ); ++i ) {
            // If the item in the event struct matches the ID we are looking for, return it.
            if ( event_struct[$ _event_id][i][0] == _id ) {
                return i;
            }
        }
        
        return false;
    }
}

function eventhandler_subscribe( _id, _event_id, _func ) {
	event_handler().Subscribe( _id, _event_id, _func );
}

function eventhandler_publish( _event_id, _data = -1 ) {
       event_handler().Publish( _event_id, _data );
}

function eventhandler_unsubscribe( _id, _event_id ) {
	event_handler().Unsubscribe( _id, _event_id );
}

function eventhandler_unsubscribe_all( _id ) {
	event_handler().UnsubscribeAll( _id );
}

function test_eventhandler( _id ) {
    show_debug_message( "Running Test..." );

    eventhandler_subscribe( _id, "TestEvent", function() {
        show_debug_message( "Subscribed event!" );
    } );
    
    eventhandler_publish( "TestEvent", function() {
        show_debug_message( "This is an event." );
    } );
}

