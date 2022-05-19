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
        // Reset input to not held down before polling
        gameState.inputComponents[0].inputCommand.reset();

        var entity = gameState.physicsComponents[0];
        if(hxd.Key.isDown(hxd.Key.UP)) {
            gameState.inputComponents[0].inputCommand.up = true;
        }
        if(hxd.Key.isDown(hxd.Key.DOWN)) {
            gameState.inputComponents[0].inputCommand.down = true;
        }
        if(hxd.Key.isDown(hxd.Key.LEFT)) {
            gameState.inputComponents[0].inputCommand.left = true;
        }
        if(hxd.Key.isDown(hxd.Key.RIGHT)) {
            gameState.inputComponents[0].inputCommand.right = true;
        }

        GameSimulation.updateGame(gameState);

        graphics.clear();
        graphics.beginFill(0xEA8220);
        graphics.drawCircle(entity.position.x, entity.position.y, 50);
        graphics.endFill();
    }
}
