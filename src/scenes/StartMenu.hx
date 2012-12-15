package scenes;

import events.EventManager;
import events.GameEvent;
import flash.events.MouseEvent;
import Game;
import scenes.Scene;

/**
 * ...
 * @author 01101101
 */

class StartMenu extends Scene
{
	
	private var btnGraphics:CREDITBTN;
	
	public function new () {
		super();
		/*m_test = new Sprite();
		m_test.graphics.beginFill(0x000000);
		m_test.graphics.drawRect(0, 0, 400, 200);
		m_test.graphics.endFill();
		m_test.buttonMode = true;
		addChild(m_test);*/
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case m_test:
				trace("youpi");
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.credits }));
		}
	}
	
}