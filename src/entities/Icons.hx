package entities;

import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Icons extends Sprite
{
	
	private var m_clip:ICONSMC;
	
	public function new (_type:String) {
		m_clip = new ICONSMC();
		m_clip.graphics.beginFill(0xFF0000);
		m_clip.graphics.drawRect(0, 0, 30, 30);
		m_clip.graphics.endFill();
		m_clip.gotoAndStop(_type);
		addChild(m_clip);
	}
	
}