import haxe.ds.Vector;

// Create a new hitbox translated by the offset provided.
function translateHitbox(hitbox:CharacterData.Hitbox, offset:utils.Math.IntVector2D):CharacterData.Hitbox {
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

function collisionSystem(gameState:GameSimulation.GameState) {
    var attackBoxes = new Vector<CharacterData.HitboxGroup>(10);
    for(i in 0...attackBoxes.length) {
        var attackBox:CharacterData.HitboxGroup = {};
        attackBoxes[i] = attackBox;
    }
    var vulnerableBoxes = new Vector<CharacterData.HitboxGroup>(10);
    for(i in 0...vulnerableBoxes.length) {
        var vulnerableBox:CharacterData.HitboxGroup = {};
        vulnerableBoxes[i] = vulnerableBox;
    }

    for(attackEntity in 0...gameState.entityCount) {
        var attackBox = attackBoxes[attackEntity];

        for(defendEntity in 0...gameState.entityCount) {
            // Don't check an attacker against itself.
            if(attackEntity == defendEntity) {
                continue;
            }

            var vulnerableBox = vulnerableBoxes[defendEntity];
            if(doHitboxesOverlap(attackBox, vulnerableBox)) {
                // Generate hit event.
            }
        }
    }
}
