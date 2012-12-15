package scenes;

import entities.Entity;
import flash.display.Sprite;
import flash.events.MouseEvent;

/**
 * ...
 * @author 01101101
 */

class Scene extends Sprite
{
	
	private var m_entities:Array<Entity>;
	public var theme:String;
	
	public function new () {
		super();
		m_entities = new Array<Entity>();
		addEventListener(MouseEvent.CLICK, clickHandler);
	}
	
	public function destroy () :Void {
		//trace("destroy");
	}
	
	private function clickHandler (_event:MouseEvent) :Void {
		
	}
	
	public function update () :Void {
		for (_e in m_entities) {
			_e.update();
		}
	}
	
}
