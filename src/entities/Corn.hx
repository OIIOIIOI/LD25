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
	
	//private var m_clip:POPCORNMC;
	private var m_clip:STONEMC;
	private var m_speed:Float;
	private var m_state:Int;
	
	public function new (_rotation:Float) {
		super();
		
		//m_clip = new POPCORNMC();
		m_clip = new STONEMC();
		m_clip.gotoAndStop(Std.random(m_clip.totalFrames));
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