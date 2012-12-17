package entities;

import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;
import scenes.Play;

/**
 * ...
 * @author 01101101
 */

class Seed extends Entity
{
	
	public var state:String;
	public inline static var STATE_IDLE:String = "state_idle";
	public inline static var STATE_FALLING:String = "state_falling";
	public inline static var STATE_LOCKED:String = "state_locked";
	private var m_clip:SEEDMC;
	private var m_vy:Float;
	
	public function new () {
		super();
		
		m_clip = new SEEDMC();
		addChild(m_clip);
		
		hitbox = new Rectangle(-15, -15, 30, 30);
		/*var _hit:Shape = new Shape();
		_hit.graphics.beginFill(0xFFFF00, 0.8);
		_hit.graphics.drawRect(hitbox.x, hitbox.y, hitbox.width, hitbox.height);
		_hit.graphics.endFill();
		addChild(_hit);*/
		
		m_vy = 0;
		state = STATE_IDLE;
	}
	
	override public function update () :Void {
		super.update();
		
		if (y < Game.BOTTOM_LINE && state == STATE_IDLE) {
			m_vy = 2;
			state = STATE_FALLING;
		}
		
		if (state == STATE_FALLING) {
			m_vy *= 1.1;
			m_vy = Math.min(Math.max(m_vy, 0), 6);
			y += m_vy;
			if (y > Game.BOTTOM_LINE) {
				y = Game.BOTTOM_LINE;
				state = STATE_IDLE;
				SoundManager.play("SEED_LAND_SND");
			}
		}
	}
	
}