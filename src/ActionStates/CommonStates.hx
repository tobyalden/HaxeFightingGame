package actionStates;

class Standing {
    static public function onStart(context:StateMachine.CombatStateContext) {
        trace("Standing.onStart(context:StateMachine.CombatStateContext)");
    }

    static public function onUpdate(context:StateMachine.CombatStateContext) {
        trace("Standing.onUpdate(context:StateMachine.CombatStateContext)");

        //  Stop character movement on standing.
        if(context.physicsComponent != null) {
            context.physicsComponent.velocity.x = 0;
        }
        if(context.inputCommand.right) {
            context.bTransition = true;
            context.nextState = StateMachine.CombatStateID.WalkingForward;
        }
    }

    static public function onEnd(context:StateMachine.CombatStateContext) {
        trace("Standing.onEnd(context:StateMachine.CombatStateContext)");
    }
}

class WalkingForward {
    static public function onStart(context:StateMachine.CombatStateContext) {
        trace("WalkingForward.onStart(context:StateMachine.CombatStateContext)");
    }

    static public function onUpdate(context:StateMachine.CombatStateContext) {
        trace("WalkingForward.onUpdate(context:StateMachine.CombatStateContext)");

        //  Move the character right when the player presses right on the controller.
        if(context.physicsComponent != null) {
            context.physicsComponent.velocity.x = 2;
        }
        if(!context.inputCommand.right) {
            context.bTransition = true;
            context.nextState = StateMachine.CombatStateID.Standing;
        }
    }

    static public function onEnd(context:StateMachine.CombatStateContext) {
        trace("WalkingForward.onEnd(context:StateMachine.CombatStateContext)");
    }
}

class Crouching {
    static public function onStart(context:StateMachine.CombatStateContext) {
        trace("Crouching.onStart(context:StateMachine.CombatStateContext)");
    }

    static public function onUpdate(context:StateMachine.CombatStateContext) {
        trace("Crouching.onUpdate(context:StateMachine.CombatStateContext)");
    }

    static public function onEnd(context:StateMachine.CombatStateContext) {
        trace("Crouching.onEnd(context:StateMachine.CombatStateContext)");
    }
}
