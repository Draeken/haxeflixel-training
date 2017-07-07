package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Player extends FlxSprite
{
    private var _playState:PlayState;
    private var _initialX:Float;
    private var _initialY:Float;
    private var _direction:Int;

    public function new(PlayState:PlayState, ?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);

        _playState = PlayState;

        loadGraphic(AssetPaths.tinybox__png, false);
        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);

        setSize(24, 15);
		maxVelocity.set(200, 250);
		acceleration.y = 400;
		drag.x = maxVelocity.x * 4;
        _direction = 1;
        centerOrigin();
    }

    public function setInitialPosition(X:Float, Y:Float):Void
    {
        _initialX = X;
        _initialY = Y;

        x = _initialX;
        y = _initialY;
    }

    override public function update(elapsed:Float):Void
    {
        movement();
        shoot();
        super.update(elapsed);
    }

    private function movement():Void
    {
        acceleration.x = 0;
		
		if (FlxG.keys.anyPressed([LEFT, A]))
		{
			acceleration.x = -maxVelocity.x * 10;
            _direction = -1;
		}
		
		if (FlxG.keys.anyPressed([RIGHT, D]))
		{
			acceleration.x = maxVelocity.x * 10;
            _direction = 1;
		}
		
		if (FlxG.keys.anyJustPressed([SPACE, UP, W]) && isTouching(FlxObject.FLOOR))
		{
			velocity.y = -maxVelocity.y / 1.25;
		}
    }

    private function shoot():Void
    {
        if (FlxG.keys.justPressed.CONTROL)
            _playState.addBullet(x + (width / 2.0), y + (height / 2.0), _direction);
    }

    public function respawn():Void
    {
        x = _initialX;
        y = _initialY;
        revive();
    }
}