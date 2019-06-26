package object.platform
{
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.geom.Rectangle;
	
	import component.Hitbox;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Basklass för alla platform-objekt
	 * 	Ärver från klassen Hitbox
	 */
	public class Platform extends Hitbox {
			
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Platform(width:int, height:int) {
			
			var hitbox:Rectangle = new Rectangle(x, y, width, height);
			super(hitbox);
		}
		
		// --------------------------------------------------------
		// Override Public Method
		// --------------------------------------------------------
		override public function dispose():void {
			super.dispose();
			trace("Disposed! " + this);
		}
	}
}