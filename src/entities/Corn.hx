package entities;
import events.EventManager;
import events.GameEvent;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;

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
		
		hitbox = new Rectangle(-5, -5, 10, 10);
		/*var _hit:Shape = new Shape();
		_hit.graphics.beginFill(0xFFFF00, 0.8);
		_hit.graphics.drawRect(hitbox.x, hitbox.y, hitbox.width, hitbox.height);
		_hit.graphics.endFill();
		addChild(_hit);*/
		
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