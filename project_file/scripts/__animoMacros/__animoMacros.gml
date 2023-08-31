global.__animoAnimationMap = {};

globalvar __animoFallbackSprite;
__animoFallbackSprite = sprGuy;

enum ANIMO_TYPE {
    FINITE, // Will animate once and then return to the first frame
    LOOPED, // Will loop over and over
    CHAINED, // Inputted animation will transition to a different one once it ends
}

enum ANIMO_NAMING_RULES {
    SNAKE_CASE,         // sprite_one
    CAMEL_CASE,         // spriteOne
    PASCAL_CASE,        // SpriteOne
}