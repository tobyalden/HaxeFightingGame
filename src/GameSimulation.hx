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
        entityCount = 0;
        physicsComponents = [for (i in 0...10) new PhysicsComponent()];
    }

    private function physicsSystem() {
        for(physicsComponent in physicsComponents) {
            physicsComponent.position.add(physicsComponent.velocity);
            physicsComponent.velocity.add(physicsComponent.acceleration);
        }
    }

    public function updateGame() {
        physicsSystem();
        frameCount += 1;
    }
}