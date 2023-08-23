#macro __FRAME_VER "0.0.1 Dev"
#macro __FRAME_DBG false
#macro __FRAME_MAXITERATIONS 256 // Maximum allowed iterations for looped or chained animations

enum ANIMATION_TYPE {
    FINITE, // Will animate once and then return to the first frame
    LOOPED, // Will loop over and over
    CHAINED, // Inputted animation will transition to a different one once it ends
}