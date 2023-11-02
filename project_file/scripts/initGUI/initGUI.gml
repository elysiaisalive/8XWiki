gui().AddContainer();
gui().AddContainer( "newContainer2" );
gui().GetContainerByName( "newContainer" ).AddPanel();
gui().GetContainerByName( "newContainer" ).AddPanel( "newPanel2" );
gui().GetContainerByName( "newContainer" ).GetPanelByName( "newPanel" ).AddElement();
gui().GetContainerByName( "newContainer" ).GetPanelByName( "newPanel" ).AddElement( "newElement2" );