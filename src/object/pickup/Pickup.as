package object.pickup {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.geom.Rectangle;
	
	import component.Hitbox;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Basklass för alla pickup-föremål
	 */
	public class Pickup extends Hitbox {
				
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Pickup(hitbox:Rectangle) {
			super(hitbox);
		}
	}
}