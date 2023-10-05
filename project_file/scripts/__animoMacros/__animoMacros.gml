global.__animoAnimationMap = {};

#macro __animoFallbackSprite __spr_animo_fallback

globalvar __animoRegex;
__animoRegex = ["spr_", "spr"];

enum ANIMO_TYPE {
    FINITE, // Will animate once and then return to the first frame
    LOOPED, // Will loop over and over
    PINGPONG, // Will hit the final frame before animating back to the first
    CHAINED, // Inputted animation will transition to a different one once it ends
}