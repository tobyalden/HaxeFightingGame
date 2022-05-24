import haxe.ds.Vector;
import hl.UI16;
import utest.Assert;
import utils.Math.IntVector2D;

function getVulnerableBoxes(
    hitboxPool:Vector<CharacterData.Hitbox>, // out parameter
    action:CharacterData.ActionProperties,
    frame:Int,
    position:IntVector2D
) {
    var poolIndex:UI16 = 0;

    // Find all active hitboxes
    for(hitboxGroup in action.vulnerableHitboxGroups) {
        if(hitboxGroup.isActiveOnFrame(frame)) {
            for(hitbox in hitboxGroup.hitboxes) {
                if(poolIndex > hitboxPool.length) {
                    throw new haxe.Exception("poolIndex > hitboxPool.length in Common.getVulnerableBoxes");
                }

                // If we exceeded the hitbox pool size, return the size of the hitbox pool and write no more hitboxes.
                if(poolIndex >= hitboxPool.length) {
                    return hitboxPool.length;
                }

                // Translate the hitbox by the character position
                var translatedHitbox:CharacterData.Hitbox = {
                    top: hitbox.top + position.y,
                    left: hitbox.left + position.x,
                    bottom: hitbox.bottom + position.y,
                    right: hitbox.right + position.x
                };
                hitboxPool[poolIndex] = translatedHitbox;

                poolIndex += 1;
            }
        }
    }
    return poolIndex;
}

class CommonTests extends utest.Test {
    function testGettingTranslatedHitboxesFromAnAction() {
        var action:CharacterData.ActionProperties = {};
        action.vulnerableHitboxGroups.push({});
        action.vulnerableHitboxGroups[0].startFrame = 0;
        action.vulnerableHitboxGroups[0].duration = 50;
        action.vulnerableHitboxGroups[0].hitboxes.push({top: 500, left: -500, bottom: 0, right: 500});

        var hitboxPool:Vector<CharacterData.Hitbox> = new Vector<CharacterData.Hitbox>(10);
        var frame = 5;
        var position:IntVector2D = {x: 200, y: 400};
        var count = getVulnerableBoxes(hitboxPool, action, frame, position);

        var testingBox = action.vulnerableHitboxGroups[0].hitboxes[0];
        var hitbox = hitboxPool[0];

        Assert.equals(count, 1);
        Assert.isTrue(action.vulnerableHitboxGroups[0].isActiveOnFrame(5));
        Assert.isTrue(hitbox.top == (position.y + testingBox.top));
        Assert.isTrue(hitbox.left == (position.x + testingBox.left));
        Assert.isTrue(hitbox.bottom == (position.y + testingBox.bottom));
        Assert.isTrue(hitbox.right == (position.x + testingBox.right));
    }
}
