package scenes;

import events.EventManager;
import events.GameEvent;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.geom.ColorTransform;
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
	private var scareselecbtn:SCARESELECBTN;
	private var birdselecbtn:BIRDSELECBTN;
	//private var scareselecbtn:SCARESELEC;
	//private var birdselecbtn:BIRDSELEC;
	private var charabtn:CHARABTN;
	private var backbtn:BACKBTN;
	
	public function new () {
		super();
		startmenubg = new STARTMENUBG();
		scareselecbtn = new SCARESELECBTN();
		birdselecbtn = new BIRDSELECBTN();
		//scareselecbtn = new SCARESELEC();
		//birdselecbtn = new BIRDSELEC();
		charabtn = new CHARABTN();
		backbtn = new BACKBTN();
		
		scareselecbtn.y = -4;
		birdselecbtn.x = 398;
		birdselecbtn.y = 194;
		charabtn.x = 360;
		charabtn.y = 380;
		backbtn.x = 820;
		backbtn.y = 20;
		
		//startmenubg.transform.colorTransform = new ColorTransform(0.8, 0.8, 0.8);
		
		addChild(startmenubg);
		addChild(scareselecbtn);
		addChild(birdselecbtn);
		addChild(charabtn);
		addChild(backbtn);
		
		scareselecbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
		birdselecbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
		backbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
	}
	
	private function changeselecbtn(me:MouseEvent):Void {
		//startmenubg.transform.colorTransform = new ColorTransform();
		var _colorTransform:ColorTransform;
		switch(me.target) {
			case scareselecbtn:
				charabtn.gotoAndStop(3);
				//birdselecbtn.transform.colorTransform = new ColorTransform(0.25, 0.25, 0.25, 1);
				scareselecbtn.addEventListener(MouseEvent.ROLL_OUT, resetselecbtn);
			case birdselecbtn:
				charabtn.gotoAndStop(2);
				//scareselecbtn.transform.colorTransform = new ColorTransform(0.25, 0.25, 0.25, 1);
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
		//startmenubg.transform.colorTransform = new ColorTransform();
		birdselecbtn.transform.colorTransform = new ColorTransform();
		scareselecbtn.transform.colorTransform = new ColorTransform();
		me.target.removeEventListener(MouseEvent.ROLL_OUT, resetselecbtn);
		charabtn.gotoAndStop(1);
		scareselecbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
		birdselecbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
		backbtn.addEventListener(MouseEvent.ROLL_OVER, changeselecbtn);
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case backbtn:
				SoundManager.play("CLICK_SND", 0, 2);
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu } ));
			case scareselecbtn:
				SoundManager.play("CLICK_SND", 0, 2);
				StartMenu.menutheme.stop();
				StartMenu.menuthemeisplaying = false;
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.play, param:Play.MODE_SCARE } ));
			case birdselecbtn:
				SoundManager.play("CLICK_SND", 0, 2);
				StartMenu.menutheme.stop();
				StartMenu.menuthemeisplaying = false;
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.play } ));
		}
	}
	
}