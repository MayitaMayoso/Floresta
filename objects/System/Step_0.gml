
    if (Input.CheckPressed("Escape", "General")) game_end();
    if (Input.CheckPressed("Fullscreen", "General")) Camera.Fullscreen();
    if (Input.CheckPressed("Slowmo", "General")) spdTar = (spdTar==1)?(30/240):1;
    Time.speed = Approach(Time.speed, spdTar, .1);
    
    for(var i=0; i<components.Size(); i++) if components.Get(i).enabled components.Get(i).Step();
    
    // Fixed Step Event
    repeat(Time.wholeDelta)
        for(var i=0; i<components.Size(); i++) if components.Get(i).enabled components.Get(i).FixedStep();
        
    Time.InstancesFixedStep();