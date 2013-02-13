package physics  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author Purple Donut Games
	 */
	public class PhysicsObject extends Entity 
	{
		/**
		 * A basic object with the ability to fall with gravity downward
		 * @param	X the x position of the object
		 * @param	Y the y position of the object
		 * @param	img an image to give the object
		 */
		public function PhysicsObject(X:int, Y:int, img:Image, force:Number) 
		{
			super(X, Y, img);
			setHitboxTo(img);
			_force = force;
		}
		
		/**
		 * whether or not the object is falling
		 */
		public var falling:Boolean = false;
		
		/**
		 * whether or not the object is on the ground
		 */
		public var grounded:Boolean = true;
		
		
		/**
		 * the first frame in which falling is initiated
		 */
		public var fallingStart:Boolean = true;
		
		/**
		 * the first frame in which the ground is hit
		 */
		public var groundedStart:Boolean = false;
		
		
		override public function update():void 
		{
			gravity(_force, _grid);
			super.update();
		}

		/**
		 * provides a falling step for the object
		 * @param	velocity the amount to step downward
		 */
		public function fall():void
		{
			_velocity += _force * FP.elapsed;
			y += _velocity * FP.elapsed;
		}
		
		/**
		 * checks the collision with the ground for the object
		 * @param	grid *optional, if not provided, goes by bottom of screen for ground
		 * @return 	whether ground is hit
		 */
		public function checkGround(grid:Grid = null):Boolean
		{
			if (grid == null)
			{
				if (y+this.height < FP.height)
				{
					return false;
				}
				return true;
			}
			else
			{
				var ent:Entity = new Entity(0, 0, null, grid);
				ent.type = "wall";
				if (collide("wall", x, y + this.height))
				{
					return true;
				}
				return false;
			}
			return false;
		}
		
		/**
		 * the global control function for gravitational pull
		 * @param	force the amount of gravity acting between 0 and 100
		 * @param	grid the grid to pass to the check ground funciton *not needed
		 */
		public function gravity(force:Number, grid:Grid = null):void
		{
			if (checkGround())
			{
				if (falling == true && grounded == false) groundedStart = true;
				else groundedStart = false;
				
				falling = false;
				grounded = true;
			}
			else
			{
				if (falling == false && grounded == true) fallingStart = true;
				else fallingStart = false;
				
				falling = true;
				grounded = false;
			}
			
			_force = force;
			
			if (groundedStart)
			{
				snapToGround(30);
			}
			if (fallingStart)
			{
				startFall();
			}
			
			if (falling) fall();
			
			
		}
		
		public function startFall():void
		{
			_velocity += _force;
		}
		
		public function snapToGround(snap:int):void
		{
			y = Math.floor(y / snap) * snap;
			_velocity = 0;
		}
		
		
		public function get force():Number
		{
			return _force;
		}
		public function set force(value:Number):void
		{
			_force = value
			return;
		}
		
		public function get grid():Grid
		{
			return _grid;
		}
		public function set grid(value:Grid):void
		{
			_grid = value;
		}
		
		public function get velocity():Number
		{
			return _velocity;
		}
		public function set velocity(value:Number):void
		{
			_velocity = value;
		}
		
		/**
		 * system dependant variables
		 */
		
		/** @private */ internal var _force:Number;
		/** @private */ internal var _grid:Grid;
		/** @private */ internal var _velocity:Number = 0;
	}

}



