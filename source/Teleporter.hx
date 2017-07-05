package;

import flixel.FlxSprite;

class Teleporter extends FlxSprite
{
    public var Name:String;

    public function new(Name:String, ?X:Float=0, ?Y:Float=0, ?Width:Float=0, ?Heigth:Float=0)
    {
        super(X, Y);
        this.Name = Name;
        visible = false;

        setSize(Width, Heigth);
    }
 }