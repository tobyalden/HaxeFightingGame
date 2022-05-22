import haxe.ds.Vector;

import utest.Assert;

@:structInit class InputComponent {
    public var inputCommand:Input.InputCommand = {};
}

@:structInit class StateMachineComponent {
    public var context:actionStates.StateMachine.CombatStateContext = {};
    public var stateMachine:actionStates.StateMachine.CombatStateMachineProcessor = {};
}

// For now our only test state is a global constant.
// Need to move this to somewhere where character specific data is stored.
var standingCallbacks:actionStates.StateMachine.CombatStateCallbacks = {
    onStart: actionStates.CommonStates.Standing.onStart,
    onUpdate: actionStates.CommonStates.Standing.onUpdate,
    onEnd: actionStates.CommonStates.Standing.onEnd
};

var walkingForwardCallbacks:actionStates.StateMachine.CombatStateCallbacks = {
    onStart: actionStates.CommonStates.WalkingForward.onStart,
    onUpdate: actionStates.CommonStates.WalkingForward.onUpdate,
    onEnd: actionStates.CommonStates.WalkingForward.onEnd
};

@:structInit class GameData {
    public var hitboxGroup:CharacterData.HitboxGroup;
}

function initializeGameData() {
    var gameData:GameData = {hitboxGroup: {hitboxes: []}};
    gameData.hitboxGroup.hitboxes.push({top: 200, left: 300, bottom: 0, right: 600});
    return gameData;
}

class GameState {
    public var frameCount:Int;
    public var entityCount:Int;
    public var physicsComponents:Vector<Component.PhysicsComponent>;
    public var stateMachineComponents:Vector<StateMachineComponent>;
    public var inputComponents:Vector<InputComponent>;
    public var gameData:GameData;

    public function new() {
        frameCount = 0;
        entityCount = 1;
        physicsComponents = new Vector<Component.PhysicsComponent>(10);
        for(i in 0...physicsComponents.length) {
            var physicsComponent:Component.PhysicsComponent = {};
            physicsComponents[i] = physicsComponent;
        }
        stateMachineComponents = new Vector<StateMachineComponent>(10);
        for(i in 0...stateMachineComponents.length) {
            var stateMachineComponent:StateMachineComponent = {};
            stateMachineComponents[i] = stateMachineComponent;
        }
        inputComponents = new Vector<InputComponent>(2);
        for(i in 0...inputComponents.length) {
            var inputComponent:InputComponent = {};
            inputComponents[i] = inputComponent;
        }

        // Game data initialization
        gameData = initializeGameData();

        // Testing initializing a single entity
        stateMachineComponents[0].context.physicsComponent = physicsComponents[0];
        stateMachineComponents[0].stateMachine.context = stateMachineComponents[0].context;
        stateMachineComponents[0].stateMachine.registry.registerCommonState(
            actionStates.StateMachine.CombatStateID.Standing, standingCallbacks
        );
        stateMachineComponents[0].stateMachine.registry.registerCommonState(
            actionStates.StateMachine.CombatStateID.WalkingForward, walkingForwardCallbacks
        );
    }
}

// Handles moving all entities which have a physics component
function physicsSystem(gameState:GameState) {
    for(entityIndex in 0...gameState.entityCount) {
        var component = gameState.physicsComponents[entityIndex];
        component.position.add(component.velocity);
        component.velocity.add(component.acceleration);
    }
}

function actionSystem(gameState:GameState) {
    for(entityIndex in 0...gameState.entityCount) {
        var component = gameState.stateMachineComponents[entityIndex];
        component.stateMachine.updateStateMachine();
    }
}

function inputCommandSystem(gameState:GameState) {
    gameState.stateMachineComponents[0].context.inputCommand = gameState.inputComponents[0].inputCommand;
}

function updateGame(gameState:GameState) {
    physicsSystem(gameState);
    actionSystem(gameState);
    inputCommandSystem(gameState);
    gameState.frameCount += 1;
}

class GameSimulationTests extends utest.Test {
    public function setupClass() {
        // Nothing for now
    }

    function testSettingUpGameData() {
        var gameData:GameData = {hitboxGroup: {hitboxes: []}};
        gameData.hitboxGroup.hitboxes.push({top: 200, left: -300, bottom: 0, right: 300});
        Assert.equals(gameData.hitboxGroup.hitboxes[0].right, 300);
    }
}
