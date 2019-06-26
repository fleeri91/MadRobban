package {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.geom.Point;
	
	import se.lnu.stickossdk.system.Engine;
	
	import scene.MenuState;

	// ------------------------------------------------------------
	// SWF Properties
	// ------------------------------------------------------------
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#000000")]
	
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Ett flash-spel för arkadmaskinen Evertron
	 * 
	 * 	Utvecklare:	Flemming Eriksson
	 * 	Designer:	Elias Skarfelt
	 */
	public class FlashGame extends Engine {
		
		// --------------------------------------------------------
		// Embedded Class
		// --------------------------------------------------------
		[Embed(source = "../asset/font/8-Bit Madness.TTF", fontName = "8-Bit Madness", mimeType = "application/x-font", embedAsCFF="false")]
		private static const FONT:Class;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function FlashGame() {
			
		}
		
		// --------------------------------------------------------
		// Override Public Method
		// --------------------------------------------------------
		
		/**
		 *	Förbereder spelet för Evertron
		 *	Ställer in ett unikt id, skärmnes storlek, bakgrund och vilket tillstånd som ska hanteras vid start
		 */
		override public function setup():void {
			initId = 47;
			initSize = new Point(800, 600);
			initBackgroundColor = 0x000000;
			//initDebugger = true;
			initDisplayState = MenuState;
		}
	}
}