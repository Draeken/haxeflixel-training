package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class EnemySpawner extends FlxSprite
{
    private var _playState:PlayState;
    private var _spawnTimer:FlxTimer;

    public function new(PlayState:PlayState, ?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        _playState = PlayState;

        _spawnTimer = new FlxTimer().start(FlxG.random.int(1, 5), spawnEnemy, 3);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    private function spawnEnemy(Timer:FlxTimer):Void
    {
        Timer.reset(FlxG.random.int(1, 5));
        _playState.addEnemy(this.x, this.y);
    }
}