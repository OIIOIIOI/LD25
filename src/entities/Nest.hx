package entities;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Nest extends Entity
{
	
	private var m_clip:Sprite;
	
	public function new () {
		super();
		
		m_clip = new Sprite();
		m_clip.graphics.beginFill(0x000000);
		m_clip.graphics.drawRect(0, 0, 80, 20);
		m_clip.graphics.endFill();
		addChild(m_clip);
		
		x = 900 - width;
		y = 60;
	}
	
}