gui().AddContainer();
gui().AddContainer( "newContainer2" );
gui().GetContainerByName( "newContainer" ).AddPanel();
gui().GetContainerByName( "newContainer2" ).AddPanel( "newPanel2" );
gui().GetContainerByName( "newContainer" ).GetPanelByName( "newPanel" ).AddElement();
gui().GetContainerByName( "newContainer2" ).GetPanelByName( "newPanel2" ).AddElement();

settings().AddConfig( "volume", "master_volume", 0 );
settings().AddConfig( "volume", "music_volume", 0 );

settings().Edit( "volume", "master_volume", 100, 0, 100 );
settings().SaveConfig();

print( settings().config );