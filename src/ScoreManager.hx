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
	
	public static function initScoreData (data:Array<Dynamic>):Void {
		scoreBoard = data.concat([]);
	}
	
	public static function saveScore (playerName:String):Void {
		scoreBoard.push( { name:playerName, score: score } );
		scoreBoard.sort(function(a:Int, b:Int) :Int { if (a > b) return 1; if (b > a) return -1; return 0; });
	}
	
	/*public function new() 
	{
		
	}*/
	
}