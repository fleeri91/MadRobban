package object.enemy.badguy {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.geom.Point;
	
	import asset.BadguyGFX;
	import object.enemy.Enemy;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class Badguy extends Enemy {
				
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Badguy(startPosition:Point, runSpeed:int) {
			
			this.x = startPosition.x;
			this.y = startPosition.y;
			
			super(startPosition, runSpeed);
			
			this.initSkin();
			this._point = 10;
		}
		
		override public function dispose():void {
			super.dispose();
		}
		
		/**
		 * 	Skapar grafiken för objektet och lägger till det som child-objekt
		 * 
		 *	@return void
		 */
		private function initSkin():void {
			this._skin = new BadguyGFX();
			this.addChild(this._skin);
		}
	}
}