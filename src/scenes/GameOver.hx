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
	private var changebtn :CHANGEBTN;
	private var quitbtn :QUITBTN;
	private var gameoverbg :GAMEOVERBG;
	private var extrabtn :EXTRABTN;
	
	public function new() 
	{
		super();
		changebtn = new CHANGEBTN();
		quitbtn = new QUITBTN();
		gameoverbg = new GAMEOVERBG();
		extrabtn = new EXTRABTN();
		addChild(gameoverbg);
		addChild(changebtn);
		changebtn.y = 420;
		changebtn.x = 744;
		addChild(quitbtn);
		quitbtn.y = 420;
		quitbtn.x = 30;
		addChild(extrabtn);
		extrabtn.y = 420;
		extrabtn.x = 407;
		ScoreManager.saveScore;
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case quitbtn:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu } ));
			case changebtn:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.charachoice } ));
		}
	}
}