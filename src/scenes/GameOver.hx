package scenes;

/**
 * ...
 * @author 01101101
 */

class GameOver extends Scene
{
	private var continuebtn :CONTINUEBTN;
	private var quitbtn :QUITBTN;
	
	public function new() 
	{
		super();
		continuebtn = new CONTINUEBTN();
		quitbtn = new QUITBTN();
		addChild(continuebtn);
		addChild(quitbtn);
		quitbtn.y = 40;
	}
	
}