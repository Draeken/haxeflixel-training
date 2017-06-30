package;

import flixel.FlxState;

class PlayState extends FlxState
{
	override public function create():Void
	{
		super.create();
		var text = new flixel.text.FlxText(50, 50, 200, 'Yosh', 24, false);
		add(text);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}