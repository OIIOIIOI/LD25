package entities;
import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;
import flash.events.Event;
import haxe.Timer;

/**
 * ...
 * @author 01101101
 */

class Feathers extends Sprite
{
	
	private var m_clip:FEATHERS_BOOM;
	
	public function new () {
		m_clip = new FEATHERS_BOOM();
		addChild(m_clip);
		m_clip.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
	}
	
	private function enterFrameHandler (_event:Event) :Void {
		if (m_clip.currentFrame == m_clip.totalFrames) {
			m_clip.stop();
			Timer.delay(destroy, 21);
		}
	}
	
	private function destroy () :Void {
		EventManager.instance.dispatchEvent(new GameEvent(GameEvent.DESTROY_FEATHERS, {this} ));
	}
	
}