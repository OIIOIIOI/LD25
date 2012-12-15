package scenes;

/**
 * ...
 * @author 01101101
 */

class GameOver extends Scene
{
	private var continuebtn :CONTINUEBTN;
	private var quitbtn :QUITBTN;
	private var gameoverbg :GAMEOVERBG;
	
	public function new() 
	{
		super();
		continuebtn = new CONTINUEBTN();
		quitbtn = new QUITBTN();
		gameoverbg = new GAMEOVERBG();
		addChild(gameoverbg);
		addChild(continuebtn);
		addChild(quitbtn);
		quitbtn.y = 40;
	}
	
}