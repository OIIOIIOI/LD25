package entities;

import entities.Entity;
import entities.Poo;
import entities.Seed;
import events.EventManager;
import events.GameEvent;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import haxe.Timer;
import scenes.Scene;
import scenes.SoundManager;
import scenes.Play;

/**
 * ...
 * @author 01101101
 */

class Bird extends Entity
{
	
	public var playerOperated:Bool;
	public var speed:Float;
	private var m_clip:BIRDMC;
	private var m_scene:Play;
	private var m_vx:Float;
	private var m_vy:Float;
	private var m_target:Entity;
	private var m_lastShot:Float;
	private var m_currentInterval:Float;
	public var state:String;
	public inline static var SHOOTING_INTERVAL:Int = 400;
	public inline static var SHOOTING_RANDOM:Float = 1;
	public inline static var ROTATION_SPEED:Float = 3;
	public inline static var MOVEMENT_SPEED:Float = 6;
	public inline static var STATE_NESTED:String = "state_nested";
	public inline static var STATE_FLYING:String = "state_flying";
	public inline static var STATE_CARRYING:String = "state_carrying";
	public inline static var STATE_HURT:String = "state_hurt";
	public inline static var STATE_DONE:String = "state_done";
	
	public function new (_scene:Play) {
		super();
		
		m_scene = _scene;
		playerOperated = (m_scene.mode == Play.MODE_BIRD);
		
		m_clip = new BIRDMC();
		addChild(m_clip);
		
		hitbox = new Rectangle(-5, -10, 30, 24);
		/*var _hit:Shape = new Shape();
		_hit.graphics.beginFill(0xFFFF00, 0.8);
		_hit.graphics.drawRect(hitbox.x, hitbox.y, hitbox.width, hitbox.height);
		_hit.graphics.endFill();
		addChild(_hit);*/
		
		state = STATE_NESTED;
		
		speed = MOVEMENT_SPEED;
		m_vx = m_vy = 0;
		m_lastShot = Date.now().getTime();
		m_currentInterval = SHOOTING_INTERVAL + (Std.random(Std.int(SHOOTING_INTERVAL * SHOOTING_RANDOM)));
		
		if (playerOperated) {
			KeyboardManager.setCallback(Keyboard.SPACE, shoot);
		}
	}
	
	public function start () :Void {
		if (state != STATE_NESTED) return;
		m_clip.gotoAndStop(2);
		SoundManager.play("BIRD_CRY_SND");
		Timer.delay(realStart, 1000);
	}
	
	private function realStart () :Void {
		state = STATE_FLYING;
		m_clip.gotoAndPlay("fly");
		m_clip.body.gotoAndStop("fly");
	}
	
	override public function update () :Void {
		super.update();
		
		if (state == STATE_NESTED) return;
		
		// User control
		if (playerOperated) {
			if (KeyboardManager.isDown(Keyboard.LEFT) && state != STATE_HURT)
				rotation -= ROTATION_SPEED;
			if (KeyboardManager.isDown(Keyboard.RIGHT) && state != STATE_HURT)
				rotation += ROTATION_SPEED;
		}
		
		// Auto choose target and shoot
		if (!playerOperated) {
			if (m_target == null) {
				if (state == STATE_CARRYING) {
					m_target = m_scene.nest;
				}
				else if (m_scene.seeds != null) {
					m_target = m_scene.seeds.splice(Std.random(m_scene.seeds.length), 1)[0];
				}
				else trace("I WON, NOOB!");
			}
			if (m_target != null) {
				var _angle:Float = Math.atan2(m_target.y - y, m_target.x - x) * 180 / Math.PI;
				if (scaleX == -1) _angle += 180;
				if (Math.abs(_angle) > 180) {
					if (_angle > 0)	_angle -= 360;
					else			_angle += 360;
				}
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
		
		// Avoid flying belly-up
		if (rotation > 90) {
			scaleX = -scaleX;
			rotation += 180;
			SoundManager.play("BIRD_SPIN_SND");
		}
		else if (rotation < -90) {
			scaleX = -scaleX;
			rotation -= 180;
			SoundManager.play("BIRD_SPIN_SND");
		}
		
		// Speed depending on rotation
		speed = MOVEMENT_SPEED + rotation / 90 * 3 * scaleX;
		//speed = MOVEMENT_SPEED;
		speed = Math.max(speed, 5);
		
		// Update
		x += velocity.x;
		y += velocity.y;
		x = Math.min(Math.max(x, 30), 860);
		y = Math.min(Math.max(y, 30), Game.BOTTOM_LINE - 20);
		
		/*// Target change
		if (!playerOperated && m_target != null) {
			if (Math.abs(x - m_target.x) < 5 && Math.abs(y - m_target.y) < 5) {
				trace("ARRIVED");
				if (m_target != m_scene.nest) {
					trace("CHOOSE NEST");
					m_target = m_scene.nest;
				}
				else {
					m_target = null;
					trace("IA unload");
				}
			}
		}*/
	}
	
	public var velocity (getVelocity, null):Point;
	private function getVelocity () :Point {
		return new Point(Math.cos(rotation * Math.PI / 180) * speed * scaleX, Math.sin(rotation * Math.PI / 180) * speed * scaleX);
	}
	
	public function hurt () :Void {
		if (state == STATE_HURT) return;
		m_clip.body.gotoAndStop("hurt");
		state = STATE_HURT;
		SoundManager.play("BIRD_HURT_" + Std.random(3) + "_SND");
		Timer.delay(hurtEnd, 500);
	}
	
	public function hurtEnd () :Void {
		if (state == STATE_FLYING) return;
		m_clip.body.gotoAndStop("fly");
		state = STATE_FLYING;
	}
	
	public function grab () :Void {
		if (state == STATE_CARRYING) return;
		m_clip.body.gotoAndStop("carry");
		state = STATE_CARRYING;
		SoundManager.play("SEED_GRAB_SND");
		if (!playerOperated) {
			m_target = null;
		}
	}
	
	public function unload () :Void {
		if (state != STATE_CARRYING) return;
		m_clip.body.gotoAndStop("fly");
		state = STATE_FLYING;
		if (!playerOperated) {
			m_target = null;
		}
	}
	
	public function shoot () :Void {
		if (state != STATE_FLYING) return;
		if (playerOperated && Date.now().getTime() - m_lastShot < m_currentInterval) {
			return;
		}
		m_lastShot = Date.now().getTime();
		m_currentInterval = SHOOTING_INTERVAL + (Std.random(Std.int(SHOOTING_INTERVAL * SHOOTING_RANDOM)));
		EventManager.instance.dispatchEvent(new GameEvent(GameEvent.BIRD_SHOOT, {x:x, y:y} ));
	}
	
}