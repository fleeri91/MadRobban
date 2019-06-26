package ui.counter  {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	import ui.counter.CounterText;

	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class Counter extends DisplayStateLayerSprite {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _counter:CounterText;
		private var _label:String;
		private var _textAlign:String;
		
		// --------------------------------------------------------
		// Getter & Setter
		// --------------------------------------------------------
		
		/**
		 *	Getter som returnerar poängvärdet
		 * 
		 * 	@return int
		 */
		public function get score():int {
			return _counter.value;
		}
		
		/**
		 *	Setter för poängvärdet
		 * 
		 * 	@param	int
		 * 	@return	void
		 */
		public function set score(value:int):void {
			_counter.value = value;
		}
						
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Counter(label:String, textAlign:String) {
			this._label = label;
			this._textAlign = textAlign;
		}
		
		// --------------------------------------------------------
		// Override Pubic Method
		// --------------------------------------------------------
		override public function dispose():void {
			this._counter.dispose();
			this._counter = null;
		}
		
		// --------------------------------------------------------
		// Public Methods
		// --------------------------------------------------------
		
		/**
		 *	Återställer poängvärdet
		 * 
		 * 	@return	void
		 */
		public function reset():void {
			_counter.value = 0;
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 *	Initialiserar poängräknare
		 * 
		 * 	@return	void
		 */
		public function initScoreCounter():void {
			_counter = new CounterText(_label, _textAlign);
			_counter.embedFonts = true;
			addChild(_counter);
		}
	}
}