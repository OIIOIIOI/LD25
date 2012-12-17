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
import flash.media.SoundChannel;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import haxe.Timer;
import scenes.Scene;
import Game;

/**
 * ...
 * @author 01101101
 */

class Play extends Scene
{
	
	inline static public var MODE_BIRD:String = "mode_bird";
	inline static public var MODE_SCARE:String = "mode_scare";
	static public var DAY:Bool = true;
	
	public var mode:String;
	public var bird:Bird;
	public var scarecrow:Scarecrow;
	public var seeds:Array<Seed>;
	public var nest:Nest;
	public var goTF:TextField;
	private var m_container:Sprite;
	private var m_seedsContainer:Sprite;
	private var seedIcons:Sprite;
	private var heartsIcons:Sprite;
	private var m_bushes:BUSHES;
	private var m_started:Bool;
	private var m_channel:SoundChannel;
	
	public function new (_mode:String) {
		super();
		
		ScoreManager.resetGame();
		
		mode = _mode;
		m_started = false;
		
		DAY = (Std.random(2) % 2 == 0);
		
		var _sky:Sprite = (DAY) ? new DAYLIGHTBG() : new NIGHTLIGHTBG();
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
			_seed.y = Game.BOTTOM_LINE;
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
		
		if (!DAY) {
			var _nightFilter:Sprite = new Sprite();
			_nightFilter.graphics.beginFill(0x486985, 0.7);
			_nightFilter.graphics.drawRect(0, 0, 900, 500);
			_nightFilter.graphics.endFill();
			_nightFilter.blendMode = BlendMode.MULTIPLY;
			addChild(_nightFilter);
		}
		
		// Seeds icons
		seedIcons = new Sprite();
		seedIcons.x = seedIcons.y = 40;
		var _icon:ICONSMC;
		for (i in 0...3) {
			_icon = new ICONSMC();
			_icon.gotoAndStop("seed");
			_icon.x = i * 40;
			seedIcons.addChild(_icon);
		}
		addChild(seedIcons);
		
		// Hearts icons
		heartsIcons = new Sprite();
		var _icon:ICONSMC;
		for (i in 0...3) {
			_icon = new ICONSMC();
			_icon.gotoAndStop("heart");
			_icon.x = (-80) + i * 40;
			heartsIcons.addChild(_icon);
		}
		heartsIcons.x = 900 - 40;
		heartsIcons.y = seedIcons.y;
		addChild(heartsIcons);
		
		var _format:TextFormat = new TextFormat("TrashHand", 60, 0x000000);
		//var _format:TextFormat = new TextFormat("TrueCrimes", 24, 0x000000);
		_format.align = TextFormatAlign.CENTER;
		
		goTF = new TextField();
		goTF.embedFonts = true;
		goTF.antiAliasType = AntiAliasType.ADVANCED;
		goTF.defaultTextFormat = _format;
		goTF.selectable = false;
		goTF.text = "READY?";
		goTF.width = 400;
		goTF.height = 200;
		goTF.x = 450 - goTF.width / 2;
		goTF.y = 200;
		addChild(goTF);
		
		var _track:String = (DAY) ? "DAY_MUSIC" : "NIGHT_MUSIC";
		
		m_channel = SoundManager.play(_track, 0, 0.7);
		
		Timer.delay(start, 2000);
	}
	
	private function start () :Void {
		m_started = true;
		bird.start();
		scarecrow.start();
		EventManager.instance.addEventListener(GameEvent.BIRD_SHOOT, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.SCARE_SHOOT, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.POO_LANDING, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.REMOVE_POO, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.REMOVE_CORN, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.DESTROY_FEATHERS, gameEventHandler);
		EventManager.instance.addEventListener(GameEvent.END_GAME, gameEventHandler);
	}
	
	private function gameEventHandler (_event:GameEvent) :Void {
		switch (_event.type) {
			case GameEvent.BIRD_SHOOT:
				var _p:Poo = new Poo(bird.velocity);
				_p.x = _event.data.x;
				_p.y = _event.data.y;
				m_container.addChild(_p);
				m_entities.push(_p);
				SoundManager.play("BIRD_SHOOT_SND", 0, 0.2);
			case GameEvent.SCARE_SHOOT:
				var _p:Corn = new Corn(scarecrow.aim.rotation - 90);
				_p.x = scarecrow.x + scarecrow.aim.x;
				_p.y = scarecrow.y + scarecrow.aim.y;
				m_container.addChild(_p);
				m_entities.push(_p);
				SoundManager.play("SC_SHOOT_" + Std.random(3) + "_SND");
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
			case GameEvent.END_GAME:
				m_started = false;
				SoundManager.stop(m_channel);
				Timer.delay(callback(endGame, _event.data), 500);
			case GameEvent.DESTROY_FEATHERS:
				var _target:Sprite = _event.data;
				if (_target.parent != null)
					_target.parent.removeChild(_target);
				_target = null;
		}
	}
	
	private function endGame (_victory:Bool) :Void {
		var _scarecrow:Bool = false;
		if (_victory) {
			if (mode == MODE_SCARE) {
				SoundManager.play("BIRD_DIE_SND");
				_scarecrow = true;
			} else {
				SoundManager.play("SC_DIE_SND");
				_scarecrow = false;
			}
		} else {
			if (mode == MODE_SCARE) {
				SoundManager.play("SC_DIE_SND");
				_scarecrow = true;
			} else {
				SoundManager.play("BIRD_DIE_SND");
				_scarecrow = false;
			}
		}
		Timer.delay(callback(showGameOver, [_victory, _scarecrow]), 1500);
	}
	
	private function showGameOver (_params:Array<Bool>) :Void {
		EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CHANGE_SCENE, { scene:GameScene.gameover, param:_params } ));
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
			//trace("lock seed");
			bird.seed.state = Seed.STATE_LOCKED;
			bird.unload(true);
			var _droppedSeeds:Int = ScoreManager.dropSeed();
			for (i in 0..._droppedSeeds) {
				seedIcons.getChildAt(i).alpha = 0.5;
			}
			if (_droppedSeeds >= 3) {
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.END_GAME, (bird.playerOperated)));
			}
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
					bird.grab(cast(_p, Seed));
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
						SoundManager.play("BIRD_HURT_" + Std.random(3) + "_SND");
						var _seed:Seed = bird.seed;
						_seed.x = bird.x;
						_seed.y = Math.min(bird.y + 40, Game.BOTTOM_LINE - 50);
						//trace("shot carrying");
						bird.unload();
						m_seedsContainer.addChild(_seed);
						m_entities.push(_seed);
						//seeds.push(_seed);
					}
					else {
						//trace("real shot (" + bird.state + ")");
						bird.hurt();
						var _lives:Int = ScoreManager.shootBird();
						for (i in 0..._lives) {
							heartsIcons.getChildAt(i).alpha = 0.5;
						}
						if (_lives <= 0) {
							EventManager.instance.dispatchEvent(new GameEvent(GameEvent.END_GAME, (scarecrow.playerOperated)));
						}
					}
				}
			}
		}
		// Remove obsolete entities
		for (_p in _toKill) {
			m_entities.remove(_p);
			if (_p.parent != null)
				_p.parent.removeChild(_p);
		}
		_toKill = null;
	}
	
}