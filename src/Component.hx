import utils.Math.IntVector2D;

@:structInit
class PhysicsComponent {
    public var position:IntVector2D = new IntVector2D();
    public var velocity:IntVector2D = new IntVector2D();
    public var acceleration:IntVector2D = new IntVector2D();
}
