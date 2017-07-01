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

class PlayState extends FlxState
{
	private var _map:TiledMap;
	private var _mWalls:FlxTilemap;
	private var _player:Player;

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

		_player = new Player();
		var tmpMap:TiledObjectLayer = cast _map.getLayer("player");
		for (e in tmpMap.objects)
		{
			placeEntities(e);
		}
		add(_player);
		FlxG.camera.follow(_player, TOPDOWN, 1);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(_player, _mWalls);
	}

	private function placeEntities(e: TiledObject):Void
	{
		if (e.name != "player") { return; }
		_player.x = e.x;
		_player.y = e.y;

	}
}