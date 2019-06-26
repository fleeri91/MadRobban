package object.pickup {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.geom.Rectangle;
	
	import asset.CupGFX;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class Cup extends Pickup {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _cup:CupGFX;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Cup() {
			
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
			this._cup = new CupGFX();
			this.addChild(_cup);
		}
	}
}

