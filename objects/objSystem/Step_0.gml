__resManager.Update();

switch( keyboard_lastchar ) {
    case 0 :
        __resManager.ChangeResMode( RES_MODE.FULLSCREEN );
        break;    
    case 1 :
        __resManager.ChangeResMode( RES_MODE.WINDOWED );
        break;  
    case 2 :
        __resManager.ChangeResMode( RES_MODE.BORDERLESS );
        break;    
    case 3 :
        global.camera.ClearFocus();
        break;    
    case 4 :
        global.camera.SetFocusPositionAligned( mouse_x, mouse_y, 0, 0 );
        break;

}

if ( !is_undefined( global.camera ) ) {
    global.camera.Tick();
}