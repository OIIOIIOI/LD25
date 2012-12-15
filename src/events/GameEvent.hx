package events;

import flash.events.Event;

/**
 * ...
 * @author 01101101
 */

class GameEvent extends Event
{
	
	inline static public var CHANGE_SCENE:String = "change_scene";
	inline static public var LEVEL_PAUSED:String = "level_paused";
	
	public var data:Dynamic;
	
	public function new (type:String, ?_data:Dynamic = null, ?bubbles:Bool = false, ?cancelable:Bool = false) {
		data = _data;
		super(type, bubbles, cancelable);
	}
	
	public override function clone () :GameEvent {
		return new GameEvent(type, data, bubbles, cancelable);
	}
	
	public override function toString () :String {
		return formatToString("GameEvent", "data", "type", "bubbles", "cancelable", "eventPhase");
	}
	
}