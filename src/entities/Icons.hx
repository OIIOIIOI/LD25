package entities;

import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Icons extends Sprite
{
	
	private var m_clip:Sprite;
	
	public function new () {
		m_clip = new Sprite();
		m_clip.graphics.beginFill(0xFF0000);
		m_clip.graphics.drawRect(0, 0, 30, 30);
		m_clip.graphics.endFill();
		addChild(m_clip);
	}
	
}