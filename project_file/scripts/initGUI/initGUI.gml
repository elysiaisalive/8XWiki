gui().AddContainer();
gui().AddContainer( "newContainer2" );
gui().GetContainerByName( "newContainer" ).AddPanel();

// Adds an embedded panel into 'newPanel'
gui().GetContainerByName( "newContainer" ).AddPanel( "newPanel" ).AddPanel();
// Adds an embedded element into 'embeddedPanel'
gui().GetContainerByName( "newContainer" ).GetPanelByName( "newPanel" ).GetPanelByName( "embeddedPanel" );

gui().GetContainerByName( "newContainer" ).GetPanelByName( "newPanel" ).AddElement();
gui().GetContainerByName( "newContainer" ).GetPanelByName( "newPanel" ).AddElement( "newElement2" );