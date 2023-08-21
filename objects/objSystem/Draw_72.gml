if ( !is_undefined( global.camera ) ) {
    global.camera.Render();
    global.camera.SetFocusPositionAligned( objGOAPGuy.x, objGOAPGuy.y, 0, 0 );
}