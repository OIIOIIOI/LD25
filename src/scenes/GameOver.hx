package scenes;

import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldType;
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
	private var playernameInput:TextField;
	private var m_background:GAMEOVERBG;
	private var changebtn :CHANGEBTN;
	private var quitbtn :QUITBTN;
	/*private var extrabtn :EXTRABTN;*/
	private var victory:Bool;
	private var scarecrow:Bool;
	
	public function new (_params:Array<Bool>) {
		super();
		
		ScoreManager.score = 5000;
		
		m_background = new GAMEOVERBG();
		if (_params == null) {
			_params = [true, true];
		}
		victory = _params[0];
		scarecrow = _params[1];
		if (victory) {
			if (scarecrow)	m_background.gotoAndStop(2);
			else			m_background.gotoAndStop(3);
		}
		addChild(m_background);
		
		var _format:TextFormat = new TextFormat("TrueCrimes", 60, 0x941212);
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
		
		SoundManager.play((victory) ? "WIN_SND" : "FAIL_SND", 0, 0.45);
		goTF.text = (victory) ? "VICTORY" : "DEFEAT";
		addChild(goTF);
		
		if (victory) {
			var _brush:WHITE_BRUSH = new WHITE_BRUSH();
			addChild(_brush);
			
			_format = new TextFormat("TrashHand", 48, 0xFFFFFF);
			
			playernameInput = new TextField();
			playernameInput.embedFonts = true;
			playernameInput.antiAliasType = AntiAliasType.ADVANCED;
			playernameInput.defaultTextFormat = _format;
			playernameInput.type = TextFieldType.INPUT;
			playernameInput.width = _brush.width;
			playernameInput.height = 80;
			playernameInput.y = 365 - playernameInput.width / 2;
			playernameInput.x = 350;
			playernameInput.maxChars = 8;
			playernameInput.restrict = "a-zA-Z0-9";
			playernameInput.text = "YOURNAME";
			addChild(playernameInput);
			
			_brush.x = playernameInput.x;
			_brush.y = playernameInput.y;
		}
		
		changebtn = new CHANGEBTN();
		quitbtn = new QUITBTN();
		addChild(changebtn);
		changebtn.y = 430;
		changebtn.x = 50;
		addChild(quitbtn);
		quitbtn.y = changebtn.y;
		quitbtn.x = 670;
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case quitbtn:
				SoundManager.play("CLICK_SND", 0, 2);
				if (victory) ScoreManager.saveScore(playernameInput.text);
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu } ));
			/*case changebtn:
				SoundManager.play("CLICK_SND", 0, 2);
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.charachoice } ));*/
		}
	}
}