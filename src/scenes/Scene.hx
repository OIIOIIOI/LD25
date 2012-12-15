package scenes;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

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
		addEventListener(MouseEvent.CLICK, clickHandler);
	}
	
	public function destroy () :Void {
		//trace("destroy");
	}
	
	private function clickHandler (_event:MouseEvent) :Void {
		
	}
	
}
