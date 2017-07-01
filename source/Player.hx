package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{
    public var speed:Float = 300;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        loadGraphic(AssetPaths.tinybox__png, false, 16, 16);
        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);
        drag.x = drag.y = 1600;
        setSize(14, 8);
        offset.set(4, 2);
    }

    override public function update(elapsed:Float):Void
    {
        movement();
        super.update(elapsed);
    }

    private function movement():Void
    {
        var _up:Bool = false;
        var _down:Bool = false;
        var _left:Bool = false;
        var _right:Bool = false;

        _up = FlxG.keys.anyPressed([UP, Z]);
        _down = FlxG.keys.anyPressed([DOWN, S]);
        _left = FlxG.keys.anyPressed([LEFT, Q]);
        _right = FlxG.keys.anyPressed([RIGHT, D]);

        if (!_up && !_down && !_left && !_right) { return; }

        var mA:Float = 0;
        if (_up)
        {
            mA = -90;
            if (_left) { mA -= 45; }
            else if (_right) { mA += 45; }
            facing = FlxObject.UP;
        }
        else if (_down)
        {
            mA = 90;
            if (_left) { mA += 45; }
            else if (_right) { mA -= 45; }
            facing = FlxObject.DOWN;
        }
        else if (_left)
        {
            mA = 180;
            facing = FlxObject.LEFT;
        }
        else if (_right)
        {
            facing = FlxObject.RIGHT;
            mA = 0;
        }


        velocity.set(speed, 0);
        velocity.rotate(FlxPoint.weak(0, 0), mA);
     }
 }