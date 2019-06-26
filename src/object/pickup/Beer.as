package object.pickup {
	

	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import asset.BeerGFX;
	import flash.geom.Rectangle;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class Beer extends Pickup {
			
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _beer:BeerGFX;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Beer() {
			
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
			this._beer = new BeerGFX();
			this.addChild(_beer);
		}
	}
}

