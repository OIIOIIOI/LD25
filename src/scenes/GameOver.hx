package scenes;

import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import Game;
/**
 * ...
 * @author 01101101
 */

class GameOver extends Scene
{
	private var continuebtn :CONTINUEBTN;
	private var quitbtn :QUITBTN;
	private var gameoverbg :GAMEOVERBG;
	
	public function new() 
	{
		super();
		continuebtn = new CONTINUEBTN();
		quitbtn = new QUITBTN();
		gameoverbg = new GAMEOVERBG();
		addChild(gameoverbg);
		addChild(continuebtn);
		addChild(quitbtn);
		quitbtn.y = 40;
		ScoreManager.saveScore;
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case quitbtn:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu } ));
		}
	}
}