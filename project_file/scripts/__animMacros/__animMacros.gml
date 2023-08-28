#macro __animoAnimationMap {}

enum ANIMO_TYPE {
    FINITE, // Will animate once and then return to the first frame
    LOOPED, // Will loop over and over
    CHAINED, // Inputted animation will transition to a different one once it ends
}