import utest.Assert;

@:structInit class Hitbox {
    public var top:Int = 0;
    public var left:Int = 0;
    public var bottom:Int = 0;
    public var right:Int = 0;
}

@:structInit class HitboxGroup {
    public var startFrame:Int = 0;
    public var duration:Int = 1;
    public var hitboxes:Array<Hitbox> = [];

    public function isActiveOnFrame(frame:Int) {
        return (frame >= startFrame) && (frame < (startFrame + duration));
    }
}

@:structInit class ActionProperties {
    public var duration:Int = 0;
    public var vulnerableHitboxGroups:Array<HitboxGroup> = [];
    public var attackHitboxGroups:Array<HitboxGroup> = [];
}

@:structInit class CharacterProperties { 
    public var maxHealth:Int = 10000;
    public var actions:Array<ActionProperties> = [];
}

class CharacterDataTests extends utest.Test {
    function testHitboxGroupIsActiveOnFrame() {
        var hitboxGroup:HitboxGroup = {startFrame: 2, duration: 5}
        Assert.isTrue(hitboxGroup.isActiveOnFrame(2));
        Assert.isFalse(hitboxGroup.isActiveOnFrame(7));
        Assert.isFalse(hitboxGroup.isActiveOnFrame(1));
    }
}
