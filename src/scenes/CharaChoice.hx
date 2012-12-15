package scenes;

import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;
import flash.events.MouseEvent;
import Game;

/**
 * ...
 * @author 01101101
 */

class CharaChoice extends Scene
{
	private var birdbtn :BIRDBTN;
	private var scarecrowbtn :SCARECROWBTN;
	private var backbtn :BACKBTN;
	
	public function new() 
	{
		super();
		birdbtn = new BIRDBTN();
		scarecrowbtn = new SCARECROWBTN();
		backbtn = new BACKBTN();
		addChild(birdbtn);
		addChild(scarecrowbtn);
		scarecrowbtn.y = 40;
		addChild(backbtn);
		backbtn.y = 80;
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case backbtn:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu } ));
			case scarecrowbtn:
				trace("ZOIZO!!!");
			case birdbtn:
				trace("KIFEPEUR!!!");
		}
	}
}