package entities;

import flash.display.Sprite;
import flash.geom.Rectangle;

/**
 * ...
 * @author 01101101
 */

class Entity extends Sprite
{
	
	public var hitbox:Rectangle;
	
	public function new () {
		super();
		hitbox = new Rectangle(-5, -5, 10, 10);
	}
	
	public function update () :Void {
		
	}
	
}