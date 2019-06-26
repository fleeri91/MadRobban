package component {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.geom.Rectangle;	
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Public klass som ligger till grund för att kunna styra ett spelobjekt
	 * 	Klassen ärver funktionalitet från klassen Physics2D
	 */
	public class Character extends Physics2D {
		
		
		// --------------------------------------------------------
		// Public Properties
		// --------------------------------------------------------
		public var _isDead:Boolean = false;
		public var _isImmune:Boolean = false;
		
		// --------------------------------------------------------
		// Protected Properties
		// --------------------------------------------------------
		protected var _dir:int = 1;
				
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const DEFAULT_SCALE_FACTOR:int = 1;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Character(hitbox:Rectangle, hitboxFeet:Rectangle, runSpeed, jumpForce) {
			super(hitbox, hitboxFeet, runSpeed, jumpForce);
		}
		
		// --------------------------------------------------------
		// Override Public Methods
		// --------------------------------------------------------
		override public function init():void {
			this.initScale();
		}
		
		override public function update():void {
			super.update();
		}
		
		override public function dispose():void {
			super.dispose();
		}
		
		// --------------------------------------------------------
		// Override Protected Method
		// --------------------------------------------------------
		override protected function checkCollision():void {
			super.checkCollision();
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 * 	Initialiserar grafikens skala
		 * 
		 * 	@return void
		 */
		private function initScale():void {
			this.scaleX = DEFAULT_SCALE_FACTOR;
			this.scaleY = DEFAULT_SCALE_FACTOR;
		}
				
		// --------------------------------------------------------
		// Protected Methods
		// --------------------------------------------------------
		
		/**
		 * 	Karaktär gå höger
		 * 
		 * 	@return void
		 */
		protected function m_moveLeft():void {
			
			if (this._skin.scaleX > 0) 
				this._skin.scaleX = -DEFAULT_SCALE_FACTOR;				
			
			this._velocity.x = -this._runSpeed;
		}
		
		/**
		 * 	Karaktär gå höger
		 * 
		 * 	@return void
		 */
		protected function m_moveRight():void {
			
			if (this._skin.scaleX < 0) 
				this._skin.scaleX = DEFAULT_SCALE_FACTOR;
			
			this._velocity.x = this._runSpeed;
		}
		
		/**
		 *	Hopp-funktion som endast kan aktiveras om spelaren är på marken
		 * 
		 * 	@return void
		 */
		protected function m_jump():void {
			
			if(this._isGrounded) {
				
				this._velocity.y = -_jumpForce;
				this._isGrounded = false;
			}
		}
	}
}