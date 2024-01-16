function ConfigurationOfInputs() {
    // If there is a previous configuration load it and skip all these steps
    //if (!Input.Load()) exit;
        
    #region GENERAL CONTROLS
    
        Input.AddConfiguration("General");
        
        Input.AddInstance("Escape");
        Input.AddInstance("Fullscreen");
        Input.AddInstance("Console");
        Input.AddInstance("Slowmo");
        
        Input.AddKey("Escape", KEY.ESCAPE);
        
        Input.AddKey("Fullscreen", KEY.SELECT, 4);
        Input.AddKey("Fullscreen", KEY.F);
        
        Input.AddKey("Console", KEY.ALT_RIGHT);
        
        Input.AddKey("Slowmo", KEY.R);
        Input.AddKey("Slowmo", KEY.RIGHT_JOYSTICK_CLICK);
    
        /*
        Input.AddConfiguration("Menu");
        
        Input.AddInstance("Up");
        Input.AddInstance("Down");
        Input.AddInstance("Left");
        Input.AddInstance("Right");
        Input.AddInstance("Select");
        Input.AddInstance("Cancel");
        
        // Keyboard menu control
        Input.AddKey("Up", KEY.W);
        Input.AddKey("Down", KEY.S);
        Input.AddKey("Left", KEY.A);
        Input.AddKey("Right", KEY.D);
        
        Input.AddKey("Up", KEY.UP_ARROW);
        Input.AddKey("Down", KEY.DOWN_ARROW);
        Input.AddKey("Left", KEY.LEFT_ARROW);
        Input.AddKey("Right", KEY.RIGHT_ARROW);
        
        Input.AddKey("Select", KEY.ENTER);
        Input.AddKey("Cancel", KEY.ESCAPE);
        
        // Gamepad menu control
        for(var i=0; i<gamepad_get_device_count(); i++) {
            if (!gamepad_is_connected(i)) continue;
            Input.AddKey("Up", KEY.PAD_UP, i);
            Input.AddKey("Down", KEY.PAD_DOWN, i);
            Input.AddKey("Left", KEY.PAD_LEFT, i);
            Input.AddKey("Right", KEY.PAD_RIGHT, i);
            
            Input.AddKey("Up", KEY.LEFT_JOYSTICK_UP, i);
            Input.AddKey("Down", KEY.LEFT_JOYSTICK_DOWN, i);
            Input.AddKey("Left", KEY.LEFT_JOYSTICK_LEFT, i);
            Input.AddKey("Right", KEY.LEFT_JOYSTICK_RIGHT, i);
            
            Input.AddKey("Select", KEY.FACE1, i);
            Input.AddKey("Cancel", KEY.FACE3, i);
        }
        */
    
    #endregion
    
    #region CAMERA CONTROL
    
        /*
        Input.AddConfiguration("Camera");
        
        Input.AddInstance("Up");
        Input.AddInstance("Down");
        Input.AddInstance("Left");
        Input.AddInstance("Right");
        Input.AddInstance("Above");
        Input.AddInstance("Below");
        Input.AddInstance("ViewUp");
        Input.AddInstance("ViewDown");
        Input.AddInstance("ViewLeft");
        Input.AddInstance("ViewRight");
        
        Input.AddKey("Up", KEY.W);
        Input.AddKey("Down", KEY.S);
        Input.AddKey("Left", KEY.A);
        Input.AddKey("Right", KEY.D);
        Input.AddKey("Above", KEY.E);
        Input.AddKey("Below", KEY.Q);
        
        Input.AddKey("Up", KEY.LEFT_JOYSTICK_UP);
        Input.AddKey("Down", KEY.LEFT_JOYSTICK_DOWN);
        Input.AddKey("Left", KEY.LEFT_JOYSTICK_LEFT);
        Input.AddKey("Right", KEY.LEFT_JOYSTICK_RIGHT);
        Input.AddKey("Above", KEY.RIGHT_TRIGGER);
        Input.AddKey("Below", KEY.LEFT_TRIGGER);
        
        Input.AddKey("ViewUp", KEY.RIGHT_JOYSTICK_UP);
        Input.AddKey("ViewDown", KEY.RIGHT_JOYSTICK_DOWN);
        Input.AddKey("ViewLeft", KEY.RIGHT_JOYSTICK_LEFT);
        Input.AddKey("ViewRight", KEY.RIGHT_JOYSTICK_RIGHT);
        */
        
    #endregion
    
    #region GAME CONTROLS
        
        // Keyboard
        Input.AddConfiguration("Keyboard");
    
        Input.AddInstance("Up");
        Input.AddInstance("Down");
        Input.AddInstance("Left");
        Input.AddInstance("Right");
        
        Input.AddInstance("Roll");
        Input.AddInstance("Shoot");
        Input.AddInstance("GunThrow");
        Input.AddInstance("Grab");
        
        Input.AddInstance("GunUp");
        Input.AddInstance("GunDown");
        Input.AddInstance("GunLeft");
        Input.AddInstance("GunRight");
        Input.AddInstance("SwapGun");
		
        Input.AddInstance("Action");
        
        Input.AddKey("Up", KEY.W);
        Input.AddKey("Down", KEY.S);
        Input.AddKey("Left", KEY.A);
        Input.AddKey("Right", KEY.D);
        
        Input.AddKey("Roll", KEY.SPACE);
        Input.AddKey("Shoot", KEY.LEFT_CLICK);
        Input.AddKey("GunThrow", KEY.RIGHT_CLICK);
        Input.AddKey("Grab", KEY.E);
        Input.AddKey("Action", KEY.E);
        Input.AddKey("SwapGun", KEY.Q);
        
        var connected = 0;
        for(var i=0; i<gamepad_get_device_count(); i++) {
            if (!gamepad_is_connected(i)) continue;
            
            Input.AddConfiguration("Gamepad" + string(connected));
            
            connected++;
        
            Input.AddInstance("Up");
            Input.AddInstance("Down");
            Input.AddInstance("Left");
            Input.AddInstance("Right");
            
            Input.AddInstance("Roll");
            Input.AddInstance("Shoot");
            Input.AddInstance("GunThrow");
            Input.AddInstance("Grab");
            Input.AddInstance("SwapGun");
            
            Input.AddInstance("GunUp");
            Input.AddInstance("GunDown");
            Input.AddInstance("GunLeft");
            Input.AddInstance("GunRight");
            
            Input.AddKey("Up", KEY.PAD_UP, i);
            Input.AddKey("Down", KEY.PAD_DOWN, i);
            Input.AddKey("Left", KEY.PAD_LEFT, i);
            Input.AddKey("Right", KEY.PAD_RIGHT, i);
            
            Input.AddKey("Up", KEY.LEFT_JOYSTICK_UP, i);
            Input.AddKey("Down", KEY.LEFT_JOYSTICK_DOWN, i);
            Input.AddKey("Left", KEY.LEFT_JOYSTICK_LEFT, i);
            Input.AddKey("Right", KEY.LEFT_JOYSTICK_RIGHT, i);
            
            Input.AddKey("Roll", KEY.FACE1, i);
            Input.AddKey("Roll", KEY.LEFT_TRIGGER, i);
            Input.AddKey("Shoot", KEY.RIGHT_TRIGGER, i);
            Input.AddKey("GunThrow", KEY.RIGHT_SHOULDER, i);
            Input.AddKey("Grab", KEY.FACE2);
            
            Input.AddKey("GunUp", KEY.RIGHT_JOYSTICK_UP, i);
            Input.AddKey("GunDown", KEY.RIGHT_JOYSTICK_DOWN, i);
            Input.AddKey("GunLeft", KEY.RIGHT_JOYSTICK_LEFT, i);
            Input.AddKey("GunRight", KEY.RIGHT_JOYSTICK_RIGHT, i);
            
            break;
        }
    
    #endregion
    
    // Save all the profiles
    Input.Save();
}