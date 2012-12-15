package entities;
import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Corn extends Entity
{
	
	private var m_clip:Sprite;
	private var m_speed:Float;
	private var m_state:Int;
	
	public function new (_rotation:Float) {
		super();
		
		m_clip = new Sprite();
		m_clip.graphics.beginFill(0x000000);
		m_clip.graphics.drawRect(-4, -4, 8, 8);
		m_clip.graphics.endFill();
		addChild(m_clip);
		
		rotation = _rotation;
		m_state = 0;
		m_speed = 8;
	}
	
	override public function update () :Void {
		super.update();
		
		x += Math.cos(degToRad(rotation)) * m_speed;
		y += Math.sin(degToRad(rotation)) * m_speed;
		if (x < 0 || x > 900 || y < 0 || y > Game.BOTTOM_LINE) {
			EventManager.instance.dispatchEvent(new GameEvent(GameEvent.REMOVE_CORN, this));
		}
	}
	
	public function degToRad(_deg:Float) :Float {
		return _deg * Math.PI / 180;
	}
	
}