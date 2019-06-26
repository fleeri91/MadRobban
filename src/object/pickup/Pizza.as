package object.pickup {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.geom.Rectangle;
	
	import asset.PizzaGFX;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class Pizza extends Pickup {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _pizza:PizzaGFX;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Pizza() {
			
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
			this._pizza = new PizzaGFX();
			this.addChild(_pizza);
		}
	}
}

