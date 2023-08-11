function cCamera() constructor {
	static camID = 0;
	++camID;

	// Set the corresponding view to the camera ID and create a new camera.
	view_camera[camID] = camera_create();
	
	x = 0;
	y = 0;
	camAngle = 0;
}