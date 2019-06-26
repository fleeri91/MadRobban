package object.player {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import asset.EliasGFX;
	
	import se.lnu.stickossdk.input.EvertronControls;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class PlayerTwo extends Player {
					
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function PlayerTwo(startPosition:Point, runSpeed:int, jumpForce:Number) {
			
			var hitbox:Rectangle = new Rectangle(-13, 5, 26, 39);
			var hitboxFeet:Rectangle = new Rectangle(-13, 40, 26, 5);
			
			this.x = startPosition.x;
			this.y = startPosition.y;
						
			super(hitbox, hitboxFeet, startPosition, runSpeed, jumpForce, EvertronControls.PLAYER_TWO);
			
			this.initSkin();
			this.initItemPlaceholder();
		}
		
		override public function dispose():void {
			super.dispose();
		}
				
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 *	Initialiserar grafiken och lägger till det som ett child-objekt
		 */
		private function initSkin():void {
			this._skin = new EliasGFX();
			this.addChild(this._skin);
		}
		
		/**
		 *	Initialiserar placeholder för föremålet som är ovanför spelaren och lägger till det som ett child-objekt
		 */
		private function initItemPlaceholder():void {
			this._holdingItemPlaceholder = new Bitmap();
			this._holdingItemPlaceholder.bitmapData = _holdingItemData;
			this._holdingItemPlaceholder.y = -30;
			this._holdingItemPlaceholder.x = -13;
			addChild(_holdingItemPlaceholder);
		}
	}
}