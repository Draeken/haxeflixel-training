package;

import flixel.group.FlxGroup;
import flixel.addons.editors.tiled.TiledMap;
import flixel.tile.FlxTilemap;

class TiledLevel extends TiledMap
{
    private inline static var c_PATH_LEVEL_TILESHEETS = "assets/tilesheets";

    public var foregroundTiles:FlxGroup;
    public var objectsLayer:FlxGroup;
    public var backgroundLayer:FlxGroup;
    private var collidableTileLayers:Array<FlxTilemap>;

    public var imagesLayer:FlxGroup;

    public function new(tiledLevel:Dynamic, state:PlayState)
    {
        super(tiledLevel);

        imagesLayer = new FlxGroup();
        backgroundLayer = new FlxGroup();
        objectsLayer = new FlxGroup();
        foregroundTiles = new FlxGroup();
    }
}