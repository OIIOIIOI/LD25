package entities;

import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Poo extends Entity
{
	
	private var m_clip:Sprite;
	private var m_vy:Float;
	private var m_state:Int;
	
	public function new () {
		super();
		
		m_clip = new Sprite();
		m_clip.graphics.beginFill(0x000000);
		m_clip.graphics.drawRect(-4, -4, 8, 8);
		m_clip.graphics.endFill();
		addChild(m_clip);
		
		m_state = 0;
		m_vy = 1;
	}
	
	override public function update () :Void {
		super.update();
		
		if (m_state == 0) {
			m_vy *= 1.1;
			m_vy = Math.min(Math.max(m_vy, 0), 5);
			y += m_vy;
			if (y > 500) {
				y = 500;
				m_state = 1;
			}
		}
		else if (m_state == 1) {
			alpha -= 0.01;
			if (alpha <= 0) {
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.REMOVE_POO, this));
			}
		}
	}
	
}