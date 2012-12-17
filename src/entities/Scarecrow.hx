package entities;

import entities.Bird;
import events.EventManager;
import events.GameEvent;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import haxe.Timer;
import scenes.Play;

/**
 * ...
 * @author 01101101
 */

class Scarecrow extends Entity
{
	
	public var playerOperated:Bool;
	public var aim:AIMMC;
	private var m_clip:SCARECROWMC;
	private var m_scene:Play;
	private var lastShot:Float;
	private var m_currentInterval:Float;
	private var m_state:String;
	public inline static var SHOOTING_INTERVAL:Int = 400;
	public inline static var SHOOTING_RANDOM:Float = 1;
	public inline static var ROTATION_SPEED:Float = 3;
	public inline static var STATE_IDLE:String = "state_idle";
	public inline static var STATE_HURT:String = "state_hurt";
	
	public function new (_scene:Play) {
		super();
		
		m_state = STATE_IDLE;
		
		m_scene = _scene;
		playerOperated = (m_scene.mode == Play.MODE_SCARE);
		
		m_clip = new SCARECROWMC();
		addChild(m_clip);
		
		aim = new AIMMC();
		aim.y = -180;
		if (playerOperated) addChild(aim);
		
		hitbox = new Rectangle(-45, -225, 75, 40);
		/*var _hit:Shape = new Shape();
		_hit.graphics.beginFill(0xFFFF00, 0.5);
		_hit.graphics.drawRect(hitbox.x, hitbox.y, hitbox.width, hitbox.height);
		_hit.graphics.endFill();
		addChild(_hit);*/
		
		x = 300;
		y = Game.BOTTOM_LINE - 10;
		lastShot = Date.now().getTime();
		m_currentInterval = SHOOTING_INTERVAL + (Std.random(Std.int(SHOOTING_INTERVAL * SHOOTING_RANDOM)));
	}
	
	public function start () :Void {
		if (playerOperated) SoundManager.play("SC_CRY_SND");
		Timer.delay(realStart, 1000);
	}
	
	private function realStart () :Void {
		if (playerOperated) {
			KeyboardManager.setCallback(Keyboard.SPACE, shoot);
		}
	}
	
	override public function update () :Void {
		super.update();
		
		if (playerOperated) {
			if (KeyboardManager.isDown(Keyboard.LEFT))
				aim.rotation -= ROTATION_SPEED;
			if (KeyboardManager.isDown(Keyboard.RIGHT))
				aim.rotation += ROTATION_SPEED;
		}
		else {
			var _bird:Bird = cast(Game.instance.scene, Play).bird;
			aim.rotation = getTargetRotation(_bird);
		}
		
		if (!playerOperated && Date.now().getTime() - lastShot > m_currentInterval &&
			m_state != STATE_HURT && m_scene.bird.state != Bird.STATE_NESTED)
			shoot();
	}
	
	public function hurt () :Void {
		if (m_state == STATE_HURT) return;
		m_clip.gotoAndPlay("hurt");
		m_state = STATE_HURT;
		SoundManager.play("SC_HURT_" + Std.random(3) + "_SND");
		Timer.delay(hurtEnd, 2000);
	}
	
	public function hurtEnd () :Void {
		if (m_state == STATE_IDLE) return;
		m_clip.gotoAndStop("idle");
		m_state = STATE_IDLE;
	}
	
	public function shoot () :Void {
		if (playerOperated && Date.now().getTime() - lastShot < m_currentInterval)
			return;
		lastShot = Date.now().getTime();
		m_currentInterval = SHOOTING_INTERVAL + (Std.random(Std.int(SHOOTING_INTERVAL * SHOOTING_RANDOM)));
		EventManager.instance.dispatchEvent(new GameEvent(GameEvent.SCARE_SHOOT, { rotation:aim.rotation } ));
		m_clip.gotoAndPlay("shoot");
	}
	
	public function getTargetRotation (_bird:Bird) :Float {
		var _point:Point = predictPosition(_bird, 30);
		var _angle:Float;
		_angle = Math.atan2(_point.y - (y + aim.y), _point.x - (x + aim.x));
		_angle = _angle * 180 / Math.PI;
		_angle += 90;
		return _angle;
	}
	
	public function predictPosition (_bird:Bird, _int:Int = 0) :Point {
		var _point:Point = new Point(_bird.x, _bird.y);
		while (_int > 0) {
			_point.x += _bird.velocity.x;
			_point.y += _bird.velocity.y;
			_int--;
		}
		_point.x = Math.min(Math.max(_point.x, 0), 900);
		_point.y = Math.min(Math.max(_point.y, 0), Game.BOTTOM_LINE);
		return _point;
	}
	
	public function degToRad(_deg:Float) :Float {
		return _deg * Math.PI / 180;
	}
	
}