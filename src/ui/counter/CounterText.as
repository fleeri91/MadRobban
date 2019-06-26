package ui.counter {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------		
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------		
	public class CounterText extends TextField {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _value:int;
		private var _label:String;
		private var _format:TextFormat;
		private var _textAlign:String;
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const DEFAULT_FONT_SIZE:int = 32;
		private static const DEFAULT_FONT_COLOR:uint = 0xFFFFFF;
		private static const DEFAULT_FONT_FACE:String = "8-Bit Madness";
		private static const DEFAULT_TEXT_VALUE:String = "0";
		
		// --------------------------------------------------------
		// Getter & Setter
		// --------------------------------------------------------
		
		/**
		 *	Getter som returnerar poängvärdet
		 * 
		 * 	@return	int
		 */
		public function get value():int {
			return _value;
		}
		
		/**
		 *	Setter för poängvärdet
		 * 
		 * 	@param	int
		 * 	@return	void
		 */
		public function set value(value:int):void {
			this._value = value;
			htmlText = _label + "<br>" +  value.toString();
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function CounterText(label:String, textAlign:String) {
			this._label = label;
			this._textAlign = textAlign;
			
			this.initTextFormat();
			this.initTextField();
		}
		
		// --------------------------------------------------------
		// Public Method
		// --------------------------------------------------------
		
		/**
		 *	Disponering
		 * 
		 * 	@return	void
		 */
		public function dispose():void {
			this._format = null;
		}
		
		// --------------------------------------------------------
		// Priavte Methods
		// --------------------------------------------------------
		
		/**
		 *	Initialiserar textfältet
		 * 
		 * 	@return void
		 */
		private function initTextField():void {
			embedFonts = true;
			multiline = true;
			defaultTextFormat = _format;
			htmlText = _label + "<br>" + DEFAULT_TEXT_VALUE;
			width = 250;
			height = 50;
			selectable = false;
		}
		
		/**
		 *	Initialiserar textformat
		 * 
		 * 	@return void
		 */
		private function initTextFormat():void {
			_format = new TextFormat();
			_format.font = DEFAULT_FONT_FACE;
			_format.size = DEFAULT_FONT_SIZE;
			_format.color = DEFAULT_FONT_COLOR;
			_format.align = _textAlign;
		}
	}
}