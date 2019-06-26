package object.platform {
	
		
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import object.platform.Platform;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------		
	public class Ground extends Platform {
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Ground(width:int, height:int) {	
			super(width, height);
		}
		
		// --------------------------------------------------------
		// Override Public Method
		// --------------------------------------------------------
		override public function dispose():void {
			super.dispose();
		}
	}
}