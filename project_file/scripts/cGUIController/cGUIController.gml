/// @desc This function initializes the gui object!
function gui() {
    static guiPanel = new cGUI();
    return guiPanel;
}
 
function cGUI() constructor {
    containers = [];
    focusedElement = undefined;
    hoveredElement = undefined;
    mousePos = new Vector2( mouse_x, mouse_y );
    
    static Init = function(){};
    
    static Tick = function() {
        if ( mouse_x != mousePos.x 
        || mouse_y != mousePos.x ) {
            mousePos.x = mouse_x;
            mousePos.y = mouse_y;
        }
    }
    
    static DrawDebug = function() {
        var _offset = new Vector2( 0, 8 );
        
        draw_set_font( fntConsole );
        for( var i = 0; i < array_length( containers ); ++i ) {
            draw_text_transformed( 0, 0 + ( _offset.y * i ), $"{containers[i].label + "<-" + containers[i].children[i].label + "<-" + containers[i].children[i].children[i].label}", 0.05 * global.camera.camScale, 0.05 * global.camera.camScale, 0 );
        }
        draw_text_transformed( mousePos.x + _offset.x, mousePos.y + _offset.y, $"X:{mousePos.x}\nY:{mousePos.y}", 0.05 * global.camera.camScale, 0.05 * global.camera.camScale, 0 );
    }
    
    static AddContainer = function( _name = "newContainer" ) {
        var _container = new cGUIContainer();
        _container.label = _name;
        
        array_push( containers, _container );
        return _container;
    }
    
    static GetContainerByName = function( _name ) {
        var _name_string = string_lower( _name );
        var _result = false;
        
        for( var i = 0; i < array_length( containers ); ++i ) {
            var _target_name = string_lower( containers[i].label );
            
            // We only retrieve one instance ( because why would you be naming multiple containers the same thing ... )
            if ( _target_name == _name_string ) {
                _result = containers[i];
                break;
            }
        }
        
        return _result;
    }
}

/* 
    Basic GUI Idea ( Somewhat HTML adjacent )
    
    gui() <--- GUI Root is initialized. Similar to the 'document' in html.
    
    gui().AddContainer('Body'); <--- Adds a new container with the label 'body'
    
    The basic idea is that the GUI will have different 'containers' inside of it.
    Each container and by extension the elements are made accessible via respective Get() functions.
    
    the root gui instance is what will track mouse movement, what is hovered, etc.
    
    Accessor functions can be chained like this since they return what they find.▼▼▼▼▼
    
    gui().GetContainerByName();
    gui().GetContainerByName().GetPanelByName().GetElementByName();
    
    This would retrieve an array of elements within a named group. Useful cases would be a settings panel.
    Although you could also potentially just use a value to represent the current settings page, and change what elements are visible/active depending on that value
    
    gui().GetContainerByName().GetPanelByName().GetElementsByGroup();
    
    
    # This is the basic idea of the hierarchy.
    gui <- container <- panel <- element
    
    gui and container do not have positions or properties, they are simply data structures that hold other gui elements.
    
    Panels and Elements however, do have properties, positions and even functions.
    Element positions are always relative to their parent panel coordinates.
    
    This will now look like;
    gui------------------------
        container-------------------
            element(position,scale,rotation,colour)
        ----------------------------
        
        // EXAMPLE
        hud--------------------
            element_text( position, scale, rotation, number_to_track, colour )
        -----------------------
        
        Panels can also be embedded within another panel, so you could have pop-ups
        popupbutton-------------
            popup_button -> popup_panel.enable()
            popup_panel---------
                element_text( position, scale, rotation, number_to_track, colour )
            --------------------
        ------------------------
    ----------------------------
*/

function cGUIContainer() constructor {
    label = "";
    children = [];
    
    static AddPanel = function( _name = "newPanel" ) {
        var _panel = new cGUIPanel();
        _panel.label = _name;
        _panel.parent = self;
        
        array_push( children, _panel );
        return _panel;
    }
    
    static GetPanelByName = function( _name ) {
        var _name_string = string_lower( _name );
        var _result = false;
        
        for( var i = 0; i < array_length( children ); ++i ) {
            var _target_name = string_lower( children[i].label );
            
            if ( _target_name == _name_string ) {
                _result = children[i];
                break;
            }
        }
        
        return _result;
    }
}

function cGUIPanel() constructor {
    label = "";
    parent = noone;
    children = [];
    
    position = new Vector2( 0, 0 );
    
    static AddElement = function( _name = "newElement", _position = new Vector2( position.x + 0, position.y + 0 ) ) {
        var _element = new cGUIContainer();
        _element.label = _name;
        _element.parent = self;
        _element.position = _position;
        
        array_push( children, _element );
        return _element;
    }
}

function cGUIElement() constructor {
    label = "";// The 'name' of the element
    group = "";
    parent = noone;
    
    position = new Vector2( 0, 0 );
}

/// @desc Text that will be displayed
function cGUIElementText() : cGUIElement() constructor {}

/*

    Design idea:
        GUI Controller --- > stored in singleton / controller object
        
        GUI Elements are rendered by the controller and ticked by the controller.
        GUI Elements can have assigned labels and categories 


*/


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