package scenes;

import events.EventManager;
import events.GameEvent;
import flash.events.MouseEvent;
import flash.media.SoundChannel;
import flash.ui.Mouse;
import Game;
import scenes.Scene;

/**
 * ...
 * @author 01101101
 */

class CharaChoice extends Scene
{
	
	private var startmenubg:STARTMENUBG;
	private var titlestain:TITLEBLOCK;
	private var scareselecbtn:SCARESELECBTN;
	private var birdselecbtn:BIRDSELECBTN;
	private var charabtn:CHARABTN;
	private var backbtn:BACKBTN;
	
	public function new () {
		super();
		startmenubg = new STARTMENUBG();
		titlestain = new TITLEBLOCK();
		scareselecbtn = new SCARESELECBTN();
		birdselecbtn = new BIRDSELECBTN();
		charabtn = new CHARABTN();
		backbtn = new BACKBTN();
		
		addChild(startmenubg);
		addChild(scareselecbtn);
		scareselecbtn.y = -5;
		scareselecbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
		addChild(birdselecbtn);
		birdselecbtn.x = 398;
		birdselecbtn.y = 194;
		birdselecbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
		addChild(charabtn);
		charabtn.y = 380;
		charabtn.x = 360;
		addChild(backbtn);
		backbtn.y = 20;
		backbtn.x = 820;
		backbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
	}
	
	private function changeselecbtn(me:MouseEvent):Void {
		switch(me.target) {
			case scareselecbtn:
				charabtn.gotoAndStop(3);
				scareselecbtn.addEventListener(MouseEvent.ROLL_OUT, resetselecbtn);
			case birdselecbtn:
				charabtn.gotoAndStop(2);
				birdselecbtn.addEventListener(MouseEvent.ROLL_OUT, resetselecbtn);
			case backbtn:
				charabtn.gotoAndStop(4);
				backbtn.addEventListener(MouseEvent.ROLL_OUT, resetselecbtn);
		}
		scareselecbtn.removeEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
		charabtn.removeEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
		backbtn.removeEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
	}
	
	
	private function resetselecbtn(me:MouseEvent):Void {
		me.target.removeEventListener(MouseEvent.ROLL_OUT, resetselecbtn);
		charabtn.gotoAndStop(1);
		scareselecbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
		birdselecbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
		backbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
		
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case backbtn:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu }));
		}
	}
	
}