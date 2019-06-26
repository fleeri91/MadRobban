package object.background {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.display.Sprite;
	import flash.display.Bitmap;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	public class Background extends Sprite {
				
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _background:Bitmap;
		
		// --------------------------------------------------------
		// Embedded Class
		// --------------------------------------------------------
		[Embed(source="../../../asset/png/Background.png")]
		public static const BACKGROUND:Class;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Background() {
			this.initBackground();
		}
		
		// --------------------------------------------------------
		// Public Method
		// --------------------------------------------------------
		public function dispose():void {
			this._background = null;
		}
		
		// --------------------------------------------------------
		// Private Method
		// --------------------------------------------------------
		
		/**
		 *	Initialiserar grafiken för bakgrunden och lägger till det som child-objekt
		 * 
		 * 	@return void
		 */
		private function initBackground():void {
			this._background = new BACKGROUND();
			this._background.cacheAsBitmap;
			
			this.addChild(_background);
		}
	}
}