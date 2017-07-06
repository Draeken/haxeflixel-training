package;

import flixel.FlxState;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	private var _map:TiledMap;
	private var _mWalls:FlxTilemap;
	private var _player:Player;
	private var _grpCoins:FlxTypedGroup<Coin>;
	private var _grpEnemySpawners:FlxTypedGroup<EnemySpawner>;

	private var _enemies:FlxTypedGroup<Enemy>;

	private var _teleporters:Array<Teleporter>;
	private var _topTeleporter:Teleporter;
	private var _bottomTeleporter:Teleporter;

	private var _playerReviveTimer:FlxTimer;

	override public function create():Void
	{
		_map = new TiledMap(AssetPaths.tilemap__tmx);
		_mWalls = new FlxTilemap();
		_mWalls.loadMapFromArray(cast(_map.getLayer("walls"), TiledTileLayer).tileArray, _map.width,
			_map.height, AssetPaths.tiles__png, _map.tileWidth, _map.tileHeight,
			FlxTilemapAutoTiling.OFF, 1, 1, 3);
		_mWalls.follow();
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.ANY);

		add(_mWalls);

		_grpCoins = new FlxTypedGroup<Coin>();
		add(_grpCoins);

		_enemies =  new FlxTypedGroup<Enemy>();
		add(_enemies);

		_teleporters = [];

		_grpEnemySpawners = new FlxTypedGroup<EnemySpawner>();
		add(_grpEnemySpawners);

		_player = new Player();

		_playerReviveTimer = new FlxTimer();		

		var tmpMapSpawn:TiledObjectLayer = cast _map.getLayer("spawn");
		var tmpMapItems:TiledObjectLayer = cast _map.getLayer("items");
		var tmpMapTeleporters:TiledObjectLayer = cast _map.getLayer("tp");
		var tmpMapEnemySpawners:TiledObjectLayer = cast _map.getLayer("mobSpawners");

		for (e in tmpMapSpawn.objects) { placeSpawn(e);	}
		for (e in tmpMapItems.objects) { placeItems(e); }
		for (e in tmpMapTeleporters.objects) { placeTeleporters(e); }
		for (e in tmpMapEnemySpawners.objects) { placeEnemySpawners(e); }

		_teleporters.push(_topTeleporter);
		_teleporters.push(_bottomTeleporter);

		for (tp in _teleporters)
			add(tp);

		add(_player);
		
		FlxG.camera.follow(_player, FlxCameraFollowStyle.PLATFORMER, 1);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(_player, _mWalls);

		for (enemy in _enemies)
		{
			FlxG.collide(enemy, _mWalls, onEnemyCollideWall);
			FlxG.overlap(_player, enemy, onPlayerTouchEnemy);
		}

		FlxG.overlap(_player, _grpCoins, onPlayerTouchCoin);

		for (tp in _teleporters)
		{
			FlxG.overlap(_player, tp, onObjectTouchTeleporter);

			for (e in _enemies)
				FlxG.overlap(e, tp, onObjectTouchTeleporter);
		}
	}

	private function placeSpawn(e: TiledObject):Void
	{
		if (e.name != "player") { return; }
		_player.setInitialPosition(e.x, e.y);
	}

	private function placeItems(e:TiledObject):Void
	{
		if (e.name != "coin") { return; }
		_grpCoins.add(new Coin(e.x, e.y));
	}

	private function placeTeleporters(e:TiledObject):Void
	{
		if (e.name == "top")
			_topTeleporter = new Teleporter(e.name, e.x, e.y, e.width, e.height);
		else if (e.name == "bottom")
			_bottomTeleporter = new Teleporter(e.name, e.x, e.y, e.width, e.height);
	}

	private function placeEnemySpawners(e:TiledObject):Void
	{
		if (e.name != "mobSpawner") { return; }
		_grpEnemySpawners.add(new EnemySpawner(this, e.x, e.y));
	}

	private function onPlayerTouchCoin(player:Player, coin:Coin):Void
	{
		if (!player.alive || !player.exists || !coin.alive || !coin.exists) { return; }
		coin.kill();
	}

	private function onPlayerTouchEnemy(player:Player, enemy:Enemy):Void
	{
		if (!player.alive || !player.exists || !enemy.alive || !enemy.exists) { return; }

		FlxObject.updateTouchingFlags(player, enemy);

		if ((player.justTouched(FlxObject.WALL) && enemy.justTouched(FlxObject.WALL)) ||
			(player.justTouched(FlxObject.UP) && enemy.justTouched(FlxObject.FLOOR)))
		{
			player.kill();
			FlxG.camera.shake(.02, 0.5);
			_playerReviveTimer.start(3, playerRespawn, 1);
		}
		else if (player.justTouched(FlxObject.DOWN) && enemy.justTouched(FlxObject.UP))
			enemy.kill();

	}

	private function playerRespawn(timer:FlxTimer):Void
	{
		_player.respawn();
	}

	private function onObjectTouchTeleporter(entity:FlxObject, teleporter:Teleporter):Void
	{
		trace("Touched teleporter");
		if (teleporter.Name == "top")
			entity.y = _bottomTeleporter.y - 16;
		else if (teleporter.Name == "bottom")
			entity.y = _topTeleporter.y + 16;
	}

	private function onEnemyCollideWall(enemy:Enemy, wall:FlxObject):Void
	{
		if (enemy.justTouched(FlxObject.WALL))
			enemy.switchDirection();
	}

	public function addEnemy(x:Float, y:Float):Void
	{
		_enemies.add(new Enemy(x, y));
	}
}