package  
{
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import physics.MoveableObject;
	import physics.PhysicsObject;
	
	/**
	 * ...
	 * @author Purple Donut Games
	 */
	public class GameWorld extends World 
	{
		
		public function GameWorld() 
		{
			add(new MoveableObject(100, 100, new Image(new BitmapData(30, 30, true, 0xFFFF00FF)), 500, Key.RIGHT, Key.LEFT, Key.SPACE, 200, 400));
		}
		
	}

}