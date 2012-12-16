package ;

import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.Lib;

/**
 * ...
 * @author 01101101
 */

class Main
{
	
	static function main()
	{
		// Init
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.quality = StageQuality.LOW;
		// Keyboard
		KeyboardManager.init(Lib.current.stage);
		// Create and add game
		Lib.current.stage.addChild(new Game());
		//Lib.current.stage.addChild(new RotTest());
	}
	
}