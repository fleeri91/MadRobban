package object.angrynerd {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	import asset.BubbleGFX;
	
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class Bubble extends DisplayStateLayerSprite {
		
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _bubble:BubbleGFX;
		private var _animation:String;
					
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Bubble() {
			this.initBubble();
		}
		
		// --------------------------------------------------------
		// Override Public Methods
		// --------------------------------------------------------
		override public function dispose():void {
			this._bubble = null;
		}
		
		// --------------------------------------------------------
		// Public Methods
		// --------------------------------------------------------
		
		/**
		 *	Initialiserar för singleplayer mode
		 * 
		 * 	@return void
		 */
		public function initSingleplayer():void {
			this._bubble.gotoAndStop("singleplayer");
		}
		
		/**
		 *	Initialiserar för coop mode
		 * 
		 * 	@return void
		 */
		public function initCoop():void {
			this._bubble.gotoAndStop("coop");
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 *	Initialiserar grafiken för tankebubblan och lägget till det som child-objekt
		 * 
		 * 	@return void
		 */
		private function initBubble():void {
			this._bubble = new BubbleGFX();
			this.addChild(this._bubble);
		}
	}
}