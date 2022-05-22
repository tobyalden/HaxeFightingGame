import utest.Runner;
import utest.ui.Report;

class Main extends hxd.App {
    private var game:Game;

    override function init() {
        game = new Game(s2d);
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
        game.gameLoop();
    }
}
