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
    public function new() {}
}

// Provides an interface for combat states to respond to various events
class CombatStateCallbacks {
    public var onStart:CombatStateContext->Void;
    public var onUpdate:CombatStateContext->Void;
    public var onEnd:CombatStateContext->Void;

    public function new(
        ?onStart:CombatStateContext->Void,
        ?onUpdate:CombatStateContext->Void,
        ?onEnd:CombatStateContext->Void
    ) {
        this.onStart = onStart;
        this.onUpdate = onUpdate;
        this.onEnd = onEnd;
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
        var state = registry.combatStates[currentState];
        if(state != null) {
            if(state.onUpdate != null) {
                if(context != null) {
                    state.onUpdate(context);
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
        var testState = new CombatStateCallbacks();
        Assert.isNull(registry.combatStates[0]);
        registry.registerCommonState(CombatStateID.Standing, testState);
        Assert.notNull(registry.combatStates[0]);
    }

    function testRunningStateUpdateOnStateMachineProcessor() {
        var context = new CombatStateContext();
        var processor = new CombatStateMachineProcessor(context);
        var testVar = false;
        var testState = new CombatStateCallbacks(null, function(_:CombatStateContext) {
            testVar = true;
        });
        processor.registry.registerCommonState(CombatStateID.Standing, testState);
        processor.updateStateMachine();
        Assert.isTrue(testVar);
    }
}
