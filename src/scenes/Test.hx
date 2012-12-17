package scenes;

import entities.Bird;
import entities.Corn;
import entities.Entity;
import entities.Nest;
import entities.Poo;
import entities.Poodle;
import entities.Scarecrow;
import entities.Seed;
import events.EventManager;
import events.GameEvent;
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxe.Timer;
import scenes.Scene;

/**
 * ...
 * @author 01101101
 */

class Test extends Scene
{
	
	inline static public var MODE_BIRD:String = "mode_bird";
	inline static public var MODE_SCARE:String = "mode_scare";
	
	public var mode:String;
	public var bird:Bird;
	public var scarecrow:Scarecrow;
	public var seeds:Array<Seed>;
	public var nest:Nest;
	private var m_container:Sprite;
	private var m_seedsContainer:Sprite;
	private var m_bushes:BUSHES;
	private var m_started:Bool;
	
	public function new (_mode:String) {
		super();
		
		mode = _mode;
		m_started = false;
		
		var _sky:Sprite = (true) ? new DAYLIGHTBG() : new NIGHTLIGHTBG();
		addChild(_sky);
		
		var _background:GAMEBG = new GAMEBG();
		addChild(_background);
		
		scarecrow = new Scarecrow(this);
		addChild(scarecrow);
		m_entities.push(scarecrow);
		
		m_seedsContainer = new Sprite();
		
		seeds = new Array<Seed>();
		var _seed:Seed;
		for (_i in 0...3) {
			_seed = new Seed();
			_seed.x = Std.random(200) + 80 + _i * 235;
			_seed.y = Game.BOTTOM_LINE - 50;
			m_seedsContainer.addChild(_seed);
			m_entities.push(_seed);
			seeds.push(_seed);
		}
		
		nest = new Nest();
		nest.x = 900 - 128;
		nest.y = 120;
		addChild(nest);
		
		bird = new Bird(this);
		bird.x = nest.x;
		bird.y = nest.y;
		bird.scaleX = -1;
		addChild(bird);
		m_entities.push(bird);
		
		m_container = new Sprite();
		addChild(m_container);
		
		addChild(m_seedsContainer);
		
		m_bushes = new BUSHES();
		m_bushes.y = 500;
		addChild(m_bushes);
		
		if (!true) {
			var _nightFilter:Sprite = new Sprite();
			_nightFilter.graphics.beginFill(0x486985, 0.7);
			_nightFilter.graphics.drawRect(0, 0, 900, 500);
			_nightFilter.graphics.endFill();
			_nightFilter.blendMode = BlendMode.MULTIPLY;
			addChild(_nightFilter);
		}
		
		Timer.delay(start, 2000);
	}
	
	private function start () :Void {
		m_started = true;
		bird.start();
		EventManager.instance.addEventListener(GameEvent.BIRD_SHOOT, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.SCARE_SHOOT, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.POO_LANDING, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.REMOVE_POO, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.REMOVE_CORN, gameEventHandler);
	}
	
	private function gameEventHandler (_event:GameEvent) :Void {
		switch (_event.type) {
			case GameEvent.BIRD_SHOOT:
				var _p:Poo = new Poo(bird.velocity);
				_p.x = _event.data.x;
				_p.y = _event.data.y;
				m_container.addChild(_p);
				m_entities.push(_p);
				SoundManager.play("BIRD_SHOOT_SND");
			case GameEvent.SCARE_SHOOT:
				var _p:Corn = new Corn(scarecrow.aim.rotation - 90);
				_p.x = scarecrow.x + scarecrow.aim.x;
				_p.y = scarecrow.y + scarecrow.aim.y;
				m_container.addChild(_p);
				m_entities.push(_p);
			case GameEvent.POO_LANDING:
				var _q:Poodle = new Poodle();
				_q.x = _event.data.x;
				_q.y = _event.data.y;
				m_container.addChild(_q);
				m_entities.push(_q);
				m_entities.remove(_event.data);
				m_container.removeChild(_event.data);
				SoundManager.play("POO_LAND_SND");
			case GameEvent.REMOVE_POO:
				m_entities.remove(_event.data);
				m_container.removeChild(_event.data);
			case GameEvent.REMOVE_CORN:
				m_entities.remove(_event.data);
				m_container.removeChild(_event.data);
		}
	}
	
	override public function update () :Void {
		super.update();
		
		if (!m_started) return;
		
		// Hitbox scarecrow
		var _scareHB:Rectangle = scarecrow.hitbox.clone();
		_scareHB.x += scarecrow.x;
		_scareHB.y += scarecrow.y;
		// Hitbox next
		var _nestHB:Rectangle = nest.hitbox.clone();
		_nestHB.x += nest.x;
		_nestHB.y += nest.y;
		// Hitbox scarecrow
		var _birdHB:Rectangle = bird.hitbox.clone();
		_birdHB.x += bird.x;
		_birdHB.y += bird.y;
		// Collisions
		if (bird.state == Bird.STATE_CARRYING && _nestHB.intersects(_birdHB)) {
			bird.unload();
			SoundManager.play("PROGRESS_3_SND");
		}
		var _tempHB:Rectangle;
		var _toKill:Array<Entity> = new Array<Entity>();
		for (_p in m_entities) {
			// Poo/scarecrow collisions
			if (Std.is(_p, Poo)) {
				_tempHB = _p.hitbox.clone();
				_tempHB.x += _p.x;
				_tempHB.y += _p.y;
				if (_scareHB.intersects(_tempHB)) {
					_toKill.push(_p);
					scarecrow.hurt();
				}
			}
			// Seed/bird collisions
			else if (Std.is(_p, Seed) && bird.state != Bird.STATE_CARRYING) {
				_tempHB = _p.hitbox.clone();
				_tempHB.x += _p.x;
				_tempHB.y += _p.y;
				if (_birdHB.intersects(_tempHB)) {
					_toKill.push(_p);
					bird.grab();
				}
			}
			// Corn/bird collisions
			else if (Std.is(_p, Corn)) {
				_tempHB = _p.hitbox.clone();
				_tempHB.x += _p.x;
				_tempHB.y += _p.y;
				if (_birdHB.intersects(_tempHB)) {
					_toKill.push(_p);
					if (bird.state == Bird.STATE_CARRYING) {
						bird.unload();
						SoundManager.play("BIRD_HURT_" + Std.random(3) + "_SND");
						var _seed:Seed = new Seed();
						_seed.x = bird.x;
						_seed.y = Math.min(bird.y + 40, Game.BOTTOM_LINE - 50);
						//trace(bird.x + " / " + bird.y);
						m_seedsContainer.addChild(_seed);
						m_entities.push(_seed);
						seeds.push(_seed);
					}
					else
						bird.hurt();
				}
			}
		}
		// Remove obsolete entities
		for (_p in _toKill) {
			m_entities.remove(_p);
			_p.parent.removeChild(_p);
			//m_container.removeChild(_p);
		}
		_toKill = null;
	}
	
}