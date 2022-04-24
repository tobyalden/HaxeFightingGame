import utils.Math.IntVector2D;

class PhysicsComponent {
    public var position:IntVector2D;
    public var velocity:IntVector2D;
    public var acceleration:IntVector2D;

    public function new() {
        position = new IntVector2D();
        velocity = new IntVector2D();
        acceleration = new IntVector2D();
    }
}

class GameState {
    public var frameCount:Int;
    public var entityCount:Int;
    public var physicsComponents:Array<PhysicsComponent>;

    public function new() {
        frameCount = 0;
        entityCount = 5;
        physicsComponents = [for (i in 0...10) new PhysicsComponent()];
    }
}

function physicsSystem(gameState:GameState) {
    for(entityIndex in 0...gameState.entityCount) {
        var component = gameState.physicsComponents[entityIndex];
        component.position.add(component.velocity);
        component.velocity.add(component.acceleration);
    }
}

function updateGame(gameState:GameState) {
    physicsSystem(gameState);
    gameState.frameCount += 1;
}
