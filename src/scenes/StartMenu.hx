package scenes;

import events.EventManager;
import events.GameEvent;
import flash.events.MouseEvent;
import flash.media.SoundChannel;
import Game;
import scenes.Scene;

/**
 * ...
 * @author 01101101
 */

class StartMenu extends Scene
{
	
	private var creditsbtnGraphics:CREDITBTN;
	private var newgamebtnGraphics:NEWGAMEBTN;
	private var scorebtnGraphics:SCOREBTN;
	private var startmenubg:STARTMENUBG;
	//private var yaychannel:SoundChannel;
	
	public function new () {
		super();
		//yaychannel = SoundManager.play("YAY");
		startmenubg = new STARTMENUBG();
		creditsbtnGraphics = new CREDITBTN();
		newgamebtnGraphics = new NEWGAMEBTN();
		scorebtnGraphics = new SCOREBTN();
		addChild(startmenubg);
		addChild(creditsbtnGraphics);
		addChild(newgamebtnGraphics);
		newgamebtnGraphics.y = 40;
		addChild(scorebtnGraphics);
		scorebtnGraphics.y = 80;
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			//case m_test:
				//trace("youpi");
				//EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.credits }));
			case scorebtnGraphics:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.score } ));
			case creditsbtnGraphics:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.credits } ));
			case newgamebtnGraphics:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.charachoice } ));
				//SoundManager.fade(yaychannel, 5000, false);
		}
	}
	
}