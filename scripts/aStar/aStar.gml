function aStarSearch( _start, _end ) {
    var cost = 0;
    var est_cost = 0;
    var f = 0;
    var open_list = [];
    var closed_list = [];
    
    array_push( open_list, _start );
    
    while( array_length( open_list ) > 0 ) {
        var lowIndex = 0;
        
        for( var i = 0; i < array_length( open_list ); ++i ) {
            if ( open_list[i].f < open_list[lowIndex].f ) {
                lowIndex = i;
            }
        }
        
        var currentNode = open_list[lowIndex];
    }
}