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

class Credits extends Scene
{
	
	private var creditsbg:CREDITSBG;
	private var backbtn:BACKBTN;
	
	public function new () {
		super();
		creditsbg = new CREDITSBG();
		backbtn =  new BACKBTN();
		addChild(creditsbg);
		addChild(backbtn);
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case backbtn:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu }));
		}
	}
	
}