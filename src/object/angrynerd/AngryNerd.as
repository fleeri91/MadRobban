package object.angrynerd {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.geom.Rectangle;
	
	import asset.RobbanGFX;
	
	import component.Hitbox;
		
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class AngryNerd extends Hitbox {
	
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function AngryNerd() {
			
			var hitbox:Rectangle = new Rectangle(10, 10, 76, 76)
			super(hitbox);
			
			this.initSkin();
		}
		
		override public function dispose():void {
			super.dispose();
		}
		
		// --------------------------------------------------------
		// Private Method
		// --------------------------------------------------------
		
		/**
		 *	Initialiserar grafiken för angrynerd
		 * 
		 * 	@return void
		 */
		private function initSkin():void {
			this._skin = new RobbanGFX();
			this.addChild(this._skin);
		}
	}
}