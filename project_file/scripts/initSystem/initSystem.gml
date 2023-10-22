console();
resolution_manager();
event_handler();
gui();
gui().AddContainer();
gui().GetContainerByName( "newContainer" ).AddPanel();
gui().GetContainerByName( "newContainer" ).GetPanelByName( "newPanel" ).AddElement();