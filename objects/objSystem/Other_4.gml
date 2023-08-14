initSystem();

if ( !is_undefined( global.camera ) ) {
    view_set_camera( 0, global.camera.GetCamera() );
    view_set_visible( 0, true );
}