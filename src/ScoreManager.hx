package ;

/**
 * ...
 * @author 01101101
 */

class ScoreManager 
{
	public static var score :Int;
	public static var scoreBoard :Array<Dynamic>;
	
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
		trace(scoreBoard);
	}
	
	public static function initScoreData (data:Array<Dynamic>):Void {
		scoreBoard = data.concat([]);
	}
	
	public static function saveScore (playerName:String):Void {
		scoreBoard.push( { name:playerName, score: score } );
	}
	
	/*public function new() 
	{
		
	}*/
	
}