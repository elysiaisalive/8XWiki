globalvar __globFlags;
__globFlags = 0;

// Any flag after 4 should go up by powers of 2.
/* 
	Ex:
		FLAG = 8 << 0,
		FLAG2 = 16 << 0
*/

enum GLOBALFLAGS {
	IDE 			= 1 << 0,
	DBG_FPS			= 2 << 0,
}