function cGUIController() constructor {
    elements = [];
    root = noone;
    focusedElement = noone;
}

function cGUIViewport() constructor {
    width = __GAME_WIDTH;
    height = __GAME_HEIGHT;
    aspectRatio = width / height;
    
    static SetViewportSize = function( _width = camera_get_view_width( 0 ), _height = camera_get_view_height( 0 ) ) {
        width = _width;
        height = _height;
        aspectRatio = width / height;
    }
}

function cGUIPanel() constructor {
    enum FGUI {
        VISIBLE = 1 << 0,
        ENABLED = 2 << 0
    }
    
    parent = noone;
    children = [];
}

function cGUIContainer() constructor {
    children = [];
}

function cGUIElement() constructor {
    label = "";// The 'name' of the element
    group = "";
    
    drawX = 0;
    drawY = 0;
}

/// @desc Text that will be displayed
function cGUIElementText() : cGUIElement() constructor {}

/*

    Design idea:
        GUI Controller --- > stored in singleton / controller object
        
        GUI Elements are rendered by the controller and ticked by the controller.
        GUI Elements can have assigned labels and categories 


*/