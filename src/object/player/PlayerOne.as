package object.player {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import asset.FlemmingGFX;
	
	import se.lnu.stickossdk.input.EvertronControls;
		
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class PlayerOne extends Player {
		
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function PlayerOne(startPosition:Point, runSpeed:int, jumpForce:Number) {

			
			var hitbox:Rectangle = new Rectangle(-13, 5, 26, 32);
			var hitboxFeet:Rectangle = new Rectangle(-13, 33, 26, 5);
			
			this.x = startPosition.x;
			this.y = startPosition.y;
						
			super(hitbox, hitboxFeet, startPosition, runSpeed, jumpForce, EvertronControls.PLAYER_ONE);
			
			this.initSkin();
			this.initItemPlaceholder();
		}
		
		override public function dispose():void {
			super.dispose();
		}
		
		/**
		 *	Initialiserar grafiken och lägger till det som ett child-objekt
		 */
		private function initSkin():void {
			this._skin = new FlemmingGFX();
			this.addChild(this._skin);
		}
		
		/**
		 *	Initialiserar placeholder för föremålet som är ovanför spelaren och lägger till det som ett child-objekt
		 */
		private function initItemPlaceholder():void {
			this._holdingItemPlaceholder = new Bitmap();
			this._holdingItemPlaceholder.bitmapData = _holdingItemData;
			this._holdingItemPlaceholder.y = -25;
			this._holdingItemPlaceholder.x = -13;
			addChild(_holdingItemPlaceholder);
		}
	}
}