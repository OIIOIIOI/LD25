package ;

import events.EventManager;
import events.GameEvent;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import scenes.Credits;
import scenes.Scene;
import scenes.StartMenu;

/**
 * ...
 * @author 01101101
 */

using Lambda;
class Game extends Sprite
{
	
	inline static public var SIZE:Rectangle = new Rectangle(0, 0, 900, 500);// Since the display is at pixel-level, specify how much to scale it
	inline static public var SCALE:Int = 1;// Since the display is at pixel-level, specify how much to scale it
	inline static public var FPS:UInt = 30;// How many times per second do we want the game to update
	inline static public var MS:Float = 1000 / FPS;
	
	//static public var SO:SharedObject;
	
	private var scene:Scene;
	
	private var lastFrame:Float;// The last time the game was updated
	
	public function new () {
		super();
		
		/*// Saved data
		SO = SharedObject.getLocal("moutonsSave");
		//SO.clear();
		if (SO.data.levels == null || !Std.is(SO.data.levels, Array)) {
			SO.data.levels = new Array<Dynamic>();
			SO.flush();
		}*/
		// Wait for the sprite to be added to the display list
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	/*private function getSavedState (_name:String) :Bool {
		//return false;
		var _SOI:Int = SOIndexOf(_name);
		if (_SOI != -1) {
			return SO.data.levels[_SOI].locked;
		}
		return true;
	}
	
	static private function SOIndexOf (_name:String) :Int {
		for (_i in 0...SO.data.levels.length) {
			if (SO.data.levels[_i].name == _name)
				return _i;
		}
		return -1;
	}*/
	
	private function init (_event:Event) :Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		// Init scene
		changeScene(GameScene.startMenu);
		
		// Start main loop
		lastFrame = 0;
		addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		// Game events
		EventManager.instance.addEventListener(GameEvent.CHANGE_SCENE, gameEventHandler);
	}
	
	private function gameEventHandler (_event:GameEvent) :Void {
		switch (_event.type) {
			case GameEvent.CHANGE_SCENE:
				changeScene(_event.data.scene, _event.data.param);
		}
	}
	
	private function changeScene (_scene:GameScene, ?_param:Dynamic) :Void {
		// Destroy current scene
		if (scene != null) {
			removeChild(scene);
			scene.destroy();
		}
		// Default scene
		if (_scene == null) {
			_scene = GameScene.startMenu;
		}
		// Create new scene
		scene = switch (_scene) {
			case GameScene.startMenu:	new StartMenu();
			case GameScene.credits:		new Credits();
		}
		addChild(scene);
		/*// TODO Play music (make music)
		if (scene.theme != null)
			playTheme(scene.theme);*/
	}
	
	private function enterFrameHandler (_event:Event) :Void {
		update();
	}
	
	private function update () :Void {
		if (scene == null)	return;
		// Update every entity
		//scene.update();
	}
	
}

enum GameScene {
	startMenu;
	credits;
}









