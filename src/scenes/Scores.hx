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
	private var scoredispcount :Int;

	public function new()
	{
		super();
		
		//ScoreManager.fromHighToLow();
		
		scorebg = new SCOREBG();
		backbtn =  new BACKBTN();
		scDisPos = new TextField();
		scDisNam = new TextField();
		scDisSco = new TextField();
		
		
		//var scoreformat = new TextFormat("GoodDog", 32);
		var scoreformat = new TextFormat("TrueCrimes", 22);
		scoreformat.leading = 15;
		addChild(scorebg);
		addChild(backbtn);
		backbtn.x = 20;
		backbtn.y = 430;
		addChild(scDisPos);
		scDisPos.x = 470;
		scDisPos.y = 150;
		scDisPos.width = 50;
		scDisPos.height = 300;
		scDisPos.embedFonts = true;
		scDisPos.selectable = false;
		scDisPos.antiAliasType = AntiAliasType.ADVANCED;
		scDisPos.defaultTextFormat = scoreformat;
		scDisPos.text = "1\n2\n3\n4\n5\n6\n7\n8\n9\n10";
		addChild(scDisNam);
		scDisNam.x = 510;
		scDisNam.y = 150;
		scDisNam.width = 200;
		scDisNam.height = 300;
		scDisNam.embedFonts = true;
		scDisNam.selectable = false;
		scDisNam.antiAliasType = AntiAliasType.ADVANCED;
		scDisNam.defaultTextFormat = scoreformat;
		addChild(scDisSco);
		scDisSco.x = 700;
		scDisSco.y = 150;
		scDisSco.width = 200;
		scDisSco.height = 300;
		scDisSco.embedFonts = true;
		scDisSco.selectable = false;
		scDisSco.antiAliasType = AntiAliasType.ADVANCED;
		scDisSco.defaultTextFormat = scoreformat;
		scoredispcount = 0;
		for (i in ScoreManager.scoreBoard) {
			scDisNam.text += "" + i.name + "\n";
			scDisSco.text += "" + i.score + "\n";
			scoredispcount++;
			if (scoredispcount > 10) {
				scoredispcount = 0;
				break;
			}
		}
		scDisPos.setTextFormat(scoreformat);
		scDisNam.setTextFormat(scoreformat);
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case backbtn:
				SoundManager.play("CLICK_SND", 0, 2);
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu }));
		}
	}
}