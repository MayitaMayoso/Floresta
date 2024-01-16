
    for(var i=0; i<components.Size(); i++) if components.Get(i).enabled components.Get(i).StepEnd();

    // Destroy the queued objects
    for(var i=0; i<destroyedQueue.Size(); i++) {
        var componentId = destroyedQueue.Get(i);
        var idx = components.Index(componentId, "id");
        components.Get(idx).Destroy();
        components.Remove(idx);
    }
    if (destroyedQueue.Size()) destroyedQueue.Clear();