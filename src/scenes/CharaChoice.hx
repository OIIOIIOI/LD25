package scenes;

import events.EventManager;
import events.GameEvent;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.geom.ColorTransform;
import flash.media.SoundChannel;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
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
	private var tutorialtext:TextField;
	private var tutoformat:TextFormat;
	
	public function new () {
		super();
		startmenubg = new STARTMENUBG();
		scareselecbtn = new SCARESELECBTN();
		birdselecbtn = new BIRDSELECBTN();
		//scareselecbtn = new SCARESELEC();
		//birdselecbtn = new BIRDSELEC();
		charabtn = new CHARABTN();
		backbtn = new BACKBTN();
		tutorialtext = new TextField();
		tutoformat = new TextFormat("GoodDog", 20);
		tutoformat.align = TextFormatAlign.CENTER;
		
		scareselecbtn.y = -4;
		birdselecbtn.x = 398;
		birdselecbtn.y = 194;
		charabtn.x = 360;
		charabtn.y = 380;
		backbtn.x = 820;
		backbtn.y = 20;
		
		tutorialtext.defaultTextFormat = tutoformat;
		tutorialtext.x = 200;
		tutorialtext.y = 440;
		tutorialtext.width = 500;
		tutorialtext.height = 60;
		tutorialtext.wordWrap = true;
		
		addChild(startmenubg);
		addChild(scareselecbtn);
		addChild(birdselecbtn);
		addChild(charabtn);
		addChild(backbtn);
		addChild(tutorialtext);
		
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
				tutorialtext.text = "Stone the starving little birdie and keep the seeds for yerself!\nLEFT/RIGHT to aim and SPACE to spitt";
			case birdselecbtn:
				charabtn.gotoAndStop(2);
				//scareselecbtn.transform.colorTransform = new ColorTransform(0.25, 0.25, 0.25, 1);
				birdselecbtn.addEventListener(MouseEvent.ROLL_OUT, resetselecbtn);
				tutorialtext.text = "Poo on the dummy, rob the seeds, conquer for wilderness!\nLEFT/RIGHT to rotate and SPACE to drop";
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
		tutorialtext.text = "";
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