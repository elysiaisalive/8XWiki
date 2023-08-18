if ( !is_undefined( global.camera ) ) {
    global.camera.DrawDebug();
    global.camera.Render();
}

draw_set_color( c_lime );

draw_rectangle( 0 + 32, 0 + 32, room_width - 32, room_height - 32, true );

draw_set_color( c_white );