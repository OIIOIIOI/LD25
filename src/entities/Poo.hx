package entities;

import events.EventManager;
import events.GameEvent;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;
import scenes.Test;

/**
 * ...
 * @author 01101101
 */

class Poo extends Entity
{
	
	private var m_clip:POO_SHOT;
	private var m_vy:Float;
	private var m_state:Int;
	
	public function new () {
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
		m_vy = 1;
	}
	
	override public function update () :Void {
		super.update();
		
		if (m_state == 0) {
			m_vy *= 1.1;
			m_vy = Math.min(Math.max(m_vy, 0), 8);
			y += m_vy;
			if (y > Game.BOTTOM_LINE) {
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.POO_LANDING, this));
			}
		}
	}
	
}