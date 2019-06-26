package object.pickup {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.geom.Rectangle;
	
	import asset.FootballGFX;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class Football extends Pickup {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _football:FootballGFX;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Football() {
			
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
			this._football = new FootballGFX();
			this.addChild(_football);
		}
	}
}

