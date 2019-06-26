package component.highscore {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import se.lnu.stickossdk.util.URLUtils;
		
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Publik klass för en rad i highscore
	 */
	public class HighscoreRow extends Sprite {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _name:TextField;
		private var _position:TextField;
		private var _score:TextField;
		
		// --------------------------------------------------------
		// Private Statics
		// --------------------------------------------------------
		private static const DEFAULT_TEXT_SIZE:int = 32;
		private static const DEFAULT_TEXT_COLOR:uint = 0xFFFFFF;
		private static const DEFAULT_TEXT_FONT:String = "8-Bit Madness";
		private static const DEFAULT_BACKGROUND_COLOR:uint = 0x000000;
		
		// --------------------------------------------------------
		// Override Public Getters & Setters
		// --------------------------------------------------------
		
		/**
		 *	Override getter för namnet på en rad
		 * 
		 * 	@return String
		 */
		override public function get name():String {
			return _name.text.toLocaleUpperCase();
		}
		
		/**
		 *	Override setter för namnet på en rad
		 * 
		 * 	@param String
		 * 	@return void
		 */
		override public function set name(value:String):void {
			_name.text = URLUtils.decode(value.toLocaleUpperCase());
		}
		
		// --------------------------------------------------------
		// Public Getters & Setters
		// --------------------------------------------------------
		
		/**
		 *	Getter för positionen för ett namn på en rad
		 * 
		 * 	@return int
		 */
		public function get position():int {
			return int(_position.text);
		}
		
		/**
		 *	Setter ...
		 * 
		 * 	@param	int
		 * 	@return void
		 */
		public function set position(value:int):void {
			_position.text = value.toString()+ ". ";
		}

		/**
		 *	Getter ...
		 * 
		 * 	@return int
		 */
		public function get score():int {
			return int(_score.text.slice(0, -2));
		}
		
		/**
		 *	Getter ...
		 * 
		 * 	@param	int
		 * 	@return void
		 */
		public function set score(value:int):void {
			_score.text = value.toString();
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function HighscoreRow() {
			this.init();
		}
		
		// --------------------------------------------------------
		// Public Methods
		// --------------------------------------------------------
		public function dispose():void {
			_position = null;
			_name = null;
			_score = null;
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		private function init():void {
			initTextField();
			cacheAsBitmap = true;
		}
		
		/**
		 *	Initialiserar textfält
		 * 
		 * 	@return void
		 */
		private function initTextField():void {
			initTextFieldPosition();
			initTextFieldName();
			initTextFieldScore();
		}
		
		/**
		 *	Initialiserar position för textfält och lägger till som ett child
		 * 
		 * 	@return void
		 */
		private function initTextFieldPosition():void {
			_position = new TextField();
			_position.defaultTextFormat = textFormat();
			_position.backgroundColor = DEFAULT_BACKGROUND_COLOR;
			_position.background = true;
			_position.embedFonts = true;
			_position.selectable = false;
			_position.width  = 46;
			_position.height = 32;
			addChild(_position);
		}
		
		/**
		 *	Initialiserar textfält för namn och lägger till som ett child
		 * 
		 * 	@return void
		 */
		private function initTextFieldName():void {
			_name = new TextField();
			_name.defaultTextFormat = textFormat();
			_name.x = _position.x + _position.width;
			_name.width = 300;
			_name.height = 32;
			_name.background = true;
			_name.backgroundColor = DEFAULT_BACKGROUND_COLOR;
			_name.selectable = false;
			_name.embedFonts = true;
			addChild(_name);
		}
		
		/**
		 *	Initialiserar ett textfälft för poäng och lägger till som ett child
		 * 
		 * 	@return void
		 */
		private function initTextFieldScore():void {
			_score = new TextField();
			_score.defaultTextFormat = textFormatScore();
			_score.x = _name.x + _name.width;;
			_score.width = 100;
			_score.height = 32;
			_score.selectable = false;
			_score.embedFonts = true;
			_score.background = true;
			_score.backgroundColor = DEFAULT_BACKGROUND_COLOR;
			
			addChild(_score);
		}
		
		/**
		 *	Skapar ett nytt textformat för text
		 * 
		 * 	@return TextFormat
		 */
		private function textFormat():TextFormat {
			var _format:TextFormat = new TextFormat();
			_format.size = DEFAULT_TEXT_SIZE;
			_format.color = DEFAULT_TEXT_COLOR;
			_format.font = DEFAULT_TEXT_FONT;
			return _format;
		}
		
		/**
		 *	Skapar ett nytt textformat för poäng
		 * 
		 * 	@return TextFormat
		 */
		private function textFormatScore():TextFormat {
			var _format:TextFormat = new TextFormat();
			_format.size = DEFAULT_TEXT_SIZE;
			_format.color = DEFAULT_TEXT_COLOR;
			_format.font = DEFAULT_TEXT_FONT;
			_format.align = TextFormatAlign.RIGHT;
			return _format;
		}
	}
}