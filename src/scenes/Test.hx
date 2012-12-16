package scenes;

import entities.Corn;
import entities.Entity;
import entities.Nest;
import entities.Poo;
import entities.Poodle;
import entities.Scarecrow;
import entities.Seed;
import events.EventManager;
import events.GameEvent;
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
	private var m_started:Bool;
	
	public function new (_mode:String) {
		super();
		
		mode = _mode;
		m_started = false;
		
		var _background:GAMEBG = new GAMEBG();
		addChild(_background);
		
		scarecrow = new Scarecrow(this);
		addChild(scarecrow);
		m_entities.push(scarecrow);
		
		seeds = new Array<Seed>();
		var _seed:Seed;
		for (_i in 0...3) {
			_seed = new Seed();
			_seed.x = Std.random(640) + 100;
			_seed.y = Game.BOTTOM_LINE;
			addChild(_seed);
			m_entities.push(_seed);
			seeds.push(_seed);
		}
		
		nest = new Nest();
		addChild(nest);
		
		bird = new Bird(this);
		addChild(bird);
		m_entities.push(bird);
		
		var _bushes:BUSHES = new BUSHES();
		_bushes.y = 500;
		addChild(_bushes);
		
		Timer.delay(start, 2000);
		/*EventManager.instance.addEventListener(GameEvent.BIRD_SHOOT, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.SCARE_SHOOT, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.POO_LANDING, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.REMOVE_POO, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.REMOVE_CORN, gameEventHandler);*/
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
				var _p:Poo = new Poo();
				_p.x = _event.data.x;
				_p.y = _event.data.y;
				addChild(_p);
				m_entities.push(_p);
			case GameEvent.SCARE_SHOOT:
				var _p:Corn = new Corn(scarecrow.aim.rotation - 90);
				_p.x = scarecrow.x + scarecrow.aim.x;
				_p.y = scarecrow.y + scarecrow.aim.y;
				addChild(_p);
				m_entities.push(_p);
			case GameEvent.POO_LANDING:
				var _q:Poodle = new Poodle();
				_q.x = _event.data.x;
				_q.y = _event.data.y;
				addChild(_q);
				m_entities.push(_q);
				m_entities.remove(_event.data);
				removeChild(_event.data);
			case GameEvent.REMOVE_POO:
				m_entities.remove(_event.data);
				removeChild(_event.data);
			case GameEvent.REMOVE_CORN:
				m_entities.remove(_event.data);
				removeChild(_event.data);
		}
	}
	
	override public function update () :Void {
		super.update();
		
		if (!m_started) return;
		
		var _scareHB:Rectangle = scarecrow.hitbox.clone();
		_scareHB.x += scarecrow.x;
		_scareHB.y += scarecrow.y;
		var _pooHB:Rectangle;
		var _toKill:Array<Entity> = new Array<Entity>();
		for (_p in m_entities) {
			if (Std.is(_p, Poo)) {
				_pooHB = _p.hitbox.clone();
				_pooHB.x += _p.x;
				_pooHB.y += _p.y;
				if (_scareHB.intersects(_pooHB)) {
					_toKill.push(_p);
					scarecrow.hurt();
				}
			}
		}
		for (_p in _toKill) {
			m_entities.remove(_p);
			removeChild(_p);
		}
		_toKill = null;
	}
	
}