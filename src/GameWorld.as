package  
{
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import physics.MoveableObject;
	import physics.PhysicsObject;
	import physics.pushableObject;
	
	/**
	 * ...
	 * @author Purple Donut Games
	 */
	public class GameWorld extends World 
	{
		
		public function GameWorld() 
		{
			add(new MoveableObject(100, 100, new Image(new BitmapData(40, 80, true, 0xFFFF00FF)), 500, Key.RIGHT, Key.LEFT, Key.SPACE, 200, 400));
			add(new pushableObject(500, 100, new Image(new BitmapData(40, 40, true, 0xFFFF0000)), 500, 50));
		}
		
	}

}