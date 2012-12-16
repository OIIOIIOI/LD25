package entities;

import events.EventManager;
import events.GameEvent;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import scenes.Test;

/**
 * ...
 * @author 01101101
 */

class Poo extends Entity
{
	
	private var m_clip:POO_SHOT;
	private var m_velocity:Point;
	private var m_state:Int;
	
	public function new (_velocity:Point) {
		super();
		
		m_clip = new POO_SHOT();
		addChild(m_clip);
		
		hitbox = new Rectangle(-6, -16, 12, 22);
		/*var _hit:Shape = new Shape();
		_hit.graphics.beginFill(0x00FFFF, 0.5);
		_hit.graphics.drawRect(hitbox.x, hitbox.y, hitbox.width, hitbox.height);
		_hit.graphics.endFill();
		addChild(_hit);*/
		
		m_state = 0;
		m_velocity = _velocity;
		m_velocity.y = Math.max(m_velocity.y, 3);
		m_velocity.x = Math.max(Math.min(m_velocity.x, 5), -5);
	}
	
	override public function update () :Void {
		super.update();
		
		if (m_state == 0) {
			x += m_velocity.x;
			m_velocity.y *= 1.1;
			m_velocity.y = Math.min(Math.max(m_velocity.y, 0), 10);
			y += m_velocity.y;
			if (y > Game.BOTTOM_LINE) {
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.POO_LANDING, this));
			}
		}
	}
	
}