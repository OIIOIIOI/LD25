package ;

import entities.Entity;
import entities.Poo;
import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;
import flash.ui.Keyboard;

/**
 * ...
 * @author 01101101
 */

class Bird extends Entity
{
	
	public var playerOperated:Bool;
	public var speed:Float;
	private var m_clip:Sprite;
	private var m_vx:Float;
	private var m_vy:Float;
	
	public function new (_player:Bool = false) {
		super();
		
		playerOperated = _player;
		
		m_clip = new Sprite();
		m_clip.graphics.beginFill(0x000000);
		m_clip.graphics.drawRect(-20, -10, 40, 20);
		m_clip.graphics.endFill();
		addChild(m_clip);
		
		y = 250;
		speed = 5;
		m_vx = m_vy = 0;
		
		if (playerOperated) {
			KeyboardManager.setCallback(Keyboard.SPACE, shoot);
		}
	}
	
	override public function update () :Void {
		super.update();
		
		if (playerOperated) {
			if (KeyboardManager.isDown(Keyboard.LEFT)) {
				rotation -= 3;
			}
			if (KeyboardManager.isDown(Keyboard.RIGHT)) {
				rotation += 3;
			}
		}
		
		x += Math.cos(degToRad(rotation)) * speed;
		x = Math.min(Math.max(x, 0), 900);
		y += Math.sin(degToRad(rotation)) * speed;
		y = Math.min(Math.max(y, 0), 500);
	}
	
	public function shoot () :Void {
		EventManager.instance.dispatchEvent(new GameEvent(GameEvent.BIRD_SHOOT, {x:x, y:y} ));
	}
	
	public function degToRad(_deg:Float) :Float {
		return _deg * Math.PI / 180;
	}
	
}