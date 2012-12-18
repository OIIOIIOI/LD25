package ;
import events.EventManager;
import events.GameEvent;

/**
 * ...
 * @author 01101101
 */

class ScoreManager
{
	public static var score :Int;
	public static var scoreBoard :Array<Dynamic>;
	public static var seedsDropped :Int;
	public static var birdLives :Int;
	public static var chain:Int;
	public static var ACTION_BASE_POINTS:Int = 100;
	//public static var CHAIN_MULTIPLIER:Float = 1;
	
	public static function reset ():Void {
		score = 0;
	}
	
	public static function add(amount:Int):Int{
		score += amount;
		return score;
	}
	
	public static function substract(amount:Int):Int{
		score -= amount;
		return score;
	}
	
	public static function multiply(amount:Int):Int{
		score *= amount;
		return score;
	}
	
	public static function fromHighToLow():Void {
		scoreBoard.sort(function(a:Dynamic, b:Dynamic):Int{ if (a.score < b.score) return 1; if (b.score < a.score) return -1; return 0; } );
		//trace(scoreBoard);
	}
	
	public static function initScoreData (data:Array<Dynamic>):Void {
		scoreBoard = data.concat([]);
	}
	
	public static function saveScore (playerName:String):Void {
		scoreBoard.push( { name:playerName, score: score } );
		fromHighToLow();
		Game.SO.data.scoresData = scoreBoard;
		Game.SO.flush();
	}
	
	public static function resetGame () :Void {
		seedsDropped = 0;
		birdLives = 3;
		score = 0;
		chain = 0;
	}
	
	public static function dropSeed () :Int {
		seedsDropped++;
		return seedsDropped;
	}
	
	public static function shootBird () :Int {
		birdLives--;
		return birdLives;
	}
	
	public static function validateAction () :Void {
		//trace("validateAction");
		score += Std.int(ACTION_BASE_POINTS * (1 + chain / 10));
		chain++;
	}
	
	public static function breakCombo () :Void {
		//trace("breakCombo");
		chain = 0;
	}
	
}










