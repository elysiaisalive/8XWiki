gui().AddContainer();
gui().AddContainer( "newContainer2" );
gui().GetContainerByName( "newContainer" ).AddPanel();
gui().GetContainerByName( "newContainer2" ).AddPanel( "newPanel2" );
gui().GetContainerByName( "newContainer" ).GetPanelByName( "newPanel" ).AddElement();
gui().GetContainerByName( "newContainer2" ).GetPanelByName( "newPanel2" ).AddElement();