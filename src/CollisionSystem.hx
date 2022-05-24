import haxe.ds.Vector;
import utest.Assert;
import utils.Math.IntVector2D;

// Create a new hitbox translated by the offset provided.
function translateHitbox(hitbox:CharacterData.Hitbox, offset:IntVector2D):CharacterData.Hitbox {
    return {
        left: hitbox.left + offset.x,
        top: hitbox.top + offset.y,
        right: hitbox.right + offset.x,
        bottom: hitbox.bottom + offset.y,
    }
}

// Check to see if two hitboxes overlap 
function doHitboxesOverlap(a:CharacterData.Hitbox, b:CharacterData.Hitbox) {
    var isNotOverlapping = (a.left > b.right) || (b.left > a.right) || (a.bottom > b.top) || (b.bottom > a.top);
    return !isNotOverlapping;
}

function getActiveAttackHitboxes(gameState:GameSimulation.GameState, entity:Int) {
    return null;
}

@:structInit class ScratchHitboxSet {
    public var hitboxStore:Vector<CharacterData.Hitbox> = new Vector<CharacterData.Hitbox>(10);
    public var hitboxes:Vector<CharacterData.Hitbox>;
}

@:structInit class CollisionSystem {
    // Working memory to pass between the collision system stages
    private var attackerEntityBoxes:Array<ScratchHitboxSet> = [];
    private var defenderEntityBoxes:Array<ScratchHitboxSet> = [];

    public function execute(gameState:GameSimulation.GameState) {
        for(attackerIndex in 0...attackerEntityBoxes.length) {
            for(attackBox in attackerEntityBoxes[attackerIndex].hitboxes) {
                for(defenderIndex in 0...defenderEntityBoxes.length) {
                    if(attackerIndex == defenderIndex) {
                        continue;
                    }

                    for(vulnerableBox in defenderEntityBoxes[defenderIndex].hitboxes) {
                        if(doHitboxesOverlap(attackBox, vulnerableBox)) {
                            // Generate hit event
                        }
                    }
                }
            }
        }
    }
}

class CollisionSystemTests extends utest.Test {
    function testClearingOutScratchHitboxDataEachFrame() {
        var collisionSystem:CollisionSystem = {};
        var gameState = new GameSimulation.GameState();
        var character:CharacterData.CharacterProperties = {};
        gameState.gameData.characters.push(character);
        collisionSystem.execute(gameState);
        // TODO: This test is unfinished. The Zig version contains asserts that fail (as of c81795d)
    }
}
