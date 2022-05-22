@:structInit class Hitbox {
    public var top:Int;
    public var left:Int;
    public var bottom:Int;
    public var right:Int;
}

@:structInit class HitboxGroup {
    public var startFrame:Int = 0;
    public var duration:Int = 1;
    public var hitboxes:Array<Hitbox>;
}

@:structInit class ActionProperties {
    public var duration:Int;
    public var hitboxGroups:Array<HitboxGroup>;
}

@:structInit class CharacterProperties { 
    public var maxHealth:Int;
    public var actions:Array<ActionProperties>;
}

