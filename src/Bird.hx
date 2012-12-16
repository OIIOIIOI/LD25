package ;

import entities.Entity;
import entities.Poo;
import entities.Seed;
import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import haxe.Timer;
import scenes.Scene;
import scenes.Test;

/**
 * ...
 * @author 01101101
 */

class Bird extends Entity
{
	
	public var playerOperated:Bool;
	public var speed:Float;
	private var m_clip:Sprite;
	private var m_graph:BIRDMC;
	private var m_scene:Test;
	private var m_vx:Float;
	private var m_vy:Float;
	private var m_target:Entity;
	private var m_lastShot:Float;
	private var m_currentInterval:Float;
	private var m_state:String;
	public inline static var SHOOTING_INTERVAL:Int = 400;
	public inline static var SHOOTING_RANDOM:Float = 1;
	public inline static var ROTATION_SPEED:Float = 3;
	public inline static var STATE_NESTED:String = "state_nested";
	public inline static var STATE_FLYING:String = "state_flying";
	public inline static var STATE_CARRYING:String = "state_carrying";
	public inline static var STATE_DONE:String = "state_done";
	
	public function new (_scene:Test) {
		super();
		
		m_scene = _scene;
		playerOperated = (m_scene.mode == Test.MODE_BIRD);
		
		hitbox = new Rectangle(-20, -10, 40, 20);
		
		/*m_clip = new Sprite();
		m_clip.graphics.beginFill(0x000000);
		m_clip.graphics.drawRect(-20, -10, 40, 20);
		m_clip.graphics.endFill();
		m_clip.graphics.beginFill(0xFF0000);
		m_clip.graphics.drawRect(10, -10, 10, 20);
		m_clip.graphics.endFill();
		addChild(m_clip);*/
		
		m_graph = new BIRDMC();
		addChild(m_graph);
		
		m_state = STATE_NESTED;
		
		y = 250;
		speed = 5;
		m_vx = m_vy = 0;
		m_lastShot = Date.now().getTime();
		m_currentInterval = SHOOTING_INTERVAL + (Std.random(Std.int(SHOOTING_INTERVAL * SHOOTING_RANDOM)));
		
		if (playerOperated) {
			KeyboardManager.setCallback(Keyboard.SPACE, shoot);
		}
	}
	
	public function start () :Void {
		if (m_state != STATE_NESTED) return;
		m_graph.gotoAndStop(2);
		Timer.delay(realStart, 1000);
	}
	
	private function realStart () :Void {
		m_state = STATE_FLYING;
		m_graph.gotoAndPlay(3);
	}
	
	override public function update () :Void {
		super.update();
		
		if (m_state == STATE_NESTED) return;
		
		// User control
		if (playerOperated) {
			if (KeyboardManager.isDown(Keyboard.LEFT))
				rotation -= ROTATION_SPEED;
			if (KeyboardManager.isDown(Keyboard.RIGHT))
				rotation += ROTATION_SPEED;
		}
		
		// Auto choose target and shoot
		if (!playerOperated) {
			if (m_target == null && m_scene.seeds != null) {
				m_target = m_scene.seeds.splice(Std.random(m_scene.seeds.length), 1)[0];
			}
			if (m_target != null) {
				var _angle:Float = Math.atan2(m_target.y - y, m_target.x - x) * 180 / Math.PI;
				var _diff:Float = rotation - _angle;
				if (_diff > 0)
					_diff = Math.min(_diff, ROTATION_SPEED);
				else if (_diff < 0)
					_diff = Math.max(_diff, -ROTATION_SPEED);
				rotation -= _diff;
			}
			if (Date.now().getTime() - m_lastShot > m_currentInterval)
				shoot();
		}
		
		// Update
		x += Math.cos(degToRad(rotation)) * speed;
		x = Math.min(Math.max(x, 0), 900);
		y += Math.sin(degToRad(rotation)) * speed;
		y = Math.min(Math.max(y, 0), Game.BOTTOM_LINE);
		
		// Collisions
		/*hitbox.x = x - hitbox.width / 2;
		hitbox.y = y - hitbox.height / 2;
		for (_s in m_scene.seeds) {
			_s.hitbox.x = _s.x - _s.hitbox.width / 2;
			_s.hitbox.y = _s.y - _s.hitbox.height / 2;
			//trace(hitbox + " / " + _s.hitbox);
			if (hitbox.intersects(_s.hitbox)) {
				trace("hit");
			}
		}*/
		
		// Target change
		if (!playerOperated && m_target != null) {
			if (Math.abs(x - m_target.x) < 5 && Math.abs(y - m_target.y) < 5) {
				if (m_target != m_scene.nest)
					m_target = m_scene.nest;
				else
					m_target = null;
			}
		}
	}
	
	public function shoot () :Void {
		if (m_state != STATE_FLYING) return;
		if (playerOperated && Date.now().getTime() - m_lastShot < m_currentInterval) {
			return;
		}
		m_lastShot = Date.now().getTime();
		m_currentInterval = SHOOTING_INTERVAL + (Std.random(Std.int(SHOOTING_INTERVAL * SHOOTING_RANDOM)));
		EventManager.instance.dispatchEvent(new GameEvent(GameEvent.BIRD_SHOOT, {x:x, y:y} ));
	}
	
	public function degToRad(_deg:Float) :Float {
		return _deg * Math.PI / 180;
	}
	
}