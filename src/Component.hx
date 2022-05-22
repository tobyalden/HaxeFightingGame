import utils.Math.IntVector2D;
import haxe.ds.Vector;
import hl.UI16;

@:structInit class PhysicsComponent {
    public var position:IntVector2D = {};
    public var velocity:IntVector2D = {};
    public var acceleration:IntVector2D = {};
}

@:structInit class HitEvent {
    public var attacker:UI16;
    public var defender:UI16;
}

inline final MAX_HIT_EVENTS_PER_ENTITY = 10;
class HitEventComponent {
    public var events:Vector<HitEvent>;
    public var eventCount:UI16;

    public function new() {
        events = new Vector<HitEvent>(MAX_HIT_EVENTS_PER_ENTITY);
        for(i in 0...events.length) {
            var event:HitEvent = {attacker: 0, defender: 0};
            events[i] = event;
        }
        eventCount = 0;
    }
}
