@:structInit class InputCommand {
    public var up:Bool = false;
    public var down:Bool = false;
    public var left:Bool = false;
    public var right:Bool = false;
    public var attack:Bool = false;

    public function reset() {
        up = false;
        down = false;
        left = false;
        right = false;
        attack = false;
    }
}
