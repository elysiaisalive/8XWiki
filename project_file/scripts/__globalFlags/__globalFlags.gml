function globalflags_set( _flags ) {
    __globFlags = _flags;
}

function globalflags_add( _flag ) {
    __globFlags |= _flag;
}

function globalflags_get( _flag ) {
    return __globFlags & _flag;
}

// Doesn't work
function globalflags_exists( _flag ) {
    if ( __globFlags & ~_flag ) {
        return false;
    }
    else {
        return true;
    }
}

function globalflags_clearflag( _flag ) {
    __globFlags &= ~_flag;
}

function globalflags_clearflags() {
    __globFlags = 0;
}