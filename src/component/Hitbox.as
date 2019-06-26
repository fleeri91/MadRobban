package component {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import object.GameObject;

	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Publik klass som ligger till grund för ett spelobjekts träffyta (hitbox)
	 * 	Klassen ärver funktionalitet från klassen GameObject
	 */
	public class Hitbox extends GameObject {
		
		
		// --------------------------------------------------------
		// Protected Properties
		// --------------------------------------------------------
		protected var _hitbox:Sprite = new Sprite();
		
		
		// --------------------------------------------------------
		// Public Getter
		// --------------------------------------------------------
		
		/**
		 *	Getter som returnerar spelobjektets hitbox
		 */
		public function get hitbox():Sprite {
			return _hitbox;
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Hitbox(hitbox:Rectangle) {
			this.drawHitbox(hitbox);
		}
		
		override public function update():void {
			super.update();
		}
		
		override public function dispose():void {
			super.dispose();
			
			this._hitbox = null;
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 * 	Skapar hitboxen
		 * 
		 * 	@param	Rectangle
		 * 	@return	void
		 */
		private function drawHitbox(hitbox:Rectangle):void {
			this._hitbox.graphics.drawRect(hitbox.x, hitbox.y, hitbox.width, hitbox.height);
			this.addChild(_hitbox);
		}
	}
}