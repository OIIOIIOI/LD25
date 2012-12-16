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
	private var scoreDisplay :TextField;

	public function new()
	{
		super();
		scorebg = new SCOREBG();
		backbtn =  new BACKBTN();
		scoreDisplay = new TextField();
		
		//var scoreformat = new TextFormat("GoodDog", 32);
		var scoreformat = new TextFormat("TrueCrimes", 32);
		addChild(scorebg);
		addChild(backbtn);
		addChild(scoreDisplay);
		scoreDisplay.x = 100;
		scoreDisplay.y = 100;
		scoreDisplay.width = 300;
		scoreDisplay.height = 300;
		scoreDisplay.border = true;
		scoreDisplay.embedFonts = true;
		scoreDisplay.selectable = false;
		scoreDisplay.antiAliasType = AntiAliasType.ADVANCED;
		scoreDisplay.defaultTextFormat = scoreformat;
		scoreDisplay.text = "dfghjklmiuytr\n";
		for (i in ScoreManager.scoreBoard) {
			scoreDisplay.text += "" + i.name + "     " + i.score+"\n";
		}
		scoreDisplay.setTextFormat(scoreformat);
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case backbtn:
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu }));
		}
	}
}