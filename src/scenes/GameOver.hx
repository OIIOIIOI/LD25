package scenes;

import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import Game;
/**
 * ...
 * @author 01101101
 */

class GameOver extends Scene
{
	
	public var goTF:TextField;
	private var m_background:GAMEOVERBG;
	/*private var changebtn :CHANGEBTN;
	private var quitbtn :QUITBTN;
	private var extrabtn :EXTRABTN;*/
	
	public function new (_params:Array<Bool>) {
		super();
		
		m_background = new GAMEOVERBG();
		if (_params[0]) {
			if (_params[1])	m_background.gotoAndStop(2);
			else			m_background.gotoAndStop(3);
		}
		addChild(m_background);
		
		var _format:TextFormat = new TextFormat("TrashHand", 60, 0x000000);
		//var _format:TextFormat = new TextFormat("TrueCrimes", 24, 0x000000);
		_format.align = TextFormatAlign.CENTER;
		
		goTF = new TextField();
		goTF.embedFonts = true;
		goTF.antiAliasType = AntiAliasType.ADVANCED;
		goTF.defaultTextFormat = _format;
		goTF.selectable = false;
		goTF.width = 400;
		goTF.height = 200;
		goTF.x = 450 - goTF.width / 2;
		goTF.y = 200;
		
		SoundManager.play((_params[0]) ? "WIN_SND" : "FAIL_SND");
		goTF.text = (_params[0]) ? "VICTORY" : "DEFEAT";
		addChild(goTF);
		
		ScoreManager.saveScore;
	}
	
	/*override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case quitbtn:
				SoundManager.play("CLICK_SND", 0, 2);
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu } ));
			case changebtn:
				SoundManager.play("CLICK_SND", 0, 2);
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.charachoice } ));
		}
	}*/
}