function cGOAPPlanner() constructor {
    
}

function cGOAPAgent() constructor {
    planner = undefined;
    availableActions = {};
    currentActions = undefined;
}

function cGOAPAction() constructor {
    cost = 0;
    target = undefined;
    
    // Array of booleans
    preconditions = {};
    effects = {};
    
    static SetCost = function( _cost = 0 ) {
        cost = _cost;
    } 
    
    static AddPrecondition = function( label, state ) {
        preconditions = new {
            label,
            state
        }
    }
    
    static AddEffect = function( label, state ) {
        effects = new {
            label,
            state
        }
    }
    
    static CheckPrecondition = function() {};
    
    // The code that will be run when the action is being executed by the planner
    // This should return true if the action performs successfully
    static Perform = function( _instance ) {};
    
    // Used to reset any values from the action
    static Reset = function() {};
}