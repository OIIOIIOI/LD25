package scenes;

import entities.Corn;
import entities.Poo;
import entities.Scarecrow;
import events.EventManager;
import events.GameEvent;
import scenes.Scene;

/**
 * ...
 * @author 01101101
 */

class Test extends Scene
{
	
	inline static public var MODE_BIRD:String = "mode_bird";
	inline static public var MODE_SCARE:String = "mode_scare";
	
	public var mode:String;
	public var bird:Bird;
	public var scarecrow:Scarecrow;
	
	public function new (_mode:String) {
		super();
		
		mode = _mode;
		
		bird = new Bird(mode == MODE_BIRD);
		addChild(bird);
		m_entities.push(bird);
		
		scarecrow = new Scarecrow(mode == MODE_SCARE);
		addChild(scarecrow);
		m_entities.push(scarecrow);
		
		EventManager.instance.addEventListener(GameEvent.BIRD_SHOOT, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.SCARE_SHOOT, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.REMOVE_POO, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.REMOVE_CORN, gameEventHandler);
	}
	
	private function gameEventHandler (_event:GameEvent) :Void {
		switch (_event.type) {
			case GameEvent.BIRD_SHOOT:
				var _p:Poo = new Poo();
				_p.x = _event.data.x;
				_p.y = _event.data.y;
				addChild(_p);
				m_entities.push(_p);
			case GameEvent.SCARE_SHOOT:
				var _p:Corn = new Corn(scarecrow.aim.rotation - 90);
				_p.x = scarecrow.x + scarecrow.aim.x;
				_p.y = scarecrow.y + scarecrow.aim.y;
				addChild(_p);
				m_entities.push(_p);
			case GameEvent.REMOVE_POO:
				m_entities.remove(_event.data);
				removeChild(_event.data);
			case GameEvent.REMOVE_CORN:
				m_entities.remove(_event.data);
				removeChild(_event.data);
		}
	}
	
}