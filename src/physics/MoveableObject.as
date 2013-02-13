package physics 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Purple Donut Games
	 */
	public class MoveableObject extends PhysicsObject 
	{
		/**
		 * A simple back and forth keyboard dependant object with gravity
		 * @param	X: x position of the object
		 * @param	Y: y position of the object
		 * @param	img: image tacked to the object
		 * @param	force: amount of gravity acting upon the object
		 * @param	right: Key to move right direciton
		 * @param	left: key to move left direciton
		 * @param	speed: the top
		 */
		public function MoveableObject(X:int, Y:int, img:Image, force:Number, right:int, left:int, jump:int, speed:Number, jumpSpeed:Number) 
		{
			super(X, Y, img, force);
			
			_right = right;
			_left = left;
			_jump = jump;
			_speed = speed;
			_defaultSpeed = speed;
			_jumpSpeed = jumpSpeed;
			_currentPlayer = this;	//may want to take this out soon to avoid list setting bugs in the render list
			type = "moveable";
		}
		
		override public function update():void 
		{
			FP.log(velocity, "fl: " + falling, "gr: " + grounded, "fs: " + fallingStart, "gs: " + groundedStart);
			move();
			jump();
			gravity(force, grid);
		}
		
		public function move():void
		{
			if (Input.check(_right)) x += _speed * FP.elapsed;
			if (Input.check(_left)) x -= _speed * FP.elapsed;
		}
		
		public function jump():void
		{
			
			if (Input.pressed(_jump) && grounded)
			{
				_jumping = true;
				grounded = false;
				falling = true;
				velocity = -_jumpSpeed;
			}
			
			if (_jumping)
			{
				
				if (velocity > 10)
				{
					_jumping = false;
					falling = true;
				}
			}
		}
		
		override public function gravity(force:Number, grid:Grid = null):void 
		{
			
			if (!_jumping || collide("wall", x, y))
			{
				super.gravity(force, grid);
			}
			else
			{
				fall();
				groundedStart = false;
			}
		}
		
		public static function get currentPlayer():MoveableObject
		{
			return _currentPlayer;
		}
		
		/**
		 * system dependant variables
		 */
		
		/** @private */ internal var _right:int;
		/** @private */ internal var _left:int;
		/** @private */ internal var _jump:int;
		/** @private */ internal var _speed:Number;
		/** @private */ internal var _defaultSpeed:Number;
		/** @private */ internal var _jumpSpeed:Number;
		/** @private */ internal var _jumping:Boolean = false;
		
		/** @private */ internal static var _currentPlayer:MoveableObject;
		/** @private */ internal static var _copyList:Vector.<MoveableObject>; //to be used soon
		
	}

}