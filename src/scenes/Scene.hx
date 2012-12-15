package scenes;

import flash.display.DisplayObject;
import flash.display.Sprite;

/**
 * ...
 * @author 01101101
 */

class Scene extends Sprite
{
	
	public var entities:Array<DisplayObject>;
	public var theme:String;
	
	public function new () {
		super();
		entities = new Array<DisplayObject>();
	}
	
	public function destroy () :Void {
		trace("destroy");
	}
	
}
