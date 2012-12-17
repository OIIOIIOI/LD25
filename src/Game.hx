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
import flash.net.SharedObject;
import scenes.CharaChoice;
import scenes.Credits;
import scenes.GameOver;
import scenes.Scene;
import scenes.Scores;
import scenes.StartMenu;
import scenes.Play;

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
	inline static public var BOTTOM_LINE:Int = 475;
	
	static public var SO:SharedObject;
	static public var instance:Game;
	
	public var scene:Scene;
	
	private var lastFrame:Float;// The last time the game was updated
	
	public function new () {
		super();
		instance = this;
		// Saved data
		SO = SharedObject.getLocal("seedsofwrath");
		//SO.clear();
		if (SO.data.scoresData == null || !Std.is(SO.data.scoresData, Array)) {
			SO.data.scoresData = new Array<Dynamic>();
			SO.data.scoresData.push( { name:"SIMON", score:2000 }, { name:"GRMPF", score:9100 }, { name:"NI!", score:3400 }, { name:"NOC", score:4500 },  { name:"CAPTAIN", score:1100 } );
			SO.data.scoresData.sort(function(a:Int, b:Int):Int{ if (a > b) return 1; if (b > a) return -1; return 0; } );
			SO.flush();
		}
		ScoreManager.initScoreData(SO.data.scoresData);
		// Wait for the sprite to be added to the display list
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init (_event:Event) :Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		// Init scene
		//changeScene(GameScene.startMenu);
		//changeScene(GameScene.play);
		changeScene(GameScene.gameover);
		
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
			case GameScene.gameover:	new GameOver();
			case GameScene.score:		new Scores();
			case GameScene.charachoice:	new CharaChoice();
			case GameScene.play:
				if (_param == null) _param = Play.MODE_SCARE;
				new Play(_param);
		}
		addChild(scene);
	}
	
	private function enterFrameHandler (_event:Event) :Void {
		update();
	}
	
	private function update () :Void {
		if (scene == null)	return;
		// Update every entity
		scene.update();
	}
	
}

enum GameScene {
	startMenu;
	credits;
	gameover;
	score;
	charachoice;
	play;
}









