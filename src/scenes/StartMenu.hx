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
	private var titlestain:TITLEBLOCK;
	
	public function new () {
		super();
		startmenubg = new STARTMENUBG();
		creditsbtnGraphics = new CREDITBTN();
		newgamebtnGraphics = new NEWGAMEBTN();
		scorebtnGraphics = new SCOREBTN();
		titlestain = new TITLEBLOCK();
		addChild(startmenubg);
		addChild(creditsbtnGraphics);
		creditsbtnGraphics.y = 455;
		creditsbtnGraphics.x = 360;
		addChild(newgamebtnGraphics);
		newgamebtnGraphics.y = 380;
		newgamebtnGraphics.x = 360;
		addChild(scorebtnGraphics);
		scorebtnGraphics.y = 455;
		scorebtnGraphics.x = 460;
		addChild(titlestain);
		titlestain.x=500;
		titlestain.y=0;
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
				creditsbtnGraphics.visible = false;
				scorebtnGraphics.visible = false;
				newgamebtnGraphics.visible = false;
		}
	}
	
}