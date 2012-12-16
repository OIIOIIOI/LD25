package entities;

import flash.display.Sprite;
import flash.geom.Rectangle;
import scenes.Test;

/**
 * ...
 * @author 01101101
 */

class Seed extends Entity
{
	
	private var m_clip:SEEDMC;
	private var m_vy:Float;
	private var m_state:Int;
	
	public function new () {
		super();
		
		hitbox = new Rectangle(-10, -10, 20, 20);
		
		m_clip = new SEEDMC();
		addChild(m_clip);
		
		m_vy = 0;
		m_state = 0;
	}
	
	override public function update () :Void {
		super.update();
		
		if (y < Game.BOTTOM_LINE && m_state == 0) {
			m_vy = 1;
			m_state = 1;
		}
		
		if (m_state == 1) {
			m_vy *= 1.1;
			m_vy = Math.min(Math.max(m_vy, 0), 5);
			y += m_vy;
			if (y > Game.BOTTOM_LINE) {
				y = Game.BOTTOM_LINE;
				m_state = 0;
			}
		}
	}
	
}