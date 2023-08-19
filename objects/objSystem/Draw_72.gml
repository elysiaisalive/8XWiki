if ( !is_undefined( global.camera ) ) {
    global.camera.Render();
    global.camera.SetFocusPosition( room_width / 2, room_height / 2 );
}