function cGUIController() constructor {
    elements = [];
}

function cGUIElement() constructor {
    label = "";
    category = "";
}

function cGUIElementText() : cGUIElement() constructor {}

/*

    Design idea:
        GUI Controller --- > stored in singleton / controller object
        
        GUI Elements are rendered by the controller and ticked by the controller.
        GUI Elements can have assigned labels and categories 


*/