__resManager.Tick();

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

}