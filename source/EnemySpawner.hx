package;

import flixel.FlxState;
import flixel.FlxSprite;

class EnemySpawner extends FlxSprite
{
    private var _playState:PlayState;

    public function new(PlayState:PlayState, ?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        _playState = PlayState;

        _playState.addEnemy(this.x, this.y);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}