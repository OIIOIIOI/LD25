package ;

import entities.Corn;
import entities.Seed;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.ui.Keyboard;

/**
 * ...
 * @author 01101101
 */

class RotTest extends Sprite
{
	
	private var m_clip:Sprite;
	private var m_tf:TextField;
	
	public function new () {
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	public function init (_event:Event) :Void {
		m_clip = new Sprite();
		
		m_clip.graphics.beginFill(0x000000);
		m_clip.graphics.moveTo(40, 0);
		m_clip.graphics.lineTo(-10, 20);
		m_clip.graphics.lineTo(-10, -20);
		m_clip.graphics.lineTo(40, 0);
		m_clip.graphics.endFill();
		
		m_clip.graphics.beginFill(0xFF0000);
		m_clip.graphics.moveTo(40, 0);
		m_clip.graphics.lineTo(-10, 0);
		m_clip.graphics.lineTo(-10, -20);
		m_clip.graphics.lineTo(40, 0);
		m_clip.graphics.endFill();
		
		m_clip.graphics.beginFill(0x00FF00);
		m_clip.graphics.drawCircle(25, -5, 5);
		m_clip.graphics.endFill();
		
		m_clip.x = stage.stageWidth / 2;
		m_clip.y = stage.stageHeight / 2;
		addChild(m_clip);
		
		m_tf = new TextField();
		m_tf.x = m_tf.y = 10;
		addChild(m_tf);
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	public function update (_event:Event) :Void {
		if (KeyboardManager.isDown(Keyboard.LEFT))
			m_clip.rotation -= 2;
		if (KeyboardManager.isDown(Keyboard.RIGHT))
			m_clip.rotation += 2;
		
		if (m_clip.rotation > 90) {
			m_clip.scaleX = -m_clip.scaleX;
			m_clip.rotation += 180;
		}
		else if (m_clip.rotation < -90) {
			m_clip.scaleX = -m_clip.scaleX;
			m_clip.rotation -= 180;
		}
		if (m_clip.rotation < 0)	m_clip.rotation += 360;
		if (m_clip.rotation > 360)	m_clip.rotation -= 360;
		
		var _speed:Float = 5 + m_clip.rotation / 90 * 3 * m_clip.scaleX;
		_speed = Math.max(_speed, 4);
		
		//m_clip.x += Math.cos(m_clip.rotation * Math.PI / 180) * _speed * m_clip.scaleX;
		//m_clip.y += Math.sin(m_clip.rotation * Math.PI / 180) * _speed * m_clip.scaleX;
		
		m_tf.text = m_clip.rotation + " / " + m_clip.scaleX + " / " + _speed;
	}
	
}



