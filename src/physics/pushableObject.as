package physics 
{
	import flash.display.InteractiveObject;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Purple Donut Games
	 */
	public class pushableObject extends PhysicsObject 
	{
		/**
		 * An object that can be pushed around by moveableObject or its relatives
		 * @param	X		*inherited
		 * @param	Y		*inherited
		 * @param	img		*inherited
		 * @param	force	*inherited
		 * @param	weight	decides whether or not the player can move it: 0 being no weight and 100 being unmovable
		 */
		public function pushableObject(X:int, Y:int, img:Image, force:Number, weight:Number) 
		{
			super(X, Y, img, force);
			
			type = "pushable";
			
			_weight = weight;
		}
		
		override public function update():void 
		{
			if (checkCollision() != null)
			{
				push(checkCollision());
			}
			else
			{
				MoveableObject.currentPlayer._speed = MoveableObject.currentPlayer._defaultSpeed;
			}
			
			super.update();
		}
		
		public function checkCollision():MoveableObject
		{
			if (collide("moveable", x, y))
			{
				return MoveableObject.currentPlayer;
			}
			return null;
		}
		
		public function push(pusher:MoveableObject):void
		{
			if (pusher.y + pusher.height < y + height)
			{
				//on top of, no movement is made
				//TODO: add solidity to the blocks here
				pusher.velocity = 0;
				pusher.y = y - pusher.height;
				
				return;
			}
			if (pusher.x > x)
			{
				//to the right of the object
				x = pusher.x - width + _pushMargin;
			}
			else
			{
				//to the left of the object
				x = pusher.x + pusher.width + _pushMargin;
			}
			if(pusher._speed == pusher._defaultSpeed) pusher._speed *= ( -_weight / 100) + 1;
		}
		
		
		
		
		internal var _weight:Number;
		internal var _pusher:MoveableObject;
		internal var _pushMargin:Number = 2;
		
	}

}