package entities;

import events.EventManager;
import events.GameEvent;

/**
 * ...
 * @author 01101101
 */

class Poodle extends Entity
{
	
	private var m_clip:POO_POODLE;
	
	public function new () {
		super();
		
		m_clip = new POO_POODLE();
		m_clip.gotoAndStop(Std.random(m_clip.totalFrames));
		addChild(m_clip);
	}
	
	override public function update () :Void {
		super.update();
		
		alpha -= 0.005;
		if (alpha <= 0) {
			EventManager.instance.dispatchEvent(new GameEvent(GameEvent.REMOVE_POO, this));
		}
	}
	
}