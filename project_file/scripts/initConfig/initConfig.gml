// #macro APPDATA_PATH ( environment_get_variable( "APPDATA" ) + @"\squeal\" )
// #macro GAME_PATH ( IDE_MODE ? @"C:\Users\capnb\Projects and Modding\Projects\WIP\Squeal 2\" : ( program_directory + @"\" ) )

// #macro ROOT_PATH ( program_directory + @"\" )
// #macro DATA_PATH ( APPDATA_PATH + @"data\" )

// #macro CONFIG_PATH ( DATA_PATH + @"config\" )
// #macro RESOURCE_PATH ( DATA_PATH + @"resource\" )
// #macro SAVE_PATH ( DATA_PATH + @"save\" )

// #macro LANG_PATH ( RESOURCE_PATH + @"lang\" )
// #macro SFX_PATH ( RESOURCE_PATH + @"sfx\" )
// #macro MUSIC_PATH ( RESOURCE_PATH + @"music\" )

// print( "initializing game directories" );

// // 	#macro SFX_PATH ( GAME_PATH + @"Sounds\finished\" )

// // Init Game Config
// directory_create( APPDATA_PATH + "\\data\\" );
// directory_create( DATA_PATH + "\\resource\\" );
// directory_create( DATA_PATH + "\\config\\" );
// directory_create( CONFIG_PATH + "\\lang\\" );
// directory_create( RESOURCE_PATH + "\\sfx\\" );
// directory_create( RESOURCE_PATH + "\\music\\" );
directory_create( environment_get_variable( "APPDATA" ) + @"\.8xlib\" );

settings().AddConfig( "volume", "master", 100 );
settings().AddConfig( "volume", "music", 100 );
settings().AddConfig( "volume", "sfx", 100 );
settings().SaveConfig();