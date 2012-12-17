package scenes;

import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.media.SoundChannel;
import Game;

/**
 * ...
 * @author 01101101
 */

class Credits extends Scene
{
	
	private var creditsbg:CREDITSBG;
	private var backbtn:BACKBTN;
	private var generik:GENERIK;
	private var credittheme:SoundChannel;
	
	public function new () {
		super();
		
		credittheme = SoundManager.play("CREDITS_MUSIC");
		
		creditsbg = new CREDITSBG();
		backbtn =  new BACKBTN();
		generik = new GENERIK();
		addChild(creditsbg);
		addChild(backbtn);
		backbtn.x = 20;
		backbtn.y = 430;
		addChild(generik);
		generik.x = 450;
		generik.y = 0;
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case backbtn:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu } ));
				credittheme.stop();
		}
	}
	
}