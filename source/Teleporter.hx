package;

import flixel.FlxSprite;

class Teleporter extends FlxSprite
{
    public var name:String;

    public function new(name:String, ?x:Float = 0, ?y:Float = 0, ?width:Float = 0, ?heigth:Float = 0)
    {
        super(x, y);
        this.name = name;
        visible = false;

        setSize(width, heigth);
    }
 }