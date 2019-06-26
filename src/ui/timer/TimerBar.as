package ui.timer {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------		
	import flash.display.Sprite;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------		
	public class TimerBar extends Sprite {
			
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function TimerBar() {
			this.initTimerBar();
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 * 	Ritar grafiken för timerbar
		 * 
		 *	@return void
		 */
		private function initTimerBar():void {
			this.graphics.beginFill(0xff0000);
			this.graphics.drawRect(0, 0, 120, 34);
			this.graphics.endFill();
		}
	}
}

