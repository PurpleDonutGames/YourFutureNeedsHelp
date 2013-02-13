package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Purple Donut Games
	 */
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			super(800, 600);
			FP.console.enable();
			FP.screen.color = 0xDAEAFA;
			FP.world = new GameWorld();
			
		}
		
	}
	
}