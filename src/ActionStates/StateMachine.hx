package actionStates;

import utest.Assert;

// Identifies common character states.
enum abstract CombatStateID(Int) to Int {
    var Standing;
    var Crouching;
    var WalkingForward;
    var WalkingBackwards;
    var Jump;
}

// A context is passed into the combat state callbacks.
class CombatStateContext {
    public var bTransition:Bool;
    public var nextState:CombatStateID;

    public function new(bTransition:Bool = false, nextState:CombatStateID = CombatStateID.Standing) {
        this.bTransition = bTransition;
        this.nextState = nextState;
    }
}

typedef CombatStateCallbacksArguments = {
    var ?onStart:CombatStateContext->Void;
    var ?onUpdate:CombatStateContext->Void;
    var ?onEnd:CombatStateContext->Void;
}

// Provides an interface for combat states to respond to various events
class CombatStateCallbacks {
    public var onStart:CombatStateContext->Void;
    public var onUpdate:CombatStateContext->Void;
    public var onEnd:CombatStateContext->Void;

    public function new(callbacks:CombatStateCallbacksArguments) {
        this.onStart = callbacks.onStart;
        this.onUpdate = callbacks.onUpdate;
        this.onEnd = callbacks.onEnd;
    }
}

// Stores the combat states used for a character.
class CombatStateRegistery {
    final MAX_STATES = 256;
    public var combatStates:haxe.ds.Vector<CombatStateCallbacks>;

    public function new() {
        combatStates = new haxe.ds.Vector(MAX_STATES);
    }

    public function registerCommonState(stateID:CombatStateID, stateCallbacks:CombatStateCallbacks) {
        combatStates[stateID] = stateCallbacks;
    }
}

// Runs and keeps track of a state machine
class CombatStateMachineProcessor {
    public var registry:CombatStateRegistery;
    public var currentState:CombatStateID;
    public var context:CombatStateContext;

    public function new(?context:CombatStateContext) {
        registry = new CombatStateRegistery();
        currentState = CombatStateID.Standing;
        this.context = context;
    }

    public function updateStateMachine() {
        if(context != null) {
            var state = registry.combatStates[currentState];
            if(state != null) {
                if(state.onUpdate != null) {
                    state.onUpdate(context);

                    // Perform a state transition when requested
                    if(context.bTransition) {
                        // Call the onEnd function of the previous state to do any cleanup required
                        if(state.onEnd != null) {
                            state.onEnd(context);
                        }

                        // Call the onStart function on the next state to do any setup required
                        var nextState = registry.combatStates[context.nextState];
                        if(nextState != null) {
                            if(nextState.onStart != null) {
                                nextState.onStart(context);
                            }
                        }

                        // Make sure the transition isn't performed more than once
                        context.bTransition = false;

                        // Make the next state current
                        currentState = context.nextState;
                    }
                }
            }
        }
    }
}

class StateMachineTests extends utest.Test {
    public function setupClass() {
        // Nothing for now
    }

    function testRegisteringCombatState() {
        var registry = new CombatStateRegistery();
        var testState = new CombatStateCallbacks({});
        Assert.isNull(registry.combatStates[0]);
        registry.registerCommonState(CombatStateID.Standing, testState);
        Assert.notNull(registry.combatStates[0]);
    }

    function testRunningStateUpdateOnStateMachineProcessor() {
        var testVar = false;
        var context = new CombatStateContext();
        var processor = new CombatStateMachineProcessor(context);
        var testState = new CombatStateCallbacks({
            onStart: null,
            onUpdate: function(_:CombatStateContext) {
                testVar = true;
            },
            onEnd: null
        });
        processor.registry.registerCommonState(CombatStateID.Standing, testState);
        processor.updateStateMachine();
        Assert.isTrue(testVar);
    }

    function testTransitioningFromOneCommonStateToAnother() {
        var testVar = false;
        var testVar2 = false;
        function standingOnUpdate(context:CombatStateContext) {
            context.bTransition = true;
            context.nextState = CombatStateID.Jump;
        }
        function standingOnEnd(context:CombatStateContext) {
            testVar = true;
        }
        function jumpOnStart(context:CombatStateContext) {
            testVar2 = true;
        }

        var context = new CombatStateContext();
        var processor = new CombatStateMachineProcessor(context);

        var standingCallbacks = new CombatStateCallbacks({
            onUpdate: standingOnUpdate,
            onEnd: standingOnEnd
        });
        var jumpCallbacks = new CombatStateCallbacks({
            onStart: jumpOnStart
        });

        processor.registry.registerCommonState(CombatStateID.Standing, standingCallbacks);
        processor.registry.registerCommonState(CombatStateID.Jump, jumpCallbacks);
        processor.updateStateMachine();

        // Test that the transition is finished
        Assert.isFalse(context.bTransition);

        // Test that the state machine correctly transitioned to the jump state
        Assert.equals(processor.currentState, CombatStateID.Jump);

        // Test to see if OnEnd was called on the previous state.
        Assert.isTrue(testVar);

        // Test to see if OnStart was called on the next state.
        Assert.isTrue(testVar2);
    }
}
