package utils;

@:structInit class IntVector2D {
    public var x:Int = 0;
    public var y:Int = 0;

    public function add(other:IntVector2D) {
        x += other.x;
        y += other.y;
    }
}
