package entities;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;

/**
 * ...
 * @author 01101101
 */

class Nest extends Entity
{
	
	private var m_clip:NESTMC;
	
	public function new () {
		super();
		
		m_clip = new NESTMC();
		addChild(m_clip);
		
		hitbox = new Rectangle(-25, -5, 50, 30);
		/*var _hit:Shape = new Shape();
		_hit.graphics.beginFill(0xFFFF00, 0.8);
		_hit.graphics.drawRect(hitbox.x, hitbox.y, hitbox.width, hitbox.height);
		_hit.graphics.endFill();
		addChild(_hit);*/
	}
	
}