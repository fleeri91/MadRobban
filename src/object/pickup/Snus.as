package object.pickup {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.geom.Rectangle;
	
	import asset.SnusGFX;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class Snus extends Pickup {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _snus:SnusGFX;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Snus() {
			
			var hitbox:Rectangle = new Rectangle(-20, -20, 30, 30);
			super(hitbox);
			
			this.initSkin();
		}
		
		/**
		 *	Skapar grafiken och lägger till det som child-objekt
		 * 
		 * 	@return void
		 */
		private function initSkin():void {
			this._snus = new SnusGFX();
			this.addChild(_snus);
		}
	}
}

