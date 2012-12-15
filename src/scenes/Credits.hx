package scenes;

import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;
import flash.events.MouseEvent;
import Game;

/**
 * ...
 * @author 01101101
 */

class Credits extends Scene
{
	
	private var m_test:Sprite;
	
	public function new () {
		super();
		
		m_test = new Sprite();
		m_test.graphics.beginFill(0xFF0000);
		m_test.graphics.drawRect(0, 0, 400, 200);
		m_test.graphics.endFill();
		m_test.buttonMode = true;
		m_test.x = 200;
		m_test.y = 200;
		addChild(m_test);
	}
	
	override private function clickHandler (_event:MouseEvent) :Void {
		switch (_event.target) {
			case m_test:
				trace("youplala");
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.startMenu }));
		}
	}
	
}