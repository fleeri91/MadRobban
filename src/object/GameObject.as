package object {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.state.StateMachine;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	
	/**
	 *	Basklass för varje spelobjekt
	 * 	Hanterar spelobjektets grafik och state
	 */
	public class GameObject extends DisplayStateLayerSprite {
		
		// ------------------------------------------------------------
		// Protected Properties
		// ------------------------------------------------------------	
		public var _skin:MovieClip;
		public var _stateMachine:StateMachine = new StateMachine();
		public var _isActive:Boolean = false;
		
		// ------------------------------------------------------------
		// Constructor Method
		// ------------------------------------------------------------	
		public function GameObject() {
			super();
		}
		
		// ------------------------------------------------------------
		// Override Public Methods
		// ------------------------------------------------------------	
		override public function update():void {
			this._stateMachine.update();
		}
		
		override public function dispose():void {
			trace("Disposed! " + this);
			this._skin = null;
			this.disposeStateMachine();
			this.disposeSelf();
		}
		
		// ------------------------------------------------------------
		// Private Methods
		// ------------------------------------------------------------	
		
		/**
		 * 	Disponerar statemachine och sätter variabel till null
		 * 
		 *	@return void
		 */
		private function disposeStateMachine():void {
			_stateMachine.dispose();
			_stateMachine = null;
		}
		
		/**
		 * 	Disponerar gameobject
		 * 
		 *	@return void
		 */
		private function disposeSelf():void {
			if(parent) parent.removeChild(this);
		}
		
	}
}