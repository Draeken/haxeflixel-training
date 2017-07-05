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

class PlayState extends FlxState
{
	private var _map:TiledMap;
	private var _mWalls:FlxTilemap;
	private var _player:Player;
	private var _grpCoins:FlxTypedGroup<Coin>;

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

		_player = new Player();

		var tmpMapSpawn:TiledObjectLayer = cast _map.getLayer("spawn");
		var tmpMapItems:TiledObjectLayer = cast _map.getLayer("items");
		for (e in tmpMapSpawn.objects) { placeSpawn(e);	}
		for (e in tmpMapItems.objects) { placeItems(e); }

		add(_player);
		FlxG.camera.follow(_player, TOPDOWN, 1);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(_player, _mWalls);
		FlxG.overlap(_player, _grpCoins, onPlayerTouchCoin);
	}

	private function placeSpawn(e: TiledObject):Void
	{
		if (e.name != "player") { return; }
		_player.x = e.x;
		_player.y = e.y;
	}

	private function placeItems(e:TiledObject):Void
	{
		if (e.name != "coin") { return; }
		_grpCoins.add(new Coin(e.x, e.y));
	}

	private function onPlayerTouchCoin(player:Player, coin:Coin):Void
	{
		if (!player.alive || !player.exists || !coin.alive || !coin.exists) { return; }
		coin.kill();
	}
}