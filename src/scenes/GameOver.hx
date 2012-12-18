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
	private var continuebtn :CHANGEBTN;
	private var retrybtn :RETRYBTN;
	private var quitbtn :QUITBTN;
	/*private var extrabtn :EXTRABTN;*/
	private var victory:Bool;
	private var scarecrow:Bool;
	private var m_scoreTF:TextField;
	
	public function new (_params:Array<Bool>) {
		super();
		
		m_background = new GAMEOVERBG();
		if (_params == null) {
			_params = [true, false];
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
		
		// Score
		_format = new TextFormat("TrueCrimes", 36, 0x000000);
		_format.align = TextFormatAlign.CENTER;
		//
		m_scoreTF = new TextField();
		m_scoreTF.embedFonts = true;
		m_scoreTF.antiAliasType = AntiAliasType.ADVANCED;
		m_scoreTF.defaultTextFormat = _format;
		m_scoreTF.selectable = false;
		m_scoreTF.width = 400;
		m_scoreTF.height = 60;
		m_scoreTF.x = 450 - m_scoreTF.width / 2;
		m_scoreTF.y = 25;
		addChild(m_scoreTF);
		
		if (victory) {
			ScoreManager.score += 1000;
			
			var _brush:WHITE_BRUSH = new WHITE_BRUSH();
			addChild(_brush);
			
			_format = new TextFormat("TrashHand", 48, 0xFFFFFF);
			_format.align = TextFormatAlign.CENTER;
			
			playernameInput = new TextField();
			playernameInput.embedFonts = true;
			playernameInput.antiAliasType = AntiAliasType.ADVANCED;
			playernameInput.defaultTextFormat = _format;
			playernameInput.type = TextFieldType.INPUT;
			playernameInput.width = _brush.width;
			playernameInput.height = 80;
			playernameInput.y = 370 - playernameInput.width / 2;
			playernameInput.x = 330;
			playernameInput.maxChars = 8;
			playernameInput.restrict = "a-zA-Z0-9";
			playernameInput.text = "YOURNAME";
			addChild(playernameInput);
			
			_brush.x = playernameInput.x + 15;
			_brush.y = playernameInput.y - 5;
		}
		
		m_scoreTF.text = Std.string(ScoreManager.score);
		
		quitbtn = new QUITBTN();
		quitbtn.x = 50;
		quitbtn.y = 430;
		addChild(quitbtn);
		
		if (victory) {
			continuebtn = new CHANGEBTN();
			continuebtn.x = 670;
			continuebtn.y = quitbtn.y;
			addChild(continuebtn);
		}
		else {
			retrybtn = new RETRYBTN();
			retrybtn.x = 670;
			retrybtn.y = quitbtn.y;
			addChild(retrybtn);
		}
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case quitbtn:
				if (victory) ScoreManager.saveScore(playernameInput.text);
				SoundManager.play("CLICK_SND", 0, 2);
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu } ));
			case continuebtn:
				if (victory) ScoreManager.saveScore(playernameInput.text);
				SoundManager.play("CLICK_SND", 0, 2);
				var _mode:String = Play.MODE_BIRD;
				if (!scarecrow) _mode = Play.MODE_SCARE;
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.play, param:_mode } ));
			case retrybtn:
				if (victory) ScoreManager.saveScore(playernameInput.text);
				SoundManager.play("CLICK_SND", 0, 2);
				var _mode:String = Play.MODE_BIRD;
				if (scarecrow) _mode = Play.MODE_SCARE;
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.play, param:_mode } ));
		}
	}
}