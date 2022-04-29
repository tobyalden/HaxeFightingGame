import utils.Math.IntVector2D;
import haxe.ds.Vector;

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
    public var physicsComponents:Vector<PhysicsComponent>;

    public function new() {
        frameCount = 0;
        entityCount = 5;
        physicsComponents = new Vector(10);
        for(i in 0...physicsComponents.length) {
            physicsComponents[i] = new PhysicsComponent();
        }
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

function updateGame(gameState:GameState) {
    physicsSystem(gameState);
    gameState.frameCount += 1;
}
