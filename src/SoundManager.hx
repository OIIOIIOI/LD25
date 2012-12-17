package ;

import flash.events.TimerEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.utils.Timer;

/**
 * ...
 * @author 01101101
 */

class SoundManager
{
	public static function play (Soundclass:String, ?loop:Int = 0, ?vol:Float = 1, ?balance:Float = 0) :SoundChannel {
		var _resolvedClass:Class<Dynamic> = Type.resolveClass(Soundclass);
		if (_resolvedClass == null) return null;
		var sound:Sound = Type.createInstance(_resolvedClass, []);
		if (sound == null) return null;
		var soundtransform:SoundTransform = new SoundTransform(vol,balance);
		return sound.play(0, loop, soundtransform);
	}
	
	public static function stop(soundchannel:SoundChannel):Void {
		soundchannel.stop();
	}
	
	public static function fade(soundchannel:SoundChannel, duration:Float, inOut:Bool):Void {
		var fadetimer :Timer;
		var currentvolume :Float;
		currentvolume = soundchannel.soundTransform.volume;
		fadetimer = new Timer(duration / 20);
		function fadestep(te:TimerEvent):Void {
			if (inOut == true) {
				currentvolume += 0.05;
				soundchannel.soundTransform = new SoundTransform(currentvolume);
				if (currentvolume >= 1) {
					fadetimer.stop();
				}
			}else {
				currentvolume -= 0.05;
				soundchannel.soundTransform = new SoundTransform(currentvolume);
				if (currentvolume <= 0) {
					fadetimer.stop();
				}
			}
		}
		fadetimer.addEventListener(TimerEvent.TIMER, fadestep);
		fadetimer.start();
	}
	
	/*public function new()
	{
		
	}*/
	
}