#region FINITE STATE MACHINE
	#macro FSM_HISTORY_MAX 10

	function FiniteStateMachine() constructor {
		instance = other.id;
		states = new List();
		statesSize = 0;
		
		currentState = -1;
		nextState = -1;
		
		history = new List();
		parentsChain = -1;
		
		framesInState = 0;
		fixedFramesInState = 0;
		millisecondsInState = 0;
		timeOnStateBegin = current_time;
		
		spriteDirection = 0;
		timeFixedAnimation = true;
		
		
		#region FSM EVENTS
		
			// Call this method on the Step Begin Event of your instance
			static StepBeginEvent = function() {
				// If a new state is selected
				if ( currentState != -1 ) {
					for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).TransitionEvent();
					currentState.TransitionEvent();
				}
				
				if ( nextState != -1 ) {
					// Execute the state end event
					if ( currentState != -1 ) {
						for(var i=0; i<GetParentsChain(currentState.name).Size()-1; i++)	GetParentsChain(currentState.name).Get(i).StateEndEvent();
						currentState.StateEndEvent();
					}
					
					// Set the new state and call its State Begin Event
					var prevState = -1;
					if (currentState!=-1)
						prevState = currentState;
					
					do {
						//previousState = currentState;
						currentState = nextState;
						nextState = -1;
						
						parentsChain = GetParentsChain(currentState.name);
						for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).TransitionEvent();
						
						currentState.TransitionEvent();
					} until ( nextState == -1 );
					
					// Update the states history. If the size of the history exceeded we will pop.
					if (prevState!=-1) {
						history.Insert(0, prevState.name);
						if ( history.Size() > FSM_HISTORY_MAX && FSM_HISTORY_MAX != -1 ) {
							history.Remove(history.Size()-1);
						}
					}
						
					for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).StateBeginEvent();
					currentState.StateBeginEvent();
					
					// Reset the timers
					framesInState = 0;
					fixedFramesInState = 0;
					millisecondsInState = 0;
					timeOnStateBegin = current_time;
				} else {
					// Update the timers
					framesInState++;
					
					millisecondsInState = current_time - timeOnStateBegin;
				}
				
				if ( currentState == -1 ) return;
				
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).StepBeginEvent();
				currentState.StepBeginEvent();
			};
			
			// Call this method on the Step Event of your instance
			static StepEvent = function() {
				if ( currentState == -1 ) return;
				
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).StepEvent();
				currentState.StepEvent();
				
				if (is_array(currentState.sprite_index))
					instance.sprite_index = currentState.sprite_index[min(spriteDirection, array_length(currentState.sprite_index)-1)];
				else
					instance.sprite_index = currentState.sprite_index;
				instance.image_speed = Time.speed*currentState.image_speed;
			};
			
			static FixedStepEvent = function() {
				if ( currentState == -1 || ( nextState != -1 && fixedFramesInState != 0 ) ) return;
				
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).FixedStepEvent();
				currentState.FixedStepEvent();
				
				fixedFramesInState++;
			}
			
			// Call this method on the Step End Event of your instance
			static StepEndEvent = function() {
				if ( currentState == -1 ) return;
				
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).StepEndEvent();
				currentState.StepEndEvent();
			};
			
			// Call this method on the Draw Begin Event of your instance
			static DrawBeginEvent = function() {
				if ( currentState == -1 ) return;
				
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).DrawBeginEvent();
				currentState.DrawBeginEvent();
			};
			
			// Call this method on the Draw Event of your instance
			static DrawEvent = function() {
				if ( currentState == -1 ) return;
				
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).DrawEvent();
				currentState.DrawEvent();
			};
			
			// Call this method on the Draw End Event of your instance
			static DrawEndEvent = function() {
				if ( currentState == -1 ) return;
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).DrawEndEvent();
				currentState.DrawEndEvent();
			};
			
			// Call this method on the Draw GUI Begin Event of your instance
			static DrawGUIBeginEvent = function() {
				if ( currentState == -1 ) return;
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).DrawGUIBeginEvent();
				currentState.DrawGUIBeginEvent();
			};
			
			// Call this method on the Draw GUI Event of your instance
			static DrawGUIEvent = function() {
				if ( currentState == -1 ) return;
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).DrawGUIEvent();
				currentState.DrawGUIEvent();
			};
			
			// Call this method on the Draw GUI End Event of your instance
			static DrawGUIEndEvent = function() {
				if ( currentState == -1 ) return;
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).DrawGUIEndEvent();
				currentState.DrawGUIEndEvent();
			};
			
			// Call this method on the Animation End Event of your instance
			static AnimationEndEvent = function() {
				if ( currentState == -1 ) return;
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).AnimationEndEvent();
				currentState.AnimationEndEvent();
			};
			
			
			/* Dont think this will be needed
			// Call this method on the Draw Pre Event of your instance
			function DrawPreEvent() {
				if ( currentState == -1 ) return;
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).DrawPreEvent();
				currentState.DrawPreEvent();
			};
			
			// Call this method on the Draw Post Event of your instance
			function DrawPostEvent() {
				if ( currentState == -1 ) return;
				for(var i=0; i<parentsChain.Size()-1; i++)	parentsChain.Get(i).DrawPostEvent();
				currentState.DrawPostEvent();
			};
			*/
		
		#endregion
		
		#region FSM CONFIGURATION
		
			static CreateState = function(_name, _data = {}) {
				var state = GetState(_name);
				if (state==undefined) state = new FSMState(_name);
				state.fsm = self;
				state.instance = instance;
				RegisterState(state);
				
				var keys = variable_struct_get_names(_data);
				for(var i=0; i<array_length(keys); i++) {
					var varName = keys[i];
					if (is_method(_data[$ varName])) {
						state[$ varName] = method(instance, _data[$ varName]);
					} else {
						state[$ varName] = _data[$ varName];
					}
				}
			}
		
			// Add new event to the list.
			// You shall never call this function. It works automatically.
			static RegisterState = function(state) {
				states.Push(state);
				statesSize++;
				SetState(state.name);
			};
			
			static GetState = function(stateName) {
				for( var i=0 ; i<statesSize ; i++ )
					if ( states.Get(i).name == stateName )
					    return states.Get(i);
				return undefined;
			};
			
			static InState = function(stateName) {
				var parents = GetParentsChain(currentState.name);
				for(var i=0; i<parents.Size(); i++)
					if (parents.Get(i).name==stateName) return true;
					
				return false;
			}
			
			static GetCurrentState = function() {
				if (currentState!=-1)
					return currentState.name;
				else
					return "";
			};
			
			static GetPreviousState = function() {
				if (history.Size()>0) {
					return history.Tail();
				}
			}
		
			// Change the state
			static SetState = function(stateName) {
				if (currentState!=-1 && (stateName==currentState.name || !GetState(stateName))) return undefined;
				
				// Store the next State so we can change on the next frame
				nextState = GetState(stateName);
			};
			
			// Go back to the previous state
			static SetPreviousState = function() {
				if ( history.Size() ) {
					// Store the previous State so we can change on the next frame
					nextState = GetState(history.Get(history.Size()-1));
					
					// Update the states history
					history.Remove(0);
				}
			};
		
			// If for some reason you want to unregister a state you have this
			static UnregisterState = function(stateName) {
				var idx = states.Index(stateName);
				states.Remove(idx);
				statesSize--;
			};
			
			static GetParentsChain = function(stateName) {
				var chain = new List();
				var curr = GetState(stateName);
				chain.Insert(0, curr);
				
				while(curr.parent!=-1) {
					curr = GetState(curr.parent);
					chain.Insert(0, curr);
				}
				
				return chain;
			}
		
		#endregion
		
		CreateState("idle", {sprite_index : instance.sprite_index});
		SetState("idle");
	};

#endregion

#region STATE

	function FSMState(_name) constructor {
		// General
		name = _name;
		parent = -1;
		sprite_index = -1;
		image_speed = 1;
		animation_loop = true;
		
		// State Events
		TransitionEvent = function() {}
		StateBeginEvent = function() {};
		StateEndEvent = function() {};
		StepBeginEvent = function() {};
		StepEvent = function() {};
		FixedStepEvent = function() {};
		StepEndEvent = function() {};
		DrawBeginEvent = function() {};
		DrawEvent = function() {};
		DrawEndEvent = function() {};
		DrawGUIBeginEvent = function() {};
		DrawGUIEvent = function() {};
		DrawGUIEndEvent = function() {};
		//DrawPreEvent = function() {};
		//DrawPostEvent = function() {};
		AnimationEndEvent = function() {};
	};

#endregion