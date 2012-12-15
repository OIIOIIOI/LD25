package entities;

import Bird;
import events.EventManager;
import events.GameEvent;
import flash.display.Sprite;
import flash.geom.Point;
import flash.ui.Keyboard;
import scenes.Test;

/**
 * ...
 * @author 01101101
 */

class Scarecrow extends Entity
{
	
	public var playerOperated:Bool;
	public var aim:Sprite;
	private var m_clip:Sprite;
	private var m_scene:Test;
	private var test:Int;
	private var lastShot:Float;
	private var m_currentInterval:Float;
	public inline static var SHOOTING_INTERVAL:Int = 300;
	public inline static var SHOOTING_RANDOM:Float = 1;
	public inline static var ROTATION_SPEED:Float = 4;
	
	public function new (_scene:Test) {
		super();
		
		m_scene = _scene;
		playerOperated = (m_scene.mode == Test.MODE_SCARE);
		
		m_clip = new Sprite();
		m_clip.graphics.beginFill(0x000000);
		m_clip.graphics.drawRect(-40, -160, 80, 160);
		m_clip.graphics.endFill();
		addChild(m_clip);
		
		aim = new Sprite();
		aim.graphics.beginFill(0xFF0000);
		aim.graphics.drawRect(-1, -100, 2, 100);
		aim.graphics.endFill();
		aim.y = -120;
		addChild(aim);
		
		x = 300;
		y = Game.BOTTOM_LINE;
		lastShot = Date.now().getTime();
		m_currentInterval = SHOOTING_INTERVAL + (Std.random(Std.int(SHOOTING_INTERVAL * SHOOTING_RANDOM)));
		
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
			var _bird:Bird = cast(Game.instance.scene, Test).bird;
			aim.rotation = getTargetRotation(_bird);
		}
		
		if (!playerOperated && Date.now().getTime() - lastShot > m_currentInterval)
			shoot();
	}
	
	public function shoot () :Void {
		if (playerOperated && Date.now().getTime() - lastShot < m_currentInterval)
			return;
		lastShot = Date.now().getTime();
		m_currentInterval = SHOOTING_INTERVAL + (Std.random(Std.int(SHOOTING_INTERVAL * SHOOTING_RANDOM)));
		EventManager.instance.dispatchEvent(new GameEvent(GameEvent.SCARE_SHOOT, {rotation:aim.rotation} ));
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
			_point.x += Math.cos(degToRad(_bird.rotation)) * _bird.speed;
			_point.y += Math.sin(degToRad(_bird.rotation)) * _bird.speed;
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