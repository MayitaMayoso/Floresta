
menu = new MenuInstance();
global.selectedMenu = menu;

menu.AddChild(  new MenuInstance("Play",         function() { Transition.GoTo(rm_level); }  ));
menu.AddChild(  new MenuInstance("Online Game",  function() { Transition.GoTo(rm_main_menu); }    ));
menu.AddChild(  new MenuInstance("Settings",     function() { Transition.GoTo(rm_main_menu); }  ));
menu.AddChild(  new MenuInstance("Credits",      function() { Transition.GoTo(rm_main_menu); }  ));
menu.AddChild(  new MenuInstance("Exit",         function() { game_end(); }                         ));