import utest.Runner;
import utest.ui.Report;

class Main extends hxd.App {
    private var gameState:GameSimulation.GameState;
    private var graphics:h2d.Graphics;

    override function init() {
        gameState = new GameSimulation.GameState();
        gameState.physicsComponents[0].position.x = 400;
        gameState.physicsComponents[0].position.y = 200;
        graphics = new h2d.Graphics(s2d);
    }
    
    static function main() {
        if(Sys.args().length > 0 && Sys.args()[0] == "test") {
            var runner = new Runner();
            runner.addCase(new actionStates.StateMachine.StateMachineTests());
            Report.create(runner);
            runner.run();
        }
        else {
            new Main();
        }
    }

    override function update(dt:Float) {
        var pressingLeft = hxd.Key.isDown(hxd.Key.LEFT);
        var pressingRight = hxd.Key.isDown(hxd.Key.RIGHT);

        var entity = gameState.physicsComponents[0];
        if(pressingLeft) {
            entity.velocity.x = -1;
        }
        else if(pressingRight) {
            entity.velocity.x = 1;
        }
        else {
            entity.velocity.x = 0;
        }

        GameSimulation.updateGame(gameState);

        graphics.clear();
        graphics.beginFill(0xEA8220);
        graphics.drawCircle(entity.position.x, entity.position.y, 50);
        graphics.endFill();
    }
}
