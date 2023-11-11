function cSurfaceChunkmap() constructor {
    chunkMap = [[]];
    chunkRows = 16;
    chunkHeight = 16;
    
    chunksWidth = 32;
    chunksHeight = 32;
    
    static InitMap = function() {
       for( var row = 0; row < chunkRows; ++row ) {
            chunkMap[row] = [];
            
            for( var col = 0; col < chunkHeight; ++col ) {
                chunkMap[row][col] = -1;
            }
        }
    }
    
    /// @param {surface} surface
    /// @param {int} ?row
    /// @param {int} ?column
    static AddSurface = function( surface, _row = -1, _column = -1 ) {
        if ( _row != -1
        && _column != -1 ) {
            chunkMap[_row, _column] = surface;
        }
        else {
           for( var row = 0; row < array_length( chunkMap ); ++row ) {
                for( var col = 0; col < array_length( chunkMap[1] ); ++col ) {
                    chunkMap[row, col] = surface;
                }
            }
        }
    }
    
    static UpdateChunks = function() {
       for( var row = 0; row < array_length( chunkMap ); ++row ) {
            for( var col = 0; col < array_length( chunkMap[1] ); ++col ) {
                if ( chunkMap[row, col] != -1 ) {
                    chunkMap[row, col].Tick();
                }
            }
        }
    }   
    
    static DrawChunks = function() {
       for( var row = 0; row < array_length( chunkMap ); ++row ) {
            for( var col = 0; col < array_length( chunkMap[1] ); ++col ) {
                if ( chunkMap[row, col] != -1 ) {
                    chunkMap[row, col].Draw();
                }
            }
        }
    }
    
    static DrawDebug = function() {
       for( var row = 0; row < array_length( chunkMap ); ++row ) {
            for( var col = 0; col < array_length( chunkMap[1] ); ++col ) {
                var _x1 = row * chunksWidth;
                var _y1 = col * chunksHeight;
                var _x2 = _x1 + chunksWidth;
                var _y2 = _y1 + chunksHeight;
                
                draw_set_color( chunkMap[row, col] != -1 ? c_lime : c_gray );
                draw_rectangle( _x1, _y1, _x2, _y2, chunkMap[row, col] != -1 ? true : false );
                draw_set_color( c_white );
            }
        }
    }
}