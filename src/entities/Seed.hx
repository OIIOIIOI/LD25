package entities;

import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;
import scenes.SoundManager;
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
		
		m_clip = new SEEDMC();
		addChild(m_clip);
		
		hitbox = new Rectangle(-15, -15, 30, 30);
		/*var _hit:Shape = new Shape();
		_hit.graphics.beginFill(0xFFFF00, 0.8);
		_hit.graphics.drawRect(hitbox.x, hitbox.y, hitbox.width, hitbox.height);
		_hit.graphics.endFill();
		addChild(_hit);*/
		
		m_vy = 0;
		m_state = 0;
	}
	
	override public function update () :Void {
		super.update();
		
		if (y < Game.BOTTOM_LINE && m_state == 0) {
			m_vy = 2;
			m_state = 1;
		}
		
		if (m_state == 1) {
			m_vy *= 1.1;
			m_vy = Math.min(Math.max(m_vy, 0), 6);
			y += m_vy;
			if (y > Game.BOTTOM_LINE) {
				y = Game.BOTTOM_LINE;
				m_state = 0;
				SoundManager.play("SEED_LAND_SND");
			}
		}
	}
	
}