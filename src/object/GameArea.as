package object {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.geom.Point;
	import flash.display.Sprite;
	
	import object.platform.Ground;
	import object.platform.Platform;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Publik klass som hanterar spelplanens plattformar
	 */
	public class GameArea extends Sprite {
		
		// --------------------------------------------------------
		// Private Static Properties
		// --------------------------------------------------------
		private static var PLATFORMS:Vector.<Platform> = new Vector.<Platform>();
				
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _ground:Ground;
		private var _platform:Platform;
		private var _platforms:Vector.<Platform> = new Vector.<Platform>();
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const GROUND_X:Number = -100;
		private static const GROUND_Y:Number = 550;
				
		private static const PLATFORMPOSITION_BIG:Vector.<Point> = new Vector.<Point>();
		private static const PLATFORMPOSITION_SMALL:Vector.<Point> = new Vector.<Point>();		
			
		PLATFORMPOSITION_BIG.push(new Point(-100, 400));
		PLATFORMPOSITION_BIG.push(new Point(500, 400));
	
		PLATFORMPOSITION_BIG.push(new Point(-200, 250));
		PLATFORMPOSITION_SMALL.push(new Point(300, 250));
		PLATFORMPOSITION_BIG.push(new Point(600, 250));
		
		// --------------------------------------------------------
		// Public Getter
		// --------------------------------------------------------
		
		/**
		 *	Getter som returnerar plattformar från vektorn PLATFORMS
		 * 
		 * 	@return Vector.<Platform>
		 */
		public static function get platforms():Vector.<Platform> {
			return PLATFORMS;
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function GameArea() {
			this.init();
		}
		
		// --------------------------------------------------------
		// Public Methods
		// --------------------------------------------------------
		public function init():void {
			this.createGround();
			this.createPlatformsBig();
			this.createPlatformsSmall();
		}
		
		public function dispose():void {
			this._ground.dispose();
			this._platform.dispose();
		}
								
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 *	Skapar nya instanser av Platform
		 * 	Dessa plattformar är de stora plattformarna som finns i mitten av spelplanen
		 * 
		 *	@return void
		 */
		private function createPlatformsBig():void {
			
			for(var i:int = 0; i < PLATFORMPOSITION_BIG.length; i++) {
				this._platform = new Platform(400, 20);
				
				this._platform.y = PLATFORMPOSITION_BIG[i].y;
				this._platform.x = PLATFORMPOSITION_BIG[i].x;
				
				this.addPlatform(this._platform);
			}
		}
		
		/**
		 *	Skapar nya instanser av Platform
		 * 	Dessa plattformar är de mindre plattformarna som finns överst på spelplanen
		 * 
		 *	@return void
		 */
		private function createPlatformsSmall():void {
			
			for(var i:int = 0; i < PLATFORMPOSITION_SMALL.length; i++) {
				this._platform = new Platform(200, 20);
				
				this._platform.y = PLATFORMPOSITION_SMALL[i].y;
				this._platform.x = PLATFORMPOSITION_SMALL[i].x;
				
				this.addPlatform(this._platform);
			}
		}

		/**
		 * 	Pushar objekt till vektorn platforms och lägger till objektet som child-objekt
		 * 
		 * 	@param	Platform
		 *	@return void
		 */
		private function addPlatform(plat:Platform):void {
			PLATFORMS.push(plat);
			this.addChild(plat);
		}
			
		/**
		 * 	Skapar en ny instans av Ground
		 * 	Pushar objektet till vektorn platforms
		 * 
		 *	@return void
		 */
		private function createGround():void {
			this._ground = new Ground(1000, 50);
			this._ground.x = GROUND_X;
			this._ground.y = GROUND_Y;
			
			this.addPlatform(_ground);
		}
	}
}