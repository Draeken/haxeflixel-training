package;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class Coin extends FlxSprite
{
    public function new(?x:Float = 0, ?y:Float = 0)
    {
        super(x, y);
        loadGraphic(AssetPaths.coin__png, false, 8, 8);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    override public function kill():Void
    {
        alive = false;
        FlxTween.tween(this, { alpha: 0, y: y - 16 }, 0.33, { ease: FlxEase.circOut, onComplete: finishKill });
    }

    private function finishKill(_):Void
    {
        exists = false;
    }
 }