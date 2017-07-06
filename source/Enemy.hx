package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Enemy extends FlxSprite
{
    private var _speed:Float;  
    private var _direction:Int;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        loadGraphic(AssetPaths.tinybox__png, false);
        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);

        _speed = 100;
		acceleration.y = 400;
        _direction = 1;
        velocity.x = _speed * _direction;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    public function switchDirection():Void
    {
        _direction *= -1;
        velocity.x = _speed * _direction;
    }
}