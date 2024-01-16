
// Basic settings
game_set_speed(120, gamespeed_fps);

#region COMPONENTS

    // Lists to manage the components
    components = new List();
    createdQueue = new List();
    destroyedQueue = new List();
    
    // Components creation
    input           = new InputManager();           #macro Input System.input
    console         = new ConsoleManager();         #macro Console System.console
    transition      = new TransitionManager();      #macro Transition System.transition
    time            = new TimeManager();            #macro Time System.time
    camera          = new CameraManager();          #macro Camera System.camera
    cinema          = new CinemaManager();          #macro Cinema System.cinema
    depthSorting    = new DepthSortingManager();    #macro DepthSorting System.depthSorting
    
#endregion

#macro PERSPECTIVE_FACTOR .5

spdTar = 1;


// gpu_set_ztestenable(true);
// gpu_set_zwriteenable(true);
// gpu_set_alphatestenable(true);
// gpu_set_blendenable(true);
// gpu_set_texrepeat(true);
// gpu_set_texfilter(false);