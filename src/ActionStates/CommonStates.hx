// May want to add an interface these implement?

class Standing {
    public function onStart() {
        trace("Standing.onStart()");
    }

    public function onUpdate() {
        trace("Standing.onUpdate()");
    }

    public function onEnd() {
        trace("Standing.onEnd()");
    }
}

class Crouching {
    public function onStart() {
        trace("Crouching.onStart()");
    }

    public function onUpdate() {
        trace("Crouching.onUpdate()");
    }

    public function onEnd() {
        trace("Crouching.onEnd()");
    }
}
