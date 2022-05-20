import utest.Runner;
import utest.ui.Report;

class Main extends hxd.App {
    private var gameState:GameSimulation.GameState;
    private var graphics:h2d.Graphics;

    override function init() {
        gameState = new GameSimulation.GameState();
        gameState.physicsComponents[0].position.x = 400000;
        gameState.physicsComponents[0].position.y = 200000;
        graphics = new h2d.Graphics(s2d);
    }
    
    static function main() {
        if(Sys.args().length > 0 && Sys.args()[0] == "test") {
            var runner = new Runner();
            runner.addCase(new actionStates.StateMachine.StateMachineTests());
            runner.addCase(new GameSimulation.GameSimulationTests());
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
        var screenX = utils.Math.worldToScreen(gameState.physicsComponents[0].position.x);
        var screenY = utils.Math.worldToScreen(gameState.physicsComponents[0].position.y);
        graphics.drawCircle(screenX, screenY, 50);

        if(gameState.gameData != null) {
            var hitbox = gameState.gameData.hitboxGroup.hitboxes[0];
            graphics.beginFill(0xFF0000, 0.5);
            graphics.drawRect(hitbox.left, hitbox.top, hitbox.right - hitbox.left, hitbox.top - hitbox.bottom);
        }
        graphics.endFill();
    }
}
