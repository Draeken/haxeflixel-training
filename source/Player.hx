package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Player extends FlxSprite
{
    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        loadGraphic(AssetPaths.tinybox__png, false);
        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);

		maxVelocity.set(200, 250);
		acceleration.y = 400;
		drag.x = maxVelocity.x * 4;
    }

    override public function update(elapsed:Float):Void
    {
        movement();
        super.update(elapsed);
    }

    private function movement():Void
    {
        acceleration.x = 0;
		
		if (FlxG.keys.anyPressed([LEFT, A]))
		{
			acceleration.x = -maxVelocity.x * 10;
		}
		
		if (FlxG.keys.anyPressed([RIGHT, D]))
		{
			acceleration.x = maxVelocity.x * 10;
		}
		
		if (FlxG.keys.anyJustPressed([SPACE, UP, W]) && isTouching(FlxObject.FLOOR))
		{
			velocity.y = -maxVelocity.y / 1.25;
		}
     }
 }