import GameSimulation.GameState;
import utils.Math.IntVector2D;

class Main extends hxd.App {
    private var gameState:GameState;
    private var graphics:h2d.Graphics;

    override function init() {
        gameState = new GameState();
        gameState.physicsComponents[0].position = new IntVector2D(400, 200);
        graphics = new h2d.Graphics(s2d);
    }
    
    static function main() {
        new Main();
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

        gameState.updateGame();

        graphics.clear();
        graphics.beginFill(0xEA8220);
        graphics.drawCircle(entity.position.x, entity.position.y, 50);
        graphics.endFill();
    }
}
