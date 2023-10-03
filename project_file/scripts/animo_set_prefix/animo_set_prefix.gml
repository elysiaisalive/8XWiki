/// @desc This function is used to setup animo for your projects sprite prefixes. By default Animo will try to ignore 'spr_' and 'spr' prefixes.
/// @param {array} ?pattern
function animo_set_prefix( _pattern = [ "spr", "spr_" ] ) {
    __animoRegex = _pattern;
}