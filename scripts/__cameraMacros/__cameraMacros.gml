enum RES_MODE {
	FULLSCREEN,
	WINDOWED,
	BORDERLESS
}

enum CAM_ALIGN {
	LEFT = 1 << 0,
	RIGHT = 2 << 0,
	TOP = 3 << 0,
	BOTTOM = 4 << 0,
	MIDDLE = 5 << 0
}

// enum CAM_ALIGN {
// 	LEFT,
// 	RIGHT,
// 	TOP,
// 	BOTTOM,
// 	MIDDLE
// }

#macro __MAX_CAMS 8
#macro __GAME_WIDTH 480
#macro __GAME_HEIGHT 270
#macro __CAM_DEBUG true

globalvar __WINDOW_MODE;
__WINDOW_MODE = RES_MODE.FULLSCREEN;