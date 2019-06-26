package ui.timer {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.display.Sprite;
	
	import asset.RageMeterGFX;
		
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	public class TimerFrame extends Sprite {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _frame:RageMeterGFX;
		
		public function set animation(value:int):void {
			this.setAnimation(value);
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function TimerFrame() {
			this.createFrame();
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 * 	Skapar ramen för ragetimer
		 * 
		 *	@return void
		 */
		private function createFrame():void {
			this._frame = new RageMeterGFX();
			this.addChild(this._frame);
		}
		
		/**
		 *	Ändrar animation på timerframe
		 * 
		 * 	@param	int
		 * 	@return	void
		 */
		private function setAnimation(value:int):void {
			this._frame.gotoAndStop(value);
		}
	}
}