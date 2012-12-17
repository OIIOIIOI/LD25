package scenes;

import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFormat;
import Game;

/**
 * ...
 * @author 01101101
 */

class Scores extends Scene
{
	private var scorebg :SCOREBG;
	private var backbtn:BACKBTN;
	private var scDisPos :TextField;
	private var scDisNam :TextField;
	private var scDisSco :TextField;

	public function new()
	{
		super();
		scorebg = new SCOREBG();
		backbtn =  new BACKBTN();
		scDisPos = new TextField();
		scDisNam = new TextField();
		scDisSco = new TextField();
		
		
		//var scoreformat = new TextFormat("GoodDog", 32);
		var scoreformat = new TextFormat("TrueCrimes", 32);
		scoreformat.leading = 5;
		addChild(scorebg);
		addChild(backbtn);
		backbtn.y = 20;
		backbtn.x = 820;
		addChild(scDisPos);
		scDisPos.x = 100;
		scDisPos.y = 100;
		scDisPos.width = 300;
		scDisPos.height = 300;
		scDisPos.embedFonts = true;
		scDisPos.selectable = false;
		scDisPos.antiAliasType = AntiAliasType.ADVANCED;
		scDisPos.defaultTextFormat = scoreformat;
		scDisPos.text = "1\n2\n3\n4\n5\n6\n7\n8\n9\n10";
		addChild(scDisNam);
		scDisNam.x = 150;
		scDisNam.y = 100;
		scDisNam.width = 300;
		scDisNam.height = 300;
		scDisNam.embedFonts = true;
		scDisNam.selectable = false;
		scDisNam.antiAliasType = AntiAliasType.ADVANCED;
		scDisNam.defaultTextFormat = scoreformat;
		addChild(scDisSco);
		scDisSco.x = 400;
		scDisSco.y = 100;
		scDisSco.width = 300;
		scDisSco.height = 300;
		scDisSco.embedFonts = true;
		scDisSco.selectable = false;
		scDisSco.antiAliasType = AntiAliasType.ADVANCED;
		scDisSco.defaultTextFormat = scoreformat;
		for (i in ScoreManager.scoreBoard) {
			scDisNam.text += "" + i.name + "\n";
			scDisSco.text += "" + i.score + "\n";
		}
		scDisPos.setTextFormat(scoreformat);
		scDisNam.setTextFormat(scoreformat);
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case backbtn:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu }));
		}
	}
}