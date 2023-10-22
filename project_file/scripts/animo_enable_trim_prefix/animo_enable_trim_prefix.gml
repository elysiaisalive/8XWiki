function animo_enable_trim_prefix( state ) {
    if ( !is_bool( state ) ) {
        show_error( $"Argument must be boolean.", true );
    }
    
    __animoTrimPrefixesEnabled = state;
}