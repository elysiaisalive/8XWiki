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

function astar_grid_create( cell_w, cell_h, w, h ) {
    var _grid = ds_grid_create( w, h );
    
    for( var i = 0; i < w ) {
        ds_grid_set( _grid, i, i, cell_w );
        
        for( var i = 0; i < h ) {
            ds_grid_set( _grid, i, i, cell_h );
        }
    }
    
    return _grid;
};

function aStarGraph() constructor {
    self.cellW = 0;
    self.cellH = 0;
    self.graphW = 0;
    self.graphH = 0;
    self.x = 0;
    self.y = 0;
    self.graph = [];
}