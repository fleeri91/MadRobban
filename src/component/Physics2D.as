package component {
		
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import component.Hitbox;
	
	import object.GameArea;
	import object.platform.Platform;
	
	import scene.game.GameState;
	
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Public klass som ligger till grund för ett spelobjekts fysik
	 * 	Klassen ärver funktionalitet från klassen Hitbox
	 */
	public class Physics2D extends Hitbox {
		
		// --------------------------------------------------------
		// Protected Properties
		// --------------------------------------------------------
		protected var _runSpeed:int;
		protected var _gravity:Number;
		protected var _jumpForce:Number;
		protected var _currentPlatform:Platform;
				
		protected var _isGrounded:Boolean = false;
		protected var _isIgnoringPlatform:Boolean = false;
		protected var _canMove:Boolean = true;
				
		protected var _velocity:Point = new Point();
		protected var _currentPos:Point = new Point();
		protected var _hitboxFeet:Sprite = new Sprite();
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const DEFAULT_GRAVITY:Number = 0.6;
		private static const DEFAULT_RUNSPEED:int = 5;
		
		// --------------------------------------------------------
		// Public Getter & Setter
		// --------------------------------------------------------
		
		/**
		 *	Getter för velocity
		 * 
		 * 	@return	Point
		 */
		public function get velocity():Point {
			return _velocity;
		}
		
		/**
		 *	Setter för velocity
		 * 
		 * 	@param	Point
		 * 	@return	void
		 */
		public function set velocity(velocity:Point):void {
			this._velocity = velocity;
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Physics2D(hitbox:Rectangle, hitboxFeet:Rectangle, runSpeed:int, jumpForce:Number) {
			
			super(hitbox);
			
			this._gravity = DEFAULT_GRAVITY;
			this._runSpeed = runSpeed;
			this._jumpForce = jumpForce;
			
			this.drawHitbox(hitboxFeet);
		}
		
		// --------------------------------------------------------
		// Override Public Methods
		// --------------------------------------------------------	
		override public function update():void {
			super.update();
			
			this.updateVelocity();
			this.checkCollision();
		}
		
		override public function dispose():void {
			super.dispose();
			
			this._currentPlatform = null;
			this._currentPos = null;
			this._hitboxFeet = null;
			this._velocity = null;
		}
		
		// --------------------------------------------------------
		// Protected Methods
		// --------------------------------------------------------
		
		/**
		 *	Kollisionshantering för plattformar
		 * 	Hämtar plattformar från klassen GameArea
		 * 
		 *	@return	void
		 */
		protected function checkCollision():void {
			
			var rect:Rectangle = this._hitboxFeet.getRect(GameState._playerLayer);
			
			for each (var plat:Platform in GameArea.platforms) {
				
				if(GameArea.platforms == null || this._isIgnoringPlatform)
					return;
				
				var platformRect:Rectangle = plat.getRect(GameState._gameObjectLayer);
				
				if(rect.intersects(platformRect)) {
					
					if(this._velocity.y > 0) {
						
						this._velocity.y = 0;
						this._isGrounded = true;
						this.y = plat.y - (_hitbox.height + 5);
						
						this._currentPlatform = plat;
						this._currentPos = new Point(rect.x, rect.y);
					}
				}
			}
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 *	Uppdaterar spelarens fysik
		 * 
		 * 	@return	void
		 */
		private function updateVelocity():void {
						
			this.x += _velocity.x;
			this.y += _velocity.y;
						
			this._velocity.x = 0;
			this._velocity.y += this._gravity;
			
			if(this.y + (this._hitbox.height / 2) >= this._currentPos.y)
				this._isGrounded = false;
		}
		
		/**
		 *	Skapar hitboxen för fötterna
		 * 
		 * 	@param	Rectangle
		 * 	@return	void
		 */
		private function drawHitbox(hitbox:Rectangle):void {
			this._hitboxFeet.graphics.drawRect(hitbox.x, hitbox.y, hitbox.width, hitbox.height);
			this.addChild(_hitboxFeet);
		}
	}
}