
    // Call the create event of the new components
    for(var i=0; i<createdQueue.Size(); i++) {
        var componentId = createdQueue.Get(i);
        var idx = components.Index(componentId, "id");
        components.Get(idx).Create();
    }
    if (createdQueue.Size()) createdQueue.Clear();

    for(var i=0; i<components.Size(); i++) if components.Get(i).enabled components.Get(i).StepBegin();